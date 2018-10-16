<?php

namespace app\common\validate;

use think\Validate;

class ProjectValidate extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
	    'title' => 'require',
        'number' => 'require|integer',
        'gold'   => 'require',
        'intro'   => 'require',
        'address'   => 'require',
        'coordinate'   => 'require',

        'id' => 'gt:0',
        'content' => 'require|length:1,200',
        'is_auth' => 'require|in:2,3',
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'title.require' => '请输入标题',
        'number.require' => '输入项目人数',
        'number.integer' => '输入项目人数必须为正数',
        'gold.require' => '项目金必须输入',
        'intro.require' => '项目描述必须输入',
        'address.require' => '项目地址必须选择',
        'coordinate.require' => '请在地图中选择一个坐标点',
        'id.require' => '操作异常，请刷新页面重新尝试',
        'id.gt' => '操作异常，请刷新页面重新尝试',

        'content.require' => '请输入内容',
        'content.length' => '内容字符长度只能在1-200位',
        'is_auth.require' => '审核状态异常',
        'is_auth.in' => '审核状态异常',

    ];

    protected $scene=[
        'add_project' => ['id','title','number','gold','intro','address','coordinate'],
        'auth_project' => ['id','is_auth','content']
    ];
}
