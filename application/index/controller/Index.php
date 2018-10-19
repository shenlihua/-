<?php
namespace app\index\controller;

use Endroid\QrCode\QrCode;
use Endroid\QrCode\ErrorCorrectionLevel;
use Endroid\QrCode\LabelAlignment;

class Index extends Common
{

    public function wechat()
    {
        echo isset($_REQUEST['echostr'])?$_REQUEST['echostr']:'';
    }

    public function index()
    {
        //获取用户通知
        $notice_model = model('UserNotice');
        $notice_list = $notice_model->where('uid','=',$this->user_id)->paginate(10);
//        dump($notice_list);exit;

        return view('index',[
            'notice_list' => $notice_list,
        ]);
    }
    //关联平台账号
    public function linkAccount()
    {
        return view('linkAccount',[

        ]);
    }

    //关联平台账号操作
    public function linkAccountAction()
    {
        $input_data = $this->request->param();
        //注入微信信息
        $input_data['wechat_info'] = session('wechat_info');
//        dump($input_data);exit;
        $validate = new \app\common\validate\UserValidate();
        $validate->scene('linkAccount');

        if ( !$validate->check($input_data) ) {
            return json(['code'=>0,'msg'=>$validate->getError()]);
        }
        $model = model('Users');
        $model = $model->where([['cellphone','=',$input_data['cellphone']]])->find();
        $state = $model->save($input_data);
//        $state = $model->save($input_data,[['cellphone','=',$input_data['cellphone']]]);
        //登录信息绑定
        $model->loginInfo();
        return ['code'=>$state?1:0,'msg'=>'操作'.($state?'成功':'失败')];
    }

    //用户注册
    public function reg()
    {
        $user_model = new \app\common\model\Users();
        $req_user_id = session('req_user_id');
        //邀请人信息
        $req_user_info = $user_model->with('userType')->where(array('id'=>$req_user_id))->find();
        //被邀请注册人身份显示
        $type_model = new \app\common\model\UserType();
        //被邀请者可注册的用户类型
        $req_type = isset($type_model::$user_req_type[$req_user_info['userType']['en']])?$type_model::$user_req_type[$req_user_info['userType']['en']]:[];
        $choose_type = $type_model->where('en','in',$req_type)->select();
        $location = $this->location();
//        dump($location);exit;
        return view('reg',[
            'location' => $location['data'],
            'choose_type' =>$choose_type
        ]);
    }

    //用户注册
    public function regAction()
    {
        $input_data = $this->request->param();
        //邀请人id
        $input_data['req_id'] = session('req_user_id');
//        $input_data['id'] = $this->user_id;
//        $wechat_info = '{"access_token":"ACCESS_TOKEN","expires_in":7200,"refresh_token":"REFRESH_TOKEN","openid":"OPENID","scope":"SCOPE","openid":" OPENID","nickname": "NICKNAME","sex":"1","province":"PROVINCE","city":"CITY","country":"COUNTRY","headimgurl":"http://thirdwx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/46","privilege":[ "PRIVILEGE1", "PRIVILEGE2"     ],"unionid": "o6_bmasdasdsad6_2sgVt7hMZOPfL"}';
//        $wechat_info = json_decode($wechat_info,true);
        //注入微信信息
        $input_data['wechat_info'] = session('wechat_info');

        $validate = new \app\common\validate\UserValidate();
        $validate->scene('wechat');

        $model = model('Users');

//        dump($input_data);exit;
        $result = $this->_dataSave($model,$input_data,$validate);
//        dump($result);exit;
        if($result['code']) { //创建成功
            //保存登录凭证
            $model->loginInfo();
        }
//        dump($result);exit;
        return $result;

    }


    //选择开通城市
    public function location($location_id=0)
    {
        $where['pid'] = $location_id;
        $where['status'] = 1;
        $location_model = new \app\common\model\SysLocation();
        $list = $location_model->getLocation($where,'id,name');

        return ['code'=>1,'msg'=>'获取成功','data'=>$list];
    }
    /*
     * 搜索团队
     * */
    public function searchTeam()
    {
        $number = $this->request->param('number');//团队编号
        $group_number = $this->request->param('group_number',0,'intval');//团队组编号

        empty($number) && abort('200',json_encode(['code'=>0,'msg'=>'请输入编号']));
        $team_model = model('UserTeam');

        $team_id = $team_model->decodeReqCode($number);
        empty($team_id) && abort(200,json_encode(['code'=>0,'msg'=>'不存在该团队']));

        $team_info = $team_model->field('id,uid')->where([
            ['id','=',$team_id],
        ])->find();
        //绑定团队组
        $team_info['group_no'] = $group_number;

        empty($team_info) && abort(200,json_encode(['code'=>0,'msg'=>'该团队已解散']));
        //验证组
        if($group_number) {
            $group_info = model('users')->where(['type'=>'pro','id'=>$group_number,'team_no'=>$team_id])->find();
            empty($group_info) && abort(200,json_encode(['code'=>0,'msg'=>'团队组不存在，请重新输入']));

        }


        return ['code'=>1,'msg'=>'存在该团队','data'=>$team_info];


    }

    //项目流程
    public function proFlow()
    {
        $content = model('SysCache')->getContent('proFlow');
        return view('proFlow',[
            'content' => $content
        ]);
    }

    //安全措施
    public function proSecurity()
    {
        $content = model('SysCache')->getContent('proSecurity');
        return view('proSecurity',[
            'content' => $content
        ]);
    }

    //QC检测
    public function proCheck()
    {
        $content = model('SysCache')->getContent('proCheck');
        return view('proCheck',[
            'content' => $content
        ]);
    }

    //设备维护
    public function proMaintain()
    {
        $content = model('SysCache')->getContent('proMaintain');
        return view('proMaintain',[
            'content' => $content
        ]);
    }

    //生成二维码
    public function generateQr()
    {

        return \qrcode\GenerateQr::getCode('123123123');

// Save it to a file
//        $qrCode->writeFile(__DIR__.'/qrcode.png');

// Create a response object
//        $response = new Response($qrCode->writeString(), Response::HTTP_OK, ['Content-Type' => $qrCode->getContentType()]);

    }

    //微信端签名
    public function jsSignature()
    {
        $req_url = $_SERVER['HTTP_REFERER'];
        $req_url_arr = explode('#',$req_url);
        $req_url = $req_url_arr[0];
        //调试微信信息
        $jsapi_ticket = \wechat\Wechat::getJsapiTicket();
        $data = [
            'noncestr' => md5(time().'noncestr'),
            'jsapi_ticket' => $jsapi_ticket,
            'timestamp' =>time(),
            'url' => $req_url,
        ];
        ksort($data);
        $str ='';
        foreach($data as $key=>$vo) {
            $str .=$key.'='.$vo.'&';
        }
        $str = substr($str,0,-1);
        $data['appId'] = \wechat\Config::$appID;
        $data['signature']  = sha1($str);

        unset($data['jsapi_ticket']);
        return ['code'=>1,'msg'=>'获取成功','data'=>$data];
    }
}
