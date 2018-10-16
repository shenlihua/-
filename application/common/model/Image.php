<?php
namespace app\common\model;


use think\model\concern\SoftDelete;

class Image extends BaseModel
{
    use SoftDelete;

    protected $tableName='image';

    protected $auto = ['type'];


    protected function setTypeAttr($value,$data)
    {
        return $value ? $value : 1;
    }


    //获取列表
    public function getList($where = [],$fields='*')
    {
        $list = $this->field($fields)->where($where)->order('sort asc')->select();
        return $list;
    }
}