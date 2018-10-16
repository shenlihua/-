<?php
namespace app\admin\controller;
use app\common\model\BaseModel;
use think\Controller;
use think\Model;
use think\Validate;

class Common extends Controller
{
    protected $user_id = 0; //当前登录管理员
    protected $team_no = 0; //团队编号
    protected $team_slice_no = 0; //团队组编号
    protected $type; //当前登录者用户类型
    protected $is_manage=0;//是否是管理员登录
    //是否必须验证
    protected $is_verify = true;
    //过滤验证
    protected $is_action_verify = array();

    //七牛图片地址
    protected $qn_domain;
    protected function initialize()
    {
        if(session('?admin_auth_info')) {
            $this->user_id = session('admin_auth_info.user_id');
            $this->team_no = session('admin_auth_info.team_no');
            $this->team_slice_no = session('admin_auth_info.team_slice_no');
            $this->type = session('admin_auth_info.type');
            $this->is_manage = session('admin_auth_info.is_manage');
        }

        if((!$this->user_id && ($this->is_verify && !in_array(strtolower(request()->action()), $this->is_action_verify)))){
            if(request()->ISAJAX()){
                abort(200,json_encode(['code'=>-1,'msg'=>'请先登录']));
            }else{
                $this->redirect('Index/login');
            }
        }
        //模型绑定操作者用户id
        BaseModel::$opt_user_id = $this->user_id;

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
            //更新数据保留数据原始数据
            $model = $model->where($where)->find();
        }

//        dump($input_data);exit;
        // 过滤post数组中的非数据表字段数据
        $state = $model->allowField(true)->save($input_data,$where);
        return ['code'=>$state,'msg'=>'操作'.($state!==false?'成功':'失败')];
    }
    /*
     * 保存操作--字段状态切换
     * @param model object 模型独享
     * @param where array 处理条件
     * @param status int 切换结果
     * @param status_fields 对应数据库字段
     * */
    protected function _changeField(Model $model, $where, $status=0 ,$status_fields = 'status')
    {

        $bool = $model->where($where)->setField($status_fields, $status);
        if ($bool!==false) {
            $result['code'] = 1;
            $result['message'] = '操作成功';
        } else {
            $result['code'] = -1;
            $result['message'] = '操作失败';
        }
        $this->ajaxReturn($result);
    }

    /*
     * 软删除数据
     * */
    protected function _softDel(Model $model,$where=array())
    {
        if(!$where){
            return ['code'=>0,'msg'=>'条件异常'];
        }
        $state = $model->destroy($where);
        return ['code'=>(int)$state,'msg'=>'删除'.($state?'成功':'失败')];
    }
}