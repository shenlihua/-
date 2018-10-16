<?php
namespace app\common\model;

use think\Model;

class BaseModel extends Model
{
    //当前操作模型的用户
    public static $opt_user_id = 0;
    //hash值
    protected $hashids_length=10;

    protected $autoWriteTimestamp = true;

    public static $fields_status = ['','正常','禁用'];
    //操作流程
    protected $opt_flow;

//    protected static function init()
//    {
//
////        self::event('before_insert',function($model){
////            dump($model);exit;
////        });
//    }


    /*
     *
     * 用户邀请码生成
     * */
    public function encodeReqCode($value)
    {

        $hashids = new \hashids\Hashids($this->generateSalt(), $this->hashids_length);
        return $hashids->encode($value);
    }

    /*
     * 解密邀请码
     * */
    public function decodeReqCode($hash)
    {
        $hashids = new \hashids\Hashids($this->generateSalt(), $this->hashids_length);
        $arr = $hashids->decode($hash);
        return isset($arr[0])?$arr[0]:'';
    }


    /*
     * 生成邀请码随机盐
     *
     * */
    protected function generateSalt()
    {
        return '';
    }
}