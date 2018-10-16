<?php

namespace app\common\validate;

use think\Validate;

class UserReqMoneyValidate extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
	    'money' => 'require|gt:0',
        'uid'=>'require|checkMoney',

        'id' => 'require|gt:0|checkOptStatus',
        'status' => 'require|in:2,3',
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'money.require' => '请输入提现金额',
        'money.gt' => '提现金额必须大于0',
        'uid.require' => '操作异常',
        'id.require' => '操作异常 :attribute',
        'id.gt' => '操作异常 :attribute',
        'status.require' => '操作异常 :attribute',
        'status.in' => '操作异常 :attribute',
    ];

    protected $scene = [
        'opt_money' => 'id,status'
    ];


    public function checkMoney($value,$rule,$data)
    {
        $model = model('Users')->where('id','=',$value)->find();
        if($data['money'] > $model['gold']) { //未处于待审核状态
            return '用户额度不足';
        }
        return true;
    }
    public function checkOptStatus($value,$rule,$data)
    {
        $model = model('UserReqMoney')->where('id','=',$value)->find();
        if(empty($model)) { //未处于待审核状态
            return '该记录不存在';
        }
        if($model['status']!=1) { //未处于待审核状态
            return '该申请未处于申请状态无法操作';
        }
        return true;
    }
}
