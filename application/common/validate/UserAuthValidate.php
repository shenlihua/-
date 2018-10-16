<?php

namespace app\common\validate;

use think\Validate;

class UserAuthValidate extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
	    'id' => 'require|checkStatus',
	    'status' => 'require',
        'handle_reason' => 'requireIf:status,2'
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'id.require' => '申请信息异常',
        'status.require' => '审核状态必须选择',
        'handle_reason.requireIf' => '请填写拒绝理由',
    ];

    public function checkStatus($value,$data)
    {
        $model = model('UserReq')->where('id','=',$value)->find();
        if($model['status']!==0) { //未处于待审核状态
            return '已被处理无需再次操作';
        }
        return true;
    }
}
