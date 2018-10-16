<?php
namespace app\common\model;

use Think\Model;

//用户提现
class UserReqMoney extends BaseModel
{
    protected $tableName='user_req_money';
    protected $insert = ['no'];
    public static $fields_status = ['','待审核','已发放','已拒绝'];
    public static function init()
    {
        self::event('after_update',function($model,Users $user_model){
            if(!empty($model['status']) && $model['status']==3) {
                $user_model->updateGold($user_model,$model['money'],(new \award_type\ReqRefuseMoney($model)));
            }
        });

        self::event('after_insert',function($model,Users $user_model){
            $user_model->updateGold($user_model,-$model['money'],(new \award_type\ReqMoney($model)));
        });
    }




    protected function setNoAttr()
    {
        $cache_name = __CLASS__.date('Y-m-d');
        $number = cache($cache_name);
        if(!$number) {
            $number = 1;
        }
        $number+=1;
        cache($cache_name,$number,86400);

        return date('YmdHis').sprintf('%06d',$number);
    }

    public function linkUsers()
    {
        return $this->belongsTo('Users','uid');
    }
}