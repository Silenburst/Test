<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
String provinceId = userLogin.getProvinceId();
String countryId = userLogin.getCountryId();
String cityId = userLogin.getCityId();
%>
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="description" content="Xenon Boostrap Admin Panel" />
		<meta name="author" content="" />
		<title>Xenon - Dashboard</title>
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/bootstrap.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-core.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-forms.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-components.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-skins.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/custom.css">
		<script src="<%=basePath%>/assets/js/jquery-1.11.1.min.js"></script>
		<script src="<%=basePath%>/js/services.js"></script>
		<link rel="stylesheet" href="../assets/js/bootbox/bootbox.css">
		<script src="../assets/js/bootbox/bootbox.min.js"></script>
		<script src="<%=basePath%>/js/page.js"></script>
		<script src="<%=basePath%>/js/base/unionschool.js"></script>
		<script type="text/javascript">
			var basepath = "<%=basePath%>";
			var countryId = "<%=countryId%>";
			var provinceId = "<%=provinceId%>";
			var cityId = "<%=cityId%>";
		</script>
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
				<jsp:include page="../include/top.jsp"/>
				
				<div class="page-title">
					<div class="breadcrumb-env pull-left">
						<ol class="breadcrumb bc-1">
							<li>
								<a href="<%=basePath%>/console/index.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<li class="active">
								<strong><a href="<%=basePath%>/base/school.action">学区管理</a></strong>
							</li>
						</ol>
					</div>
				</div>
<!-- 		<form action="formschool"  method="post"> -->
			<input type="hidden" name="page" id="page" value="1"/>
				<div class="panel panel-default">
					<div class="row">
						<div class="col-md-12" style="display:none">							
							<div class="Color pull-left h5" id="country">
							</div>
						</div>
						<div class="col-md-12" >							
							<div class="Color pull-left h5" id="pro">
								
							</div>
						</div>
						<div class="col-md-12">							
							<div class="Color pull-left h5" id="city">
							
							</div>
						</div>
						<div class="col-md-12">						
							<div class="Color pull-left h5" id="sQy">
							</div>
						</div>
						<div class="col-md-12">						
							<div class="Color pull-left h5" id="sSq">
							</div>
						</div>
						<div class="col-md-12">
							<div class="pull-right">
								<button class="btn btn-secondary btn-xs " onclick="editType()" data-toggle="modal" data-target="#lei-gai"><i class="fa-pencil"></i> 编辑</button>
								<button class="btn btn-success btn-xs " data-toggle="modal" data-target="#lei-zeng"><i class="fa-plus"></i> 新增</button>
							</div>
							<div class="Color pull-left h5" id="xxlx">
							</div>
						</div>
					</div>
				</div>
				
				<div class="panel panel-default">
				<div class="input-group col-lg-3" style="padding-bottom: 10px;" >
					<input type="text" class="form-control no-right-border form-focus-purple"  placeholder="请输入学区名称" id="xuequName">
					<span class="input-group-btn">
						<a href="#" class="btn btn-success" onclick="queryData()">搜索</a>
					</span>
				</div>
					<div>
						<a href="<%=basePath%>/base/add.jsp?k=base&p=xq" class="btn btn-secondary"><i class="fa-plus"></i> 新增 </a>
						<button class="btn btn-danger" onclick="deleteAllSchool()"><i class="fa-trash-o"></i> 批量删除 </button>
					</div>
					<div class="table-responsive">
						<table class="table table-bordered table-striped table-condensed">
							<thead>
								<tr>
									<th width="50"><input type="checkbox" id="table_ckall" class="cbr" /></th>
									<th colspan="2">学校</th>
									<th>划片小区</th>
									<th>招生简章</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody class="middle-align" id="tbodyData">
							</tbody>
						</table>
			    	</div>
			    	<div class="clearfix"></div>
			    	<div style="height:10px;"></div>
						<div id="macPageWidget"></div>
			    	<div class="clearfix"></div>
			</div>
<!-- </form> -->
			<!-- start: Chat Section -->
			<div id="chat" class="fixed">
				<div class="chat-inner">
					<h2 class="chat-header">
			<a href="#" class="chat-close" data-toggle="chat">
				<i class="fa-plus-circle rotate-45deg"></i>
			</a>
			Chat
			<span class="badge badge-success is-hidden">0</span>
		</h2>
					<script type="text/javascript">
						// Here is just a sample how to open chat conversation box
						jQuery(document).ready(function($) {
							var $chat_conversation = $(".chat-conversation");
							$(".chat-group a").on('click', function(ev) {
								ev.preventDefault();
								$chat_conversation.toggleClass('is-open');
								$(".chat-conversation textarea").trigger('autosize.resize').focus();
							});
							$(".conversation-close").on('click', function(ev) {
								ev.preventDefault();
								$chat_conversation.removeClass('is-open');
							});
						});
					</script>
					<div class="chat-group">
						<strong>dasda</strong>
						<a href="#"><span class="user-status is-online"></span> <em>发撒打发四大倒萨</em></a>
						<a href="#"><span class="user-status is-online"></span> <em>发撒打发四大倒萨</em></a>
						<a href="#"><span class="user-status is-busy"></span> <em>发撒打发四大倒萨</em></a>
						<a href="#"><span class="user-status is-idle"></span> <em>发撒打发四大倒萨</em></a>
						<a href="#"><span class="user-status is-offline"></span> <em>发撒打发四大倒萨</em></a>
					</div>

					<div class="chat-group">
						<strong>321321</strong>
						<a href="#"><span class="user-status is-busy"></span> <em>大声道打算倒萨</em></a>
						<a href="#"><span class="user-status is-offline"></span> <em>的撒大大撒大声地倒萨</em></a>
						<a href="#"><span class="user-status is-offline"></span> <em>发撒打发四大倒萨</em></a>
					</div>
					<div class="chat-group">
						<strong>Other</strong>
						<a href="#"><span class="user-status is-online"></span> <em>发撒打发四大倒萨</em></a>
					</div>
				</div>
			</div>
			<!-- end: Chat Section -->

		</div>

		<div class="go-up" style="position: fixed;right: 15px; bottom: 10px; z-index: 9999; background: #f7aa47;padding: 10px;filter:alpha(opacity=50);moz-opacity:0.5;opacity:0.5;">
			<a href="#" rel="go-top">
				<i class="fa-arrow-up" style="font-size: 3em;"></i>
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
<script src="../assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script src="../assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>
<script src="../assets/js/toastr/toastr.min.js"></script>

<!-- Imported scripts on this page -->
<script src="../assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="../assets/js/tocify/jquery.tocify.min.js"></script>
<!-- JavaScripts initializations and stuff -->
<script src="../assets/js/xenon-custom.js"></script>


<!--类型-->
<div class="modal fade" id="lei-zeng" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">新增</h4>
			</div>
			<div class="modal-body">
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
				<form role="form" class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-3 control-label">添加类型：</label>
						<div class="col-sm-8" id="addButton">
							<div class="input-group input-group-minimal">
								<input type="text" class="form-control" id="" name="typeName">
								<a href="#" class="input-group-addon"><i class="fa-plus" onclick="addInput()"></i></a>
							</div>
						</div>
					</div>
					<div class="form-group-separator"></div>
				</form>

			</div>	
			</div>	
			<div class="modal-footer">
				<button type="submit" class="btn btn-info" onclick="addType()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="lei-gai" data-backdrop="static">
<form action="" method="POST" id="form" >
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">编辑</h4>
			</div>
			<div class="modal-body">
			<input type="hidden" id ="hidderDelete" />
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;" id="editType">
			</div>	
			</div>	
			<div class="modal-footer">
				<button type="submit" class="btn btn-info" onclick="saveType()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
	</form>
</div>
