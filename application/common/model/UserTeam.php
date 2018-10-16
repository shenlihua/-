<?php
namespace app\common\model;

use Think\Model;
use think\model\concern\SoftDelete;

class UserTeam extends BaseModel
{
    use SoftDelete;

    protected $tableName='user_team';

    /*
     * 创建团队组
     * */
    public function recordData($uid)
    {
        $this->save([
            'uid' => $uid,
        ]);
        return $this->id;
    }

    /*
     * 创建团队组
     * */
    public function modTeamUser(Users $user_model,$id)
    {
        $this->update([
            'uid' => $user_model['id'],
        ],[['id','=',$id]]);
    }

    /*
     * 生成邀请码随机盐-团队编号加密
     *
     * */
    protected function generateSalt()
    {
        return 'team.';
    }

}