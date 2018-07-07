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
  $('#btn_accept').attr('disabled', 'disabled');
  ajax = $.ajax({
    url: "?mode=api&install=true&a=install&m=setOptions",
    data: {"sp":sp, "ak":ak, "sk":sk, "bkt":bkt, "dm":dm, "qd":qd, "auth_pw":auth_pw},
    type: "post",
    dataType: "json",
    timeout: 10000,
    complete: function(Http, status){
      if( status === "timeout" ){
        $('#btn_accept').removeAttr('disabled');
        alert("连接服务器超时");
        return ;
      }
    },
    success: function(data){
      console.log(data);
      if( data.code === "0" ){
        setTimeout(function(){
          location.href="?page=login";
        },2000);
        return ;
      }else{
        $('#btn_accept').removeAttr('disabled');
        alert("设置失败：" + data.msg + " [" + data.code +"]");
        return ;
      }
    }
  });
}
