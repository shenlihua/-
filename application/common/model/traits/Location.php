<?php
namespace app\common\model\traits;

trait Location
{
    protected function setProvinceAttr($value)
    {
        $name = model('SysLocation')->where('id',$value)->value('name');
        $value = sprintf('%06d',$value).';'.$name;
        return $value;
    }

    protected function setCityAttr($value)
    {
        $name = model('SysLocation')->where('id',$value)->value('name');
        $value = sprintf('%06d',$value).';'.$name;
        return $value;
    }

    protected function setAreaAttr($value)
    {
        $name = model('SysLocation')->where('id',$value)->value('name');
        $value = sprintf('%06d',$value).';'.$name;
        return $value;
    }
}