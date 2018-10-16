<?php
namespace app\common\model;

class ProWorker extends BaseModel
{
    protected $tableName='pro_worker';

    protected $autoWriteTimestamp = false;


    protected static function init()
    {

        //绑定监听事件
        //记录项目流程
        self::observe(\app\common\event\ProWorker::class);

        //判断是否已有指定的人员
        self::event('before_write', function ($model,Project $project_model) {
            //调整项目状态
            if($project_model['status']==2) {
                abort(200,json_encode(['code'=>0,'msg'=>'项目已禁用无法进行此操作']));
            } elseif($project_model['status']==4) {
                abort(200,json_encode(['code'=>0,'msg'=>'项目已完成无法进行此操作']));
            }


        });

        self::event('after_write', function ($model,Project $project_model) {
            //调整项目状态
            if($project_model['status']!=3) {
                $project_model->save([
                    'status' => 3,
                    'act_time' => time()
                ]);
            }


        });
    }

    public function getFlowIntro()
    {
        return '项目任务人员分配';
    }

    public function getProId()
    {
        return ['id'=>$this['pid']];
    }

    public function linkUser()
    {
        return $this->belongsTo('Users','uid');
    }
}