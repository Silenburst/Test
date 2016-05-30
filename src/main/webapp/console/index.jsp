<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="description" content="Xenon Boostrap Admin Panel" />
		<meta name="author" content="" />
		<title>楼盘字典管理系统</title>
		<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="../assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../assets/css/xenon-core.css">
		<link rel="stylesheet" href="../assets/css/xenon-forms.css">
		<link rel="stylesheet" href="../assets/css/xenon-components.css">
		<link rel="stylesheet" href="../assets/css/xenon-skins.css">
		<link rel="stylesheet" href="../assets/css/custom.css">
		<script src="../assets/js/jquery-1.11.1.min.js"></script>

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
				
					<div class="title-env">
						<h1 class="title">欢迎使用楼盘字典</h1>
					</div>
						
				</div>
				
				
				<!-- Main Footer -->
			</div>

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
<script src="../assets/js/jquery-ui/jquery-ui.js"></script>
<script src="../assets/js/tocify/jquery.tocify.min.js"></script>
<!-- JavaScripts initializations and stuff -->
<script src="../assets/js/xenon-custom.js"></script>
