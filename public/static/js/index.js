var msgBox={

    showConfirm:function(content,fnc,title){
        var title =title?title:'确认提交';
        msgBox.yes=fnc
        $('body').append('<div id="show-tip-box"><div id="tip-mask" onclick="msgBox.destroy()"></div>\n' +
            '<div id="tip-pop">\n' +
            '    <h3>'+title+'</h3>\n' +
            '    <p>'+content+'</p>\n' +
            '    <div class="btn">\n' +
            '        <span class="cancel" onclick="msgBox.destroy()">取消</span>\n' +
            '        <span class="sure" onclick="msgBox.yes()">确定</span>\n' +
            '    </div>\n' +
            '</div></div>')
    },
    destroy:function() {
        $("#show-tip-box").remove()
    },
    yes:function() {
    }
}