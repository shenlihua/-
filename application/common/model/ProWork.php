<?php
namespace app\common\model;

class ProWork extends BaseModel
{
    protected $tableName='pro_work';

    protected $autoWriteTimestamp = false;

    //任务分配信息
    public function linkWorker()
    {
        return $this->hasMany('ProWorker','wid');
    }
}