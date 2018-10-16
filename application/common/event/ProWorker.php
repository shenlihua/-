<?php
namespace app\common\event;

class ProWorker
{
    //执行次数次后否关闭写入
    protected static $is_close_write = 1;

    public function afterWrite($event_obj)
    {
        if(self::$is_close_write<=0) {
            return;
        }
        //执行次数
        self::$is_close_write--;

        $model = new \app\common\model\ProFlow();
        $model->insert([
            'opt_id' => $model::$opt_user_id,
            'intro'  => $event_obj->getFlowIntro(),
            'pid' => $event_obj['pid'],
            'create_time' => date('Y-m-d H:i:s')
        ]);

    }


}