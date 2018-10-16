<?php
namespace app\index\controller;

class Project extends Common
{

    protected $user_model;

    protected $beforeActionList = [
        'bindUserModel', //绑定用户模型
        //检测操作权限
        'checkOptProjectAuth' => ['only'=>'detail,auth,send,sendproaction,prosendworkeraction,authaction']
    ];

    protected function bindUserModel()
    {
        $this->user_model = model('Users')->where('id','=',$this->user_id)->find();
    }

    //检测用户是否有操作权限
    protected function  checkOptProjectAuth()
    {
        if($this->user_model['type']=='city') {//城市
            $model = model('ProDelegate');

        }elseif($this->user_model['type']=='pro') {//项目
            $model = model('ProDelegate');

        }elseif($this->user_model['type']=='staff') {//员工
            $model = model('ProWorker');

        }else{//暂无数据
            abort(200,json_encode(['code'=>'0','msg'=>'您没有权限操作该项目']));
        }

        $count = $model->where('uid','=',$this->user_id)->count();
        if(!$count) {
            abort(200,json_encode(['code'=>'0','msg'=>'您没有权限操作该项目:1']));
        }

    }

    //项目中心
    public function index()
    {
        if($this->request->isAJAX()){
            $project_model = model('project');
            $list = $project_model->getProInfo($this->user_model);

            $list = $list->each(function($item, $key){

                $item['status_intro'] = $item['is_auth'] ? \app\common\model\Project::$fields_is_auth[$item['is_auth']]
                    :\app\common\model\Project::$fields_status[$item['status']] ;
                return $item;
            });
            return ['code'=>1,'msg'=>'获取成功','data'=>$list];
        }



        return view('index',[

        ]);
    }

    //项目详情
    public function detail()
    {
        $id = $this->request->param('id');
        $model = model('project');
        $model = $model->with(['linkManage.linkUserInfo'])->where('id','=',$id)->find();
//        dump($model);exit;
        $show_users=[];
        if($model['link_manage']) {
            foreach(\app\common\model\UserType::$type_level as $vo ) {
                foreach ( $model['link_manage'] as $lm ) {
                     if ($lm['type'] == $vo) {
                         $show_users = $lm['link_user_info'];
                     }
                }
            }
        }

        return view('detail',[
            'model' => $model,
            'user_model' => $this->user_model,
            'show_users' => $show_users
        ]);
    }

    //项目审核
    public function auth()
    {
        $id = $this->request->param('id');
        $project_model = model('project');
        $project_model = $project_model->with(['linkManage.linkUserInfo'])->where('id','=',$id)->find();
        return view('auth',[
            'project_model' => $project_model,
        ]);
    }

    //派单动作
    public function send()
    {
        $id = $this->request->param('id');
        $project_model = model('project');
        //查看项目资料
        $where = [
            'id' => $id,
            'team_no' => $this->user_model['team_no']
        ];
        $project_model = $project_model->where($where)->find();

        //当前项目委派项目经理
        $project_pro_users =[];
        if($project_model){
            $project_pro_info = $project_model->linkProUser()->select()->toArray();
            $project_pro_users = array_column($project_pro_info,'uid');
        }

        //查询当前登录者用户身份
        if ( $this->user_model['type']=='city') { //城市经理
            $view = 'citySend';
            //绑定城市经理信息


            //查看所有城市经理所有项目经理
            $pro_users = $this->user_model->where([
                'team_no'=>$this->user_model['team_no'],
                'type' =>'pro'
            ])->select();

            $this->assign('project_pro_users',$project_pro_users);
            $this->assign('pro_users',$pro_users);
        } elseif ( $this->user_model['type'] == 'pro' ) {//项目经理
            $view = 'proSend';
            //项目工作事项
            $project_work = $project_model->with('linkWork.linkWorker.linkUser')->where($where)->find();

            $handle_users = model('users')->where([[
                ['is_auth','=',1],
                ['status','=',1],
                ['team_slice_no','in',implode(',',$project_pro_users)],
            ]])->whereOr([[
                ['is_auth','=',1],
                ['status','=',1],
                ['id','in',implode(',',$project_pro_users)]
            ]])->select();

            $this->assign('handle_users',$handle_users);
            $this->assign('project_work',$project_work);
        }else{ //派单动作只允许 city pro
            return $this->redirect('index/index');
        }

//        dump($project_model);exit;
        return view($view,[
            'project_model'=>$project_model,
        ]);
    }

    //指定项目经理
    public function sendProAction()
    {
        $input_data = $this->request->param();
        $input_data['type'] = 'pro';//指定项目经理
        $validate = new \app\common\validate\ProDelegateValidate();
        $validate->scene('wechat_add');

        $model = model('ProDelegate');
        //绑定依赖注入
        bind('app\common\model\BaseModel',model('Project')->where('id','=',$input_data['pid'])->find());
        $result = $this->_dataSave($model,$input_data,$validate);
        //更新项目备注
        if($result['code'] && !empty($input_data['remark'])){
            model('Project')->update(['remark'=>$input_data['remark']],['id'=>$input_data['pid']]);
        }
        return $result;
    }

    //项目指定员工
    public function proSendWorkerAction()
    {
        $pid = $this->request->param('pid');//项目id
        $worker = $this->request->param('worker');//工作人员/项目分类
        if(empty($pid)) return ['code'=>0,'msg'=>'项目信息异常:'];
        if(empty($worker)) return ['code'=>0,'msg'=>'请选择项目对应的员工:'];
        $model = model('ProWorker');
        $data = [];
        foreach($worker as $key=>$vo) {
            foreach($vo as $user) {
                $data[] = [
                    'pid' => $pid,
                    'wid' => $key,
                    'uid' => $user,
                ];
            }

        }
        try{
            $model->where('pid','=',$pid)->delete();
            $model->saveAll($data);
            return ['code'=>1,'msg'=>'操作成功'];
        }catch (\Exception $e) {
            return ['code'=>0,'msg'=>'操作异常:'.$e->getMessage()];
        }
    }

    //项目审核提交
    public function authAction()
    {
        $input_data = $this->request->param();
        $input_data['uid'] = $this->user_id;
        $input_data['img'] = empty($input_data['img'])?'':implode(',',$input_data['img']);
        $validate = new \app\common\validate\ProAuthValidate();

        $model = model('ProAuth');
        $result = $this->_dataSave($model,$input_data,$validate);
        if($result['code']) { //保存成功
            model('Project')->save([
                'is_auth' => 1,
                'submit_auth_time' => time()
            ],[['id','=',$model['pid']]]);
        }
        return $result;
    }



    //城市经理派单
    public function citySend()
    {
        return view('citySend',[

        ]);
    }

    //城市经理派单
    public function proSend()
    {
        return view('proSend',[

        ]);
    }

    //添加员工
    public function addWorker()
    {
        return view('addWorker',[

        ]);
    }

    //项目管理
    public function manage()
    {
        if($this->request->isAJAX()){
//            $model = model('ProDelegate');
            $state = $this->request->param('state',0,'intval');
            $where = [];
            $state && $where[] = ['p.status','=',$state];

            $project_model = model('project');
            $list = $project_model->getProInfo($this->user_model,$where);

            $list = $list->each(function($item, $key){

                $item['status_intro'] = $item['is_auth'] ? \app\common\model\Project::$fields_is_auth[$item['is_auth']]
                    :\app\common\model\Project::$fields_status[$item['status']] ;
                return $item;
            });
            return ['code'=>1,'msg'=>'获取成功','data'=>$list];

        }

        return view('manage',[

        ]);
    }
}