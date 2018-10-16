<?php
namespace app\http\middleware;

use think\Request;

class ListenWechatAuth
{
    //全使用小写--不需要检查的动作
    protected $no_check_action = 'index/wechat,index/reg,index/regAction,';

    //无需检验用户信息的动作
    protected $no_check_user_info_action = 'index/linkAccount,index/linkAccountAction,index/location';

    public function handle($request, \Closure $next)
    {
        $action = strtolower($request->controller().'/'.$request->action());
        if(strpos(strtolower($this->no_check_action), $action)!==false) {

        }elseif(!session('?user_info') && session('?wechat_info')){ //验证是否保存过微信信息且不存在用户资料
            if(strpos(strtolower($this->no_check_user_info_action), $action)!==false) {

            }else{
                return redirect('index/reg');
            }
        }else {
            //登录授权信息是否存在
            if(!session('?user_info')){
                if($request->has('code','get') && $request->has('state','get')){
                    $code = $request->get('code');
                    $state = $request->get('state');
                    $wechat_auth_info = \wechat\Wechat::accessToken($code);
//                    dump($wechat_auth_info);exit;
                    //授权失败--直接提示错误
                    if(isset($wechat_auth_info['errcode'])) abort(400,'配置异常:'.$wechat_auth_info['errmsg']);

                    //判断用户是否存在
                    $model = model('Users');
                    $model = $model->where('wechat_openid',$wechat_auth_info['openid'])->find();
                    if (!$model) {
                        $model = model('Users');
                        //邀请人用户id
                        $req_user_id =  $model->decodeReqCode($state);
                        session('req_user_id',$req_user_id?$req_user_id:0);

                        $wechat_user_info = \wechat\Wechat::getUserInfo($wechat_auth_info['access_token'], $wechat_auth_info['openid']);
                        //授权失败--直接提示错误
                        if(isset($wechat_user_info['errcode'])) abort(400,'配置异常:'.$wechat_user_info['errmsg']);
                        //保存session-跳转注册页面
                        session('wechat_info',array_merge($wechat_user_info,$wechat_auth_info));

//                        //存在邀请人
//                        if(!$req_user_id){
//                            $save_data['req_id'] = array_merge($wechat_user_info,$wechat_auth_info);
//                        }
//
//                        //创建用户
//                        $save_data['wechat_info'] = array_merge($wechat_user_info,$wechat_auth_info);
//                        $model->save($save_data);

                        return redirect('index/reg');
                    }

                    //更新用户微信信息
                    $model->updateWechatToken($model,$wechat_auth_info);
                    //保存session
                    $model->loginInfo();

                }else{
                    return redirect(\wechat\Wechat::authLogin(request()->url(true),$request->param('req_code','STATE')));
                }
            }
        }


        return $next($request);
    }

}
