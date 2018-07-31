$(function(){
  menuReg();
  // 获取公告
  $.ajax({
    url : '?mode=api&a=notice&m=getNotice',
    dataType: 'json',
    timeout: 10000,
    complete: function(XMLHTTPRequest, status){
      if ( status === 'timeout' ){
        alerter('连接服务器超时，请稍后再试', 'warning');
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
      // $.each(data.data.data, function(key, value){
      //   var content = tpl.replace('#color', value[0]);
      //   content = content.replace('#title', value[1]);
      //   content = content.replace('#link', server + '/notice/' + value[2] + '.html');
      //   $('#notice').append(content);
      // });
      // 只显示最新公告
      var content = tpl.replace('#color', data.data.data[0][0]);
      content = content.replace('#title', data.data.data[0][1]);
      content = content.replace('#link', server + '/notice/' + data.data.data[0][2] + '.html');
      $('#notice').append(content);
      return ;
    }
  });
  // 面包屑导航处理
  $('span#prefix').append('<a href="?page=manager">根目录</a>');
  _prefix = prefix.split('/');
  var _prefix_nav = ''; // 累计
  if( _prefix[0] !== '' ){
    $.each(_prefix, function(key, value){
      _prefix_nav += value + '/';
      $('span#prefix').append('/<a href="?page=manager&prefix=' + _prefix_nav + '">' + value + '</a>');
    });
  }
});

// 注册邮件菜单
function menuReg() {
  // 注册每个文件的右键菜单
  $('a[name=file-link]').each(function(key, value){
    var obj   = $('a[name=file-link]:eq(' + key + ')');
    var id    = obj.attr('id'); // hash
    var href  = obj.attr('href');
    var name  = obj.data('name');
    var key   = obj.data('key');
    var hash  = obj.data('hash');
    var size  = obj.data('size');
    var size_unit_array = ["B", "K", "M", "G", "T", "P"];
    var size_unit = size_unit_array.shift();
    while (size >= 1024) {
      if( size_unit_array.length === 0 ){
        break;
      }
      size = size/1024;
      size_unit = size_unit_array.shift();
    }
    size = size.toFixed(2);
    $('#size-'+id).text(size +' '+size_unit);;
    $('#'+id).parent().contextify({
      items:[
        {text: '下载', onclick: function(){
          window.open(href);
        }},
        {text: '重命名', onclick: function(){
          rename_dialog(id);
        }},
        {divider: true},
        {text: '<font color="red">删除</font>', onclick: function(){
          del(key, hash);
        }}
      ],
    });
    var tpl_item = $('#tpl-btn-dd-item').html();
    var items = '';
    // 打开
    var item = tpl_item.replace('#click', "window.open('" + href + "')");
    item = item.replace('#action', '打开');
    items += item;
    // 分割线
    items += $('#tpl-btn-dd-divider').html();
    // 关闭
    item = tpl_item.replace('#click', "javascript:del('"+key+"','"+hash+"');");
    item = item.replace('text-dark', 'text-danger');
    item = item.replace('#action', '删除');
    items += item;
    $('#btn-dd-'+id).append(items);
  });
}

function rename_dialog(id) {
  // 原名与原key
  var o_name = $('#' + id).data('name');
  var o_key  = prefix + '/' + o_name;
  $('#rename_name').val(o_name);
  $('#btn-rename').unbind();
  $('#btn-rename').bind('click', function(){
    var name = $('#rename_name').val();
    var key  = prefix + '/' + name;
    console.log(name);
    if (name === '') {
      alert('请输入文件名后修改');
      return false;
    }else if(name === o_name) {
      // 未修改文件名
      $('#rename').modal('hide');
      return false;
    }
    // 修改
    $('#rename').modal('hide');
    rename(o_key, key, id);
  });
  $('#rename').modal('show');
}

// 修改文件名
function rename(okey, key, id) {
  loading();
  $.ajax({
    url:  '?mode=api&a=OSSController&m=rename',
    type: 'post',
    data: {'okey':okey, 'key':key},
    dataType: 'json',
    timeout: 10000,
    complete: function(XMLHttpRequest, status){
      loading('close');
      if ( status === 'timeout' ){
        alerter('连接服务器超时，请稍后再试');
      }
    },
    success: function(data){
      console.log(data);
      if( data.code === "0" ){
        // $('#' + id).removeAttr('title');
        // $('#' + id).removeAttr('href');
        // $('#' + id).removeAttr('data-name');
        // $('#' + id).removeAttr('data-key');
        // $('#' + id).attr('title', data.data.title);
        // $('#' + id).attr('href', data.data.href);
        // $('#' + id).attr('data-name', data.data.name);
        // $('#' + id).attr('data-key', data.data.key);
        alerter('修改成功！');
        location.href='';
        return ;
      }else{
        alerter("修改失败：" + data.msg_zh + " [" + data.code +"]", 'danger');
        return ;
      }
    }
  });
}

// 删除文件操作
function del(key, hash){
  loading();
  $.ajax({
    url : '?mode=api&a=OSSController&m=del',
    type: 'post',
    data: {'key': key},
    dataType: 'json',
    timeout: 10000,
    complete: function(XMLHttpRequest, status){
      loading('close');
      if ( status === 'timeout' ){
        alerter('连接服务器超时，请稍后再试');
      }
    },
    success: function(data){
      if( data.code === "0" ){
        $('#box_'+hash).remove();
        alerter('删除成功！');
        return ;
      }else{
        alerter("删除失败：" + data.msg_zh + " [" + data.code +"]", 'danger');
        return ;
      }
    }
  });
}

// 新建文件夹
function newFolder() {
  var folder = $('#newFolderName').val();
  location.href = '?page=manager&prefix=' + prefix + '/' + folder + '/';
}

function loading(operate='open'){
  var loading = $('#loading');
  if (operate === 'open') {
    console.log('loading');
    loading.modal({
      backdrop : 'static',
    });
  }
  if (operate === 'close' || operate === 'hide') {
    console.log('loaded');
    setTimeout(function(){
      loading.modal('hide');
    }, 500);
  }
}

function alerter(text, color='success'){
  var _alert   = $('#alerter-alert');
  var _alerter = $('#alerter');
  _alert.text(text);
  _alert.removeAttr('class');
  _alert.addClass('m-0 alert');
  _alert.addClass('alert-' + color);
  _alerter.modal('show');
}
