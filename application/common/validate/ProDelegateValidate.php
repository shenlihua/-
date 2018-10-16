<?php

namespace app\common\validate;

use think\Validate;

class ProDelegateValidate extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
	    'pid' => 'require',
	    'type' => 'require',
        'user_id' => 'require|gt:0',
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'pid.require' => '操作异常:id',
        'type.require' => '操作异常:type',
        'user_id.require' => '请选择用户',
        'user_id.gt' => '请选择用户',
    ];

    protected $scene = [
        'admin_add' => ['type','user_id'],
        'wechat_add' => ['pid','type','user_id']
    ];
}
