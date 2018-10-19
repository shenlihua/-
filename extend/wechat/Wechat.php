<?php
namespace wechat;

class Wechat
{
    //接口请求域
    const DOMAIN = 'https://api.weixin.qq.com';

    //获取全局access_token
    public static function getGlobalAccessToken()
    {
        $access_token = cache('wechat_access_token');
        if(!$access_token){
            $uri = self::DOMAIN.'/cgi-bin/token?grant_type=client_credential&appid='.Config::$appID.'&secret='.Config::$appsecret;
            $result = file_get_contents($uri);
            empty($result) && abort(400,'请求异常');
            $result = json_decode($result,true);
            if(isset($result['errcode']))  abort(400,'请求异常:code'.$result['errmsg'].' msg:'.$result['errmsg']);

            $access_token = $result['access_token'];
            //缓存6000秒
            cache('wechat_access_token',$access_token,6000);
        }
        return $access_token;
    }


    //微信授权登录
    public static function authLogin($redirect_uri,$state='STATE',$scope='snsapi_userinfo')
    {
        $uri = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid='
            .Config::$appID.
            '&redirect_uri='.urlencode($redirect_uri).
            '&response_type=code&scope='.$scope.
            '&state='.$state.'#wechat_redirect';
        return $uri;
    }
    //微信授权获取access_token
    public static function accessToken($code)
    {
        $uri = self::DOMAIN.'/sns/oauth2/access_token?appid='
            .Config::$appID.'&secret='.Config::$appsecret.'&code='
            .$code.'&grant_type=authorization_code';
//        dump($uri);exit;
        $result = file_get_contents($uri);
//        dump($result);exit;
        return json_decode($result,true);
    }

    //刷新access_token
    public static function refreshToken($refresh_token)
    {
        $uri = self::DOMAIN.'/sns/oauth2/refresh_token?appid='
            .Config::$appID.'&grant_type='
            .$refresh_token.'&refresh_token=REFRESH_TOKEN';
        $result = file_get_contents($uri);
        return json_decode($result,true);
    }

    //获取用户信息
    public static function getUserInfo($access_token,$openid)
    {
        $uri = self::DOMAIN.'/sns/userinfo?access_token='
            .$access_token.'&openid='
            .$openid.'&lang=zh_CN';
        $result = file_get_contents($uri);
        return json_decode($result,true);
    }

    //获取js-jssdk--jsapi_ticket
    public static function getJsapiTicket()
    {
        $cache_name = 'wechat_jsapi_ticket';
        $jsapi_ticket = cache($cache_name);
        if(!$jsapi_ticket){

            $access_token = self::getGlobalAccessToken();
            $uri = self::DOMAIN.'/cgi-bin/ticket/getticket?access_token='.$access_token.'&type=jsapi';
            $result = file_get_contents($uri);
            $result = json_decode($result,true);
            $jsapi_ticket = $result['ticket'];
            if(!$result['errcode']) { //获取成功
                cache($cache_name, $jsapi_ticket, 6000);
            }  else{
                abort(200,'获取异常code'.$result['errcode'].'  msg:'.$result['errmsg']);
            }
        }
        return $jsapi_ticket;
    }

}