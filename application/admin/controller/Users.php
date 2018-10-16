<?php

namespace app\admin\controller;

use app\common\model\UserAuthModel;
use app\common\model\UserModel;
use think\Request;

class Users extends Common
{

    //用户列表
    public function index()
    {
        $keyword = request()->param('keyword','','trim');
//        dump($keyword);
        $keyword && $where[] = ['cellphone|nickname|user_name','like','%'.$keyword.'%'];

        $where_fnc =[];
        $where[] = ['status','neq',0];

        $model = model('Users');
        if($this->type=='city') { //城市经理
            $where[] = ['type','<>','manage'];
            $where[] = ['team_no','=',$this->team_no];
        }elseif($this->type=='pro') { //项目经理
            $where[] = ['type','<>','manage'];
            $where[] = ['team_slice_no','=',$this->user_id];
        }else{ //管理员操作
//            $where[] = ['id','=',0];
            $where_fnc=function($query) {
                $query->where('type', '<>', 'manage')->whereNull('type','OR');
            };
        }
        $list = $model->with('userType')->where($where)->where($where_fnc)->paginate();
//        dump($list);exit;

        return view('',[
            'keyword' => $keyword,
            'list' => $list,
            'breadcrumb' => array('fa-users','用户管理','用户列表')
        ]);
    }

    /*
     * 添加用户
     * */
    public function userAdd()
    {
        $id = request()->param('id',0,'intval');
        $model = model('Users');
        $user_info = $model->where('id',$id)->find();

        return view('userAdd',[
             'user_info' => $user_info,
             'breadcrumb' => array('fa-users','用户管理','添加用户')
        ]);
    }

    /*
     * 用户保存操作
     * */
    public function userAddAction(Request $request)
    {
        $input_data = $request->param();
        //新增绑定
        if(empty($input_data['id'])){
            //绑定添加者的团队
            $input_data['team_no'] = $this->team_no;
            //项目经理绑定人员--绑定团队组
            if($this->type=='pro') $input_data['team_slice_no'] = $this->user_id;

            //后台添加的用户直接进入团队
            $input_data['is_auth'] =1;
            $input_data['auth_time'] = time();
        }

        if(empty($input_data['password'])) unset($input_data['password']);

        $validate = new \app\common\validate\UserValidate();
        $validate->scene('admin_add');

        $model = model('Users');
//        dump($input_data);exit;
        return $this->_dataSave($model,$input_data,$validate);
    }

    /*
     * 用户详情
     * */
    public function userDetail(Request $request)
    {
        $id = $request->param('id',0,'intval');
        $model = model('Users');
        $model = $model->with(['userType','userReqUser.userType'])->withCount('userReqUser')->where('id',$id)->find();
//        dump($model);exit;
        return view('userDetail',[
            'model' => $model
        ]);
    }


    //用户人员审核
    public function auth()
    {
        $keyword = $this->request->param('keyword','','trim');
        $where_fnc = $where = [];

//        dump($keyword);
        $keyword && $where[] = ['cellphone|nickname|user_name','like','%'.$keyword.'%'];
        //绑定团队编号

        if($this->type=='city') { //城市经理
            $where[] = ['linkUserReq.team_no','=',$this->team_no];
        }elseif($this->type=='pro') { //项目经理
            $where[] = ['linkUserReq.team_slice_no','=',$this->user_id];
        }else{ //查询不出数据
            $where_fnc=function($query) {
                $query->where('type', '<>', 'manage')->whereNull('type','OR');
            };
        }

        $model = model('Users');
        $list = $model->withJoin('linkUserReq','right')->where($where)->where($where_fnc)->order(['linkUserReq.status'=>'asc','linkUserReq.id'=>'desc'])->paginate();
//        dump($list);exit;
        return view('',[
            'keyword' => $keyword,
            'list' => $list,
        ]);
    }

    //用户审核操作
    public function authAction()
    {
        $input_data = $this->request->param();
        $validate = new \app\common\validate\UserAuthValidate();

        $model = model('UserReq');
        $req_uid = $model->where('id','=',$input_data['id'])->value('uid');

        //绑定依赖注入
        bind('app\common\model\BaseModel',model('Users')->where('id','=',$req_uid)->find());

        return $this->_dataSave($model,$input_data,$validate);
    }

    //团队人员调整
    public function team()
    {
        //过去当前团队所有项目经理
        $user_model = model('users');
        //未指定人员--不包含城市经理跟项目经理
        $not_specified = $user_model->where([
            'team_no' => $this->team_no,
            'team_slice_no' => 0,
        ])->whereNotIn('type',["pro","city"])->select();
        //项目经理
        $pro_model = $user_model->with(['linkProDownUser'])->where([
            'team_no' => $this->team_no,
            'type' => 'pro'
        ])->select();
        return view('team',[
            'not_specified' => $not_specified,
            'pro_model' => $pro_model
        ]);
    }

    //调整人员信息
    public function teamAction()
    {
        $input_data = $this->request->post();
        if(empty($input_data)) return['code'=>0,'msg'=>'人员未调整'];

        $user_model = model('users');
        foreach ($input_data as $key=>$vo) {
            if(is_numeric($key) && is_numeric($vo)) {
                $user_model = $user_model->where('id','=',$key)->find();
                $user_model->team_slice_no = (int)$vo;
                $user_model->save();
            }
        }

        return['code'=>1,'msg'=>'操作成功'];
    }
}