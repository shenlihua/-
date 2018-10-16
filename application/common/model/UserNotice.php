<?php
namespace app\common\model;


class UserNotice extends BaseModel
{
    protected $tableName='user_notice';

    protected $json = ['param'];

    public static $fields_type = [
        'platform'=>array('name'=>'平台通知','uri'=>''),
        'project'=>array('name'=>'项目通知','uri'=>'Project/detail'),
        'user_req' => array('name'=>'用户申请','uri'=>''),
        'user_auth' => array('name'=>'用户申请','uri'=>''),
        ];
}