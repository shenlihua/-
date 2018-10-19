var wechatBox = {
    //分享处理
    shareInfo:function(){},
    //分享回调
    shareCallback:function(res){}
}


$(document).ready(function() {
    $.get('/index/jsSignature',function(reslut){
        var obj = reslut.data
        wx.config({
            debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId : obj.appId, // 必填，公众号的唯一标识
            timestamp : obj.timestamp, // 必填，生成签名的时间戳
            nonceStr : obj.noncestr, // 必填，生成签名的随机串
            signature : obj.signature,// 必填，签名，见附录1
            jsApiList : ["updateAppMessageShareData",'updateTimelineShareData']
        });
    })

});

wx.ready(function(){
    // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
});
wx.error(function(res){
    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
    alert(res.errMsg)
});


//分享
$("#share").click(function(){
    var style=$(this).data('style')
    var obj = wechatBox.shareInfo();
    //绑定失败--调用时间
    obj.fail = function(res){
        alert('调用失败:'+res.errMsg)
    }
    //完成
    obj.complete = function(res) {
        alert(res.errMsg)
    }
    if(style=='updateAppMessageShareData') { //自定义“分享给朋友”及“分享到QQ”按钮的分享内容（1.4.0）
        wx.updateTimelineShareData(obj, function(res) {
            console.log('updateTimelineShareData');
            //这里是回调函数
            wechatBox.shareCallback(res);
        });
    }else if(style=='updateTimelineShareData') {//自定义“分享到朋友圈”及“分享到QQ空间”按钮的分享内容（1.4.0）
        wx.updateTimelineShareData(obj, function(res) {
            console.log('updateTimelineShareData');
            //这里是回调函数
            wechatBox.shareCallback(res);
        });
    }else {
        alert('分享参数异常')
    }
})

