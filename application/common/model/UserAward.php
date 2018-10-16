<?php
namespace app\common\model;

use Think\Model;

class UserAward extends BaseModel
{
    protected $tableName='user_award';

    protected $json=['param'];

    //发放奖励时间
    const SEND_DAY=0; //天数-- 0立即发放 1 一天后发放

    //获取发放时间
    public function getSendTime($user_id)
    {
        return time()+self::SEND_DAY*86400;
    }

    //发放奖励
    public function sendAward()
    {
        $award_list = $this->where([
            ['status','=',0],
            ['send_time','<=',time()]
        ])->select();

        //发放奖励
        foreach($award_list as $vo) {
            if($vo['type'] == 'project') {
                $model = model('Project')->where('id','=',$vo['relation_id'])->find();
            }
            $type = new \award_type\Project($model);

            $user_model = new Users();// model('Users');
            $user_model = $user_model->where('id','=',$vo['uid'])->find();
            $result = $user_model->updateGold($user_model,$vo['gold'],$vo,$type);
            if($result){
                $vo->status=1;
                $vo->save();
            }
        }

    }
}