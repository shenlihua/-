<?php
namespace wechat;

use wechat\temp_msg\IMsg;

class TemplateMsg
{
    protected $access_token;

    public function __construct()
    {
        $this->access_token = Wechat::getGlobalAccessToken();
    }

//    //设置行业
//    public function


    //获取设置的行业
    public function getIndustry()
    {
        $uri = Wechat::DOMAIN.'/cgi-bin/template/get_industry?access_token='.$this->access_token;
        $result = file_get_contents($uri);
//        dump($result);
        return json_decode($result,true);
    }

    //获取所有消息模版
    public function getAllPrivateTemplate()
    {
        $uri = Wechat::DOMAIN.'/cgi-bin/template/get_all_private_template?access_token='.$this->access_token;
        $result = file_get_contents($uri);
        $result = json_decode($result,true);
//        dump($result);
        return isset($result['template_list'])?$result['template_list']:[];
    }

    /*
     * 发送模版消息
     * 参数	是否必填	说明
            touser	是	接收者openid
            template_id	是	模板ID
            url	否	模板跳转链接
            miniprogram	否	跳小程序所需数据，不需跳小程序可不用传该数据
            appid	是	所需跳转到的小程序appid（该小程序appid必须与发模板消息的公众号是绑定关联关系，暂不支持小游戏）
            pagepath	否	所需跳转到小程序的具体页面路径，支持带参数,（示例index?foo=bar），暂不支持小游戏
            data	是	模板数据
            color	否	模板内容字体颜色，不填默认为黑色
     * */
    public function send($openid,IMsg $temp_obj)
    {
        $uri = Wechat::DOMAIN.'/cgi-bin/message/template/send?access_token='.$this->access_token;
        $data = [
            'touser' => $openid,
            'template_id' => $temp_obj->getTempID(),
            'url' => $temp_obj->getUrl(),
            'miniprogram'=> $temp_obj->getUrl(),
            'data' => $temp_obj->getMsgData()
        ];
//        dump($data);exit;
        $data = json_encode($data);
        $result = \http_curl\HttpCurl::request($uri,'post',$data);
        return $result;
    }
}