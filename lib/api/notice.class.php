<?php
// +----------------------------------------------------------------------
// | Constructed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------

/**
 * Notice
 * @version  1.0.0
 * @author   Jokin
 */
class notice {
  // 服务地址
  public $server = false;

  // 获取公告
  public function getNotice() : void {
    // 检查支持情况
    $this->checkSupport();
    // 获取服务器链接
    if ($this->server === false) {
      $this->error();
    }
    // notice server
    $notices = \fp\acquirer::get($this->server.'/notice/notices.md');
    if ($notices !== false) {
      $notices = @json_decode($notices, true);
    }else{
      $this->error();
    }
    // 解析错误
    if (!$notices) {
      $this->error();
    }
    // 解析数据
    $err['code'] = "0";
    $err['msg'] = "success";
    $err['msg_zh'] = "成功获取公告数据";
    $err['data'] = array(
      'server' => $this->server,
      'data'   => $notices
    );
    echo json_encode($err);
  }

  // 检查支持情况
  private function checkSupport() : void {
    // 获取支持信息
    $pi = \fp\tserver::getProjectInfo(C('NAME'));
    if ($pi === false){
      $this->error();
    }
    $this->server = $pi['server'][0];
  }

  private function error() : void {
    $err['code'] = "-1"; // 不显示错误
    $err['msg'] = "failed to connect to server";
    $err['msg_zh'] = "连接公告服务器失败";
    echo json_encode($err);
    exit();
  }
}
?>
