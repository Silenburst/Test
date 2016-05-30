<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
			UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
			
	String BMSPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/BMS";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>房源采集管理</title>
<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="../assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../assets/css/xenon-core.css">
		<link rel="stylesheet" href="../assets/css/xenon-forms.css">
		<link rel="stylesheet" href="../assets/css/xenon-components.css">
		<link rel="stylesheet" href="../assets/css/xenon-skins.css">
		<link rel="stylesheet" href="../assets/css/custom.css">
		<link rel="stylesheet" href="../assets/css/xiaoqu.css">
		<link rel="stylesheet" href="../assets/js/bootbox/bootbox.css">
		
		<script src="./common.js"></script>
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		<script src="./jquery.timers-1.2.js"></script>
		
		<script src="../assets/js/page.js"></script>
		<script src="../assets/js/bootbox/bootbox.min.js"></script>
		<script src="../js/ajaxpage/pagination.js"></script>
		
		<script src="../js/jquery.loadTemplate-1.4.4.min.js"></script>
		
		<style type="text/css">
		#table button {
			padding:0 0 0 0;
		}
		#table button a {
			text-decoration:none;
		}
		.modal-dialog {
		    width: 400px;
		}
		.modal .modal-dialog .modal-content {
		    padding: 20px;
		}
		
		</style>
</head>
<body class="page-body">

		<div class='onsubing' style="display:none; width:100%; height:100%; background:#fff; position:fixed; z-index:99999; opacity:0.8;-moz-opacity:0.8; filter:alpha(opacity=80); ">
			<div class="text-center" style="position:absolute; top:20%; left:50%;">
				<img src="../assets/images/loading.gif" width="176" height="220"/>
				<span> 数据正在加载中....</span>
			</div>
		</div>
		
		<div class="page-container">
			<div class="sidebar-menu toggle-others fixed">
				<jsp:include page="../include/left.jsp"/>
			</div>
			<div class="main-content">
				<jsp:include page="../include/top.jsp"/>
				
				<div class="page-title">
					<div class="breadcrumb-env pull-left">
						<ol class="breadcrumb bc-1">
							<li>
								<a href="verInfo.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<li>
								<span>个人设置</span>
							</li>
							<li class="active">
								<strong>站点管理</strong>
							</li>
						</ol>
					</div>
				</div>
				
				<div class="panel">
					<div class="panel-body">
					<div>
						<ul class="nav nav-tabs pull-left" style="margin-bottom: 10px;" id="toolbar">
							<li onclick="loadPage();" class="active"><a href="#tab-01" data-toggle="tab">
									<span class="visible-xs"><i class="fa-home"></i></span> <span
									class="hidden-xs">全部网站</span>
							</a></li>
							<li onclick="loadPage(1);"><a href="#tab-02" data-toggle="tab"> <span
									class="visible-xs"><i class="fa-user"></i></span> <span
									class="hidden-xs">已开通网站</span>
							</a></li>
							<li onclick="loadPage(0);"><a href="#tab-03" data-toggle="tab"> <span
									class="visible-xs"><i class="fa-user"></i></span> <span
									class="hidden-xs">未开通网站</span>
							</a></li>
						</ul>
					</div>
					<div class="table-responsive pull-right"
						data-pattern="priority-columns"
						data-focus-btn-icon="fa-file-text-o"
						data-sticky-table-header="true" data-add-display-all-btn="true"
						data-add-focus-btn="false">

						<table class="table table-bordered table-hover table-model-2"
							id="table">
							<tbody></tbody>
						</table>

					</div>
					
				</div>
			</div>
		</div>
			
	</div>
		        
<div class="modal fade custom-width" id="userModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<form action="" method="post" id="userForm">
			<input type="hidden" name="id" value="0"/>
			<input type="hidden" name="uid" value="<%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>"/>
			<input type="hidden" name="sid" value=""/>
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h5 class="modal-title">添加信息</h5>
			</div>
			<div class="modal-body">
					<table class="table">
						<tbody>
							<tr>
								<td><label class="control-label"><span class="red">*</span> 账号</label></td>
								<td>
									<input type="text" name="username" class="form-control" placeholder="请输入账号"/>
								</td>
							</tr>
							<tr>
								<td><label class="control-label"><span class="red">*</span> 密码</label></td>
								<td><input type="password" name="password" class="form-control" placeholder="请输入密码"/></td>
							</tr>
							<tr style="display: none;">
								<td><label class="control-label"><span class="red">*</span> 联系人</label></td>
								<td><input type="text" name="linkman" class="form-control" placeholder="请输入联系人"/></td>
							</tr>
							<tr style="display: none;">
								<td><label class="control-label"><span class="red">*</span> 联系电话</label></td>
								<td><input type="text" name="phone" class="form-control" placeholder="请输入联系电话"/></td>
							</tr>
						</tbody>
					</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="saveUserModal();">保存</button>
				<button type="button" class="btn btn-info" id="addLpSchoolClose" data-dismiss="modal">关闭</button>
			</div>
			</form>
		</div>
	</div>
</div>

</body>
</html>

<script type="text/html" id="template">
<tr>
	<input type="hidden" name="id" data-value="id"/>
	<input type="hidden" name="pid" data-value="pid"/>
	<input type="hidden" name="state" data-value="state"/>
	<input type="hidden" name="username" data-value="username"/>
	<td class="middle-align text-center values" data-content="state" data-format="stateFormatter"></td>
	<td class="middle-align" style="width: 250px;">
		<img data-src="logo" style="width: 120px;height: 50px;"/>
	</td>
	<td class="middle-align text-center" style="width:200px;">
		<button type="button" class="btn"><a href="javascript:void(0);" onclick="openUserModal(this,0);">添加账号</a></button>
		<button type="button" class="btn"><a target="_blank" data-href="login">去注册</a></button>
	</td>
	<td class="middle-align text-center" style="width:300px;">
		<span data-content="username" data-format="infoFormatter"></span>
		<code data-content="status" data-format="statusFormatter"></code>
	</td>
	<td class="middle-align text-center">
		<button type="button" class="btn"><a href="javascript:void(0);" onclick="getValication(this);">验证</a></button>
		<button type="button" class="btn"><a href="javascript:void(0);" onclick="deleteUser(this);">删除账号</a></button>
		<button type="button" class="btn"><a onclick="openUserModal(this,1);">修改信息</a></button>
	</td>
</tr>
</script>

<script type="text/javascript">
$("#menu0401").addClass("active expanded");
$("#menu0401").parent().show();

var uid = "<%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>";
loadPage();

function loadPage(state){
	if (typeof(state) == "undefined")
		state = "";
	else
		state = "&state="+state;
	$.ajax({
		url : cloudPlatformUrl+"/services/newenv/cloub/source_site/list?uid="+uid+state,
		dataType : "json",
		type : "GET",
		contentType : "application/json; charset=utf-8",
		success : function(obj){
			$.addTemplateFormatter({
				stateFormatter : function(value, template) {
					if(value == 0){
						return "未支持";
					}else{
						return "已支持";
					}
		        },
		        infoFormatter : function(value, template) {
		        	if(value != ''){
		        		return '<input type="radio" checked="true"/><span>'+value+'</span><span></span>';
		        	}
					console.log(value);
		        },
		        loginFormatter : function(value, template) {
		        	var href = "autologin.jsp?id="+value;
		        	return '<a target="_blank" href="<%=basePath%>/crawl/'+href+'">登录后台</a>';
		        },
		        statusFormatter : function(value, template) {
		        	var content = "";
		        	if(value > 0){
		        		content = "可用";
		        	}
		        	return content;
		        }
			});
			$('#table tbody').loadTemplate("#template", obj.result);
		}
	});
}

function openUserModal(thiz,type){
	var id = $(thiz).parents("tr").find("input[name='id']").val();
	var pid = $(thiz).parents("tr").find("input[name='pid']").val();
	var state = $(thiz).parents("tr").find("input[name='state']").val();
	if(state != 1){
		bootbox.alert({title:"提示",message:"系统暂未开通支持，敬请期待!"});
	}else{
		if(type == 1){
			if(pid == 0){
				bootbox.alert({title:"提示",message:"没有添加账号!"});
				return;
			}
			if(id == 1){
				$("#userForm input[name='phone']").parents("tr").show();
				$("#userForm input[name='linkman']").parents("tr").show();
			}else{
				$("#userForm input[name='phone']").parents("tr").hide();
				$("#userForm input[name='linkman']").parents("tr").hide();
			}
			$("#userModal .modal-title").html("修改密码");
			$("#userModal .table tr:eq(0)").hide();
			var pid = $(thiz).parents("tr").find("input[name='pid']").val();
			var username = $(thiz).parents("tr").find("input[name='username']").val();
			$("#userForm input[name='id']").val(pid);
			$("#userForm input[name='username']").val(username);
			$("#userForm input[name='password']").val("");
			$("#userForm input[name='phone']").val("");
			$("#userForm input[name='linkman']").val("");
		}else{
			if(pid > 0){
				bootbox.alert({title:"提示",message:"系统暂未开通支持同一站点配置多个账号!"});
				return;
			}
			if(id == 1){
				$("#userForm input[name='phone']").parents("tr").show();
				$("#userForm input[name='linkman']").parents("tr").show();
			}else{
				$("#userForm input[name='phone']").parents("tr").hide();
				$("#userForm input[name='linkman']").parents("tr").hide();
			}
			$("#userModal .modal-title").html("添加账号");
			$("#userModal .table tr:eq(0)").show();
			$("#userForm input[name='username']").val("");
			$("#userForm input[name='password']").val("");
			$("#userForm input[name='phone']").val("");
			$("#userForm input[name='linkman']").val("");
		}
		var sid = $(thiz).parents("tr").find("input[name='id']").val();
		$("#userModal input[name='sid']").val(sid);
		$('#userModal').modal();
	}
}

function saveUserModal(){
	var username = $("#userForm input[name='username']").val();
	var password = $("#userForm input[name='password']").val();
	var phone = $("#userForm input[name='phone']").val();
	var linkman = $("#userForm input[name='linkman']").val();
	if($.trim(username) == '' || $.trim(password) == ''){
		alert("信息不完整!");
		return;
	}
	var isPhone = $("#userForm input[name='phone']").parents("tr");
	if(!isPhone.is(":hidden")){
		if($.trim(phone) == ''){
			alert("信息不完整!");
			return;
		}
	}
	var isLinkman = $("#userForm input[name='linkman']").parents("tr");
	if(!isLinkman.is(":hidden")){
		if($.trim(linkman) == ''){
			alert("信息不完整!");
			return;
		}
	}

	var url = cloudPlatformUrl+"/services/newenv/cloub/personal_site/save";
	$("#userForm").attr("action",url);
	$("#userForm").ajaxSubmit(function(result){
		if(result.status){
			refresh();
			$('#userModal').modal("hide");
			alert("保存成功!");
		}else{
			alert("保存失败!");
		}
	});
}

function deleteUser(thiz){
	var pid = $(thiz).parents("tr").find("input[name='pid']").val();
	var state = $(thiz).parents("tr").find("input[name='state']").val();
	var uId = <%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>;
	if(state != 1){
		bootbox.alert({title:"提示",message:"系统暂未开通支持，敬请期待!"});
	}else if(pid == 0){
		bootbox.alert({title:"提示",message:"没有添加账号!"});
	}else{
		var msg = "您确定要删除吗？";
		if (confirm(msg) == true) {
			var pid = $(thiz).parents("tr").find("input[name='pid']").val();
			var url = cloudPlatformUrl+"/services/newenv/cloub/personal_site/delete?id="+pid+"&uId="+uId;
			var result = $.ajax({url:url,async:false});
			if(result.status){
				refresh();
				alert("删除成功!");
			}else{
				alert("删除失败!");
			}
		}
	}
}

function refresh(){
	$("#toolbar li").each(function(){
		if($(this).hasClass("active")){
			$(this).click();
		}
  	});
}

function getValication(thiz){
	var pid = $(thiz).parents("tr").find("input[name='pid']").val();
	if(pid > 0){
		$('.onsubing').show();
		var url = cloudPlatformUrl+"/services/newenv/cloub/personal_site/getValidate?id="+pid;
		var result = $.ajax({
			url : url,
			async : true,
			dataType : "json",
			type : "GET",
			contentType : "application/json; charset=utf-8",
			success : function(resultObj){
				if(resultObj.status){
					bootbox.alert({title:"提示",message:"验证成功!"});
					refresh();
				}else{
					bootbox.alert({title:"提示",message:"验证失败!"});
					refresh();
				}
				setTimeout("$('.onsubing').hide();",200);
			},
			error: function(e) {
				setTimeout("$('.onsubing').hide();",200);
			}
		});
	}else{
		bootbox.alert({title:"提示",message:"请先添加账号再验证!"});
	}
}

</script>
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
<script src="../js/jquery.form.js"></script>