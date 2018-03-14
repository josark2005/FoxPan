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
    var sp = "__SP__".toUpperCase();
    var flux = "__FLUX__" + "MB";
    $(function(){
      document.getElementById("SP").innerHTML = (sp === "") ? "缺失" : sp;
      document.getElementById("flux").innerHTML = flux;
      // active fix
      if( sp !== "" ){
        $("option[value="+sp+"]").attr("selected", "selected");
      }
    });
    // Ajax配置
    var ajax = null;
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
    function accept(){
      var sp = $("#sp").val();
      var ak = $("#ak").val();
      var sk = $("#sk").val();
      var bkt = $("#bkt").val();
      var dm = $("#dm").val();
      var qd = $("#qd").val();
      var upd = $("#upd").val()==="" ? $("#upd").attr("placeholder") : $("#upd").val();
      var auth_pw = $("#auth_pw").val();
      if( sp === "null" || ak === "" || sk === "" || bkt === "" || dm ==="" || qd === "" || upd === "" ){
        alert("信息不完整，请返回重新填写");
        return ;
      }
      ajax = $.ajax({
        url: "?mode=api&install=true&a=install&m=setOptions",
        data: {"sp":sp, "ak":ak, "sk":sk, "bkt":bkt, "dm":dm, "qd":qd, "upd":upd, "auth_pw":auth_pw},
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

    {_nav_}

    <div class="container mt-4" id="container">

      <div class="row">

        <div class="col-md-12 col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">全局设置</span>
            </div>
            <div class="card-body table-responsive">
              <!-- S2 -->
              <div id="s2" name="s2">
                <h3 name="sp">提供商设置</h3>
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
              </div>

              <hr />

              <!-- S3 -->
              <div id="s3" name="s3">
                <h3 name="bkt">空间设置</h3>
                <div class="alert alert-primary"><strong>提醒！</strong>如“自动获取”的Bucket中没有您想要填写的名称，直接在下方输入框中填写即可。</div>
                <div class="clearfix mb-2">
                  <button type="button" class="btn btn-outline-primary float-right">自动获取</button>
                </div>
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

              </div>


              <hr />

              <!-- S4 -->
              <div id="s4" name="s4">
                <h3 name="domain">域名设置</h3>
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_dm">使用域名 DM</span>
                  </div>
                  <input type="text" class="form-control" id="dm" aria-describedby="_dm" placeholder="请输入域名" value="__DM__">
                </div>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_qd">流量查询域名 QD</span>
                  </div>
                  <input type="text" class="form-control" id="qd" aria-describedby="_qd" placeholder="请输入域名" value="__QD__">
                </div>
              </div>

              <hr />

              <!-- S5 -->
              <div id="s5" name="s5">
                <h3 name="update">更新设置</h3>
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_upd">更新地址 UPD</span>
                  </div>
                  <input type="text" class="form-control" id="upd" aria-describedby="_upd" placeholder="http://jokin1999.github.io/PrivacyCloud/" value="__UPDATE_BASIC_URL__">
                </div>

                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="_auth_pw">授权密码 AUTH_PW</span>
                  </div>
                  <input type="text" class="form-control" id="auth_pw" aria-describedby="_auth_pw" placeholder="不修改请留空" value="">
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
