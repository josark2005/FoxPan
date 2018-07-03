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
    <script type="text/javascript">
    // Ajax配置
    var ajax = null;
    function accept_a(){
      $("div#s0").addClass("d-none");
      $("div#s1").addClass("d-none");
      $("div#s2").removeClass("d-none");
    }
    function back2a(){
      $("div#s0").removeClass("d-none");
      $("div#s1").removeClass("d-none");
      $("div#s2").addClass("d-none");
    }
    function accept_c(){
      if( ajax !== null ){
        ajax.abort();
      }
      var sp = $("#sp").val();
      var ak = $("#ak").val();
      var sk = $("#sk").val();
      var bkt = $("#bkt").val();
      if( sp === "null" || ak === "" || sk === "" || bkt === "" ){
        alert("请完整填写相关信息");
        return ;
      }
      $("div#s3").addClass("d-none");
      $("div#s4").removeClass("d-none");
      $("#domain_p").removeClass("d-none");
      ajax = $.ajax({
        url: "?mode=api&install=true&a=install&m=getDomain",
        data: {"sp":sp, "ak":ak, "sk":sk, "bkt":bkt},
        type: "post",
        dataType: "json",
        timeout: 10000,
        complete: function(Http, status){
          if( status === "timeout" ){
            ajax.abort();
            alert("连接服务器超时");
            back2b();
            return ;
          }
        },
        success: function(data){
          console.log(data);
          if( data.code === "0" ){
            $("#domain_p").addClass("d-none");
            console.log(data.data.length);
            if( data.data.length !== 0 ){
              $("#dm").val(data.data[0]);
              var qd = data.data.join(",");
              $("#qd").val(qd);
            }
            return ;
          }else{
            $("#domain_p").addClass("d-none");
            alert("获取域名失败：" + data.msg + " [" + data.code +"]");
            return ;
          }
        }
      });
    }
    function back2b(){
      if( ajax !== null ){
        ajax.abort();
      }
      $("div#s2").removeClass("d-none");
      $("div#s3").addClass("d-none");
    }
    function accept_b(){
      if( ajax !== null ){
        ajax.abort();
      }
      // get Bkt
      var sp = $("#sp").val();
      var ak = $("#ak").val();
      var sk = $("#sk").val();
      if( sp === "null" || ak === "" || sk === "" ){
        alert("请完整填写相关信息");
        return ;
      }
      $("div#s2").addClass("d-none");
      $("div#s3").removeClass("d-none");
      $("#bkt_p").removeClass("d-none");
      ajax = $.ajax({
        url: "?mode=api&install=true&a=install&m=getBkt",
        data: {"sp":sp, "ak":ak, "sk":sk},
        type: "post",
        dataType: "json",
        timeout: 10000,
        complete: function(Http, status){
          if( status === "timeout" ){
            ajax.abort();
            alert("连接服务器超时");
            back2b();
            return ;
          }
        },
        success: function(data){
          console.log(data);
          if( data.code === "0" ){
            $("#bkt_p").addClass("d-none");
            var content = "";
            $.each(data.data, function(key, value){
              content += "<option value=\""+value+"\">"+value+"</option>";
            });
            $("#bkt_a").append(content);
            return ;
          }else{
            $("#bkt_p").addClass("d-none");
            $("#_bkt_select").addClass("d-none");
            alert("获取Bucket失败：" + data.msg + " [" + data.code +"]");
            return ;
          }
        }
      });
    }
    function back2c(){
      if( ajax !== null ){
        ajax.abort();
      }
      $("div#s3").removeClass("d-none");
      $("div#s4").addClass("d-none");
    }
    function back2d(){
      $("div#s4").removeClass("d-none");
      $("div#s5").addClass("d-none");
    }
    function accept_d(){
      if( ajax !== null ){
        ajax.abort();
      }
      $("div#s4").addClass("d-none");
      $("div#s5").removeClass("d-none");
    }
    function accept(){
      var sp = $("#sp").val();
      var ak = $("#ak").val();
      var sk = $("#sk").val();
      var bkt = $("#bkt").val();
      var dm = $("#dm").val();
      var qd = $("#qd").val();
      var auth_pw = $("#auth_pw").val();
      if( sp === "null" || ak === "" || sk === "" || bkt === "" || dm ==="" || qd === "" ){
        alert("信息不完整，请返回重新填写");
        return ;
      }
      ajax = $.ajax({
        url: "?mode=api&install=true&a=install&m=setOptions",
        data: {"sp":sp, "ak":ak, "sk":sk, "bkt":bkt, "dm":dm, "qd":qd, "auth_pw":auth_pw},
        type: "post",
        dataType: "json",
        timeout: 10000,
        complete: function(Http, status){
          if( status === "timeout" ){
            alert("连接服务器超时");
            return ;
          }
        },
        success: function(data){
          console.log(data);
          if( data.code === "0" ){
            location.href="?page=index";
            return ;
          }else{
            alert("设置失败：" + data.msg + " [" + data.code +"]");
            return ;
          }
        }
      });
    }
    </script>
  </head>
  <body>

    <div class="container mt-4" id="container">
      {_warning_}
      <div class="row">

        <div class="col-md-12 col-sm-12 mb-2" id="s0">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold"><img src="./lib/tpl/imgs/logo.png" width="21" height="21" alt="logo">欢迎使用 / Welcome</span>
            </div>
            <div class="card-body table-responsive">
              <p>欢迎使用__NAME__云存储解决方案。<br />
                请仔细阅读下方引导文案，并在下方的卡片中完成基本信息的填写以便__NAME__对接您的存储中心。
              </p>
              <hr />
              <h3># 非首次安装出现此页面</h3>
              <ol>
                <li>没有完善设置，或系统无法读取设置。</li>
                <li>请查看根目录是否存在"config.inc.php"文件。</li>
              </ol>
              <hr />
              <h3># 首次安装程序</h3>
              <ol>
                <!-- <li>请按<a href="http://jokin1999.github.io/PrivacyCloud/manual/start.html" target="_blank">教程（版本信息请参考下方）</a>仔细填写下方信息表。</li> -->
                <li>请按下方分步引导程序进行设置</li>
              </ol>
              <hr />
              <h3># 版本信息</h3>
              <ol>
                <li>主程序版本：__VERSION__</li>
              </ol>
              <hr />
              <h3># 许可与声明</h3>
              <ol>
                <li>License：MIT</li>
                <li>官网：<a href="http://jokin1999.github.io/FoxPan/" target="_blank">FoxPan</a></li>
                <li><strong>一旦您完成设置并开始使用，即视为您已阅读并接受免责声明！</strong></li>
              </ol>
            </div>
          </div>
        </div>

        <div class="col-md-12 col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">全局设置</span>
            </div>
            <div class="card-body table-responsive">
              <!-- S1 -->
              <div class="" id="s1">
                <h3 class="text-center">免责声明</h3>
                <ol>
                  <li>本程序基础功能免费开源不收取任何资费（请于官网免费下载），由于第三方存储产生的资费请自行负责，与本程序开发组无关;</li>
                  <li>本程序不会向开发者递交任何隐私信息，所有联网操作（除文件管理外）均为单向获取;</li>
                  <li>本程序仅为第三方对象存储的管理方案，请自行确保文件托管的安全性，丢失损坏本程序开发组无法负责;</li>
                  <li>本程序页面中提供的第三方信息如流量等仅供参考，具体使用情况以用户自行选择的服务提供商（SP）提供的数据为准。</li>
                  <li>您设置的AK/SK将被程序存储并使用加密算法进行保护，因加密算法可逆，请确保您的服务器环境安全以避免配置文件内的密码被下载与破解。</li>
                  <li>如果您发现了AK/SK被窃取，请第一时间登录您的服务提供商官网并删除该对AK/SK即可。</li>
                </ol>
                <button type="button" class="btn btn-outline-danger btn-block" onclick="accept_a();">我已阅读上方免责声明并接受，继续设置</button>
              </div>
              <!-- S2 -->
              <div class="d-none" id="s2" name="s2">
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <label class="input-group-text" for="sp">服务提供商 SP</label>
                  </div>
                  <select class="custom-select" id="sp">
                    <option value="null" selected>请选择服务提供商</option>
                    <option value="QINIU">七牛云</option>
                    <option value="null" disabled>待开放</option>
                  </select>
                </div>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_ak">Access Key</span>
                  </div>
                  <input type="text" class="form-control" id="ak" aria-describedby="_ak" placeholder="请输入Access Key" value="__AK__">
                </div>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_sk">Secret Key</span>
                  </div>
                  <input type="text" class="form-control" id="sk" aria-describedby="_sk" placeholder="请输入Secret Key" value="__SK__">
                </div>

                <hr />

                <div class="clearfix">
                  <button type="button" class="btn btn-outline-danger float-right" onclick="accept_b();">继续设置</button>
                  <button type="button" class="btn btn-outline-secondary float-right mr-2" onclick="back2a();">上一步</button>
                </div>
              </div>
              <!-- S3 -->
              <div class="d-none" id="s3" name="s3">
                <p class="text-center" id="bkt_p"><i class="fa-spin fab fa-cloudscale"></i> 获取BKT信息中，请稍候。。。</p>
                <div class="alert alert-primary"><strong>提醒！</strong>如“自动获取”的Bucket中没有您想要填写的名称，直接在下方输入框中填写即可。</div>
                <div class="input-group mb-3" id="_bkt_select">
                  <div class="input-group-prepend">
                    <label class="input-group-text" for="bkt_a">自动获取Bucket</label>
                  </div>
                  <select class="custom-select" id="bkt_a" onchange="$('#bkt').val(this.value==='null'?'':this.value);console.log(this.value);">
                    <option value="null" selected>请选择Bucket</option>
                  </select>
                </div>

                <div class="input-group mb-3" id="_bkt_manual">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_bkt">Bucket名称 BKT</span>
                  </div>
                  <input type="text" class="form-control" id="bkt" aria-describedby="_bkt" placeholder="请输入Bucket名称" value="__BKT__">
                </div>

                <hr />

                <div class="clearfix">
                  <button type="button" class="btn btn-outline-danger float-right" onclick="accept_c();">继续设置</button>
                  <button type="button" class="btn btn-outline-secondary float-right mr-2" onclick="back2b();">上一步</button>
                </div>
              </div>
              <!-- S4 -->
              <div class="d-none" id="s4" name="s4">
                <p class="text-center" id="domain_p"><i class="fa-spin fab fa-cloudscale"></i> 获取BKT信息中，请稍候。。。</p>

                <div class="alert alert-danger" role="alert">
                  已为您自动填写最新的数据，如无需修改，请参照下方原信息<strong>重新填写</strong>。
                </div>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_dm">使用域名 DM</span>
                  </div>
                  <input type="text" class="form-control" id="dm" aria-describedby="_dm" placeholder="请输入域名" value="__DM__">
                </div>

                <div class="alert alert-primary" role="alert">
                  DM原设置值（不修改请复制下面的信息至上方输入框）：<br />
                  __DM__
                </div>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_qd">流量查询域名 QD</span>
                  </div>
                  <input type="text" class="form-control" id="qd" aria-describedby="_qd" placeholder="请输入域名" value="__QD__">
                </div>

                <div class="alert alert-primary" role="alert">
                  QD原设置值（不修改请复制下方的信息至上方输入框）：<br />
                  __QD__
                </div>

                <hr />

                <div class="clearfix">
                  <button type="button" class="btn btn-outline-danger float-right" onclick="accept_d();">继续设置</button>
                  <button type="button" class="btn btn-outline-secondary float-right mr-2" onclick="back2c();">上一步</button>
                </div>
              </div>
              <!-- S5 -->
              <div class="d-none" id="s5" name="s5">

                <div class="alert alert-danger" role="alert">
                  <strong>警告！</strong>下方密码设置后请一定牢记，下次打开需要填写密码才可以进入！留空则取消密码。
                </div>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_auth_pw">授权密码 AUTH_PW</span>
                  </div>
                  <input type="text" class="form-control" id="auth_pw" aria-describedby="_auth_pw" placeholder="请输入授权密码" value="__AUTH_PW__">
                </div>

                <hr />

                <div class="clearfix">
                  <button type="button" class="btn btn-outline-danger float-right" onclick="accept();">保存设置</button>
                  <button type="button" class="btn btn-outline-secondary float-right mr-2" onclick="back2d();">上一步</button>
                </div>
              </div>

            </div>
          </div>
        </div>

      </div>

    </div>

  </body>
</html>
