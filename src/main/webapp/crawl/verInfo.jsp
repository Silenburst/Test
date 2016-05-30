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
		.cbp_tmtimeline > li .cbp_tmlabel {
		    max-width: 800px;
		}		
		</style>
</head>
<body class="page-body">
		<div class="page-container">
			<div class="sidebar-menu toggle-others fixed">
				<jsp:include page="../include/left.jsp"/>
			</div>
			<div class="main-content">
				<jsp:include page="../include/top.jsp"/>

				<div class="panel panel-default" id="content">
					<ul class="cbp_tmtimeline">
						<li>
							<time class="cbp_tmtime">
								<span>2016年01月21日</span><span>17:20</span>
							</time>
							<div class="cbp_tmicon timeline-bg-success">
								<i class="fa-location-arrow"></i>
							</div>
							<div class="cbp_tmlabel">
								<h3>V1.2</h3>
								<h2>
									一、功能内容：<br>
									1.1、可将云采集资源秒发到58同城、安居客、新环境房屋网；可将内网网房源秒发到58同城、安居客、新环境房屋网（具体操作见发布步骤）。<br>
									1.2、个人设置：<br>
									A、个人设置增加站点管理功能，点击添加账号配置账户、密码、联系人、联系电话。 录入完信息，点击验证按钮。系统会校验配置账户在对应站点是否存在。验证通过之后账户状态为可用。<br>
									B、站点管理提供删除账户、修改信息功能，仅提供删除、修改配置的信息，不会更新对应站点信息。<br>
									1.3、出售管理、出租管理：<br>
									A、房源采集增加收藏功能，方便快速收藏房源。收藏过的房源在云发布出售管理、出租管理中草稿箱查看。<br>
									B、房源采集增加秒发功能，点击秒发至(出售、出租)秒发表单，录入完信息，点击保存草稿箱保存到发布列表。点击下一步更新房源状态为发布中，直接跳转到推送网站列表，<br>
									C、选择已配置并通过的网站点击上架推送房源<br>
									二、发布步骤：<br>
									第一步、在个人设置添加对应账号（58同城、安居客等），然后点击验证按钮，系统会校验配置账户在对应站点是否存在。验证通过之后账户状态 为可用。<br>
									第二步、在云采集模块列表选择一条合适房源，点击秒发按钮，按表单内容填写，按说明操作发布或保存即可；<br>
									内网发布保留原有操作流程，直接到内网房源列表选中一条房源，让后点击发布功能，按表单内容填写，按说明操作发布或保存即可；<br>
									（说明：发布直接发到58同城、安居客、新环境房屋网，保存直接保存到草稿箱以便后续补充再发布）<br>
								</h2>
							</div>
						</li>
					</ul>

					<ul class="cbp_tmtimeline">
						<li>
							<time class="cbp_tmtime">
								<span>2015年12月9日</span><span>19:00</span>
							</time>
							<div class="cbp_tmicon timeline-bg-success">
								<i class="fa-location-arrow"></i>
							</div>
							<div class="cbp_tmlabel">
								<h3>V1.1</h3>
								<h2>
									BUG修复： <br>
									一.房源采集：<br>
									&nbsp;A、(已解决)点击秒录时，传递户型、业主信息、委托来源等信息到BMS页面。 <br>
									&nbsp;B、(已解决)来源为安居客的房源信息在录入页面未显示问题。 <br>
									&nbsp;C、(已解决)秒录成功后跳转到云采集页面（原来是跳转到BMS页面）。 <br>
									<br>
									二. 客源采集：<br>
									&nbsp;A、(已解决)秒录时未能保存户型信息到CRM系统，导致CRM系统无法查询到相应用户的户型信息。 <br>
								</h2>
							</div>
						</li>
					</ul>

					<ul class="cbp_tmtimeline">
						<li>
							<time class="cbp_tmtime">
								<span>2015年12月1日</span><span>19:00</span>
							</time>
							<div class="cbp_tmicon timeline-bg-success">
								<i class="fa-location-arrow"></i>
							</div>
							<div class="cbp_tmlabel">
								<h3>V1.0</h3>
								<h2>
									一. 房源采集： <br>
									1.1 秒录规则：<br>
									&nbsp;A.每人每天可秒录（N）条房源，前期全放开无限制（通次数过决策参数控制，N默认为20）。  <br>
									&nbsp;B.每条房源可供（N）个经纪人可秒录，已秒录并标明已秒录（前提满足A条件），前期全放开无限制（次数通过决策参数控制，N默认为20）。 <br>
									&nbsp;C.秒录流程：秒录，直接跳转到内网房源模块，进行下一步内网操作。 <br>
									1.2 举报：<br>
									&nbsp;A、一条房源最多举报（20次），被视为黑中介房源，系统自动过滤（次数通过决策参数控制）。 <br>
									&nbsp;B、已被举报房源前用图标标记，没有达（20）次举报任然显示可举报按钮,如果达20次则从列表中清除。 <br>
								</h2>
								<h2>
									一. 客源采集： <br>
									2.1 秒录（也就是转客）：<br>
									&nbsp;A、每人每天可转（N）条客源，前期全放开无限制（通次数过决策参数控制，，N默认为20）。 <br>
									&nbsp;B、每条客源可供（N）个经纪人转客，已转并标明已转（前提满足A条件），前期全放开无限制（次数通过决策参数控制，，N默认为20）。 <br>
									&nbsp;C、流程：满足A、B条件后，系统在后台自动完成，并标明已转。 <br>
									&nbsp;D、新环境房屋网预约直接进入我的客源，新增一条记录。 <br>
									2.2 举报：<br>
									&nbsp;A、一条房源最多举报（20次），被视为黑中介房源，系统自动过滤（次数通过决策参数控制）。<br>
									&nbsp;B、已被举报房源前用图标标记，没有达（20）次举报任然显示可举报按钮,如果达20次则从列表中清除。 <br>
								</h2>
							</div>
						</li>
					</ul>

				</div>
			</div>
		</div>
			
	</div>
		        
</body>
</html>

<script type="text/html" id="template">
<ul class="cbp_tmtimeline">
	<li>
		<time class="cbp_tmtime">
			<span data-content="createdate" data-format="dateFormatter"></span><span data-content="createdate" data-format="timeFormatter"></span>
		</time>
		<div class="cbp_tmicon timeline-bg-success">
			<i class="fa-location-arrow"></i>
		</div>
		<div class="cbp_tmlabel">
			<h3><span>V</span><span data-content="newVersion"></span></h3>
			<div data-content="content"></div>
		</div>
	</li>
</ul>
</script>

<script type="text/javascript">

if(parent && parent.setUserId){
	parent.setUserId("<%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>");
}

Date.prototype.Format = function (fmt) { //author: meizz
	var o = {
		"M+": this.getMonth() + 1, //月份
		"d+": this.getDate(), //日
		"h+": this.getHours(), //小时
		"m+": this.getMinutes(), //分
		"s+": this.getSeconds(), //秒
		"q+": Math.floor((this.getMonth() + 3) / 3), //季度
		"S": this.getMilliseconds() //毫秒
	};
	if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for (var k in o)
		if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}

$(document).ready(function(){
/*	$.ajax({
		type:"POST",
		url:hrsUrlServices+"services/newenv/hr/version/getVersionList",
		dataType:"json",
		contentType:"application/json; charset=utf-8",
		data:JSON.stringify({versionType:"YPT",dateStr:null}),
		success:function(result){
			var arrayObj = JSON.parse(result.data);
			$.addTemplateFormatter({
				dateFormatter : function(value, template) {
					value = value.replace(/-/g,"/");
					return new Date(value).Format("yyyy年MM月dd");
				},
				timeFormatter : function(value, template) {
					value = value.replace(/-/g,"/");
					return new Date(value).Format("hh:mm");
				}
			});
//			$('#content').loadTemplate("#template", arrayObj);
		}
	});*/
});
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