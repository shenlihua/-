<?php
namespace award_type;

class ReqMoney implements IType
{
    protected $type = 'req_money';
    protected $model;

    public function __construct(\app\common\model\UserReqMoney $model)
    {
        $this->model = $model;
    }

    public function getNotice($gold)
    {
        return '用户提现:'.$gold;
    }

    public function getExtraData()
    {
        return ['id'=>$this->model['id'],'no'=>$this->model['no']];
    }
}