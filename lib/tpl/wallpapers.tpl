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
    {_common_var_}
    <script src="./lib/tpl/js/lazyload.min.js?ver=1" charset="utf-8"></script>
    <script src="./lib/tpl/js/main.js?ver=__VERSION__" charset="utf-8"></script>
    <script src="./lib/tpl/js/wallpapers.js?ver=__VERSION__" charset="utf-8"></script>
    <script type="text/template" id="wallpaper">
      <div class="col-sm-12 col-md-4 border-bottom border-secondary mb-4">
        <img src="./lib/tpl/imgs/loading.gif" data-src="#link" class="img-fluid mb-1 lazy" alt="wallpaper">
        <p class="clearfix">
          <span class="float-left">投稿：#poster</span>
          <a class="float-right badge badge-primary" href="javascript:;" onclick="javascript:setWallpaper('#id');">设为壁纸</a>
        </p>
      </div>
    </script>
  </head>
  <body>

    {_nav_}

    <div class="container mt-4" id="container">
      <div class="alert alert-warning text-center">壁纸中心仍在测试阶段</div>
      <div class="alert alert-success text-center" id="alert">获取壁纸数据中......</div>
      <div class="row" id="wallpapers-container"></div>
    </div>

  </body>
</html>
