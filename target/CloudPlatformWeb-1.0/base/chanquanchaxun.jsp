<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page isErrorPage="false" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
String cityId= SecurityUserHolder.getCurrentUserLogin().getCityId();
String countryId= SecurityUserHolder.getCurrentUserLogin().getCountryId();
String provinceId=SecurityUserHolder.getCurrentUserLogin().getProvinceId();
%>
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="description" content="Xenon Boostrap Admin Panel" />
		<meta name="author" content="" />
		<title>产权查询</title>
		<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="../assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../assets/css/xenon-core.css">
		<link rel="stylesheet" href="../assets/css/xenon-forms.css">
		<link rel="stylesheet" href="../assets/css/xenon-components.css">
		<link rel="stylesheet" href="../assets/css/xenon-skins.css">
		<link rel="stylesheet" href="../assets/css/custom.css">
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		<script src="<%=basePath%>/assets/js/page.js"></script>
		<script src="<%=basePath%>/js/services.js"></script>
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
								<a href="<%=basePath%>/console/index.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<li class="active">
								<strong><a href="<%=basePath%>/base/chanquanchaxun.jsp?k=cjzl&p=chanquanchaxun">产权查询</a></strong>
							</li>
						</ol>
					</div>
				</div>
				<div class="panel panel-default">
						<div class="row" style="margin-bottom:5px">
								<label class="control-label col-md-1" for="field-1">地区</label>
								<div class="col-md-3">
									<select class="form-control" id="quyu"  onchange="queryData()" style="height:43px">
										<option value="0">不限</option>
										<option value="开福">开福</option>
<!-- 									<option value="csx">长沙县</option> -->
<!-- 									<option value="xs">星沙</option> -->
										<option value="岳麓">岳麓</option>
										<option value="芙蓉">芙蓉</option>
										<option value="雨花">雨花</option>
										<option value="天心">天心</option>
									</select>
							</div>
									<label class="control-label col-md-1" for="field-1">地址</label>
									<div class="col-md-3">
										<input type="text" style="height:43px" class="form-control" placeholder="请输入搜索地址字段"  id="address">
									</div>
							</div>
							<div class="row" style="margin-bottom:5px">
									<label class="control-label col-md-1" for="field-1">面积</label>
									<div class="col-md-3">
									<input style="height:43px" type="text" class="col-xs-6 wenbenkuan1" placeholder="起始面积" id="mianjistarts"/>
									<input style="height:43px" type="text" class="col-xs-6 wenbenkuan1" placeholder="最大面积" id="mianjiend"/>
									</div>
								<label class="control-label col-md-1" for="field-1">用途</label>
								<div class="col-md-3">
								<select class="form-control" onchange=" queryData()" id="yongtu" style="height:43px">
			                      <option value="0">不限</option>
			                      <option value="住宅">住宅</option>
			                      <option value="写字楼">写字楼</option>
			                      <option value="商铺">商铺</option>
			                      <option value="别墅">别墅</option>
			                      <option value="公寓">公寓</option>
			                      <option value="车库">车库</option>
			                      <option value="其他">其他</option>
			                    </select>
						</div>
						<div class="col-md-3">
						<button type="button" id="bnSaveFw1" class="btn btn-info" onclick=" queryData()">搜索</button>
						</div>
				</div>
				<div class="panel panel-default">
					<div class="table-responsive">
						<table class="table table-bordered table-striped table-condensed">
							<thead>
								<tr>
									<th data-priority="3"class="text-center hidden-480" width="25%">区域</th>
									<th data-priority="3"class="text-center hidden-480" width="25%">地址</th>
									<th data-priority="3"class="text-center hidden-480" width="25%">用途</th>
									<th data-priority="3"class="text-center hidden-480" width="25%">面积</th>
								</tr>
							</thead>
							<tbody class="middle-align" id="tbodyData">
							</tbody>
						</table>
						<div id="macPageWidget"></div>
			    	</div>
				</div>
				<!-- Main Footer -->
			</div>

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
</script>

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

<script type="text/javascript">
$(document).ready(function(){
	queryData();
});

var basePath="<%=basePath%>";
function queryData(){
	
		var quyu = $("#quyu").val() == null ? 0 : $("#quyu").val();
	    var address = $("#address").val() == null ? "" : $("#address").val();
	    var yongtu = $("#yongtu").val() == null ? 0 : $("#yongtu").val();
	    var mianjistarts = $("#mianjistarts").val() == null ? "" : $("#mianjistarts").val();
	    var mianjiend = $("#mianjiend").val() == null ? "" : $("#mianjiend").val();
	    var url = basePath+"/base/actionAll!pageInFo.action";
	    $("#macPageWidget").asynPage(url, "#tbodyData", buildDataHtml, true, true, {
	        'chanquan.quyu': quyu,
	        'chanquan.address': address,
	        'chanquan.yongtu': yongtu,
	        'chanquan.mianjistarts': mianjistarts,
           'chanquan.mianjisend': mianjiend
	    });
	};
	
	function buildDataHtml(list) {
		$("#tbodyData").html("");
	    $.each(list, function (i, info) {
	        var tr = [
	            '<tr>',
	            '<td class="text-center">', info[0]=="null" ||info[0]=="" || info[0]==null?"":info[0], '</td>',
	            '<td class="text-center">', info[1]=="null" ||info[1]=="" || info[1]==null?"":info[1], '</td>',
	            '<td class="text-center">', info[2]=="null" ||info[2]=="" || info[2]==null?"":info[2], '</td>',
	            '<td class="text-center">', info[3]=="null" ||info[3]=="" || info[3]==null?"":info[3], '</td>',
	            '</tr>'].join('');
	        $("#tbodyData").append(tr);
	    });
		
	};
</script>
