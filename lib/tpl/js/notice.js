$(function(){
  // 获取公告
  $.ajax({
    url : '?mode=api&a=notice&m=getNotice',
    dataType: 'json',
    timeout: 10000,
    complete: function(XMLHTTPRequest, status){
      if ( status === 'timeout' ){
        alerter('连接服务器超时，请稍后再试');
      }
    },
    success: function(data){
      console.log(data);
      if (data.code === '-1') {
        return ;
      }
      var tpl = $('#tpl-notice').html();
      var server = data.data.server;
      // 获取全部公告
      $.each(data.data.data, function(key, value){
        var content = tpl.replace('#color', value[0]);
        content = content.replace('#title', value[1]);
        content = content.replace('#link', server + '/notice/' + value[2] + '.html');
        $('#notice').append(content);
      });
      return ;
    }
  });
});
