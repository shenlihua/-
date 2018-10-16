/**
 * 获取省份
 */
function get_province(){
  var url = '/index.php?m=Admin&c=Api&a=getRegion&level=1&parent_id=0';
  $.ajax({
    type : "GET",
    url  : url,
    error: function(request) {
      alert("服务器繁忙, 请联系管理员!");
      return;
    },
    success: function(v) {
      v = '<option value="0">选择省份</option>'+ v;
      $('#province').empty().html(v);
    }
  });
}


/**
 * 获取城市
 * @param t  省份select对象
 */
function get_city(t){
  var parent_id = $(t).val();
  if(!parent_id > 0){
    return;
  }
  $('#twon').empty().css('display','none');
  var url = '{:url("location")}?location_id'+ parent_id;
  $.ajax({
    type : "GET",
    url  : url,
    error: function(request) {
      alert("服务器繁忙, 请联系管理员!");
      return;
    },
    success: function(v) {
      v = '<option value="0">选择城市</option>'+ v;
      $('#city').empty().html(v);
    }
  });
}
