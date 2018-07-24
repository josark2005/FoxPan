wallpaper = [];
$(function(){
  $.ajax({
    url:      '?mode=api&a=wallpaper&m=newTerm',
    dataType: 'json',
    timeout:  30000,
    complete: function(XMLHttpRequest, status){
      if (status === 'timeout'){
        $('#alert').removeAttr('alert-success');
        $('#alert').attr('alert-danger');
        $('#alert').text('连接服务器超时，请刷新页面重试');
      }
    },
    success:  function(data){
      if (data.code !== '0') {
        $('#alert').removeAttr('alert-success');
        $('#alert').attr('alert-danger');
        $('#alert').text(data.msg_zh);
        return false;
      }
      $('#alert').remove();
      var tpl = $('#wallpaper').html();
      $.each($.parseJSON(data.data), function(key, value){
        wallpaper[key] = value;
        var html = tpl.replace('#link', value[0]);
        html = html.replace('#poster', value[1] === 'official' ? '官方' : value[1]);
        html = html.replace('#id', key);
        $('#wallpapers-container').append(html);
        new LazyLoad({elements_selector: ".lazy"});
      });
    }
  });
});
function setWallpaper(id) {
  // loading
  $.ajax({
    url:      '?mode=api&a=wallpaper&m=setWallpaper',
    type:     'post',
    data:     {'url': wallpaper[id][0]},
    dataType: 'json',
    timeout:  10000,
    complete: function(XMLHttpRequest, status){
      if (status === 'timeout'){
        $('#alert').removeAttr('alert-success');
        $('#alert').attr('alert-danger');
        $('#alert').text('连接服务器超时，请刷新页面重试');
      }
    },
    success:  function(data){
      if (data.code !== '0') {
        $('#alert').removeAttr('alert-success');
        $('#alert').attr('alert-danger');
        $('#alert').text(data.msg_zh);
        return false;
      }
      alert('成功更换壁纸！');
    }
  });
}
