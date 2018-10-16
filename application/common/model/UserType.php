<?php
namespace app\common\model;

use Think\Model;

class UserType extends BaseModel
{
    protected $tableName='user_type';
    //用户等级排序
    public static $type_level = ['manage','city','pro','staff'];

    public static $user_type = [
        'manage' => '后台管理员',
        'city' => '城市经理',
        'pro' => '项目经理',
        'staff' => '员工'
    ];

    //可邀请哪几种用户类型
    public static $user_req_type = [
        'city' => ['pro'],
        'pro' => ['staff'],
        'staff' => [],
    ];

    //获取用户职位名称
    public static function getTypeName($id,$type='img')
    {
        if ( $type == 'img' ) {
             switch ($id){
                 case 1:
                     $img_id = 2;
                     break;
                 case 2:
                     $img_id = 3;
                     break;
                 case 3:
                     $img_id = 0;
                     break;
                 case 4:
                     $img_id = 4;
                     break;
                 case 5:
                     $img_id = 5;
                     break;
                 case 6:
                     $img_id = 6;
                     break;
                 default:
                     $img_id = 0;
                     break;
             }

             return '/static/images/me_'.$img_id.'.png';
        }
    }

    public function childType()
    {
        return $this->hasMany('UserType','pid');
    }
}