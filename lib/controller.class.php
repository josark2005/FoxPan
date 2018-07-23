<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------

namespace fp;

/**
 * Controller
 * @version 1.0.0
 * @author Jokin
 */

class controller {

  // 公开页面设置
  const PUBLIC_PAGE = [
    'login',
    '404'
  ];

  // 默认跳转页面
  const HOME_PAGE = 'manager';

  // 启动器
  public static function run(){
    self::auth();
    $page = C('page');
    self::$page();
  }

  // 登录页控制器
  public static function login(){
    template::process(__FUNCTION__);
  }

  // 默认页面
  public static function index(){
    router::redirect('manager');
  }

  // manager
  public static function manager(){
    $prefix = htmlspecialchars((isset($_GET['prefix'])) ? $_GET['prefix'] : '');
    template::assign('prefix', rtrim(str_replace('\'', '\\\'', $prefix), '/'));  // 给模板传递prefix参数
    $files = sdk\oss::getFiles(C('AK'), C('SK'), C('BKT'), $prefix, $marker='');
    if( isset($files['items']) ){
      foreach ($files['items'] as $key => $value) {
        // 去除前缀
        $files['items'][$key]['name'] = ltrim($value['key'], $prefix);
        $files['items'][$key]['name_fixed'] = str_replace('"', '\\"', $files['items'][$key]['name']);
        $files['items'][$key]['key_fixed'] = str_replace('"', '\\"', str_replace('\'', '\\\'', $value['key']));
      }

      template::assign('files', $files['items']);
    }
    if( isset($files['commonPrefixes']) ){
      foreach ($files['commonPrefixes'] as $key => $value) {
        // 去除前缀
        $files['commonPrefixes']['fixed'][$key]['name'] = rtrim(ltrim($value, $prefix), '/');
        $files['commonPrefixes']['fixed'][$key]['key'] = str_replace('"', '\\"', str_replace('\'', '\\\'', $value));
      }
      template::assign('folders', $files['commonPrefixes']['fixed']);
    }
    template::process(__FUNCTION__);
  }

  // 上传页
  public static function upload(){
    self::getUpToken('token');
    template::assign('upload_url', 'upload.qiniup.com');
    header('Access-Control-Allow-Origin: https://upload.qiniup.com');
    template::process(__FUNCTION__);
  }

  // 获取/传递Token
  private static function getUpToken($assign = false){
    $token = sdk\oss::getUpToken(C('AK'), C('SK'), C('BKT'), 7200);
    if( $assign !== false ){
      template::assign($assign, $token);
    }else{
      return $token;
    }
  }

  // 自动调用
  public static function __callStatic(string $name, array $arguments){
    if( is_file("./lib/tpl/{$name}.tpl") ){
      template::process($name);
    }else{
      template::process('404');
    }
    return ;
  }

  // 授权管理
  private static function auth(){
    // 判断授权状态
    $auth = safety::is_auth();
    if( !$auth && !in_array(C('page'), self::PUBLIC_PAGE, true) ){
      router::redirect("login");
      exit('no-auth');
    }
    // 登录状态自动跳转
    if( $auth && C("PAGE") === "login" ){
      router::redirect("index", true);
      exit('logged-in');
    }
  }

}


?>
