<?php
namespace wechat\temp_msg;

//任务配送
use think\Model;

class JobSend extends AMsg
{
    protected $temp_id = 'Hjt-yxna5POQub6kj_dBJKZR3RDK8qZRNmYG5dKnvwo';
    protected $model;
    private $redirect_uri = 'Project/detail';

    public function setMsgData(Model $model,$remark='欢迎再次光临')
    {
        $this->model = $model;
//        dump($model);exit;
        $this->msg_data = [
            'result' => [
                "value"=>$model['title'],
                "color"=>"#173177"
            ],
            'withdrawMoney' => [
                "value"=> $model['gold'],
                "color"=>"#173177"
            ],
            'withdrawTime' => [
                "value"=> $model['create_time'],
                "color"=>"#173177"
            ],
            'cardInfo' => [
                "value"=>$model['intro'],
                "color"=>"#173177"
            ],
            'arrivedTime' => [
                "value"=>date('Y-m-d H:i:s'),
                "color"=>"#173177"
            ],

            'remark' => [
                "value"=>$remark,
                "color"=>"#173177"
            ]
        ];
    }

    //获取跳转链接
    public function getUrl()
    {
        return request()->root(true).'/'.$this->redirect_uri.'/id/'.$this->model['id'];
    }


}