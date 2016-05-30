<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
			UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>采集管理</title>
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
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		
		<script src="../assets/js/page.js"></script>
		<script src="../assets/js/bootbox/bootbox.min.js"></script>
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
								<a href="javascript:void(0)"><i class="fa-home"></i>采集资料</a>
							</li>
							<li class="active">
								<strong>采集数据处理</strong>
							</li>
						</ol>
					</div>
				</div>
				
				<div class="panel panel-default">
					<div class="row">
						<div class="col-md-12" style="display:none">
							<input type="hidden" id="usCountry" value="<%=SecurityUserHolder.getCurrentUserLogin().getCountryId()%>">
							<input type="hidden" id="usPro" value="<%=SecurityUserHolder.getCurrentUserLogin().getProvinceId()%>">
							<input type="hidden" id="usCity" value="<%=SecurityUserHolder.getCurrentUserLogin().getCityId()%>">	
							<div class="Color pull-left h5" id="country">
								
							</div>
						</div>
						<div class="col-md-12" >							
							<div class="Color pull-left h5" id="pro">
								
							</div>
						</div>
						<div class="col-md-12" >							
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
						<div class="col-md-12" style="height:35px;vertical-align: top;">
							<div style="float:left;vertical-align: top;">
								<span>采集状态：</span><select id="gathered" style="with:85px;height:32px;ertical-align: top;"><option value="0">未采集</option><option value="1">已采集</option></select>
							</div>
							<div class="input-group" style="width: 300px;padding-left:5px;">
								<input type="text" class="form-control" id="sousuo" placeholder="请输入楼盘名称">
								<a href="javascript:queryData()" class="btn btn-success input-group-addon">搜索</a>
							</div>
						</div>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="table-responsive">
						<table class="table table-bordered table-striped table-condensed">
							<thead>
								<tr>
									<td width="50" align="center"><input type="checkbox" id="cbALL"/></td>
									<!--
									<td align="center"><strong>国家</strong></td>
									-->
									<td align="center"><strong>省份</strong></td>
									<td align="center"><strong>城市</strong></td>
									<td align="center"><strong>区域</strong></td>
									<td align="center"><strong>商圈</strong></td>
									<td align="center"><strong>小区</strong></td>
									<td align="center"><strong>操作</strong></td>
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
<div class="modal fade" id="lpReview_xz" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">小区点评</h4>
			</div>
			<div class="modal-body">
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
				<form role="form" class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-2 control-label">点评部门：</label>
						<div class="col-sm-5">
								<label class="col-sm-5 control-label"><%=SecurityUserHolder.getCurrentUserLogin().getDepartment().getDepartmentName()%></label>
								<input type="hidden" name="userID" id="userID" value="<%=SecurityUserHolder.getCurrentUserLogin().getUserLogin().getId()%>">
								<input type="hidden" name="lpiId" id="lpReview_lpid">
						</div>
						<label class="col-sm-2 control-label">点评人员：</label>
						<div class="col-sm-3">
								<label class="col-sm-8 control-label"><%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getFullname()%></label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">点评内容：</label>
						<div class="col-sm-8">
								<textarea rows="5" cols="48" id="lpReview_content"></textarea>
							</div>
					</div>
				</form>

			</div>	
			</div>	
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="lpReview_button" onclick="savelpReviewxz()">提交点评</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
	</body>
</html>

<script type="text/javascript">
	$(document).ready(function(){
		buildCountry();
		buildPro($("#usCountry").val(),false);
		buildCity($("#usPro").val(),false);
		buildQy($("#usCity").val());
	});
	
	//获取所有选中
	$('#cbALL').change(function(){
		if($('#cbALL').prop("checked")){
			//选中
			$('.cbrs1').each(function(i){
				$(this).prop('checked',true);
			});
		}else{
			//未选中
			$('.cbrs1').each(function(i){
				$(this).prop('checked',false);
			});
		};
	});
	
	function batchLock(){
		var ids="";
		$('.cbrs1').each(function(i){
			if($(this).prop('checked')){
				ids += "," + $(this).val();
			}
		});
		if(ids == ""){
			bootbox.alert({title:"提示",message:"请选择要锁盘的楼盘"});
			return false;
		};
		$.ajax({
			url : "<%=basePath%>/spider/spiderAction!batchLock.action", 
			dataType : "json", 
			type : "POST",
			data : {"idsi" : ids.substring(1)},
			success : function(result){
				if(result.data == "success") {
					bootbox.alert({title:"提示",message:"锁盘成功!"});
					queryData();
				} else {
					bootbox.alert({title:"提示",message:"锁盘失败 : " + result.data});
				}
	    	}
		});
	};
	
	function queryData(){
		var couId = $("#country a.active").attr("data-id") == null ? 0 : parseInt($("#country a.active").attr("data-id"));
	    var proId = $("#pro a.active").attr("data-id") == null ? 0 : parseInt($("#pro a.active").attr("data-id"));
	    var cityId = $("#city a.active").attr("data-id") == null ? 0 : parseInt($("#city a.active").attr("data-id"));
	    var qyId = $("#sQy a.active").attr("data-id") == null ? 0 : parseInt($("#sQy a.active").attr("data-id"));
	    var sqId = $("#sSq a.active").attr("data-id") == null ? 0 : parseInt($("#sSq a.active").attr("data-id"));

		var couValue = $("#country a.active").attr("dataValue") == null ? '' : $("#country a.active").attr("dataValue");
	    var proValue = $("#pro a.active").attr("dataValue") == null ? '' : $("#pro a.active").attr("dataValue");
	    var cityValue = $("#city a.active").attr("dataValue") == null ? '' : $("#city a.active").attr("dataValue");
	    var qyValue = $("#sQy a.active").attr("dataValue") == null ? '' : $("#sQy a.active").attr("dataValue");
	    var sqValue = $("#sSq a.active").attr("dataValue") == null ? '' : $("#sSq a.active").attr("dataValue");
	    
	    var gathered = $("#gathered").val();
	    var sousuo = $("#sousuo").val();
		
	    var url = "<%=basePath%>/spider/spiderAction!queryData.action";
	    $("#macPageWidget").asynPage(url, "#tbodyData", buildDataHtml, true, true,
	    { 	
	        'spiderCoummunityEntity.countryid': couId,
	        'spiderCoummunityEntity.provinceid': proId,
	        'spiderCoummunityEntity.cityId': cityId,
	        'spiderCoummunityEntity.stressId': qyId,
	        'spiderCoummunityEntity.sqId': sqId,
	        
	        'spiderCoummunityEntity.countryValue': couValue,
	        'spiderCoummunityEntity.provinceValue': proValue,
	        'spiderCoummunityEntity.cityValue': cityValue,
	        'spiderCoummunityEntity.stressValue': qyValue,
	        'spiderCoummunityEntity.sqValue': sqValue,
	        
	        'spiderCoummunityEntity.Statuss': gathered,
	        'spiderCoummunityEntity.lpName': sousuo
	    });
	};
	
	function buildDataHtml(list)
	{
		$("#tbodyData").html("");
	    $.each(list, function (i, info)
	    {
	    	var lock = info[6];
	    	if(lock == 2)
	    	{
	    		lock = "已锁盘";
	    	} 
	    	else 
	    	{
	    		lock = "未锁盘";
	    	}
	    	
			var couId = $("#country a.active").attr("data-id") == null ? 0 : parseInt($("#country a.active").attr("data-id"));
		    var proId = $("#pro a.active").attr("data-id") == null ? 0 : parseInt($("#pro a.active").attr("data-id"));
		    var cityId = $("#city a.active").attr("data-id") == null ? 0 : parseInt($("#city a.active").attr("data-id"));
		    var qyId = $("#sQy a.active").attr("data-id") == null ? 0 : parseInt($("#sQy a.active").attr("data-id"));
		    var sqId = $("#sSq a.active").attr("data-id") == null ? 0 : parseInt($("#sSq a.active").attr("data-id"));
		    
	    	var ids='&couId='+couId+'&proId='+proId+'&cityId='+cityId+'&qyId='+qyId+'&sqId='+sqId;
	    	
	        var tr = [
	            '<tr>',
	            '<td class="text-center">', '<input type="checkbox" class="fanghaoCB" name="" value="'+info[5]+'" />', '</td>',
	            
	            //'<td class="text-center">', info[0], '</td>',
	            
	            '<td class="text-center">', info[1], '</td>',
	            '<td class="text-center">', info[2], '</td>',
	            '<td class="text-center">', info[3], '</td>',
	            '<td class="text-center">', info[4], '</td>',
	            '<td class="text-left">', info[5], '</td>',
	            '<td class="text-center">', '<a class="btn btn-success" href="<%=basePath%>/spider/spiderAction!doGather.action?countryValue='+info[0]+'&provinceValue='+info[1]+'&cityValue='+info[2]+'&qyValue='+info[3]+'&sqValue='+info[4]+'&lpname='+info[5]+ids+'">采集</a>', '</td>',
	            '</tr>'].join('');
	        $("#tbodyData").append(tr);
	    });
	};
	
	//删除楼盘
	function delLpxx(delId){
		bootbox.confirm({title:"确认",message:"您确定要删除该楼盘吗？",callback:function(result){
    		if(result){//判断是否点击了确定按钮
        		//执行删除等操作
        		$.ajax({
				url: "<%=basePath%>/cam/campus!delLpxx.action",
					dataType: "json",
					type: "POST",
					async : false,
					data : {
						"lpid" : delId
					},
					success: function(result){
						if(result.data == "success") {
							bootbox.alert({title:"提示",message:"删除成功!"});
							queryData();
						} else {
							bootbox.alert({title:"提示",message:"修改失败" +result.data});
						}
				    }
				});
    		}
		}});
	};
	
	//国家
	function buildCountry(){
		$.ajax({ 
			url: "<%=basePath%>/cam/campus!getCountryInfo.action",
			dataType: "json", 
			type: "POST",
			async : false,
			success: function(data){
				var cHtml = '<span>国家：</span><a href="javascript:buildPro(0,true)" class="mr10 active" data-id="0">不限</a>';
				$.each(data, function(i,n){
					if(i % 8 == 0 && i > 0) {
						cHtml += "<br>";
					}
					cHtml += '<a href="javascript:buildPro(\''+n.id+'\',true)" class="mr10" data-id="'+n.id+'" dataValue="'+n.cname+'">'+n.cname+'</a>';
				});
				$("#country").html(cHtml);
		    }
		});
	};
	
	function buildPro(val,ch){
		$("#country a").removeClass("active");
		$("#country a[data-id='"+val+"']").addClass("active");
		$("#city").html("");
		$("#sQy").html("");
		$("#sSq").html("");
		$.ajax({ 
			url: "<%=basePath%>/cam/campus!getPro.action",
			dataType: "json",
			type: "POST",
			async : false,
			data : {"cid" : val},
			success: function(data){
				var pHtml = '<span>省份/州：</span><a href="javascript:buildCity(0,true)" class="mr10 active" data-id="0">不限</a>';
				$.each(data, function(i,n){
					if(i % 8 == 0 && i > 0) {
						pHtml += "<br>";
					}
					pHtml += '<a href="javascript:buildCity(\''+n.id+'\',true)" class="mr10" data-id="'+n.id+'" dataValue="'+n.pname+'">'+n.pname+'</a>';
				});
				$("#pro").html(pHtml);
		    }
		});
		if(ch) {
			queryData();
		}
	};
	
	function buildCity(val,ch){
		$("#pro a").removeClass("active");
		$("#pro a[data-id='"+val+"']").addClass("active");
		$("#sQy").html("");
		$("#sSq").html("");
		$.ajax({ 
			url: "<%=basePath%>/cam/campus!getCity.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"pid" : val},
			success: function(data){
				var cHtml = '<span>城市：</span><a href="javascript:buildQy(0)" class="mr10 active" data-id="0">不限</a>';
				$.each(data, function(i,n){
					if(i % 8 == 0 && i > 0) {
						cHtml += "<br>";
					}
					cHtml += '<a href="javascript:buildQy(\''+n.id+'\')" class="mr10" data-id="'+n.id+'" dataValue="'+n.cityName+'">'+n.cityName+'</a>';
				});
				$("#city").html(cHtml);
		    }
		});
		if(ch) {
			queryData();
		}
	};
	
	function buildQy(val){
		$("#city a").removeClass("active");
		$("#city a[data-id='"+val+"']").addClass("active");
		$("#sSq").html("");
		$.ajax({ 
			url: "<%=basePath%>/cam/campus!getQy.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"cid" : val},
			success: function(data){
				var cHtml = '<span>区域：</span><a href="javascript:buildSq(0)" class="mr10 active" data-id="0">不限</a>';
				$.each(data, function(i,n){
					cHtml += '<a href="javascript:buildSq(\''+n.id+'\')" class="mr10" data-id="'+n.id+'" dataValue="'+n.qyName+'">'+n.qyName+'</a>';
				});
				$("#sQy").html(cHtml);
		    }
		});
		queryData();
	};
	
	function buildSq(val){
		$("#sQy a").removeClass("active");
		$("#sQy a[data-id='"+val+"']").addClass("active");
		$.ajax({ 
			url: "<%=basePath%>/cam/campus!getSq.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"stressId" : val},
			success: function(data){
				var cHtml = '<span>商圈：</span><a href="javascript:void(0)" class="mr10 active" data-id="0">不限</a>';
				$.each(data, function(i,n){
					if(i ==9) {
					cHtml += "<br><a style='margin-left:50px'>";
					}
					if((i-9) % 10 == 0 && i > 10) {
						cHtml += "<br><a style='margin-left:50px'>";
					}
					cHtml += '<a href="javascript:void(0)" class="mr10" data-id="'+n.id+'" dataValue="'+n.sqName+'">'+n.sqName+'</a>';
				});
				$("#sSq").html(cHtml);
				$("#sSq a").click(function(){
					$("#sSq a").removeClass("active");
					$(this).addClass("active");
					queryData();
				});
		    }
		});
		queryData();
	};
	
	function  lpReviewxz(lpid){
	$("#lpReview_lpid").val(lpid);
	$("#lpReview_content").val("");
	$("#lpReview_button").removeAttr("disabled");
	jQuery('#lpReview_xz').modal('show');
	}
	
	function savelpReviewxz(){
	if($("#lpReview_content").val()!=null&&$("#lpReview_content").val()!=''){
		$("#lpReview_button").attr("disabled",true);
	$.ajax({ 
			url: "<%=basePath%>/cam/campus!savelpReview.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"userID" : $("#userID").val(),"lpId":$("#lpReview_lpid").val(),"content":$("#lpReview_content").val()},
			success: function(result){
					if(result.data == "success") {
							jQuery('#lpReview_xz').modal('hide');
							bootbox.alert({title:"提示",message:"点评成功!"});
						} else {
						$("#lpReview_button").removeAttr("disabled");
							bootbox.alert({title:"提示",message:"点评失败" +result.data});
						}
				
		    }
		});
	}else{
		bootbox.alert({title:"提示",message:"请输入点评内容!"});
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
