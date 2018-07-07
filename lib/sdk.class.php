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
 * SDK Interface
 * @version 1.0.0
 */
interface sdk {

  /**
   * 初始化SDK
   * @param  void
   * @return void
   */
  public static function init();

  /**
   * 删除文件
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @param  string key
   * @return boolean
   */
  public static function del(string $ak, string $sk, string $bkt, string $key);

  /**
   * 获取下载链接
   * @param  string ak
   * @param  string sk
   * @param  string url
   * @param  int expires
   * @return boolean
   */
  public static function getDownloadUrl(string $ak, string $sk, string $url, int $expires=3600);

  /**
   * 重命名文件
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @param  string okey 原始文件名
   * @param  string key 新文件名
   * @param  boolean add_prefix
   * @return boolean
   */
  public static function rename(string $ak, string $sk, string $bkt, string $opath, string $path, bool $add_prefix);

  /**
   * 获取目录与文件
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @param  string path
   * @param  string marker
   * @return mixed
   */
  public static function getFiles(string $ak, string $sk, string $bkt, string $path, string $marker);

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
  public static function moveFile(string $ak, string $sk, string $bkt, string $okey, string $key, bool $add_prefix);

  /**
   * 复制文件
   * @param  string ak
   * @param  string sk
   * @param  string opath 源文件路径
   * @param  string path 新文件路径
   * @return boolean
   */
  public static function copyFile(string $ak, string $sk, string $opath, string $path);

  /**
   * 获取域名
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @return mixed
   */
  public static function getDoamin(string $ak, string $sk, string $bkt);

  /**
   * 获取Bukcet
   * @param  string ak
   * @param  string sk
   * @return mixed
   */
  public static function getBucket(string $ak, string $sk);

  /**
   * 获取流量信息
   * @param  string ak
   * @param  string sk
   * @param  string qd
   * @return mixed
   */
  public static function getFlux(string $ak, string $sk, string $qd);

  /**
   * 获取uptoken
   * @param  string ak
   * @param  string sk
   * @param  string bkt
   * @param  int expires
   * @return mixed
   */
  public static function getUpToken(string $ak, string $sk, string $bkt, int $expires=3600);
}
?>
