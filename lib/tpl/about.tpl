<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>__NAME_CN__</title>
    <link rel="shortcut icon" href="./lib/tpl/img/logo_pc.png">
    <link rel="stylesheet" href="./lib/tpl/css/bootstrap.min.css">
    <script src="./lib/tpl/js/jquery-3.2.1.min.js" charset="utf-8"></script>
    <script src="./lib/tpl/js/bootstrap.bundle.min.js" charset="utf-8"></script>
    {_common_var_}
    <script src="./lib/tpl/js/main.js?ver=__VERSION__" charset="utf-8"></script>
    <script type="text/javascript">
      $(function(){
        document.getElementById("SP").innerHTML = (sp === "") ? "缺失" : sp;
        document.getElementById("flux").innerHTML = flux;
      });
    </script>
  </head>
  <body>

    {_nav_}

    <div class="jumbotron pb-2">
      <div class="container">
        <h1 class="display-4">__NAME_CN__ (__NAME__)</h1>
        <p class="lead">私有云对象存储服务管理一站式解决方案</p>
        <hr class="my-4">
        <p class="lead">
          <a class="btn btn-primary btn-md" href="//jokin1999.github.io/FoxPan" target="_blank" role="button">官方网站</a>
          <a class="btn btn-success btn-md" href="//github.com/jokin1999/FoxPan" target="_blank" role="button">项目源码</a>
        </p>
      </div>
    </div>

    <div class="container mt-4" id="container">
      <div class="row">
        <div class="col-md-6 col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">反馈</div>
            <div class="card-body">
              <p>在使用过程中有任何疑问或发现了Bug欢迎您发送邮件到 <strong>jokin@twocola.com</strong>，请注明以下内容：</p>
              <ol>
                <li>反馈项目：__NANE__</li>
                <li>Bug复现流程</li>
                <li>即时联系方式如QQ、微信等。</li>
              </ol>
              <p>我们会及时给予回复！</p>
            </div>
            <div class="card-footer text-muted">
              <small>当前版本：__VERSION__</small>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">项目介绍</div>
            <div class="card-body">
              <p>__NAME__源于<a href="//github.com/jokin1999/PrivacyCloud" target="_blank">Privacy Cloud项目</a>，因该项目在设计初没有加入“升级”功能的考虑，导致问题频繁，故重新立项并将源项目归档。</p>
              <p>__NAME__在线相关服务基于<a href="//github.com/jokin1999/twocola-server" target="_blank">twocola-server</a>，采用统一控制管理，不再对用户直接开放，但仍将支持第三方服务与其他源项目在线服务特性，包括“Zen”等。</p>
              <p>__NAME__使用了“单一入口”技术，在设置“授权密码”后，可保证程序安全运行。</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    {_footer_}

  </body>
</html>
