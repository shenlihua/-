<?php
namespace app\admin\controller;

class Money extends Common
{
    public function index()
    {
        $keyword = $this->request->param('keyword','','trim');

        $where = [];
        !empty($keyword) && $where[] = ['no','like','%'.$keyword.'%'];

        if($this->is_manage) { //管理员

        }elseif($this->type=='city') { //城市经理
            $where[] = ['team_no','=',$this->team_no];//查看团队数据
        } elseif ($this->type=='pro') { //项目经理
            $where[] = ['team_no','=',$this->team_no];
            $where[] = ['team_slice_no','=',$this->user_id]; //只能查看自己下级的数据
        }

        $list = model('UserReqMoney')->withJoin('linkUsers')->where($where)->order('id','desc')->paginate();

        return view('index',[
            'keyword' => $keyword,
            'list' => $list
        ]);
    }

    //金额操作
    public function optMoneyAction()
    {
        $input_data = $this->request->param();
        $input_data['opt_id'] = $this->user_id;
        $input_data['auth_time']  = time();
        $validate = new \app\common\validate\UserReqMoneyValidate();
        $validate->scene('opt_money');

        $model = new \app\common\model\UserReqMoney();
        $info = $model->where('id','=',$input_data['id'])->find();
        bind('app\common\model\Users',model("users")->where('id','=',$info['uid'])->find());
        return $this->_dataSave($model,$input_data,$validate);
    }
}