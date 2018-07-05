<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>__NAME_CN__</title>
    <link rel="shortcut icon" href="./lib/tpl/imgs/logo.png">
    <link rel="stylesheet" href="./lib/tpl/css/bootstrap.min.css">
    <!-- Special Page -->
    <link rel="stylesheet" href="./lib/tpl/css/fontawesome-all.min.css">
    <script src="./lib/tpl/js/jquery-3.2.1.min.js" charset="utf-8"></script>
    <script src="./lib/tpl/js/bootstrap.bundle.min.js" charset="utf-8"></script>
    {_common_var_}
    <script type="text/javascript">
      var server_url = false;
      var plugins = false;
      var tpserver = false;
      $(function(){
        // 检查服务支持
        progress("检查服务器支持中");
        $.ajax({
          url: "?mode=api&a=geter&m=getpi",
          dataType: "json",
          timeout: 20000,
          complete: function(XMLHttpRequest, status){
            if( status === "timeout"){
              $("#progress").text("检查服务器超时，请刷新页面重试");
            }
          },
          success: function(data){
            progress("就绪");
            if(data === false){
              $("#progress").text("服务器返回错误，请刷新页面重试");
              return false;
            }
            // 插件支持
            plugins = data.plugins;
            if( data.plugins === true ){
              $('#server-plugins').text("支持");
              $('#server-plugins').addClass("badge-success");
            }else{
              $('#server-plugins').text("不支持");
              $('#server-plugins').addClass("badge-warning");
            }
            // 独立服务支持
            tpserver = data.tpserver;
            if( data.tpserver === true ){
              server_url = data.server.pop();
              $('#server-url').text(server_url);
            }else{
              $('#server-url').text("不支持");
              $('#server-url').addClass("badge-warning");
            }
          }
        });
        // 检查地址安全性
      });
      // 进度显示
      function progress(text){
        $("#progress").text(text);
      }
    </script>
  </head>
  <body>

    {_nav_}

    <div class="container mt-4" id="container">

      <div class="alert alert-danger text-center" role="alert">当前程序为alpha开发阶段，出于稳定性考虑，暂不提供云服务。</div>

      <div class="row">

        <div class="col-md-12 col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">Twocola Server 云服务中心</span>
            </div>
            <div class="card-body table-responsive">
              <div class="alert alert-info"><strong>提醒！</strong>推荐使用带有<strong>认证地址</strong>绿色标识的更新地址！（调试地址与非认证地址同样存在安全风险，请获悉！）</div>
              <p>
                TS服务：<span id="tserver" class="badge badge-primary">FoxPan</span><br />
                插件支持：<span id="server-plugins" class="badge">获取中。。。</span><br />
                项目服务：<span id="server-url" class="badge">获取中。。。</span><br />
              </p>
            </div>
            <div class="card-footer">
              <small id="progress">当前无任务</small>
            </div>
          </div>
        </div>

      </div>

    </div>

  </body>
</html>
