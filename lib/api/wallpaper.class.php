<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------

/**
 * Wallpaper
 * @version  1.0.0
 * @author   Jokin
 */
class wallpaper {
  // 服务地址
  public $server = false;

  // 获取最新期壁纸
  public function newTerm() : void {
    // 检查支持情况
    $this->checkSupport();
    // 获取服务器链接
    if ($this->server === false) {
      $this->error();
    }
    // wallpaper server
    $wps = \fp\acquirer::get($this->server.'/wallpapers/server.md');
    if ($wps !== false) {
      $wps = @json_decode($wps, true);
    }else{
      $this->error();
    }
    // 解析错误
    if ($wps === null || !isset($wps['public'])) {
      $this->error();
    }
    // 解析数据
    $wp = \fp\acquirer::get($this->server."/wallpapers/{$wps['public']}.json");
    if ($wp !== false) {
      $err['code'] = "0";
      $err['msg'] = "success";
      $err['msg_zh'] = "成功获取壁纸数据";
      $err['data'] = $wp;
      echo json_encode($err);
    }else{
      $this->error();
    }
  }

  public function setWallpaper() : void {
    if (!isset($_POST['url'])) {
      $err['code'] = "JPCAE01";
      $err['msg'] = "bad infomation";
      $err['msg_zh'] = "提交的数据不合法";
      echo json_encode($err);
      exit();
    }
    if( !is_file("./config.inc.php") ){
      $err['code'] = "JPCAD03";
      $err['msg'] = "confinguration file lost";
      $err['msg_zh'] = "设置文件丢失";
      exit(json_encode($err));
    }
    $config = include "./config.inc.php";
    $config['WALLPAPER_LOGIN'] = htmlspecialchars($_POST['url']);
    $linefeed = PHP_EOL;
    $content = "<?php{$linefeed}return ".var_export($config,true).";";
    $res = file_put_contents("./config.inc.php", $content);
    if ($res) {
      $err['code'] = "0";
      $err['msg'] = "success";
      $err['msg_zh'] = "设置成功";
      exit(json_encode($err));
    }else{
      $err['code'] = "JPCAD04";
      $err['msg'] = "failed to write confinguration file";
      $err['msg_zh'] = "设置文件无法写入";
      exit(json_encode($err));
    }
  }

  // 检查支持情况
  private function checkSupport() : void {
    // 获取支持信息
    $pi = \fp\tserver::getProjectInfo(C('NAME'));
    if ($pi === false){
      $this->error();
    }
    if (!is_array($pi) || !in_array('wallpaper', $pi) || !isset($pi['server'][0])) {
      var_dump($pi);
      $this->error();
    }
    $this->server = $pi['server'][0];
  }

  private function error() : void {
    $err['code'] = "JPCAE08";
    $err['msg'] = "failed to connect to wallpaper server";
    $err['msg_zh'] = "连接壁纸服务器失败";
    echo json_encode($err);
    exit();
  }
}
?>
