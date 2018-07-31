<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>__NAME_CN__</title>
    <link rel="shortcut icon" href="./lib/tpl/imgs/logo.png?ver=__VERSION__">
    <link rel="stylesheet" href="./lib/tpl/css/bootstrap.min.css?ver=__VERSION__">
    <link rel="stylesheet" href="./lib/tpl/css/manager.css?ver=__VERSION__">
    <script src="./lib/tpl/js/jquery-3.2.1.min.js?ver=__VERSION__" charset="utf-8"></script>
    <script src="./lib/tpl/js/jquery.contextify.min.js?ver=__VERSION__" charset="utf-8"></script>
    <script src="./lib/tpl/js/bootstrap.bundle.min.js?ver=__VERSION__" charset="utf-8"></script>
    {_common_var_}
    <script src="./lib/tpl/js/main.js?ver=__VERSION__" charset="utf-8"></script>
    <script src="./lib/tpl/js/notice.js?ver=__VERSION__" charset="utf-8"></script>
    <script type="text/template" id="tpl-notice">
      <div class="alert alert-#color text-center"><a class="text-dark" href="#link" target="_blank">#title</a></div>
    </script>
  </head>
  <body>

    {_nav_}

    <div class="container my-4" id="container">
      <h1>公告中心</h1>
      <p class="text-muted">FoxPan官方发布的所有的有效公告</p>
      <hr />
      <div id="notice"></div>
      <hr />
      <p class="text-muted">以上公告均由FoxPan发布，若出现任何问题请使用“关于”页面中的联系方式与我们取得联系。</p>
    </div>

  </body>
</html>
