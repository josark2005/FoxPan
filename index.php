<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------

/**
 * Fox Pan
 * @author  Jokin
 * @link    http://jokin1999.github.io/FoxPan/
 */

/**
 * 请勿随意修改以下内容
 * DO NOT Modify the following content without professional guide
 */
// 环境版本限制
if (version_compare(PHP_VERSION, "7.0.0", "<")) {
  die('PHP版本(' . PHP_VERSION . ')过低！请使用7.0.0或更新版本！<br />PHP 7.0.0 or newer needed.');
}
// 载入核心
include "./lib/core.class.php";
// 初始化驱动
\fp\Core::initialize();
?>
