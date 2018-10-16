<?php

namespace app\index\controller;

use think\Controller;
use think\Request;

class Upload extends Controller
{
    public function upload($type='')
    {
        // 获取表单上传文件 例如上传了001.jpg
        $file = request()->file('file');
        // 移动到框架应用根目录/uploads/ 目录下
        $path = '/images'.($type?'/'.$type:'');
        $info = $file->move('../public/'.$path);
        if($info){
            $save_name = $info->getSaveName();
            $save_name = str_replace('\\','/',$save_name);
            return ['code'=>0,'msg'=>'上传成功','path'=>$path.'/'.$save_name];
        }else{
            // 上传失败获取错误信息
            return ['code'=>0,'msg'=>$file->getError()];
        }
    }

}
