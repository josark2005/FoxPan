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
 * Acquirer
 * @version 1.0.0
 * @author  Jokin
 */
class acquirer {

  /**
   * 模拟访问
   * @param  string url
   * @param  array  post
   * @return mixed
  **/
  public static function get($url, $post = false){
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_HEADER, FALSE);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
    if( $post !== false ){
      curl_setopt($ch, CURLOPT_POST, TRUE);
      curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
    }
    $res = curl_exec($ch);
    $err = curl_errno($ch);
    if( $err !== 0 ){
      return false;
    }else{
      return $res;
    }
  }

  /**
   * Get Project Info
   * @param  void
   * @return void
  **/
  public static function getpi() : void {
    $info = fp\tserver::getProjectInfo(NAME);
    exit(json_encode($info));
  }

}

?>
