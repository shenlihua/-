<?php
namespace app\common\event;

use app\common\model\BaseModel;

class SendNotice
{
    /*
     * 监听 添加 修改 删除操作
     * @param $event_obj object 对象
     * @param $base_model BaseModel 模型对象 具体使用bind操作
     * */
    public function afterWrite($event_obj,BaseModel $base_model)
    {
        $model = new \app\common\model\UserNotice();
        $model->insert([
            //通知对象
            'uid' => method_exists($event_obj,'eventGetNoticeUid')?$event_obj->eventGetNoticeUid():$event_obj['uid'],
            'type' => $event_obj->eventNoticeType(),
            'title' => $event_obj->eventNoticeTitle($base_model),
            'intro'  => $event_obj->eventNoticeIntro($base_model),
            'param' => $event_obj->getProId(),
            'status' => 1,
            'create_time' => time()
        ]);
    }
}