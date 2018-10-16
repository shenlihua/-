<?php
namespace wechat\temp_msg;

abstract class AMsg implements IMsg
{
    protected $temp_id;

    protected $msg_data;

    function getMsgData()
    {
        return $this->msg_data;
    }

    function getTempID()
    {
        return $this->temp_id;
    }

    function getUrl()
    {
        return '';
    }

    function getMiniProgram()
    {
//        ["appid":"xiaochengxuappid12345",
//        "pagepath":"index?foo=bar"]

        return [];
    }
}