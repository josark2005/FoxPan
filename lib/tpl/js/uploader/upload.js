var uploader;
var chunk_size = 4*1024*1024;
$(function(){
  var list_item = $('#list-item').html();
  var token = $('#token').data('token');
  var upload_url = $('#upload_url').data('upload-url');
  uploader = new plupload.Uploader({
    runtimes:       'html5,html4',
    browse_button:  'pickfiles',
    drop_element:   'upload',
    url:            'https://' + upload_url,
    filters: {
      prevent_duplicates : true
    },
    max_retries:  1, // 重试1次
    multipart: true,
    required_features: 'chunks',
    chunk_size:   chunk_size,
    init: {
      FilesAdded: function(up, files) {
         plupload.each(files, function(file) {
           var size = (file.size/1024/1024).toFixed(2);
           // 文件添加进队列后，处理相关的事情
           var content = list_item.replace('#id', file.id);
           content = content.replace('#name', file.name);
           $('#upload_list').append(content);
         });
         list_alert();
         up.start();
       },
      UploadProgress: function(up, file) {
        // 每个文件上传时，处理相关的事情
        $('li#' + file.id).removeClass('bg-secondary');
        $('li#' + file.id).addClass('bg-primary');
        $('li#' + file.id + '>span').text(file.percent+'%');
       },
      BeforeUpload:  function(up, file) {
        size = file.size;
      },
      BeforeChunkUpload: function(up, file, post, blob, offset) {
        up.setOption('headers', {
          'Host':            upload_url,
          'Authorization':   'UpToken ' + token
        });
        up.setOption('multipart_params', {
          'token': token,
          'key': file.name,
        })
      },
      FileUploaded: function(up, file, info) {
        console.log(file);
        $('li#' + file.id).removeClass('bg-primary');
        $('li#' + file.id).addClass('bg-success');
        $('li#' + file.id + '>button').remove();
        $('li#' + file.id + '>span').remove();
        setTimeout(function(){
          $('li#' + file.id).remove();
          list_alert();
        }, 10000);
      },
      Error: function(up, file, errTip) {
        console.log(file);
        uploader.stop();
        $('li#' + file.id).removeClass('bg-primary');
        $('li#' + file.id).addClass('bg-danger');
        console.log(file.status);
        switch (file.status) {
          case 614:
            $('li#' + file.file.id).removeClass('bg-primary');
            $('li#' + file.file.id).addClass('bg-success');
            $('li#' + file.file.id + '>button').remove();
            $('li#' + file.file.id + '>span').remove();
            break;
          default:
            alert('上传时出错');
        }
        list_alert();
      }
    }
  });
  uploader.init();
});
function removeFile(id){
  uploader.stop();
  for(var i in uploader.files){
    if(uploader.files[i].id === id){
      var toremove = i;
    }
  }
  var file = uploader.files.splice(toremove, 1);
  $('li#' + file[0].id).remove();
  uploader.start();
}
function list_alert(){
  var tasks = $('ul#upload_list>li').length;
  if( tasks === 0 ){
    $('#list-alert').show();
  }else{
    $('#list-alert').hide();
  }
}
