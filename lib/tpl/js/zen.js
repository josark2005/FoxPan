$(function(){
  // 判断本地是否拥有今日获取的Zen
  var zen_date = storage("zen_date");
  var dater = new Date();
  var t = dater.getFullYear().toString() + dater.getMonth().toString() + dater.getDate().toString();
  if( zen_date && zen_date === t ){
    // 调取json
    var zen_title = storage("zen_title");
    var zen_url = storage("zen_url");
    if( zen_title && zen_url ){
      console.log("[Zen] local");
      $("a#zen").html(zen_title);
      $("a#zen").attr("href", zen_url);
    }else{
      console.log("[Zen] online");
      getZen();
    }
  }else{
    console.log("[Zen] online");
    getZen();
  }
});

function getZen(){
  // 获取支持信息
  $.getJSON( "?mode=api&a=zen&m=getZen", function(data){
    console.log(data);
    if( data.code === "0" ){
      $("a#zen").html(data.data.zen);
      $("a#zen").attr("href", data.data.url);
      var dater = new Date();
      var t = dater.getFullYear().toString() + dater.getMonth().toString() + dater.getDate().toString();
      data.date = t;
      console.log(data);
      storage("zen_date", t);
      storage("zen_title", data.data.zen);
      storage("zen_url", data.data.url);
    }else{
	    $("a#zen").html("Zen");
      $("a#zen").attr("href", "http://jokin1999.github.io/FoxPan/resources/zen/page/0.html");
      console.log("[Zen]"+data.code+":"+data.msg);
      console.log("[Zen]"+data.msg_zh);
    }
  });
}

function storage(key, value=null){
  if( window.localStorage ){
    if( value === null ){
      return localStorage.getItem(key);
    }else{
      return localStorage.setItem(key, value);
    }
  }else{
    console.log("[System] localStorage is not supported.");
    return false;
  }
}
