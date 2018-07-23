<link rel="stylesheet" href="./lib/tpl/css/fontawesome-all.min.css">
<script type="text/javascript">
  var sp = "__SP__".toUpperCase();
  var flux = "__FLUX__" + "MB";
  var update_basic_url = "__update_basic_url__";
  var danger_code = "___DANGER__";
  var danger_msg = "___DANGER_MSG__";
  var danger_api = "?mode=api&a=___DANGER_API_FILE__&m=___DANGER_API_METHOD__";
  $(function(){
    document.getElementById("SP").innerHTML = (sp === "") ? "未设置" : sp;
    document.getElementById("flux").innerHTML = flux;
    // 危险提示
    if( danger_code !== "" ){
      var danger_alert = "<div class=\"alert alert-danger text-center\" role=\"alert\">" + "["+danger_code+"]" + danger_msg + " <a class=\"text-danger\" href=\"javascript:;\" onclick=\"safetyAssistant();\">修复</a></div>";
      $("div#container").html(danger_alert + $("div#container").html());
    }
  });
  function safetyAssistant(){
    $.ajax({
      url: danger_api,
      dataType: "json",
      timeout: 10000,
      complete: function(XMLHttpRequest, status){
        if( status === "timeout" ){
          alert("连接服务器超时，请稍候再试");
        }
      },
      success: function(data){
        console.log(data);
        if( data.code === "0"){
          location.href = "";
        }else{
          alert(data.msg_zh+" "+data.code);
        }
      }
    });
  }
</script>
