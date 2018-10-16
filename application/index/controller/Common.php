<?php
namespace app\index\controller;

use think\Controller;
use think\Model;
use think\Validate;

class Common extends Controller
{
    protected $user_id = 0; //当前登录管理员
    protected $team_no = 0; //团队编号
    protected $team_slice_no = 0; //团队组编号
//    protected $user_type = 4;//用户类型
    protected $request;

    public function initialize()
    {
        //测试专用
//        session('user_info',['user_id'=>20]);
//        session('req_user_id',2);
        //请求对象
        $this->request = request();

        //具体生成session代码请查看 \\app\\http\\middleware\\ListenWechatAuth
        $this->user_id = session('user_info.user_id');
    }




    /*
     * 保存操作
     * */
    protected function _dataSave(Model &$model, $input_data,Validate $validate=null)
    {


        if($validate && !$validate->check($input_data)){
            return ['code'=>0,'msg'=>$validate->getError()];
        }

        $where = [];
        $pk = $model->getPk();
        if(!empty($input_data[$pk])){
            $where[$pk] = $input_data[$pk];
        }
//        dump($input_data);exit;
        // 过滤post数组中的非数据表字段数据
        $state = $model->allowField(true)->save($input_data,$where);
        return ['code'=>$state?1:0,'msg'=>'操作'.($state?'成功':'失败')];
    }
}