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
		<title>采盘和地址申请审核</title>
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
		<link rel="stylesheet" href="../assets/js/datepicker/bootstrap-datetimepicker.min.css">
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		<script src="../js/jquery.serialize-object.js"></script>
		<script src="../assets/js/page.js"></script>
		<script src="../js/services.js"></script>
		<script src="../js/lp/check.js?r=1"></script>

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

		<script type="text/javascript">
			currentTab = "${param.tab}";
			if(currentTab==""){
				currentTab = "xhjAddressApplication";
			}
		</script>
	</head>

	<body class="page-body">
		<div class="page-container">
			<!-- add class "sidebar-collapsed" to close sidebar by default, "chat-visible" to make chat appear always -->

			<!-- Add "fixed" class to make the sidebar fixed always to the browser viewport. -->
			<!-- Adding class "toggle-others" will keep only one menu item open at a time. -->
			<!-- Adding class "collapsed" collapse sidebar root elements and show only icons. -->
			<div class="sidebar-menu toggle-others fixed" style="width:200px">
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
								<strong>采盘及地址审核</strong>
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
								</div>		
								<div class="row">
								
									<label class="col-sm-1 control-label" for="field-3">申请部门</label>
									<div class="col-sm-3">	
										<div class="form-group">	
											 <input type="hidden" name="condition.departmentId" id="selectDepartmentId" class="form-control" value="" data-bmName="" data-userId=""/>
										</div>
									</div>										
						
									<label class="col-sm-1 control-label" for="field-3">申请人</label>	
									<div class="col-sm-3">		
										<div class="form-group">
											<select class="form-control" name="condition.userId" id="selectUserId">
												<option value="">请选择人员</option>
											</select>
										</div>
									</div>									
									<label class="col-sm-1 control-label" for="field-3">状态</label>
									<div class="col-sm-3">	
										<div class="form-group">
											<select class="form-control" name="condition.checkStatus">
												<option value="">全部</option>
												<option value="0">未审核</option>
												<option value="1">审核通过</option>
												<option value="2">驳回</option>
												<option value="3">待审核</option>
											</select>
										</div>
									</div>	
								</div>
							
								<div class="row">
										<label class="col-lg-1 control-label" for="field-3">申请时间</label>
													
										<div class="col-lg-3">
											<div class="form-group">
												<input type="text" class="col-xs-5 wenbenkuan1 datepicker" name="condition.timeFrom">
												<div class="col-xs-2 text-center magin-top5">一</div>
												<input type="text" class="col-xs-5 wenbenkuan1 datepicker" name="condition.timeTo">
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
						<div class="panel-heading">
							<ul id="checkTabs" class="nav nav-tabs">
								<li class="active" id="tabLiAddressApplication">
									<a href="#xhjAddressApplication" data-toggle="tab">
										<span class="visible-xs"><i class="fa-home"></i></span>
										<span class="hidden-xs">地址申请</span>
									</a>
								</li>
								<li id="tabLiLpConnect">
									<a href="#lpxxCollect" data-toggle="tab">
										<span class="visible-xs"><i class="fa-user"></i></span>
										<span class="hidden-xs">采盘申请</span>
									</a>
								</li>
							</ul>
						</div>
						<div class="tab-content">
							<div class="tab-pane active" id="xhjAddressApplication">	
								<div class="panel-body">
									<div class="">
										<table class="table table-bordered table-striped table-condensed">
											<thead>
												<tr>													
													<th class="text-center" style="padding-left:0;padding-right:0">审核状态</th>
													<th class="text-center" style="padding-left:0">商圈</th>
													<th style="width:87px">小区名称</th>
													<th class="text-center" style="width:80px">栋座</th>
													<th class="text-center" style="padding-left:0;padding-right:0">单元</th>
													<th class="text-center" style="padding-left:0;padding-right:0">楼层</th>
													<th class="text-center" style="width:80px">门牌号</th>
													<th class="text-center">申请时间</th>
													<th class="text-center" style="padding-left:0">申请人</th>
													<th class="text-center" style="padding-left:0">申请人电话</th>
													<th class="text-center" style="width:100px">申请部门</th>
													<th class="text-center" style="padding-left:0">审核时间</th>
													<th class="text-center" style="padding-left:0">审核人</th>
													<th class="text-center" style="padding-left:0">操作</th>
												</tr>
											</thead>
											<tbody id="xhjAddressApplicationTBodyData">
												
											</tbody>
										</table>
										<div id="xhjAddressApplicationPageWidget"></div>
									</div>
									<div style="clear:both"></div>
								</div>
							</div>
							<div class="tab-pane" id="lpxxCollect">
								<div class="panel-body">
									<div class="">
										<table class="table table-bordered">
											<thead>
												<tr>
													<th class="text-center" style="padding-left:0;padding-rigth:0">审核状态</th>
													<th class="text-center" style="padding-left:0">用途</th>
													<th class="text-center" style="padding-left:0">区域</th>
													<th class="text-center" style="padding-left:0">商圈</th>
													<th class="text-center" style="width:80px">小区名称</th>
													<th class="text-center" style="padding-left:0">申请人</th>
													<th class="text-center" style="padding-left:0">申请人电话</th>
													<th class="text-center" style="width:80px">申请部门</th>
													<th class="text-center" style="padding-left:0">申请时间</th>
													<th class="text-center" style="padding-left:0">审核时间</th>
													<th class="text-center" style="padding-left:0">审核人</th>												
													<th class="text-center" style="padding-left:0" >操作</th>
												</tr>
											</thead>
											<tbody id="lpxxCollectTBodyData">
											</tbody>
										</table>
										<div id="lpxxCollectPageWidget"></div>					
									</div>
									<div style="clear:both"></div>
								</div>
							</div>
						<div style=" height:20px;"></div>
					</div>
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
<script src="../assets/js/daterangepicker/daterangepicker.js"></script>
<script src="../assets/js/datepicker/bootstrap-datetimepicker.js"></script>
<script src="../assets/js/datepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="../assets/js/timepicker/bootstrap-timepicker.min.js"></script>

<!-- Imported scripts on this page -->
<script src="../assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="../assets/js/tocify/jquery.tocify.min.js"></script>
<!-- JavaScripts initializations and stuff -->
<script src="../assets/js/xenon-custom.js"></script>

<div class="modal fade" id="shenhe">
  <div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
      <h4 class="modal-title">审核</h4>
    </div>
    <div class="modal-body">
      <table class="table">
        <tbody>
        	<tr>
        	<td width="60">申请说明</td>
            <td><textarea name="shenqingshuoming" class='form-control' style="height:100px; width:100%;" readonly="readonly"></textarea></td>
        	</tr>
          <tr>
            <td width="60">备注</td>
            <td><textarea name="shenhebeizhu" class='form-control' style="height:100px; width:100%;"></textarea></td>
          </tr>
          <tr>
        </tbody>
      </table>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
      <button type="button" class="btn btn-info" onclick="saveshenhe()">确定</button>
    </div>
    </div>
  </div>
</div>

<div class="modal fade" id="bohui">
  <div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
      <h4 class="modal-title">驳回</h4>
    </div>
    <div class="modal-body">
      <table class="table">
        <tbody>
            <tr>
        	<td width="60">申请说明</td>
            <td><textarea name="shenqingshuomingb" class='form-control' style="height:100px; width:100%;" readonly="readonly"></textarea></td>
        	</tr>
          <tr>
          <tr>
            <td width="60">备注</td>
            <td><textarea name="bohuibeizhu" class='form-control' style="height:100px; width:100%;"></textarea></td>
          </tr>
          <tr>
        </tbody>
      </table>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
      <button type="button" class="btn btn-info"onclick="savebohui()">确定</button>
    </div>
  </div>
  </div>
</div>

<div class="modal fade" id="infoModal" data-backdrop="static">

</div>