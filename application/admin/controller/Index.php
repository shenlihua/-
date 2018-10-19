<?php

namespace app\admin\controller;

use think\Controller;
use think\facade\Session;
use think\Request;

class Index extends Common
{

    protected $is_action_verify = ['login','loginaction'];

    /**
     * 显示资源列表
     *
     * @return \think\Response
     */
    public function index()
    {

        return view('index',[
            'breadcrumb'=>[]
        ]);
    }

    /*
     * 登录
     * */
    public function login()
    {
        return view('login');
    }

    /*
     * 登录
     * */
    public function loginAction(Request $request)
    {
        $username = $request->post('username','','trim');
        $password = $request->post('password','','trim');
        if(empty($username)){
            return ['code'=>0,'msg'=>'用户名不能为空'];
        }
        if(empty($password)){
            return ['code'=>0,'msg'=>'密码不能为空'];
        }
        $model = model('Users');
        $where['cellphone'] = $username;
        $user_info = $model->with('userType')->where($where)->find();

        $is_manage = $user_info['type']=='manage'?1:0; //是否是管理员登录

        if(empty($user_info)) {
            return ['code'=>0,'msg'=>'用户名或密码错误'];
        }
        if(!$is_manage && $user_info['user_type']['is_login_admin']!=1){
            return ['code'=>0,'msg'=>'你没有权限登录后台'];
        }
        $entry_pwd = $model::entryPwd($user_info['salt'],$password);
        if($entry_pwd!=$user_info['password']){
            return ['code'=>0,'msg'=>'用户名或密码错误'];
        }
        //验证成功后生成session
        session(
            'admin_auth_info' , [
                'is_manager' => 0,
                'user_id' => $user_info['id'],
                'nickname' => $user_info['nickname'],
                'team_no' => $user_info['team_no'],
                'team_slice_no' => $user_info['team_slice_no'],
                'type' => $user_info['type'],
                'type_name' => $is_manage?'系统管理员':$user_info['user_type']['name'],
                'is_manage' => $is_manage,
            ]
        );

        return ['code'=>1,'msg'=>'登录成功'];
    }

    /*
     * 退出
     * */
    public function logout()
    {
        session(null);
        $this->redirect('Index/login');
    }

    /*
     * 城市列表
     * */
    public function location(Request $request)
    {
        $id = $request->param('id');
        $model = new \app\common\model\SysLocation();
//        $model->field(['id','name']);
        $data = $model->getLocation(['pid'=>$id,'status'=>1],'id,name');
        return ['code'=>0,'msg'=>'获取成功','data'=>$data];
    }

    /*
     * 获取指定用户--已审核的用户
     * @param $type string 用户类型
     * */
    public function getChooseUsers($type='',$team_no=0)
    {
        $model = new \app\common\model\Users();
        $fields = 'id,nickname,user_name,cellphone';
        $where['is_auth'] = 1;
        $where['status'] = 1;
        !empty($type) && $where['type'] = $type;
        $team_no && $where['team_no'] = $team_no;
        $data = $model->field($fields)->where($where)->select();
        return ['code'=>0,'msg'=>'获取成功','data'=>$data];
    }
}
