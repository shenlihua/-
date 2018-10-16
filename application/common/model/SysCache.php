<?php
namespace app\common\model;

use Think\Model;

class SysCache extends BaseModel
{
    protected $tableName='sys_cache';


    //缓存类型
//    public static $type_name = array(
//          'proFlow'=>'项目流程',
//          'proSecurity'=>'安全措施',
//          'proCheck'=>'QC检查',
//          'proMaintain'=>'设备维护',
//    );

    /*
     * 获取模版消息
     * @param $type string 类型
     * */
    public function getContent($type)
    {
        //添加缓存
        $content = $this->cache($this->tableName.$type)->where(array('type'=>$type))->value('content');

        return $content;
    }

    /*
     * 保存模版消息
     * */
    public function saveContent($type,$content)
    {
        $state = $this->cache($this->tableName.$type)->where(array('type'=>$type))->setField('content',$content);
        //清空缓存
//        cache($this->tableName.$type,null);
        return $state;
    }
}