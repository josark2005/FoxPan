<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>__NAME_CN__</title>
    <link rel="shortcut icon" href="./lib/tpl/imgs/logo.png">
    <link rel="stylesheet" href="./lib/tpl/css/bootstrap.min.css">
    <script src="./lib/tpl/js/jquery-3.2.1.min.js" charset="utf-8"></script>
    <script src="./lib/tpl/js/bootstrap.bundle.min.js" charset="utf-8"></script>
    <script src="./lib/tpl/js/uploader/plupload.full.min.js" charset="utf-8"></script>
    {_common_var_}
    <script src="./lib/tpl/js/main.js?ver=__VERSION__" charset="utf-8"></script>
    <script src="./lib/tpl/js/uploader/upload.js?ver=__VERSION__" charset="utf-8"></script>
    <script type="text/template" id="list-item">
      <li class="list-group-item float-none bg-secondary text-white" id="#id">
        <div class="text-truncate float-left" style="width:80%">#name</div>
        <button type="button" class="close" aria-label="Close" onclick="removeFile('#id')"><span aria-hidden="true">&times;</span></button>
        <span class="float-right">0%</span>
      </li>
    </script>
  </head>
  <body>

    {_nav_}

    <div class="container mt-4" id="container">
      {_warning_}
      <div class="row">

        <div class="col-md-4 col-sm-12 mb-2">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">数据上传</span>
              <i id="token" data-token="{$token}"></i>
              <i id="upload_url" data-upload-url="{$upload_url}"></i>
              <a href="javascript:;" onclick="$('#warmTips').modal('show');" class="badge badge-warning">友情提示</a>
            </div>
            <div class="card-body" id="upload">
              <button class="btn btn-primary btn-block my-4" id="pickfiles">选择文件或拖动到这里上传</button>
            </div>
          </div>
        </div>

        <div class="col-md-8 col-sm-12 mb-2">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">传输列表</span>
            </div>
            <div class="card-body">
              <div id="list-alert" class="alert alert-success text-center">当前没有上传任务</div>
              <ul class="list-group" id="upload_list"></ul>
            </div>
          </div>
        </div>

        <div class="modal fade" id="warmTips" tabindex="-1" role="dialog" aria-labelledby="warmTipsLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="warmTipsLabel">友情提示</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <ul>
                  <li>请勿滥用，所有对资源操作的行为都是计费的，有一定额度是免费的</li>
                  <li>实际资源使用情况请参考服务提供商的数据，本程序提供的数据仅供参考（存在延迟）</li>
                </ul>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">我知道啦</button>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

    <!-- {_footer_} -->

  </body>
</html>
