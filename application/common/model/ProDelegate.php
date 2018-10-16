<?php
namespace app\common\model;

use Think\Model;

class ProDelegate extends BaseModel
{

    //项目流程记录
//    protected $observerClass = 'app\common\event\ProFlow';

    protected $tableName='pro_delegate';
    protected $autoWriteTimestamp = false   ;

    protected $auto = ['last_time','type','uid'];
    protected $insert = [];

    protected function setLastTimeAttr($value,$data)
    {
        return date('Y-m-d H:i:s');
    }

    protected function setTypeAttr($value,$data)
    {
        return $value;
    }

    protected function setUidAttr($value,$data)
    {
        return $value ? $value : (empty($data['user_id'])?0:$data['user_id']);
    }

    protected static function init()
    {

        //绑定监听事件
        //记录项目流程
        self::observe(\app\common\event\ProFlow::class);
        //发送通知
        self::observe(\app\common\event\SendNotice::class);


        self::event('before_insert', function ($model) {
            $model->opt_flow = 'insert';
        });
        self::event('before_update', function ($model) {
            $model->opt_flow = 'update';
        });
        self::event('before_delete', function ($model) {
            $model->opt_flow = 'delete';
        });
        //判断是否已有指定的人员
        self::event('before_write', function ($model) {
            //城市和项目经理只能唯一
            if($model['type']=='city' || $model['type']=='pro') {
                $where = [
                    ['type','=',$model['type']],
                    ['pid','=',$model['pid']]
                ];
                $info = $model->where($where)->order('id desc')->find();
                if($info){
                    $model->isUpdate(true, ['id'=>$info['id']]);
                }
            }
        });
        //判断是否已有指定的人员
        self::event('after_write', function ($model) {
            //城市
            if($model['type']=='city') {
                //更新项目团队信息
                $user_model = model('Users')->where('id','=',$model['uid'])->find();
                model('Project')->save([
                    'team_no' => $user_model['team_no']
                ],['id'=>$model['pid']]);
            }
        });
    }

    //关联项目
    public function linkProject()
    {
        $this->belongsTo('Project','pid');
    }

    //获取用户信息
    public function linkUserInfo()
    {
        return $this->belongsTo('Users','uid');
    }

    //获取用户信息
    public function linkUsers()
    {
        return $this->hasOne('Users','id','uid');
    }



    //获取流程信息--流程记录
    public function getFlowIntro()
    {
        //城市和项目经理只能唯一
        if($this['type']=='city' || $this['type']=='pro') {
            $opt_name = '';
            if($this->opt_flow == 'insert') {
                $opt_name= '指派';
            } elseif($this->opt_flow == 'update' ) {
                $opt_name = '更新';
            }elseif($this->opt_flow == 'delete') {
                $opt_name = '移除';
            }
            return '项目'.$opt_name.':'.(isset(UserType::$user_type[$this['type']])?UserType::$user_type[$this['type']]:'');
        }

    }

    //获取项目id
    public function getProId()
    {
        return ['id'=>$this->pid];
    }

    //通知事件--通知类型
    public function eventNoticeType()
    {
        return 'project';
    }

    //通知事件--通知标题
    public function eventNoticeTitle($project_model)
    {
        return $project_model->title;
    }

    //通知事件--通知简介
    public function eventNoticeIntro($project_model)
    {
        $opt_name = '';
        if($this->opt_flow == 'insert') {
            $opt_name= '指派';
        } elseif($this->opt_flow == 'update' ) {
            $opt_name = '更新';
        }elseif($this->opt_flow == 'delete') {
            $opt_name = '移除';
        }
        return '项目'.$opt_name.':'.(isset(UserType::$user_type[$this['type']])?UserType::$user_type[$this['type']]:'');
    }
}