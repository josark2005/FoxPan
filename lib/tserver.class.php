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
 * Twocola Server
 * @version  1.0.2
 * @author Jokin
**/
class tserver {

  private static $basic_url = "http://jokin1999.github.io/twocola-server";

  /**
   * 获取项目服务地址
   * @param  string project
   * @return string
  **/
  public static function getProjectUrl($project, $need_arkslash = false){
    $url = self::fixUrl(self::$basic_url, true).$project;
    $url = self::fixUrl($url, $need_arkslash);
    return $url;
  }

  /**
   * 地址兼容
   * @param  string url
   * @param  boolean need_arkslash
   * @return string
  **/
  public static function fixUrl($url, $need_arkslash = false){
    if( mb_substr($url, mb_strlen($url)-1, mb_strlen($url)) === "/" ){
      if( $need_arkslash === true ){
        return $url;
      }else{
        return mb_substr($url, 0, mb_strlen($url)-1);
      }
    }else{
      if( $need_arkslash === false ){
        return $url;
      }else{
        return $url."/";
      }
    }
  }

  /**
   * 获取项目信息
   * @param  string name
   * @param  string suffix
   * @return void
  **/
  public static function getProjectInfo($name, $suffix=".md"){
    $url = self::getProjectUrl($name).$suffix;
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_HEADER, FALSE);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
    $res = curl_exec($ch);
    $errno = curl_errno($ch);
    if( $errno !== 0 ){
      return false;
    }else{
      return json_decode($res, true);
    }
  }

  /**
   * 获取所有项目地址
   * @param  string name
   * @param  string suffix
   * @return mixed
  **/
  public static function getServerUrls($name, $suffix=".md"){
    $res = self::getProjectInfo($name, $suffix);
    if( $res === false ){
      return false;
    }else{
      if( isset($res['server']) && is_array($res['server']) ){
        return $res['server'];
      }else{
        return false;
      }
    }
  }

  /**
   * 获取单个项目地址
   * @param  string name
   * @param  string suffix
   * @return mixed
  **/
  public static function getServerUrl($name, $suffix=".md"){
    $res = self::getServerUrls($name, $suffix);
    if( $res === false ){
      return false;
    }else{
      return array_pop($res);
    }
  }

}

?>
