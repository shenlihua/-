<?php

namespace app\common\validate;

use think\Validate;

class UserValidate extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'req_id' => 'require|gt:0',
        'tid' => 'require',
        'province' => 'require|gt:0',
        'city' => 'require|gt:0',
        'user_name' => 'requireWith:bank_card',
        'cellphone' => 'require|length:11|unique:users',
        'user_card' => 'unique:users',
        'bank_card' => 'unique:users',
        'bank_location' => 'requireWith:bank_card',
        'password' => 'requireCallback:checkPwdRequire',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */
    protected $message = [
        'req_id.require' => '必须拥有邀请对象才能进行注册',
        'req_id.gt' => '必须拥有邀请对象才能进行注册',

        'tid.require' => '请选择用户类型',
        'province.require' => '请选择省份',
        'province.gt' => '请选择省份',
        'city.require' => '请选择城市',
        'city.gt' => '请选择城市',
        'cellphone.require' => '手机号必须输入',
        'cellphone.length' => '手机号长度必须11位',
        'cellphone.unique' => '用户已存在',

        'user_card.require' => '身份证号必须输入',
        'user_card.unique' => '身份证号已存在',

        'bank_card.require' => '银行卡号必须输入',
        'bank_card.unique' => '银行卡号已存在',

        'user_name.require' => '用户名必须填写',
        'user_name.requireWith' => '银行卡输入后用户名称必须填写',

        'bank_location.require' => '开户行必须输入',
        'bank_location.requireWith' => '银行卡输入后开户行称必须填写',

        'password.require' => '密码必须输入',
        'password.requireCallback' => '密码必须输入',
    ];

    protected $scene = [
        'admin_add'  =>  ['tid','cellphone','password','province','city','bank_card','user_name','bank_location'],
    ];

    // edit 验证场景定义
    public function sceneWechat()
    {
        return $this->only(['province','city','user_name','user_card','bank_card','bank_location','cellphone'])
            ->append('user_name', ['require'])
            ->remove('user_name', ['requireWith'])


            ->append('user_card', ['require'])
            ->append('bank_card', ['require'])

            ->append('bank_location', ['require'])
            ->remove('bank_location', ['requireWith'])
            ;
    }

    //关联用户信息
    public function sceneLinkAccount()
    {
        return $this->only(['cellphone','wechat_info'])
            ->remove('cellphone', 'unique')
            ->append('cellphone', 'checkCellPhoneExist')
            ->append('wechat_info', 'require|checkWechatInfo')
            ;
    }

    protected function checkPwdRequire($value,$data)
    {
        if(empty($data['id'])){
            return true;
        }
        unset($data['password']);
        return false;
    }

    //绑定微信账号验证手机号是否存在
    protected function checkCellPhoneExist($value,$data)
    {
         $user_model = model("Users")->where('cellphone','=',$value)->find();
         if(empty($user_model)) {
             return '该手机号未注册';
         }elseif ($user_model['wechat_openid']) {
             return '该手机号已关联微信号,无法进行此操作';
         }
         return true;
    }

    //绑定微信账号验证手机号是否存在
    protected function checkWechatInfo($value,$data)
    {
        if ( empty($value) || !isset($value['openid']) ) {
            return '微信授权异常';
        }
         $user_model = model("Users")->where('wechat_openid','=',$value['openid'])->find();
         if ($user_model['wechat_openid']) {
             return '该微信号已绑定，无需继续操作';
         }
         return true;
    }
}
