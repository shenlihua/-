<?php

namespace app\admin\controller;

use app\common\model\UserAuthModel;
use app\common\model\UserModel;
use think\Request;

class Project extends Common
{
    //项目列表
    public function index(Request $request)
    {
        $keyword = $request->param('keyword','','trim');
        $where =[];
        $keyword && $where[] = ['title','like','%'.$keyword.'%'];
        $model = model('Project');
        $list = $model->where($where)->paginate();
        return view('index',[
            'list' => $list,
            'keyword' => $keyword
        ]);
    }

    //新增项目
    public function projectAdd(Request $request)
    {
        $id = $request->param('id',0,'intval');
        $model = model('Project');
        $model = $model->with('linkWork')->where('id',$id)->find();
        return view('projectAdd',[
            'model' => $model
        ]);
    }


    /*
     * 项目保存操作
     * */
    public function projectAddAction(Request $request)
    {
        $input_data = $request->param();
        //谁添加的绑定那个团队
        if($this->team_no){//团队
            $input_data['team_no'] = $this->team_no;
        }

        $validate = new \app\common\validate\ProjectValidate();
        $validate->scene('add_project');
        $model = model('Project');
        bind('app\common\model\Users',model('Users')->where('id','=',$this->user_id)->find());
        $result = $this->_dataSave($model,$input_data,$validate);

        if($result['code']){//保存成功
//            dump($input_data);exit;
            // 操作工作内容
            $work_model = model('ProWork');
            $save_work_id = empty($input_data['work_id'])?[]:$input_data['work_id'];

            if (!empty($input_data['work'])) {
                $works = [];
                foreach ($input_data['work'] as $key=>$vo) {
                    $arr = [];
                    if (isset($save_work_id[$key])) { //存在值
                        $arr['id'] = $save_work_id[$key];
                    }
                    $arr['content']  = $vo;
                    $works[] = $arr;
                }

                $model->linkWork()->saveAll($works);
            }

            if(!empty($input_data['work_del'])) {
                $work_model->where('id','in', $input_data['work_del'])->delete();
            }



        }
        return $result;
    }

    /*
     * 项目详情
     * */
    public function projectDetail(Request $request)
    {
        $id = $request->param('id',0,'intval');
        $model = model('Project');
        $model = $model
            ->with([
                'linkCityUser.linkUserInfo',
                'linkProUser.linkUserInfo',
                'linkProFlow','linkWork.linkWorker','linkAuthDetail'
            ])
            ->where('id',$id)
            ->find();

        //项目施工人员
        $pro_delegate_model = model('ProDelegate');
        $pro_users = $pro_delegate_model->with('linkUserInfo')->where('pid','=',$id)->select();
//        dump($pro_users);exit;
        //施工人员
        $handle_users = [];
        $pro_delegate_users = $model['link_pro_user']->toArray();
        if($pro_delegate_users) { //存在项目经理

            $manager_uid = array_column($pro_delegate_users,'uid');

            $handle_users = model('users')->where([[
                ['is_auth','=',1],
                ['status','=',1],
                ['team_slice_no','in',implode(',',$manager_uid)],
            ]])->whereOr([[
                ['is_auth','=',1],
                ['status','=',1],
                ['id','in',implode(',',$manager_uid)]
            ]])->select();

        }
        return view('projectDetail',[
             'model' => $model,
             'pro_users' => $pro_users,
             'handle_users' => $handle_users,
             'user_type' => \app\common\model\UserType::$user_type,
        ]);
    }

    //项目委派
    public function delegate(Request $request)
    {
        $input_data = $request->param();
        $validate = new \app\common\validate\ProDelegateValidate();
        $validate->scene('admin_add');

        $model = model('ProDelegate');
        //绑定依赖注入
        bind('app\common\model\BaseModel',model('Project')->where('id','=',$input_data['pid'])->find());
        return $this->_dataSave($model,$input_data,$validate);

    }

    //分配具体项目信息
    public function workerAction()
    {
        $pid = $this->request->param('pid');//项目id
        $worker = $this->request->param('w_uid');//工作人员/项目分类
        if(empty($pid)) return ['code'=>0,'msg'=>'项目信息异常:'];
        if(empty($worker)) return ['code'=>0,'msg'=>'请选择项目对应的员工:'];
        $project_model = model('Project')->where('id','=',$pid)->find();

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
            //绑定项目
            bind('app\common\model\Project',$project_model);
            $model->where('pid','=',$pid)->delete();
            $model->saveAll($data);
            return ['code'=>1,'msg'=>'操作成功'];
        }catch (\Exception $e) {
            return ['code'=>0,'msg'=>'操作异常:'.$e->getMessage()];
        }
    }

    /*
     * 项目审核
     * */
    public function authAction()
    {
        $input_data = $this->request->param();
        $validate = new \app\common\validate\ProjectValidate();
        $validate->scene('auth_project');

        $model = model('project');
        //绑定依赖注入
//        bind('app\common\model\BaseModel',model('Project')->where('id','=',$input_data['pid'])->find());
        try{
            $model->startTrans();
            $result = $this->_dataSave($model,$input_data,$validate);
            $model->commit();

        }catch (\Exception $e) {
            $model->rollback();
            $result = ['code'=>0,'msg'=>'操作异常:'.$e->getMessage()];
        }

        //触发发放奖励
        model('userAward')->sendAward();
        return $result;
    }
}