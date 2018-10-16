<?php
namespace award_type;
//奖励类型
interface IType
{
    function getNotice($gold);
    function getExtraData();
}