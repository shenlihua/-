<?php
namespace wechat\temp_msg;

interface IMsg
{

    function getMsgData();

    function getTempID();
    //跳转参数
    function getUrl();
    //小程序
    function getMiniProgram();
}