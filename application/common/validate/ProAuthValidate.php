<?php

namespace app\common\validate;

use think\Validate;

class ProAuthValidate extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
        'content' => 'require|length:1,200',
        'pid' => 'require|checkAuthStatus'
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'content.require'=>'内容必须输入',
        'content.length'=>'内容必须输入且，长度不能超过200字符',
        'pid.require'=>'请求参数异常:pid',
    ];

    protected function checkAuthStatus($value,$data)
    {
        $project_model = model('Project');
        $is_auth = $project_model->where(['id'=>$value])->value('is_auth');
        if($is_auth==1) {
            return '项目已提交审核，无需再次提交';
        }elseif($is_auth==2){
            return '项目已通过审核，无需再次提交';
        }
        return true;
    }


}
