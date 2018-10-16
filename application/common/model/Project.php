<?php
namespace app\common\model;

use app\common\model\traits\Location;

class Project extends BaseModel
{
    use Location;
    protected $tableName='project';

    protected $insert = ['opt_id','no'];

    public static $fields_status = ['','创建项目','关闭项目','进行中','已完成'];
    public static $fields_is_auth = ['','待审核','通过审核','审核被拒'];

    protected static function init()
    {

        self::event('after_insert',function($model,Users $user_model){

            if($user_model['type']=='city') {
                //绑定依赖注入
                bind('app\common\model\BaseModel',$model);

                model('ProDelegate')->save([
                    'uid' => $user_model['id'],
                    'type' => $user_model['type'],
                    'pid' => $model['id'],
                ]);
            }elseif ($user_model['type']=='pro') {
                //绑定依赖注入
                bind('app\common\model\BaseModel',$model);
                //获取团队城市经理
                $city_uid = model('user_team')->where('id','=',$user_model['team_no'])->value('uid');

                model('ProDelegate')->saveAll([
                    ['uid' => $user_model['id'],'type' => $user_model['type'],'pid' => $model['id']],
                    ['uid' => $city_uid,'type' => 'city','pid' => $model['id']]
                ]);
            }
        });

        //更新前
        self::event('before_update', function ($model) {



            //城市和项目经理只能唯一
            if(!empty($model['is_auth'])) {

                if($model['status']==4) {
                    abort(200,'项目已完成，无法继续操作');
                }if($model['is_auth']==3) { //拒绝
                    $model['auth_time'] = time();
                } elseif($model['is_auth']==2) { //通过
                    $model['status']=4;//项目完成
                    $model['complete_time']  = time();
                }
            }
        });


        //更新后
        self::event('after_update', function ($model) {
            //城市和项目经理只能唯一
            if(!empty($model['is_auth'])) {
                if($model['is_auth']==3) { //拒绝

                } elseif($model['is_auth']==2) { //通过
                    //发放奖励
                    $award_model = model('userAward');
                    //查询工作人
                    //奖励金
                    $award_gold = $model['gold'];
                    $worker = $model->linkWorker()->select()->toArray();
                    $worker = array_values(array_column($worker,null,'uid'));
                    $count_worker = count($worker);
                    $avg_gold = $count_worker ? $award_gold/$count_worker:0;
                    $data = [];
                    $rec_money=0;//已抵扣金额
                    foreach ($worker as $key=>$vo) {
                        //保留两位只舍不入
                        if(($count_worker-1)==$key) {
                            $money=$award_gold-$rec_money;
                        }else {
                            $money = intval($avg_gold*100)/100;
                            $rec_money +=$money;
                        }

                        $data[] = [
                            'type' => 'project',
                            'relation_id' => $model['id'],
                            'uid' => $vo['uid'],
                            'gold' => $money,
                            'param' => ['award_gold'=>$award_gold,
                                'count_worker'=>$count_worker,
                                'team_no'=>$model['team_no'],
                            ],
                            'status' =>0,//创建
                            'send_time' => $award_model->getSendTime($vo['uid']),//获取发放时间
                        ];
                    }
                    //创建
                    $award_model->saveAll($data);
                }
            }

            //项目完成
            if(!empty($model['status']) && $model['status']==4){
                //更新用户完成项目数量
                $worker = $model->linkWorker()->column('uid');

                $mange_uid = $model->linkManage()->column('uid');
                $all_users = array_merge($worker,$mange_uid);

                $user_model = new Users();
                $user_model->whereIn('id',$all_users)->setInc('complete_pro_num');
            }
        });


    }


    protected function setNoAttr()
    {
        $cache_name = date('Y-m-d');
        $number = cache($cache_name);
        if(!$number) {
            $number = 1;
        }
        $number+=1;
        cache($cache_name,$number,86400);

        return date('YmdHis').sprintf('%06d',$number);
    }


    protected function setOptIdAttr($value)
    {
//        dump(self::$opt_user_id);exit;
        return self::$opt_user_id;
    }

    //获取坐标
    protected function getCoordinateAttr($value)
    {
        $coordinate = explode(',',$value);
        return [
            'lat' => isset($coordinate[0])?$coordinate[0]:0,     //经度
            'lng' => isset($coordinate[1])?$coordinate[1]:0,     //纬度
        ];
    }

    //获取团队编号
    protected function getTeamNoAttr($value)
    {
        return $value?$this->encodeReqCode($value):'';
    }


    /*
         * 生成邀请码随机盐
         *
         * */
    protected function generateSalt()
    {
        return 'project.';
    }


    //获取城市经理
    public function linkCityUser()
    {
        return $this->hasMany('ProDelegate','pid')->where('type','=','city');
    }

    //获取项目经理
    public function linkProUser()
    {
        return $this->hasMany('ProDelegate','pid')->where('type','=','pro');
    }

    //获取负责人
    public function linkManage()
    {
        return $this->hasMany('ProDelegate','pid')->where('type','in','pro,city');
    }

    //项目流程
    public function linkProFlow()
    {
        return $this->hasMany('ProFlow','pid')->order('id asc');
    }

    //项目工作事项
    public function linkWork()
    {
        return $this->hasMany('ProWork','pid');
    }

    //项目工作事项
    public function linkWorker()
    {
        return $this->hasMany('ProWorker','pid');
    }

    //项目审核详情
    public function linkAuthDetail()
    {
        return $this->hasOne('ProAuth','pid')->order('id','desc')->limit(1);
    }

    //项目完成情况
    public function getProInfo(Users $user_model,$where = [],$opt = 'paginate')
    {

        $db_prefix =         config('database.prefix');

        $fields = 'p.id,p.title,p.intro,p.create_time,p.number,p.gold,p.status,p.is_auth';

        $where[] = ['team_no','=',$user_model['team_no']];
        $where[] = ['uid','=',$user_model['id']];

        if($user_model['type']=='city') {//城市
            $join = [$db_prefix.'pro_delegate t'];
            $join_where = 'p.id=t.pid and type="city"';

        }elseif($user_model['type']=='pro') {//项目
            $join = [$db_prefix.'pro_delegate t'];
            $join_where = 'p.id=t.pid and type="pro"';

        }elseif($user_model['type']=='staff') {//员工
            //子查询
            $subQuery = \think\Db::table($db_prefix.'pro_worker')
                ->group(['pid','uid'])
                ->fetchSql(true)
                ->select();
            $join = ['('.$subQuery.') w'];
            $join_where = 'p.id=w.pid';

        }else{//暂无数据
            return ['code'=>1,'msg'=>'获取成功','data'=>''];
        }

        $result = \think\Db::table($db_prefix.'project')
            ->alias('p')
            ->field($fields)
            ->leftJoin($join,$join_where)
            ->where($where)
            ->whereNull('p.delete_time') //防止项目删除
            ->$opt();
        return $result;
    }
}