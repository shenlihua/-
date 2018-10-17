<?php
namespace app\index\controller;

class Mine extends Common
{
    protected $user_model;

    protected $beforeActionList = [
        'bindUserModel', //绑定用户模型

    ];

    protected function bindUserModel()
    {
        $this->user_model = model('Users')->where('id','=',$this->user_id)->find();
    }


    public function index()
    {
        return view('index',[
            'model' => $this->user_model
        ]);
    }

    //我的积分
    public function integral()
    {
        $gold_model = model('userGoldLog');
        $log_model = $gold_model->order('id desc')->paginate(4);
        $current_month_gold = $gold_model
            ->where([['uid','=',$this->user_id],])
            ->whereTime('update_time','>',strtotime(date('Y-m')))
            ->sum('gold');
//        dump($log_model);exit;

        return view('integral',[
            'model' => $this->user_model,
            'log_model' => $log_model,
            'current_month_gold' =>$current_month_gold,
        ]);
    }

    //更多记录
    public function integralMore()
    {
        if($this->request->isAJAX()){
            $fields = 'gold,param,update_time';
            $log_model = model('userGoldLog')->field($fields)->order('id desc')->paginate()->each(function($item,$key){
                $item['no'] = $item['param']->no;
                $item['time'] = substr($item['update_time'],0,10);
                unset($item['param'],$item['update_time']);
                return $item;
            });
            return ['code'=>1,'msg'=>'获取成功','data'=>$log_model];
        }

        return view('integralMore',[
        ]);
    }


    //员工
    public function users()
    {
        //判断用户等级
        if($this->user_model['type']=='city') {//城市经理
            $view ='usersCity';//显示页面
            $where = [
                ['type','=','pro'],//员工类型
                ['team_no','=',$this->user_model['team_no']],
            ];
        }elseif($this->user_model['type']=='pro'){//项目经理
            $view = 'usersPro';//显示页面
            $where = [
                ['type','=','staff'],//员工类型
                ['team_no','=',$this->user_model['team_no']],
                ['team_slice_no','=',$this->user_id]
            ];

            //按类型搜索
            $id = $this->request->param('id',0,'intval');
            !empty($id) && array_push($where ,['tid','=',$id]);


            //员工类型
            $this->assign('staff_type',model('user_type')->where('en','=','staff')->select());
        }else{//普通员工
            return $this->redirect('index');
        }
        //关键字搜索
        $keyword = $this->request->param('keyword','','trim');
        !empty($keyword) && array_push($where,['cellphone|user_name|nickname','like','%'.$keyword.'%']);
        if($this->request->isAjax()){
            $model = $this->user_model->with(['userType'])->where($where)->paginate(5);
            return ['code'=>1,'msg'=>'获取成功','data'=>$model];
        }

        return view($view,[
            'keyword' => $keyword
        ]);
    }

    //统计中心
    public function statistics()
    {
        //当月时间
        $current_month = strtotime(date('Y-m'));
        //员工总数
        //这个月数量
        $current_mouth_worker = $this->user_model->where([
            ['team_no','=',$this->user_model['team_no']],
            ['auth_time','>',$current_month]
        ])->count();

        $worker_num = $this->user_model
            ->where(['team_no'=>$this->user_model['team_no']])
            ->count();

        $current_month_gold = model('user_gold_log')
            ->where([['uid','=',$this->user_id],])
            ->whereTime('update_time','>',$current_month)
            ->sum('gold');
        //项目统计
        $project_model = model('Project');
        //当月完成数量
        $current_month_pro_num = $project_model->getProInfo($this->user_model,[['status','=',4],['auth_time','>',$current_month]],'count');
        //进行中
        $current_month_pro_wait_complete_num = $project_model->getProInfo($this->user_model,[['status','=',3],['auth_time','>',$current_month]],'count');

        return view('statistics',[
            'user_model' => $this->user_model,
            'worker_num' => $worker_num,
            'current_mouth_worker' => $current_mouth_worker,
            'current_month_gold' => $current_month_gold,
            'current_month_pro_num' =>$current_month_pro_num,
            'current_month_pro_wait_complete_num' =>$current_month_pro_wait_complete_num,
        ]);
    }

    //统计中心
    public function extension()
    {
        $req_code = $this->request->root(true).'/index/index/req_code/'.$this->user_model->encodeReqCode($this->user_id);
//        dump($req_code);exit;
        $team_model = model('user_team');

        return view('extension',[
            'model' =>$this->user_model,
            'team_model'=>$team_model,
            'req_code' =>$req_code,
        ]);
    }

    //申请加入团队
    public function usersReq()
    {
        //申请状态 1可以申请 2待审核 3已通过
        if($this->user_model['team_no']){
            $state = 3;
        } else {
            $record = model('userReq')->where(['uid'=>$this->user_id])->order('id','desc')->find();
            $state = $record['status']===0?2:1;
        }

        return view('usersReq',[
            'state' => $state
        ]);
    }
    //申请加入团队操作
    public function usersReqAction()
    {
        $team_uid = $this->request->param('team_uid');
        $team_id = $this->request->param('team_id');
        $group_no = $this->request->param('group_no',0,'intval');

        $reason = $this->request->param('reason','','trim');
        empty($team_uid) && abort(200,json_encode(['code'=>0,'msg'=>'团队用户信息异常']));
        empty($team_id) && abort(200,json_encode(['code'=>0,'msg'=>'团队信息异常']));

        !empty($this->user_model['team_no']) &&  abort(200,json_encode(['code'=>0,'msg'=>'您已加入团队无法操作']));
        //验证是否有申请记录
        $req_model = model('userReq');
        $record = $req_model->where(['uid'=>$this->user_id,'status'=>0])->find();
        !empty($record)  &&  abort(200,json_encode(['code'=>0,'msg'=>'已有申请记录，请等待审核']));
        ////绑定依赖注入--绑定通知
        bind('app\common\model\BaseModel',$this->user_model);

        $req_model->save([
            'uid' => $this->user_id,
            'team_no'=> $team_id,
            'team_slice_no'=> $group_no, //团队组
            'req_reason'=>$reason
        ]);

        return ['code'=>1,'msg'=>'您已申请，请耐心等待审核'];

    }
    //退出团队
    public function outTeam()
    {
        $this->user_model->save([
            'team_no' => 0,
        ]);
    }
//    public function testMsg()
//    {
//
//        $model = model('Users');
//        $model = $model->where('id','=',$this->user_id)->find();
//
//        $obj = new \wechat\TemplateMsg();
//        //发送消息
//        $temp_msg_obj = new \wechat\temp_msg\JobSend();
//        $pro_model = model('project');
//        $pro_model = $pro_model->where('id','=',3)->find();
//        $temp_msg_obj->setMsgData($pro_model);
////        dump($obj->getAllPrivateTemplate());
//        dump($obj->send($model['wechat_openid'],$temp_msg_obj,$this->request->root(true)));
//        dump(\wechat\Wechat::getGlobalAccessToken());exit;
//    }

    //用户提现
    public function money()
    {
        return view('money',[
            'model'=>$this->user_model
        ]);
    }

    //用户提现
    public function moneyAction()
    {
        $input_data = $this->request->param();
        $input_data['uid'] = $this->user_id;
        $validate = new \app\common\validate\UserReqMoneyValidate();

        $model = new \app\common\model\UserReqMoney();
        bind('app\common\model\Users',model("users")->where('id','=',$this->user_id)->find());
        return $this->_dataSave($model,$input_data,$validate);
    }
}