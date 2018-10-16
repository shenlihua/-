<?php
namespace app\admin\widget;


use think\Controller;

class Page  extends Controller {

    /*
     * 选择地区
     * */
    public function chooseLocation($city_id=0,$province_id=0)
    {
        $model = new \app\common\model\SysLocation();

        $province_info = $model->getLocation(['pid'=>0,'status'=>1]);

        //市
        $location_province_id = $province_id ? $province_id : (isset($province_info[0])?$province_info[0]['id']:null);
        $city_info = $model->getLocation(['pid'=>$location_province_id,'status'=>1]);


        $this->assign('location_city_id',$city_id);
        $this->assign('location_province_id',$location_province_id);
        $this->assign('city_info', $city_info);
        $this->assign('province_info', $province_info);

        return $this->fetch('Common/chooseLocation');
    }

    /*
     * 选择用户
     * */
    public function chooseUser($user_id=0,$name='user_id',$after_select_param = false)
    {
        if($after_select_param===true) {
            $list = model('Users')->field('id,cellphone,nickname,user_name')->where('status',1)->select();
        }else {
            $list = [];

        }

        $this->assign('user_id',$user_id);
        $this->assign('name',$name);
        $this->assign('list',$list);
        return $this->fetch('common/chooseUsers');
    }

    /*
     * 选择用户类型
     * */
    public function chooseUserType($type=0)
    {
        $model = model('UserType');
        $where = [
            ['pid','=',0]
        ];

        if(!session('admin_auth_info.is_manage')) {
            array_push($where,['en','<>','city']);
            if (session('admin_auth_info.type')=='pro') { //项目经理只允许添加员工
                array_push($where,['en','=','staff']);
            }
        }else{ //管理员只允许添加城市合伙人
            array_push($where,['en','=','city']);
        }

        $list = $model->with('childType')->where($where)->whereNull('en','or')->select();
        $this->assign('list',$list);
        $this->assign('type',$type);
        // 不带任何参数 自动定位当前操作的模板文件
        return $this->fetch('common/chooseUserType');
    }


    /*
     * 百度地图ak
     * */
    public function mapAK()
    {
        echo 'M2BGSmhmIqrAtohNVZ5qufTNwWwhEq4p';
    }
}