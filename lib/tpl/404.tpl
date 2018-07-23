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
  </head>
  <!-- <body class="bg-secondary" style="background: url(./lib/tpl/imgs/background-0.jpg) no-repeat; background-position: center center; background-attachment: fixed;"> -->
  <body class="bg-secondary">

    <nav class="navbar navbar-expand-lg navbar-dark" style="box-shadow:0 0 150px 1px rgba(52, 58, 64); background-color: rgba(52, 58, 64 ,0.7);" id="navbar">
      <div class="container">
        <a class="navbar-brand" href="javascript:;">
          <img src="./lib/tpl/imgs/logo.png" width="30" height="30" alt="logo">
          __NAME_CN__
        </a>
        <span class="navbar-text text-muted">No more, no less either.</span>
      </div>
    </nav>

    <div class="container mt-4" id="container">
      <div class="row">

        <div class="col-md-6 col-sm-12 mx-auto mt-4 pt-4">
          <div class="card" style="border:none;">
            <div class="card-header bg-dark text-white"><i class="far fa-sad-tear"></i> 页面丢失了 - 404</div>
            <div class="card-body">
              <div class="alert alert-primary" id="msg">
                Sorry啦~这个页面找不到了<i class="far fa-grin-beam-sweat"></i>
              </div>
              <button class="btn btn-warning btn-block" onclick="javascript:history.go(-1);">返回上个页面</button>
            </div>
            {_login_footer_}
          </div>
        </div>

      </div>
    </div>

  </body>
</html>
