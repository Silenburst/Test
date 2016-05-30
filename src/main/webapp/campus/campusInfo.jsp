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
<title>楼盘管理</title>
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
			<div class="sidebar-menu toggle-others fixed" >
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
								<strong>楼盘管理</strong>
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
							<div class="Color pull-left h4" id="country">
								
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
						<div class="row">						
							<div class="input-group" style="width: 300px;">
								<input type="text" class="form-control" id="sousuo" placeholder="请输入楼盘名称">
								<a href="javascript:queryData()" class="btn btn-success input-group-addon" >搜索</a>
							</div>
						</div>
								
					</div>
				</div>
				<div class="panel panel-default">
					<div>
						<a href="<%=basePath%>/campus/addCampus.jsp?p=xq&k=lp"><button class="btn btn-secondary"><i class="fa-plus"></i> 新增小区 </button></a>
						<button class="btn btn-danger" onclick="batchLock()"><i class="fa-trash-o"></i> 批量锁盘 </button>	
					</div>
<!-- 					 class="table-responsive" -->
					<div>
						<table class="table table-bordered table-striped table-condensed">
							<thead>
								<tr>
									<td width="50" class="text-center"><input type="checkbox" id="cbALL"/></td>
									<td width="60" class="text-center">区域</td>
									<td class="text-center">商圈</td>
									<td class="col-lg-2">楼盘名称</td>
									<td>楼盘用途</td>
									<td class="col-lg-3">地址</td>
									<td >楼盘等级</td>
									<td class="text-center">完成阶段</td>
									<td class="text-center">操作</td>
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


		</div>

		<div class="go-up" style="position: fixed;right: 15px; bottom: 10px; z-index: 9999; background: #f7aa47;padding: 10px;filter:alpha(opacity=50);moz-opacity:0.5;opacity:0.5;">
			<a href="#" rel="go-top">
				<i class="fa-arrow-up" style="font-size: 3em;"></i>
			</a>
		</div>
<div class="modal fade" id="dianping" data-backdrop="static" aria-hidden="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">小区信息完成度</h4>
			</div>
			<form role="form" class="form-horizontal" id="lpfinshform">
			<div class="modal-body">
				<div class="scrollable" data-max-height="300">
				<input type="hidden" name="lpid" id="lpfinsh_lpid">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="full_name">第一阶段完成度</label>
								<input type="hidden" name="lpfinsh[0].finshName" id="finshName0" value="1">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label">
								<input type="checkbox"  name="lpfinsh[0].finshNumber"  class="finshNumber0" value="100"/> 已完成</label>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<textarea class="form-control autogrow"  id="remark0" data-validate="minlength[10]"  name="lpfinsh[0].remark" rows="5" placeholder="备注"></textarea>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="full_name">第二阶段完成度</label>
								<input type="hidden" name="lpfinsh[1].finshName" id="finshName1" value="2">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label"><input type="checkbox"  name="lpfinsh[1].finshNumber"  class="finshNumber1" value="100"/> 已完成</label>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<textarea class="form-control autogrow"  id="remark1" data-validate="minlength[10]" rows="5" name="lpfinsh[1].remark" placeholder="备注"></textarea>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="full_name">第三阶段完成度</label>
								<input type="hidden" name="lpfinsh[2].finshName"id="finshName2"value="3"> 
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label"><input type="checkbox" name="lpfinsh[2].finshNumber" class="finshNumber2"  value="100" /> 已完成</label>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<textarea class="form-control autogrow"  id="remark2" data-validate="minlength[10]" rows="5" name="lpfinsh[2].remark" placeholder="备注"></textarea>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="full_name">第四阶段完成度</label>
								<input type="hidden" name="lpfinsh[3].finshName" id="finshName3" value="4">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label"><input type="checkbox" name="lpfinsh[3].finshNumber" class="finshNumber3"  value="100"/> 已完成</label>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<textarea class="form-control autogrow"  id="remark3" data-validate="minlength[10]" rows="5" name="lpfinsh[3].remark" placeholder="备注"></textarea>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="full_name">第五阶段完成度</label>
								<input type="hidden" name="lpfinsh[4].finshName" id="finshName4" value="5">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label"><input type="checkbox" name="lpfinsh[4].finshNumber"  class="finshNumber4"  value="100" /> 已完成</label>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<textarea class="form-control autogrow"  id="remark4" data-validate="minlength[10]" rows="5" name="lpfinsh[4].remark" placeholder="备注"></textarea>
							</div>
						</div>
					</div>

				</div>
			</div>
			
			<div class="modal-footer">
			<button type="button" class="btn btn-info" id="lpfinsh_button" onclick="savelpfinsh()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="guanbi()">关闭</button>
			</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
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
			url : "<%=basePath%>/cam/campus!batchLock.action", 
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
		var couId = $("#country a.active").attr("data-id") == null ? 0 : $("#country a.active").attr("data-id");
	    var proId = $("#pro a.active").attr("data-id") == null ? 0 : $("#pro a.active").attr("data-id");
	    var cityId = $("#city a.active").attr("data-id") == null ? 0 : $("#city a.active").attr("data-id");
	    var qyId = $("#sQy a.active").attr("data-id") == null ? 0 : $("#sQy a.active").attr("data-id");
	    var sqId = $("#sSq a.active").attr("data-id") == null ? 0 : $("#sSq a.active").attr("data-id");
	    var sousuo = $("#sousuo").val();
	    
	    var url = "<%=basePath%>/cam/campus!queryData.action";
	    $("#macPageWidget").asynPage(url, "#tbodyData", buildDataHtml, true, true, {
	        'queryLpxx.countryid': couId,
	        'queryLpxx.provinceid': proId,
	        'queryLpxx.cityId': cityId,
	        'queryLpxx.stressId': qyId,
	        'queryLpxx.lpName': sousuo,
	        'queryLpxx.sqId': sqId
	    });
	};
	
	function buildDataHtml(list) {
		$("#tbodyData").html("");
	    $.each(list, function (i, info) {
	    	var lock = info[6];
	    	if(lock == 2) {
	    		lock = "已锁盘";
	    	} else {
	    		lock = "未锁盘";
	    	}
	        var tr = [
	            '<tr>',
	            '<td class="text-center">', '<input type="checkbox" class="cbrs1" name="" value="'+info[7]+'" />', '</td>',
	            '<td class="text-center">', info[0], '</td>',
	            '<td class="text-center">', info[1], '</td>',
	            '<td>', '<a class="pr10" href="<%=basePath%>/cam/campus!updLpxx.action?lpid='+info[7]+'&p=xq&k=lp">'+info[2]+'</a>', '</td>',
	            '<td >', info[3], '</td>',
	            '<td>', info[4], '</td>',
                '<td >', info[9], '</td>',
	            //'<td class="text-center">', info[5], '</td>',
	            //'<td style="display:none" class="text-center">', lock, '</td>',
	            '<td>', info[8], '</td>',
	            '<td class="text-center">', '<a class="fa-pencil pr10" href="#" onclick="lpfinsh(this,\''+info[7]+ '\')">完成度</a><a class="fa-file-text pr10" href="<%=basePath%>/cam/campus!showDetail2.action?lpid='+info[7]+'&p=xq&k=lp">&nbsp查看</a><a class="fa-trash-o pr10" href="javascript:delLpxx(\''+info[7]+ '\')">&nbsp;删除</a>', '</td>',
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
					cHtml += '<a href="javascript:buildPro(\''+n.id+'\',true)" class="mr10" data-id="'+n.id+'">'+n.cname+'</a>';
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
					pHtml += '<a href="javascript:buildCity(\''+n.id+'\',true)" class="mr10" data-id="'+n.id+'">'+n.pname+'</a>';
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
					cHtml += '<a href="javascript:buildQy(\''+n.id+'\')" class="mr10" data-id="'+n.id+'">'+n.cityName+'</a>';
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
					cHtml += '<a href="javascript:buildSq(\''+n.id+'\')" class="mr10" data-id="'+n.id+'">'+n.qyName+'</a>';
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
					cHtml += "<br><a style='margin-left:30px'>";
					}
					if((i-9) % 10 == 0 && i > 10) {
						cHtml += "<br><a style='margin-left:30px'>";
					}
					cHtml += '<a href="javascript:void(0)" class="mr10" data-id="'+n.id+'">'+n.sqName+'</a>';
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
	
	var wcdobj;
	function  lpfinsh(obj,lpid){
	   wcdobj = $(obj).parent().parent().find("td").eq(7);
	   $("#lpfinsh_lpid").val(lpid);
	   $("#lpfinsh_button").removeAttr("disabled");
	   jQuery.ajax({
			url:"<%=basePath%>/cam/campus!querylpFinshs.action",
			dataType: "json",
			data:{"lpid": lpid}, 
			type: "POST",
			async :true,
			success: function(data){
			if(data!=null&&data!=''){
				$.each(data,function(index,info){
					if(info.finshName==1){
						$("#remark0").html(info.remark);
						 if(info.finshNumber==100){
						  	$(".finshNumber0").prop("checked", true);
						 } else
						 {
						 		$(".finshNumber0").prop("checked", false);
						 }
						 
					}else if(info.finshName==2){
						$("#remark1").html(info.remark);
						 if(info.finshNumber==100){
						    $(".finshNumber1").prop("checked", true);
						 } else 
						 {
						 	$(".finshNumber1").prop("checked", false);
						 }
						
					}else if(info.finshName==3){
						$("#remark2").html(info.remark);
						if(info.finshNumber==100){
							$(".finshNumber2").prop("checked", true);
						 }else
						 {
						 		$(".finshNumber2").prop("checked", false);
						 }
						
					}else if(info.finshName==4){
						$("#remark3").html(info.remark);
						if(info.finshNumber==100){
						   $(".finshNumber3").prop("checked", true);
						 }else
						 {
						 		$(".finshNumber3").prop("checked", false);
						 }
						
					}else if(info.finshName==5){
						$("#remark4").html(info.remark);
					
						if(info.finshNumber==100){
						   $(".finshNumber4").prop("checked", true);
						}else
						 {
						 	$(".finshNumber4").prop("checked", false);
						 }
					}
				});
			}else{
				$(".finshNumber0").prop("checked", false);
				$(".finshNumber1").prop("checked", false);
				$(".finshNumber2").prop("checked", false);
				$(".finshNumber3").prop("checked", false);
				$(".finshNumber4").prop("checked", false);
				$("#remark0").html("");
				$("#remark1").html("");
				$("#remark2").html("");
				$("#remark3").html("");
				$("#remark4").html("");
				}
			}
		});
	jQuery('#dianping').modal('show');
	}
	
	
	function guanbi(){
		$(".finshNumber0").prop("checked", false);
		$(".finshNumber1").prop("checked", false);
		$(".finshNumber2").prop("checked", false);
		$(".finshNumber3").prop("checked", false);
		$(".finshNumber4").prop("checked", false);
	}
	
	function  savelpfinsh(){
		var wcd = [];
		wcdobj.text('');
		var finshNumber0 = $(".finshNumber0").prop("checked");
		var finshNumber1 = $(".finshNumber1").prop("checked");
		var finshNumber2 = $(".finshNumber2").prop("checked");
		var finshNumber3 = $(".finshNumber3").prop("checked");
		var finshNumber4 = $(".finshNumber4").prop("checked");
		if(finshNumber0)wcd.push(1);
		if(finshNumber1)wcd.push(2);
		if(finshNumber2)wcd.push(3);
		if(finshNumber3)wcd.push(4);
		if(finshNumber4)wcd.push(5);
		wcdobj.text(wcd);
	
	 $("#lpReview_button").attr("disabled",true);
		jQuery.ajax({
			url:"<%=basePath%>/cam/campus!saveLpFinsh.action",
			dataType: "json",
			data: $('#lpfinshform').serialize(), 
			type: "POST",
			async :false,
			success: function(result){
				if(result.data == "success") {
					//在异步提交成功后要做的操作
					bootbox.alert({title:"提示",message:"保存成功!"});
					jQuery('#dianping').modal('hide');
				} else {
				 $("#lpfinsh_button").removeAttr("disabled");
					alert(result.data);
					wcdobj.text('');
					return false;
				}
			}
		});
		return false;
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
