<?php
namespace app\common\model;


class News extends BaseModel
{
    protected $tableName='news';

    public static $fields_status = ['','禁用','正常'];

    public static $fields_type = ['','新闻','活动'];

    protected $insert = ['views'=>0];
}