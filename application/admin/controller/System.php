<?php

namespace app\admin\controller;

use think\Request;

class System extends Common
{
    //城市管理
    public function location(Request $request)
    {
        $id = $request->param('id',0,'intval');

        $model = new \app\common\model\SysLocation();
        $where = [
            ['pid','=',$id],
            ['status','<>',0]
        ];
//        dump($where);exit
        $list = $model->getLocation($where);
//        dump($list);exit;
        return view('location',[
            'list' => $list,
            'id' =>$id
        ]);
    }
    //城市管理
    public function locationAdd(Request $request)
    {
        $id = $request->param('id',0,'intval');
        $model = new \app\common\model\SysLocation();
        $province = $model->getLocation(['status'=>1,'pid'=>0]);

        $where = [
            ['id','=',$id]
        ];
        $model = $model->where($where)->find();
        return view('locationAdd',[
            'model' => $model,
            'province' =>$province
        ]);
    }

    /*
     * 用户保存操作
     * */
    public function locationAddAction(Request $request)
    {
        $input_data = $request->param();

        $validate = new \app\common\validate\LocationValidate();

        $model = new \app\common\model\SysLocation();
        return $this->_dataSave($model,$input_data,$validate);
    }

    /*
     * 用户保存操作
     * */
    public function locationDel(Request $request)
    {
        $id = $request->param('id');
        $model = new \app\common\model\SysLocation();
        $result = $this->_softDel($model,['id'=>$id]);
        return $result;
    }

    /*
     * 图片管理
     * */
    public function flowImages()
    {
        $model = model('image');
        $where = [
            ['type','=',1]
        ];
        $list = $model->where($where)->paginate();
        // 获取分页显示
        $page = $list->render();
        return view('flowImages',[
            'list' => $list,
            'page' =>$page
        ]);
    }

    /*
     * 图片管理--新增
     * */
    public function flowImagesAdd()
    {
        $id = $this->request->param('id',0,'intval');

        $model = model('image');
        $model = $model->where('id','=',$id)->find();
        return view('flowImagesAdd',[
            'model' => $model
        ]);
    }

    /*
     * 图片管理--新增
     * */
    public function flowImagesAddAction()
    {
        $input_data = $this->request->param();

        $validate = new \app\common\validate\ImageValidate();

        $model = new \app\common\model\Image();

        return $this->_dataSave($model,$input_data,$validate);
    }

    //缓存保存
    public function sysCacheAction()
    {
        $type = $this->request->param('type');
        $input_data= $this->request->param('content');

        if(empty($type)) return ['code'=>'-1','msg'=>'保存的类型异常'];
        if(empty($input_data)) return ['code'=>'-1','msg'=>'保存数据异常'];

        if(is_array($input_data)) {
            $input_data = json_encode($input_data);
        }

        $cache_model = new \app\common\model\SysCache();
        $cache_model->saveContent($type, $input_data);
        return(['code'=>'1','msg'=>'保存成功']);
    }

    /*
     * 注意事项
     * */
    public function warning($type)
    {
        $cache_model = new \app\common\model\SysCache();
        $content = $cache_model->getContent($type);
//        dump($content);exit;
        return  view($type,[
            'content' => $content,
            'type' => $type
        ]);
    }
}
