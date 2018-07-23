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
 * Template Processing Unit
 * @version 1.0.0
 * @author Jokin
**/
class template {

  public static $assign = array(
    'array' => array(),
    'single'  => array(),
  );

  public static function process(string $name){
    if( is_file("./lib/tpl/{$name}.tpl") ){
      $page = file_get_contents("./lib/tpl/{$name}.tpl");
    }else{
      die('[Controller]您要访问的页面不存在，请检查程序是否完整！');
    }
    // 处理
    $content = self::clearComments($page);
    $content = self::pageInclude($content);
    $content = self::conReference($content);
    $content = self::foreach($content);
    // 变量引用载入
    foreach (self::$assign['single'] as $key => $value) {
      $content = str_replace("{\${$key}}", $value, $content);
    }
    echo $content;
    self::initialize();
  }

  /**
   * 注释清除
   * @param  string page
   * @return string page
   */
  public static function clearComments(string $page){
    $pattern = "/<!--([\s\S]*)-->/iUm";
    $preg = preg_match_all($pattern,$page,$matches);
    if($preg!=0){
      for($i=0;$i<count($matches[0]);$i++){
        $page = str_replace($matches[0][$i],"",$page);
      }
    }
    return $page;
  }


  /**
   * 常量引用
   * @param  string  content
   * @return string
   */
  public static function conReference(string $content){
    $pattern = "/__(.+)__/U";
    $preg = preg_match_all($pattern,$content,$matches);
    if($preg !== 0){
      //去除重复
      $matches[0] = array_unique($matches[0]);
      $matches[1] = array_unique($matches[1]);
      $i = 0;
      $res = array();
      foreach($matches[0] as $match){
        $res[0][$i] = $match;
        $i++;
      }
      $i = 0;
      foreach($matches[1] as $match){
        $res[1][$i] = $match;
        $i++;
      }
      $matches = $res;
      for($i=0; $i<count($matches[0]); $i++){
        $const = C($matches[1][$i]);
        $content = str_replace($matches[0][$i],$const,$content);
      }
    }
    return $content;
  }

  /**
   * 变量引用
   * @param  string name
   * @param  mixed var
   * @return void
   */
  public static function assign(string $name, $var){
    $type = 'single';
    if( is_array($var) ){
      $type = 'array';
    }
    self::$assign[$type][$name] =  $var;
    self::$assign['all'][$name] =  $var;
  }

  /**
   * foreach模板处理
   * @param  string content
   * @return string
   */
  public static function foreach(string $content){
    $pattern = '/<foreach[\s]*name=[\'|\"](?<name>[\s\S]*)[\'|\"][\s]*>(?<container>[\s\S]*)<\/foreach>/iUm';
    $preg = preg_match_all($pattern, $content, $matches);
    // var_dump($matches);
    if ($preg !== 0) {
      for ($i=0; $i < count($matches[0]); $i++) {
        $name = $matches['name'][$i];
        // 无效循环清除
        if( !isset(self::$assign['array'][$name]) ){
          $content = str_replace($matches[0][$i], '', $content);
          continue;
        }
        $result = '';
        $values = self::$assign['array'][$name];
        // 单层变量匹配
        $res = '';
        foreach ($values as $key => $value) {
          if( is_array($value) ) continue;
          $res = str_replace('($value)', $value, $matches['container'][$i]);
          $res = str_replace('($key)', $key, $res);
          $result .= $res;
        }
        // 多层变量匹配
        // [优化]：去除重复项
        $res = '';
        $pattern3 = '/\(\$value(?<sub>:[\s\S]+)+\)/U';
        $preg3 = preg_match_all($pattern3, $matches['container'][$i], $matches3);
        if( $preg3 !== 0 ){
          for ($j=0; $j < count($values); $j++) {
            $res = $matches['container'][$i];
            for ($k=0; $k < count($matches3[0]); $k++) {
              $sub = explode(':', trim($matches3['sub'][$k], ':'));
              $vals = $values[$j];
              // 取出value
              foreach ($sub as $val) {
                $value = isset($vals[$val]) ? $vals[$val] : '';
              }
              if( is_array($value) ) continue;
              $res = str_replace($matches3[0][$k], $value, $res);
            }
            $result .= $res;
          }
        }
        $content = str_replace($matches[0][$i], $result, $content);
      }
    }
    return $content;
  }

  /**
   * 页面引用
   * @param  string  content 内容
   * @return string
   */
  public static function pageInclude(string $content){
    $path = "./lib/tpl/public/";
    $suffix = ".tpl";
    $pattern = "/{_(.+)_}/U";
    $preg = preg_match_all($pattern,$content,$matches);
    if($preg !== 0){
      //去除重复
      $matches[0] = array_unique($matches[0]);
      $matches[1] = array_unique($matches[1]);
      for ($i=0; $i < count($matches[1]); $i++) {
        if( is_file($path.$matches[1][$i].$suffix) ){
          $c = file_get_contents($path.$matches[1][$i].$suffix);
          $content = str_replace($matches[0][$i], $c, $content);
        }
      }
    }
    return $content;
  }

  /**
   * 初始化
   * @param  void
   * @return void
   */
  private static function initialize(){
    self::$assign = array(
      'array' => array(),
      'single'  => array(),
    );
  }

}
?>
