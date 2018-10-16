<?php

namespace app\common\validate;

use think\Validate;

class News extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
	    'title' => 'require|min:2',
        'img' => 'require',
        'author' => 'require',
        'description' => 'require',
        'content' => 'require',
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'title.require' => '文章标题必须输入',
        'title.min' => '文章标题字符长度必须超过 :rule 位',
        'img.require' => '封面图片必须上传',
        'author.require' => '简介必须输入',
        'content.require' => '详细内容必须输入',
    ];

    protected $scene = [
        'admin_add'  =>  ['title','image','author','description','content'],
    ];

}
