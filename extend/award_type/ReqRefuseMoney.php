<?php
namespace award_type;

class ReqRefuseMoney implements IType
{
    protected $type = 'req_refuse_money';
    protected $model;

    public function __construct(\app\common\model\UserReqMoney $model)
    {
        $this->model = $model;
    }

    public function getNotice($gold)
    {
        return '审核被拒反还额度:'.$gold;
    }

    public function getExtraData()
    {
        return ['id'=>$this->model['id'],'no'=>$this->model['no']];
    }
}