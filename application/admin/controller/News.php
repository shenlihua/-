<?php

namespace app\admin\controller;

use think\Request;

class News extends Common
{
    public function index()
    {
        $keyword = request()->param('keyword','','trim');

        $where = [];
        $keyword && $where[] = ['title','like','%'.$keyword.'%'];
        $model = model("News");

        $list = $model->where($where)->paginate();

        return view('',[
            'keyword' => $keyword,
            'list' => $list,
            'breadcrumb' => array('fa-users','文章管理','文章列表')
        ]);

    }


    public function newsAdd()
    {
        $id = request()->param('id',0,'intval');
        $model = model("News");
        $model = $model->where('id',$id)->find();

        return view('newsAdd',[
            'fields_cate_type'=> [],
            'model' => $model,
            'breadcrumb' => array('fa-book','文章管理','文章操作')
        ]);
    }


    public function newsAddAction()
    {
        $input_data = request()->param();
        $validate = new \app\common\validate\News();
        $validate->scene('admin_add');

        $model = model("News");
        return $this->_dataSave($model,$input_data,$validate);
    }


    public function edit($id = 0){

        if(IS_POST){
            $Model = D("News");
            if(!$Model->create()){
                $this->error($Model->getError());
            }else{
                $id = $Model->save();
                if(!$id){
                    $this->error('编辑失败');
                }else{
                    $this->success('编辑成功');
                }
            }
        }else{
            $info = D("News")->find($id);
            $this->assign('info',$info);
            $this->display('add');

        }
    }

    public function activity()
    {
        $keyword = request()->param('keyword','','trim');

        $where = array();
        $keyword && $where['title']= array('like','%'.$keyword.'%');
        $model = D("Activity");
        $count = $model->where($where)->count();
        $page  = new \Think\AcePage($count,C('page_size'));
        $fields = 'id,cate_id,author,title,views,status,sort,create_time,update_time';
        $order = 'update_time desc';
        $list  = $model->field($fields)->where($where)->order($order)->limit($page->firstRow,$page->listRows)->select();


        $this->assign('keyword',$keyword);
        $this->assign('fields_status',$model::$fields_status);
        $this->assign('fields_cate_type',$model->getCateType());
        $this->assign('list',$list);
        $this->assign('page',$page->show());
        $this->assign('breadcrumb',array('fa-book','文章管理','活动文章列表'));//面包屑
        $this->display();
    }

    //添加活动
    public function activityAdd()
    {
        $id = request()->param('id',0,'intval');
        $model = D("Activity");
        $info = $model->where(array('id'=>$id))->find();
        $info['img'] = explode(',',$info['img']);
        $info['sponsor'] = explode(',',$info['sponsor']);//支持单位
        $this->assign('info',$info);
        $this->assign('fields_cate_type',$model->getCateType());
        $this->assign('breadcrumb',array('fa-book','文章管理','活动文章操作'));//面包屑
        $this->display();
    }

    public function activityAddAction()
    {
        $input_data = request()->param('post.');
        $model = D("Activity");
        $this->_dataSave($model,$input_data);
    }

}