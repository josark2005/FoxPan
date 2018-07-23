$(function(){
  // 面包屑导航处理
  $('span#prefix').append('<a href="?page=manager">根目录</a>');
  prefix = prefix.split('/');
  var _prefix_nav = ''; // 累计
  if( prefix[0] !== '' ){
    $.each(prefix, function(key, value){
      _prefix_nav += value + '/';
      $('span#prefix').append('/<a href="?page=manager&prefix=' + _prefix_nav + '">' + value + '</a>');
    });
  }
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
        {divider: true},
        {text: '<font color="red">删除</font>', onclick: function(){
          del(key, hash);
        }}
      ],
    });
    var tpl_item = $('#tpl-btn-dd-item').html();
    var items = '';
    // 打开
    var item = tpl_item.replace('#click', "location.href='"+href+"'");
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
});

// 删除文件操作
function del(key, hash){
  loading();
  $.ajax({
    url : '?mode=api&a=OSSController&m=del',
    data: {'key': key},
    type: 'post',
    dataType: 'json',
    timeout: 10000,
    complete: function(XMLHTTPRequest, status){
      loading('close');
      if ( status === 'timeout' ){
        alerter('连接服务器超时，请稍后再试');
      }
    },
    success: function(data){
      console.log(data);
      if( data.code === "0" ){
        $('#box_'+hash).remove();
        alerter('删除成功！');
        return ;
      }else{
        alerter("删除失败：" + data.msg_zh + " [" + data.code +"]");
        return ;
      }
    }
  });
}

function loading(operate='open', time=10000){

}

function alerter(text){
  alert('e' + text);
}
