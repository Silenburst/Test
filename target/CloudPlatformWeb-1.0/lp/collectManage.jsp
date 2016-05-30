<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="description" content="Xenon Boostrap Admin Panel" />
		<meta name="author" content="" />
		<title>楼盘采集</title>
		<link rel="stylesheet" href="../assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="../assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/css/xenon-core.css">
		<link rel="stylesheet" href="../assets/css/xenon-forms.css">
		<link rel="stylesheet" href="../assets/css/xenon-components.css">
		<link rel="stylesheet" href="../assets/css/xenon-skins.css">
		<link rel="stylesheet" href="../assets/css/custom.css">
		<link rel="stylesheet" href="../assets/css/xiaoqu.css">
		<link rel="stylesheet" href="../assets/js/select2/select2.css">
		<link rel="stylesheet" href="../assets/js/select2/select2-bootstrap.css">
		<link rel="stylesheet" href="../assets/js/multiselect/css/multi-select.css">
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		<script src="../js/jquery.serialize-object.js"></script>
		<script src="../assets/js/page.js"></script>
		<script src="../js/services.js"></script>
		<script src="../js/lp/collectManage.js"></script>

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

	</head>

	<body class="page-body">
		<div class="page-container">
			<!-- add class "sidebar-collapsed" to close sidebar by default, "chat-visible" to make chat appear always -->

			<!-- Add "fixed" class to make the sidebar fixed always to the browser viewport. -->
			<!-- Adding class "toggle-others" will keep only one menu item open at a time. -->
			<!-- Adding class "collapsed" collapse sidebar root elements and show only icons. -->
			<div class="sidebar-menu toggle-others fixed">
				<jsp:include page="../include/left.jsp"/>
			</div>
			<div class="main-content">
				<!-- User Info, Notifications and Menu Bar -->
				<jsp:include page="../include/top.jsp"/>
				
				<div class="page-title">
					<div class="breadcrumb-env pull-left">
						<ol class="breadcrumb bc-1">
							<li>
								<a href="javascript:void(0)"><i class="fa-home"></i>首页</a>
							</li>
							<li class="active">
								<strong>楼盘采集</strong>
							</li>
						</ol>
					</div>
				</div>
				<div class="row">					

					<div class="panel panel-default">
						<form name="formCondition" role="form" class="form-horizontal">	
								<div class="row">												
									<label class="col-sm-1 control-label" for="field-3">区域</label>
									<div class="col-sm-3">	
										<div class="form-group">
											<select class="form-control" name="condition.stressId">
												<option value="">请选择区域</option>
												<s:iterator value="stressList">
							                		<option  value="<s:property value="id"/>"><s:property value="qyName"/></option>
							                	</s:iterator>
											</select>
										</div>
									</div>
									<label class="col-sm-1 control-label" for="field-3">商圈</label>
									<div class="col-sm-3">	
										<div class="form-group">
											<select class="form-control" name="condition.sqId">
												<option value="">请选择商圈</option>
											</select>
										</div>
									</div>								
									<label class="col-sm-1 control-label" for="field-3">小区名称</label>
									<div class="col-sm-3">	<div class="form-group"><input type="text" name="condition.lpName" class="form-control" ></div></div>
									<label class="col-sm-1 control-label" for="field-3">状态</label>
									<div class="col-sm-3">	
										<div class="form-group">
											<select class="form-control" name="condition.checkStatus">
												<option value="">全部</option>
												<option value="0">未提交</option>
												<option value="1">待审核</option>
												<option value="2">审核通过</option>
												<option value="3">审核驳回</option>
											</select>
										</div>
									</div>	
									<div class="col-lg-3 col-lg-offset-1">
											<div class="form-group">
												<button type="button" class="btn btn-secondary" id="bnQueryData">查询</button>
											</div>
										</div>	
								</div>
						</form>
						<div class="clearfix"></div>
					</div>
					
					<div class="panel panel-default">
							<div>
								<a href="../campus/addCampus.jsp?from=apply"><button class="btn btn-secondary"><i class="fa-plus"></i> 新增楼盘 </button></a>
							</div>
							<div class="panel-body">
								<div class="table-responsive">
									<table class="table table-bordered">
										<thead>
											<tr>
									            <th class="text-center">审核状态</th>
									            <th class="text-center">用途</th>
									            <th class="text-center">区域</th>
									            <th class="text-center">商圈</th>
									            <th class="text-center">小区名称</th>
									            <th class="text-center">申请人</th>
									            <th class="text-center">申请部门</th>
									            <th class="text-center">申请时间</th>
									            <th class="text-center">操作</th>
											</tr>
										</thead>
										<tbody id="lcTBodyData">
											
										</tbody>
									</table>
									<div id="lcPageWidget"></div>
								</div>
								<div style="clear:both"></div>
							</div>
						<div style=" height:20px;"></div>
					</div>
				</div>
			</div>
		</div>

		<div class="go-up" style="position: fixed;right: 15px; bottom: 10px; z-index: 9999;">
			<a href="#" rel="go-top">
				<i class="el-up-open"></i>
			</a>
		</div>	
	</body>

</html>

<!-- Bottom Scripts -->
<script src="../assets/js/bootstrap.min.js"></script>
<script src="../assets/js/TweenMax.min.js"></script>
<script src="../assets/js/resizeable.js"></script>
<script src="../assets/js/joinable.js"></script>
<script src="../assets/js/xenon-api.js"></script>
<script src="../assets/js/xenon-toggles.js"></script>

<!-- Imported scripts on this page -->
<script src="../assets/js/xenon-widgets.js"></script>
<script src="../assets/js/select2/select2.min.js"></script>
<script src="../assets/js/select2/select2_locale_zh-CN.js"></script>
<script src="../assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="../assets/js/selectboxit/jquery.selectBoxIt.min.js"></script>
<script src="../assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script src="../assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>
<script src="../assets/js/toastr/toastr.min.js"></script>

<!-- Imported scripts on this page -->
<script src="../assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="../assets/js/tocify/jquery.tocify.min.js"></script>
<!-- JavaScripts initializations and stuff -->
<script src="../assets/js/xenon-custom.js"></script>

<div class="modal fade" id="Shanchu">
  <div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-body">
      <button type="button" class="bootbox-close-button close" data-dismiss="modal" aria-hidden="true" style="margin-top: -10px;">×</button>
      <div class="bootbox-body">您确定要删除选中的楼盘吗？</div>
    </div>
    <div class="clearfix"></div>
    <div class="modal-footer">
      <button type="button" class="btn btn-white" data-dismiss="modal">取消</button>
      <button type="button" class="btn btn-info" onclick="deletelp()">确定</button>
    </div>
  </div>
  </div>
</div>

<div class="modal fade" id="Shenqing">
  <div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
      <h4 class="modal-title">提交申请</h4>
    </div>
    <div class="modal-body">
      <table class="table">
        <tbody>
          <tr>
            <td width="60">申请说明</td>
            <td><textarea name="shenqingbeizhu" class='form-control' style="height:100px; width:100%;"></textarea></td>
          </tr>
          <tr>
        </tbody>
      </table>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
      <button type="button" class="btn btn-info"onclick="saveshenqing()">确定</button>
    </div>
  </div>
  </div>
</div>

<div class="modal fade" id="infoModal" data-backdrop="static">

</div>