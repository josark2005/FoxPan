<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------

namespace fp\sdk;

/**
* SDK Loader
* @param  void
* @return void
*/

class loader {

  const SDK_PATH = './lib/sdk/';

  // SDK载入路径
  private static $sdk_autoload = array(
    "QINIU" => "qiniu.class.php",
  );

  public static function load(){
    $status = 0;
    $path = null;
    switch ( mb_strtoupper(C("SP")) ) {
      case "QINIU":
        $status = 1;
        $path =  self::SDK_PATH.self::$sdk_autoload[mb_strtoupper(C("SP"))];
        break;

      default:
        if( C("PAGE") !== "guide" ){
          if( !isset($_GET['install']) || $_GET['install'] !== 'true' ){
            \fp\router::redirect("guide");
          }
        }
    }
    if ($status !== 0 && is_file($path)) {
      include $path;
      oss::init();
    }
  }

}
?>
