<?php
namespace award_type;

class Project implements IType
{
    protected $type = 'project';
    protected $model;

    public function __construct(\app\common\model\Project $model)
    {
        $this->model = $model;
    }

    public function getNotice($gold)
    {
        return '项目'.$this->model['title'].'已完成,奖励:'.$this->model['gold'].'获得:'.$gold;
    }

    public function getExtraData()
    {
        return ['id'=>$this->model['id'],'no'=>$this->model['no']];
    }
}