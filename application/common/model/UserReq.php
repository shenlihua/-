<?php
namespace app\common\model;

use Think\Model;

class UserReq extends BaseModel
{
    protected $tableName='user_req';

    public static $fields_status = ['待处理','已通过','被拒绝'];


    protected $insert = ['status'=>0,'last_time'];
    protected $auto = ['status'];

    protected $autoWriteTimestamp = false;

    /*
     *
     * */
    public static function init()
    {
        //绑定监听事件
        //发送申请、审核通知
        self::observe(\app\common\event\SendNotice::class);
        //更新成功后
        self::event('after_update',function($model){
             //如果更新成功--且通过审核
            if(isset($model['status']) && $model['status']=1) {
                //同步用户数据
                model('users')->update([
                    'team_no'=>$model['team_no'],
                    'team_slice_no'=>$model['team_slice_no'],
                    'is_auth'=>1,
                    'auth_time'=>time(),
                ],[['id','=',$model['uid']]]);
            }
        });
    }
    //加入时间
    protected function setLastTimeAttr($value,$data)
    {
        return time();
    }

    protected function setStatusAttr($value,$data)
    {
        if($value==1 || $value==2) {
            $this->opt_uid = self::$opt_user_id;
            $this->handle_time = time();
            $value==1 && $this->handle_reason = empty($data['handle_reason'])?'恭喜您通过审核':$data['handle_reason'];
        }
        return $value;
    }


    //加入时间
    protected function getLastTimeAttr($value)
    {
        return date('Y-m-d H:i:s',$value);
    }

    /*
     * 添加邀请/申请记录
     * */
    public function recordData(Users $user_model,$req_uid=0)
    {
        //绑定依赖注入
        bind('app\common\model\BaseModel',$user_model);
        //获取邀请者信息
        $req_user_info = $user_model->where('id','=',$req_uid)->find();

        $this->save([
            'uid' => $user_model['id'],
            'team_no'=>$req_user_info['team_no'],
            'team_slice_no' => $req_user_info['team_slice_no'],
            'req_uid' => $req_uid,
        ]);
    }

    /*
     * 用户申请、审核
     * */
    public function eventNoticeType()
    {

        return empty($this['status']) ? 'user_req' : 'user_auth';
    }

    /*
     * 通知标题
     * */
    public function eventNoticeTitle($user_model)
    {
        if(empty($this['status'])) {
            return '用户申请';
        }else {
            return $this['status']==1?'审核通过':'审核拒绝';
        }
    }

    /*
     * 通知简介
     * */
    public function eventNoticeIntro($user_model)
    {
        if(empty($this['status'])) {
            return '用户'.($user_model['user_name']?$user_model['user_name']:$user_model['nickname'])
                .'手机号'.$user_model['cellphone']
                .' 申请加入团队';
        }else {
            return $this['handle_reason'];
        }
    }
    /*
     *
     * */
    public function getProId()
    {
        return ['id'=>$this['id']];
    }
    public function eventGetNoticeUid()
    {
        $nc_uid = 0;
        if(empty($this['status'])) {
            if(empty($this['req_uid'])) { //通知城市合伙人
                $nc_uid = model('UserTeam')->where('id','=',$this['team_no'])->value('uid');
            }else {
                $nc_uid = $this['req_uid'];
            }
        }else {
            $nc_uid = $this['uid'];
        }
        return $nc_uid ;//empty($this['status']) ? $this['req_uid'] : $this['uid'];
    }
}