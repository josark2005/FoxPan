<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>__NAME_CN__</title>
    <link rel="shortcut icon" href="./lib/tpl/imgs/logo.png?ver=__VERSION__">
    <link rel="stylesheet" href="./lib/tpl/css/bootstrap.min.css?ver=__VERSION__">
    <link rel="stylesheet" href="./lib/tpl/css/manager.css?ver=__VERSION__">
    <script src="./lib/tpl/js/jquery-3.2.1.min.js?ver=__VERSION__" charset="utf-8"></script>
    <script src="./lib/tpl/js/jquery.contextify.min.js?ver=__VERSION__" charset="utf-8"></script>
    <script src="./lib/tpl/js/bootstrap.bundle.min.js?ver=__VERSION__" charset="utf-8"></script>
    {_common_var_}
    <script src="./lib/tpl/js/main.js?ver=__VERSION__" charset="utf-8"></script>
    <script src="./lib/tpl/js/manager.js?ver=__VERSION__" charset="utf-8"></script>
    <script type="text/javascript">
      var prefix = '{$prefix}';
    </script>
    <script type="text/template" id="tpl-btn-dd-item">
      <a class="dropdown-item text-dark" href="javascript:;" onclick="#click">#action</a>
    </script>
    <script type="text/template" id="tpl-btn-dd-divider">
      <div class="dropdown-divider"></div>
    </script>
    <script type="text/template" id="tpl-notice">
      <div class="alert alert-#color text-center"><a href="#link" target="_blank">#title</a></div>
    </script>
  </head>
  <body>
    {_nav_}
    <div class="container my-4" id="container">
      <div id="notice">
        {_warning_}
      </div>
      <div class="row">

        <div class="col-md-12 col-sm-12">
          <div class="card">
            <div class="card-header bg-dark text-white">
              <span class="font-weight-bold">资源管理</span> <small class="badge badge-light">位置：<span id="prefix"></small>
            </div>
            <div class="card-body">

                  <table class="table table-hover table-responsive-sm">
                    <col style="max-width: 80%" />
                    <col style="min-width: 180px;" />
                    <col style="min-width: 180px;" />
                    <thead>
                      <tr>
                        <th scope="col">名称</th>
                        <th scope="col">大小</th>
                        <th scope="col">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <foreach name="folders">
                        <tr>
                          <td class="text-truncate">
                            <a class="text-dark" href="?page=manager&prefix=($value:key)" title="($value:name)">
                              <i class="fas fa-folder-open fa-fw fa-2x"></i> ($value:name)
                            </a>
                          </td>
                          <td>文件夹</td>
                          <td><button class="btn btn-sm btn-info" onclick="location.href='?page=manager&prefix=($value:key)'">打开</button></td>
                        </tr>
                      </foreach>
                      <foreach name="files">
                        <tr id="box_($value:hash)">
                          <td class="text-truncate">
                            <a class="text-dark" name="file-link" href="http://__DM__/($value:key)" id="($value:hash)" title="($value:name)"
                             data-name="($value:name_fixed)" data-key="($value:key_fixed)" data-hash="($value:hash)" data-size="($value:fsize)">
                              <i class="fas fa-file fa-fw fa-2x"></i> ($value:name)
                            </a>
                          </td>
                          <td id='size-($value:hash)'>0</td>
                          <td>
                            <div class="dropdown">
                              <button class="btn btn-sm btn-primary dropdown-toggle" type="button" id="btn-($value:hash)"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                操作
                              </button>
                              <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" id="btn-dd-($value:hash)"></div>
                            </div>
                          </td>
                        </tr>
                      </foreach>
                  </table>


            </div>
            <div class="card-footer">
              <small class="text-muted">*[删除文件夹]：删除文件夹中的所有内容文件夹会自动清除。</small>
            </div>
          </div>
        </div>

      </div>

    </div>

    <!-- {_footer_} -->

    <div class="modal fade" tabindex="-1" role="dialog" id="newFloder">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">新建文件夹</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
            <div class="alert alert-danger"><strong>警告！</strong>请勿使用斜杠"/"以避免创建其子文件夹。</div>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text" id="inputGroup-sizing-default">新文件夹名称</span>
              </div>
              <input type="text" id="newFloderName" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default">
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            <button type="button" class="btn btn-primary" onclick="newFloder();">创建并进入</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="modal fade" tabindex="-1" role="dialog" id="confirmer">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">确认删除</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
            <div class="alert alert-danger">您确定要删除<strong id="filekey">null</strong>吗？</div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            <button type="button" class="btn btn-danger" id="del_href">删除</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="modal fade" tabindex="-1" role="dialog" id="rename">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">重命名</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          </div>
          <div class="modal-body">
            <div class="input-group mb-3">
              <input type="text" id="name" tabindex="0" class="form-control" autofocus="autofocus" placeholder="重命名" />
              <div class="input-group-sappend">
                <button class="btn btn-outline-danger" id="btn-rename" type="button">修改</button>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

  </body>
</html>
