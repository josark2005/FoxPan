getWallpaper_retry = 0;
wallpaper = [];
$(function(){
  getWallpaper(3);
});

function getWallpaper(times = 1) {
  if (getWallpaper_retry >= times) {
    getWallpaper_retry = 0; // 重置
    return false;
  }
  getWallpaper_retry++;
  $.ajax({
    url:      '?mode=api&a=wallpaper&m=newTerm',
    dataType: 'json',
    timeout:  10000,
    complete: function(XMLHttpRequest, status){
      if (status === 'timeout'){
        $('#alert').removeClass('alert-success');
        $('#alert').addClass('alert-danger');
        $('#alert').html('连接服务器超时<a href="javascript:getWallpaper();">[重试]</a>');
      }
    },
    success:  function(data){
      if (data.code !== '0') {
        $('#alert').removeClass('alert-success');
        $('#alert').addClass('alert-danger');
        $('#alert').html(data.msg_zh + '<a href="javascript:getWallpaper();">[重试]</a>');
        setTimeout(function(){getWallpaper(times)}, 1000);
        return false;
      }
      $('#alert').remove();
      var tpl = $('#wallpaper').html();
      console.log($.parseJSON(data.data));
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
}

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
        $('#alert').removeClass('alert-success');
        $('#alert').addClass('alert-danger');
        $('#alert').text('连接服务器超时，请刷新页面重试');
      }
    },
    success:  function(data){
      if (data.code !== '0') {
        $('#alert').removeClass('alert-success');
        $('#alert').addClass('alert-danger');
        $('#alert').text(data.msg_zh);
        return false;
      }
      alert('成功更换壁纸！');
    }
  });
}
function delWallpaper() {
  // loading
  $.ajax({
    url:      '?mode=api&a=wallpaper&m=delWallpaper',
    dataType: 'json',
    timeout:  10000,
    complete: function(XMLHttpRequest, status){
      if (status === 'timeout'){
        $('#alert').removeClass('alert-success');
        $('#alert').addClass('alert-danger');
        $('#alert').text('连接服务器超时，请刷新页面重试');
      }
    },
    success:  function(data){
      if (data.code !== '0') {
        $('#alert').removeClass('alert-success');
        $('#alert').addClass('alert-danger');
        $('#alert').text(data.msg_zh);
        return false;
      }
      alert('成功删除壁纸！');
    }
  });
}
