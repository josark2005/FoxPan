<?php
// +----------------------------------------------------------------------
// | Writed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------

namespace fp;

/**
 * Core
 * @author Jokin
 */
class Core {
  /**
   * 初始化系统
   * @param  void
   * @return void
   */
  public static function initialize(){
    // 基本定义
    define("NAME", "FoxPan");
    define("NAME_CN", "狐云");
    define("VERSION", "0.2.0");
    // 注册autoload方法
    spl_autoload_register("fp\Core::autoload");
    // 载入系统配置
    configuration::init()->analyzeConf("./config.inc.php", "config");
    // 载入系统方法
    include("./lib/function.php");
    // 关闭报错
    debug::error_report();
    // 安装更新
    self::exec_update();
    // 检查系统完整性
    self::verify();
    // 解析路径
    router::analyze($_GET);
    // 初始化
    initialize::atCore();
    // 载入SDK
    sdk\loader::load();
    // View
    if( C("MODE") === router::MODE_API ){
      api::run();
    }else{
      controller::run();
    }
  }


  /**
   * Autoload
   * @param  class string
   * @return boolean
   */
  public static function autoload(string $class){
    $root_path = "./";
    $class_exploded = explode("\\", $class);
    $module = array_shift($class_exploded);
    if( $module == "fp" ){
      $root_path = "./lib/";
    }
    $path = $root_path.join('/', $class_exploded).'.class.php';
    if ( !is_file($path) ){
      return false;
    }
    include $path;
    return true;
  }

  /**
   * verify
   * @param  boolean is_again
   * @return void
   */
  public static function verify(bool $is_again = false){
    // 检查配置文件
    if( !is_file("./config.inc.php") ){
      if( !is_file("./lib/assets/configuration/config.inc.php.tpl") ){
        exit("[ERROR]Lost configuration file.");
      }else if( $is_again === false ){
        $conf = file_get_contents("./lib/assets/configuration/config.inc.php.tpl");
        file_put_contents("./config.inc.php", $conf);
        self::verify(true);
      }else{
        exit("[ERROR]Failed to create the configuration file.");
      }
    }
  }

  /**
   * Execute Update
   * @param  void
   * @return void
   */
  public static function exec_update(){
    if( is_file("./_update.php") ){
      include("./_update.php");
      @unlink("./_update.php");
    }
  }
}

?>
