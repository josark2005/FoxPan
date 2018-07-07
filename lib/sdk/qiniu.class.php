<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------

/**
 * QINIU SDK DRIVER
 * @version  1.0.0
 * @author Jokin
 */

namespace fp\sdk;

class oss implements \fp\sdk {

  /**
   * SDK载入路径
   */
  const SDK_PATH = "./lib/sdk/qiniu/autoload.php";

  /**
   * 初始化SDK
   * @param  void
   * @return void
   */
  public static function init(){
    // 载入SDK
    include self::SDK_PATH;
    self::getFlux(C('AK'), C('SK'), C('QD'));
    self::getUpToken(C('AK'), C('SK'), C('BKT'));
  }

  /**
   * 删除文件
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @param  string key
   * @return boolean
   */
  public static function del(string $ak, string $sk, string $bkt, string $key){
    $auth = new \Qiniu\Auth($ak, $sk);
    $config = new \Qiniu\Config();
    $bucketManager = new \Qiniu\Storage\BucketManager($auth, $config);
    $err = $bucketManager->delete($bkt, $key);
    return $err;
  }

  /**
   * 获取下载链接
   * @param  string ak
   * @param  string sk
   * @param  string url
   * @param  string expires
   * @return boolean
   */
  public static function getDownloadUrl(string $ak, string $sk, string $url, int $expires=3600){
    $auth = new \Qiniu\Auth($ak, $sk);
    $signedUrl = $auth->privateDownloadUrl($url, $expires);
    return $signedUrl;
  }

  /**
   * 重命名文件
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @param  string okey 原始文件名
   * @param  string key 新文件名
   * @return boolean
   */
  public static function rename(string $ak, string $sk, string $bkt, string $okey, string $key, bool $add_prefix){
    return self::moveFile($ak, $sk, $bkt, $okey, $key, $add_prefix);
  }

  /**
   * 获取目录与文件
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @param  string path
   * @param  string marker
   * @return mixed
   */
  public static function getFiles(string $ak, string $sk, string $bkt, string $prefix, string $marker){
    $auth = new \Qiniu\Auth($ak, $sk);
    $bucketManager = new \Qiniu\Storage\BucketManager($auth);
    $limit = 200;
    $delimiter = '/';
    // 列举文件
    $res = null;
    do {
        list($ret, $err) = $bucketManager->listFiles($bkt, $prefix, $marker, $limit, $delimiter);
        if ($err !== null) {
            return false;
        } else {
            $marker = null;
            if (array_key_exists('marker', $ret)) {
                $marker = $ret['marker'];
            }
            if( array_key_exists('items', $ret) ){
              foreach ($ret['items'] as $value) {
                $res['items'][] = $value;
              }
            }
            if( array_key_exists('commonPrefixes', $ret) ){
              foreach ($ret['commonPrefixes'] as $value) {
                $res['commonPrefixes'][] = $value;
              }
            }
        }
    } while (!empty($marker));
    return $res;
  }

  /**
   * 移动文件
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @param  string okey 源文件名
   * @param  string key 新文件名
   * @param  boolean add_prefix
   * @return boolean
   */
  public static function moveFile(string $ak, string $sk, string $bkt, string $okey, string $key, bool $add_prefix){
    if( $add_prefix === true ){
      $prefix = explode("/", $okey);
      if( count($prefix) === 1 ){
        $prefix = "";
      }else{
        array_pop($prefix);
        $prefix = join("/", $prefix)."/";
      }
    }
    $key = $prefix.$key;
    if( $okey === $key ){
      return true;
    }
    $auth = new \Qiniu\Auth($ak, $sk);
    $config = new \Qiniu\Config();
    $bucketManager = new \Qiniu\Storage\BucketManager($auth, $config);
    $srcBucket = $bkt;
    $destBucket = $bkt;
    $srcKey = $okey;
    $destKey = $key;
    $err = $bucketManager->move($srcBucket, $srcKey, $destBucket, $destKey, true);
    if($err) {
      return false;
    }else{
      return true;
    }
  }

  /**
   * 复制文件
   * @param  string ak
   * @param  string sk
   * @param  string opath 源文件路径
   * @param  string path 新文件路径
   * @return boolean
   */
  public static function copyFile(string $ak, string $sk, string $opath, string $path){

  }

  /**
   * 获取域名
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @return mixed
   */
  public static function getDoamin(string $ak, string $sk, string $bkt){
    $auth = new \Qiniu\Auth($ak, $sk);
    $config = new \Qiniu\Config();
    $bucketManager = new \Qiniu\Storage\BucketManager($auth, $config);
    list($domains, $err) = $bucketManager->domains($bkt);
    if ($err) {
        return $err;
    } else {
        return $domains;
    }
  }

  /**
   * 获取Bukcet
   * @param  string ak
   * @param  string sk
   * @return mixed
   */
  public static function getBucket(string $ak, string $sk){
    $auth = new \Qiniu\Auth($ak, $sk);
    $config = new \Qiniu\Config();
    $bucketManager = new \Qiniu\Storage\BucketManager($auth, $config);
    list($buckets, $err) = $bucketManager->buckets(true);
    if ($err) {
        return false;
    } else {
        return $buckets;
    }
  }

  /**
   * 获取流量信息
   * @param  string ak
   * @param  string sk
   * @param  string qd
   * @return mixed
   */
  public static function getFlux(string $ak, string $sk, string $qd){
    $auth = new \Qiniu\Auth($ak, $sk);
    $cdnManager = new \Qiniu\Cdn\CdnManager($auth);
    $domains = explode(",", $qd);
    $startDate = date("Y-m-01");
    $endDate = date("Y-m-d");
    $granularity = "day";
    list($fluxData, $getFluxErr) = $cdnManager->getFluxData($domains, $startDate, $endDate, $granularity);
    if ($getFluxErr != null) {
        $flux = "获取失败";
    } else {
        $flux = 0;
        foreach ($fluxData['data'] as $domain) {
          foreach ($domain as $key => $value) {
            foreach ($value as $key => $value2) {
              $flux += $value2;
            }
          }
        }
    }
    if( is_numeric($flux) ){
      $flux = round($flux/1024/1024, 2);
    }
    C("FLUX", $flux, true);
    return $flux;
  }

  /**
   * 获取uptoken
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @param  int expires
   * @return mixed
   */
  public static function getUpToken(string $ak, string $sk, string $bkt, int $expires=3600){
    $auth = new \Qiniu\Auth($ak, $sk);
    $expires = $expires;
    $policy = null;
    $upToken = $auth->uploadToken($bkt, null, $expires, $policy, true);
    C("UPTOKEN", $upToken);
    return $upToken;
  }
}

?>
