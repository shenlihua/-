<?php

namespace app\http\middleware;



class CheckAuthLogin
{
    public function handle($request, \Closure $next)
    {
//        dump($request);exit;
//        dump($next);exit;
//        exception('http://www.baidu.com', 10006,'\app\common\exception\NotFoundException');
////        exception('http://www.baidu.com', 10006,'\app\common\exception\NotFoundException');
//        redirect('http://www.baidu.com');exit;
//        dump($request);exit;
        return $next($request);
    }
}
