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
 * @version 1.0.0
 * @author Jokin
 */

class loader {

  // 设置SDK目录
  const SDK_PATH = './lib/sdk/';

  // SDK载入路径
  const SDK_AUTOLOAD = array(
    'QINIU' => 'qiniu.class.php',
  );

  /**
   * 自动载入SDK
   * @param  void
   * @return void
   */
  public static function load(){
    $status = 0;
    $path = null;
    switch ( mb_strtoupper(C('SP')) ) {
      case 'QINIU':
        $status = 1;
        $path =  self::SDK_PATH.self::SDK_AUTOLOAD[mb_strtoupper(C("SP"))];
        break;

      default:
        if( C('PAGE') !== 'guide' ){
          if( !isset($_GET['install']) || $_GET['install'] !== 'true' ){
            \fp\router::redirect('guide');
            return ;
          }
        }
    }
    if ($status !== 0 && is_file($path)) {
      include $path;
      oss::init();
    }else{
      die('[SDK Loader]SDK不存在，请检查程序是否完整或者配置文件是否正常！');
    }
  }

}
?>
