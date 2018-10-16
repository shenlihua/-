<?php
namespace app\common\model;


use think\model\concern\SoftDelete;

class SysLocation extends BaseModel
{
    use SoftDelete;

    protected $tableName='sys_location';

    protected $auto = ['last_time','pid'];

    //获取城市信息
    public function getLocation($where = [],$fields='*')
    {
        $list = $this->field($fields)->where($where)->order('sort asc')->select();
        return $list;
    }

    public function setLastTimeAttr($value)
    {
        return time();
    }

    public function setPidAttr($value)
    {
        return $value?$value:0;
    }
}