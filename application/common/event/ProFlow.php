<?php
namespace app\common\event;

class ProFlow
{

    public function afterWrite($event_obj)
    {
        $model = new \app\common\model\ProFlow();
        $model->insert([
            'opt_id' => $model::$opt_user_id,
            'intro'  => $event_obj->getFlowIntro(),
            'pid' => $event_obj['pid'],
            'create_time' => date('Y-m-d H:i:s')
        ]);
    }
}