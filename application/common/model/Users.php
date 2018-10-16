<?php
namespace app\common\model;

use app\common\model\traits\Location;
use Think\Model;

class Users extends BaseModel
{
    use Location;

    //生成签名用的加密字符串

    protected $tableName='users';

    public static $fields_sex = ['未知','男','女'];

    protected $insert = ['status'=>1,'header'];

    protected $auto = ['sex'=>0];

    public static function init()
    {

        //新增用户前
//        self::event('before_insert', function ($model) {
//            if (isset($model['req_id']) && $model['req_id']) {//绑定团队信息
//                $req_user_info = $model->where('id','=',$model['req_id'])->find();
//                $model->team_no = $req_user_info['team_no'];
//                $model->team_slice_no = $req_user_info['team_slice_no'];
//            }
//        });

        //新增用户后
        self::event('after_insert', function ($model) {
            if (isset($model['req_id']) && $model['req_id']) {//添加邀请记录
                model('UserReq')->recordData($model,$model['req_id']);
            }
            //非邀请情况下-存在团队id 更新对应用户
            if(empty($model['req_id']) && isset($model['team_no']) && $model['team_no']){
                //创建项目组
                $team_model = model('UserTeam');
                $team_model->modTeamUser($model, $model['team_no']);
            }
        });


        //操作用户成功前--包含更新 修改 删除
        self::event('before_write', function ($model) {
            //任命城市经理--创建项目组
            if(isset($model['type']) && $model->getOrigin('type')!='city' && $model['type']=='city' ) {
                //项目组
                $team_model = model('UserTeam');
                $model->team_no = $team_model->recordData($model['id']);
                //团队组清空
                $model->team_slice_no = 0;
            }elseif(isset($model['type']) && $model->getOrigin('type')=='city' && $model['type']!='city') { //团队解散
                //项目组--停用
                $team_model = model('UserTeam');
                $team_model->destroy($model['team_no']);
                $model->team_no = 0 ;
                //团队组清空
                $model->team_slice_no = 0;
            }
            //团队
            if(isset($model['type']) && $model->getOrigin('type')!='pro' && $model['type']=='pro') {
//                $model->team_slice_no = !empty($model['id'])?$model['id']:0;
            }elseif(isset($model['type']) && $model->getOrigin('type')=='pro' && $model['type']!='pro') {
                //解散团队
                if(!empty($model['id'])){
                    $model->where('team_slice_no','=',$model['id'])->setField('team_slice_no',0);
                }
            }



        });

    }

    protected function setMoneyAttr($value)
    {
        return sprintf('%.2f',$value);
    }

    protected function setTidAttr($value,$data)
    {
        //绑定账户类型
        $this->data('type',model('user_type')->where('id','=',$value)->value('en'));
        return $value;
    }


    //用户密码
    protected function setPasswordAttr($value)
    {

        if(empty($value)){
            array_push($this->readonly,'password');
            return;
        }
        $salt = $this->getUserSalt();
        return self::entryPwd($salt,$value);
    }


    protected function setHeaderAttr($value)
    {
        return $value?$value:'/images/header/default_header_'.rand(1,8).'.png';
    }

    //用户密码
    protected function setNicknameAttr($value,$data)
    {
        return $value ? $value : $data['cellphone'];
    }



    /*
     * 绑定微信信息
     * */
    public function setWechatInfoAttr($value)
    {
        $this->data('wechat_openid',$value['openid']);
        $this->data('nickname',$value['nickname']);
        $this->data('header',$value['headimgurl']);
        $this->data('wechat_token',$value['access_token']);
        $this->data('wechat_refresh_token',$value['refresh_token']);
        $this->data('wechat_update_time',time()+$value['expires_in']);//token有效期
        $this->data('sex', $value['sex']);//性别 1男 2女
//        dump($this);
//        dump($value);exit;
    }

    public function getUserSalt()
    {
        if(!array_key_exists('salt', $this->getdata())) {
            $this->data('salt',rand(10000,99999));
        }
        return $this->getdata('salt');
    }
    /*
     * 用户密码加密
     * */
    public static function entryPwd($salt,$pwd)
    {
        return $pwd?md5($pwd.md5($pwd.$salt).$salt):'';
    }

    /*
     * 用户分类--
     * */
    public function userType()
    {
        return $this->belongsTo('UserType','tid');
    }

    /*
     * 关联模型-我邀请的人
     * */
    public function userReqUser()
    {
        return $this->hasMany('Users','req_id');
    }

    /*
     * 保存登录凭证
     * */
    public function loginInfo()
    {
        session('user_info',[
            'user_id' => $this->id,
        ]);
    }



    /*
     * 更新用户token
     * */
    public function updateWechatToken(self $model,$wechat_auth_info)
    {
        //更新登录信息
        $model->update(array(
            'wechat_openid' => $wechat_auth_info['openid'],
            'wechat_token' => $wechat_auth_info['access_token'],
            'refresh_token' => $wechat_auth_info['refresh_token'],
            'wechat_update_time' => time()+7200,
        ),[['id','=',$model['id']]]);
    }

    /*
     * 获取用户职位
     * */
    public function getUserPosition($tid=0)
    {
        return UserType::getTypeName($tid);
    }

    /*
     * 生成邀请码随机盐
     *
     * */
    protected function generateSalt()
    {
        return '123456abc.';
    }


    /*
     * 用户申请
     * */
    public function linkUserReq()
    {
        return $this->hasOne('UserReq','uid');
    }

    /*
     * 项目经理下面的人
     * */
    public function linkProDownUser()
    {
        return $this->hasMany('Users','team_slice_no');
    }

    /*
     * 更新用户金额
     * */
    public function updateGold(self $user_model,$gold,\award_type\IType $type)
    {
        try{
            $user_model->startTrans();
//            $user_info = $this->where('id','=',$user_id)->find();
            $before_gold = $user_model['gold'];
            $after_gold = $before_gold+$gold;

            $this->gold = $after_gold;
            $this->history_gold = $user_model['history_gold']+$gold;
            $user_model->save();
            $log_model = model('user_gold_log');
            $log_model->insert([
                'uid' => $user_model['id'],
                'intro' => $type->getNotice($gold),
                'gold_before' => $before_gold,
                'gold' =>$gold,
                'gold_after' => $after_gold,
                'param' => $type->getExtraData(),
                'update_time' => time()
            ]);

            $user_model->commit();
            return true;
        }catch (\Exception $e) {
            $user_model->rollback();
            \Log::record('数据操作异常'.$e->getMessage(),'change_gold');
            return false;
        }

    }

}