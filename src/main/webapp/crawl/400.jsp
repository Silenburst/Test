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
								<a href="../index.html"><i class="fa-home"></i>首页</a>
							</li>
							<li>
								<a href="#">云采集</a>
							</li>
							<li class="active">
								<strong>房源采集</strong>
							</li>
						</ol>
					</div>
				</div>
				
				<div class="panel panel-default">

					<ul id="crawlType" class="nav nav-tabs pull-left">
						<li class="active" data-id="fangyuan_chushou">
							<a data-toggle="tab" href="#tab-01" onclick="$('#price').next().html('万')">
								<span class="visible-xs">
									<i class="fa-home"></i>
								</span>
								<span class="hidden-xs">出售</span>
							</a>
						</li>
						<li data-id="fangyuan_chuzu">
							<a data-toggle="tab" href="#tab-02" onclick="$('#price').next().html('元/月')">
								<span class="visible-xs">
									<i class="fa-user"></i>
								</span>
								<span class="hidden-xs">出租</span>
							</a>
						</li>
						<!--
						<li data-id="fangyuan_qiushou">
							<a data-toggle="tab" href="#tab-03">
								<span class="visible-xs">
									<i class="fa-user"></i>
								</span>
								<span class="hidden-xs">求购</span>
							</a>
						</li>
						<li data-id="fangyuan_qiuzu">
							<a data-toggle="tab" href="#tab-04">
								<span class="visible-xs">
									<i class="fa-user"></i>
								</span>
								<span class="hidden-xs">求租</span>
							</a>
						</li>
						-->
					</ul>
					<div class="clearfix"></div>
					

					<div class="row">
						<div class="col-md-12" style="display:none">
							<input type="hidden" id="usCountry" value="<%=SecurityUserHolder.getCurrentUserLogin().getCountryId()%>">
							<input type="hidden" id="usPro" value="<%=SecurityUserHolder.getCurrentUserLogin().getProvinceId()%>">
							<input type="hidden" id="usCity" value="<%=SecurityUserHolder.getCurrentUserLogin().getCityId()%>">
								
							<div class="Color pull-left h5" id="country">
							</div>
						</div>
						<div class="col-md-12" >							
							<div class="Color pull-left h5" id="pro" style="display: none;">
								
							</div>
						</div>
						<div class="col-md-12" >							
							<div class="Color pull-left h5" id="city" style="display: none;">
							
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
							<div class="Color pull-left h5" id="houseType">
								<span>类型：</span>
								<a data-toggle="tabHouseType" class="mr10 active" data-id="1" dataValue="0" href="javascript:doActive('houseType','1')">住宅</a>
								<a data-toggle="tabHouseType" class="mr10" data-id="2" dataValue="1" href="javascript:doActive('houseType','2')">写字楼</a>
								<a data-toggle="tabHouseType" class="mr10" data-id="3" dataValue="2" href="javascript:doActive('houseType','3')">店面</a>
								<!-- <a data-toggle="tabHouseType" class="mr10" data-id="4" dataValue="3" href="javascript:doActive('houseType','4')">厂房</a> -->
								<a data-toggle="tabHouseType" class="mr10" data-id="5" dataValue="4" href="javascript:doActive('houseType','5')">别墅</a>
							</div>
						</div>
						
					</div>
				</div>
				
				
				
				
				<div class="tab-content bgcolor">
					<div class="tab-pane active" id="tab-01">

						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">基本信息</h3>
								<div class="panel-options">
								</div>
							</div>

							<div class="panel-body">
								<table width="80%" align="center" style="margin-top:10px;">
									<tr style="height:35px;">
										<td width="10%" align="right"><span class="red">*</span>姓名：</td>
										<td width="23%"><input id="chinaName" type="text" class="form-control pull-left"></td>
										
										<td width="10%" align="right"><span class="red">*</span>电话：</td>
										<td width="24%"><input id="telephone" maxlength="15" type="text" class="form-control pull-left" ></td>
										
										<td width="10%" align="right"><span class="red">*</span>性别：</td>
										<td width="23%">
											<select id="sex" class="form-control">
												<option selected>先生</option>
												<option>女士</option>
											</select>
										</td>
									</tr>
									<tr style="height:35px;">
										<td align="right"><span class="red">*</span>面积：</td>
										<td><input id="areaSize" type="text" maxlength="5" class="form-control pull-left" style="width:120px;"><span style="line-height: 28px;float:left;padding-left:10px;">m²</span></td>
										
										<td align="right"><span class="red">*</span>心里价位：</td>
										<td><input id="price" type="text" maxlength="5" class="form-control pull-left" style="width:120px;"><span style="line-height: 28px;float:left;padding-left:10px;">万</span></td>
										
										<td></td>
										<td></td>
									</tr>
									<tr style="height:35px;">
										<td align="right"><span class="red">*</span>户型：</td>
										<td colspan="5">
											<input id="room1" type="text" maxlength="5" class="form-control pull-left" style="width:120px;"><span style="line-height: 28px;float:left;padding-left:10px;">室&nbsp;</span>
											<input id="room2" type="text" maxlength="5" class="form-control pull-left" style="width:120px;"><span style="line-height: 28px;float:left;padding-left:10px;">厅&nbsp;</span>
											<input id="room3" type="text" maxlength="5" class="form-control pull-left" style="width:120px;"><span style="line-height: 28px;float:left;padding-left:10px;">卫&nbsp;</span>
										</td>
									</tr>
									<tr style="height:35px;">
										<td align="right"><span class="red">*</span>朝向：</td>
										<td>
											<select id="forward" name="select" style="with:85px;height:32px;ertical-align: top;">
												<option value="">请选择</option>
												<option value="45">东</option>
												<option value="46">南</option>
												<option value="198">西</option>
												<option value="199">北</option>
												<option value="200">东南</option>
												<option value="201">东北</option>
												<option value="202">西南</option>
												<option value="203">西北</option>
												<option value="554">南北</option>
												<option value="556">东西</option>
												<option value="204">其它</option>
											</select>
										</td>
										
										<td align="right"><span class="red">*</span>总楼层：</td>
										<td><input id="floors" type="text" maxlength="5" class="form-control pull-left" ></td>
										
										<td align="right"><span class="red">*</span>所在楼层：</td>
										<td><input id="floor" type="text" maxlength="5" class="form-control pull-left" ></td>
									</tr>
									<tr style="height:35px;">
										<td align="right"><span class="red">*</span>标题：</td>
										<td colspan="5"><input id="title" type="text" class="form-control pull-left"></td>
									</tr>
									<tr style="height:55px;">
										<td align="right">备注：</td>
										<td colspan="5"><textarea id="remark" class="form-control" placeholder="输入文本..."></textarea></td>
									</tr>
									<tr>
										<td align="center" colspan="6">
											<a class="btn btn-success" style="width:55px;height:30px;margin-bottom:1px;" onclick="doSave();">保存</a>
											<a class="btn btn-success" style="width:55px;height:30px;margin-bottom:1px;" href="<%=basePath%>/crawl/index.jsp">返回</a>
										</td>
									</tr>
								</table>
							</div>
						</div>
				</div>
				
				<!-- Main Footer -->
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
	
	
	function doActive(src,val)
	{
		$("#"+src+" a").removeClass("active");
		$("#"+src+" a[data-id='"+val+"']").addClass("active");
	}
	
	function queryData()
	{
		
	}
	
	function doSave()
	{
		// 参数.
		// ---------------------------------------------
	    var businessType=$("#crawlType li.active").attr("data-id") == null ? '' : $("#crawlType li.active").attr("data-id");
	    
		var couValue = $("#country a.active").attr("dataValue") == null ? '' : $("#country a.active").attr("dataValue");
	    var proValue = $("#pro a.active").attr("dataValue") == null ? '' : $("#pro a.active").attr("dataValue");
	    var cityValue = $("#city a.active").attr("dataValue") == null ? '' : $("#city a.active").attr("dataValue");
	    var qyValue = $("#sQy a.active").attr("dataValue") == null ? '' : $("#sQy a.active").attr("dataValue");
	    var sqValue = $("#sSq a.active").attr("dataValue") == null ? '' : $("#sSq a.active").attr("dataValue");
	    var houseTypeValue = $("#houseType a.active").attr("dataValue") == null ? '' : $("#houseType a.active").attr("dataValue");
		
	    if(qyValue.length<1)
	    {
	    	bootbox.alert({title:"提示",message:"请选择区域信息!"});
	    	return;
	    }
	    if(sqValue.length<1)
	    {
	    	bootbox.alert({title:"提示",message:"请选择商圈信息!"});
	    	return;
	    }
	    
	    if($("#chinaName").val().length<1)
	    {
	    	bootbox.alert({title:"提示",message:"请输入联系人姓名!"});
	    	return;
	    }
	    var phone = $("#telephone").val().replace(/\s+/g, "");
	    if(checktel(phone)==false)
	    {
	    	bootbox.alert({title:"提示",message:"请输入正确的电话号码!"});
	    	return;
	    }
	    
	    var areaSize=$("#areaSize").val();
	    if (areaSize.length<1)
	    {
	    	bootbox.alert({title:"提示",message:"请输入房屋面积!"});
	    	return;
	    }
	    var areaSizeRegExp = /^([-]){0,1}([0-9]){1,}([.]){0,1}([0-9]){0,}$/;
		if (areaSizeRegExp.test(areaSize)==false)
	    {
	    	bootbox.alert({title:"提示",message:"请输入正确的房屋面积!"});
	    	return;
	    }
		
		var price=$("#price").val();
	    if (price.length<1)
	    {
	    	bootbox.alert({title:"提示",message:"请输入心里价格!"});
	    	return;
	    }
	    var priceRegExp = /^([-]){0,1}([0-9]){1,}([.]){0,1}([0-9]){0,}$/;
		if (priceRegExp.test(price)==false)
	    {
	    	bootbox.alert({title:"提示",message:"请输入正确的心里价格!"});
	    	return;
	    }
		
	    var room1 = $("#room1").val();
	    var room2 = $("#room2").val();
	    var room3 = $("#room3").val();
	    if (room1.length<1)
	    {
	    	bootbox.alert({title:"提示",message:"请输入室数量!"});
	    	return;
	    }
	    if (room2.length<1)
	    {
	    	bootbox.alert({title:"提示",message:"请输入厅数量!"});
	    	return;
	    }
	    if (room3.length<1)
	    {
	    	bootbox.alert({title:"提示",message:"请输入卫数量!"});
	    	return;
	    }
	    var roomRegExp = /^([-]){0,1}([0-9]){1,}([.]){0,1}([0-9]){0,}$/;
		if (roomRegExp.test(room1)==false)
	    {
	    	bootbox.alert({title:"提示",message:"请输入正确的室数量!"});
	    	return;
	    }
		if (roomRegExp.test(room2)==false)
	    {
	    	bootbox.alert({title:"提示",message:"请输入正确的厅数量!"});
	    	return;
	    }
		if (roomRegExp.test(room3)==false)
	    {
	    	bootbox.alert({title:"提示",message:"请输入正确的卫数量!"});
	    	return;
	    }
		
//		var direction = $("#forward").val();
		var direction = $("#forward option:selected").text();
		if(direction.length<1)
	    {
	    	bootbox.alert({title:"提示",message:"请选择朝向信息!"});
	    	return;
	    }
			
		var floors=$("#floors").val();
	    if (floors.length<1)
	    {
	    	bootbox.alert({title:"提示",message:"请输入总楼层数量!"});
	    	return;
	    }
	    var floorsRegExp = /^([-]){0,1}([0-9]){1,}([.]){0,1}([0-9]){0,}$/;
		if (floorsRegExp.test(floors)==false)
	    {
	    	bootbox.alert({title:"提示",message:"请输入正确的总楼层数量!"});
	    	return;
	    }
	    
		var floor=$("#floor").val();
	    if (floor.length<1)
	    {
	    	bootbox.alert({title:"提示",message:"请输入楼层信息!"});
	    	return;
	    }
	    var floorRegExp = /^([-]){0,1}([0-9]){1,}([.]){0,1}([0-9]){0,}$/;
		if (floorRegExp.test(floor)==false)
	    {
	    	bootbox.alert({title:"提示",message:"请输入正确的楼层信息!"});
	    	return;
	    }
		
		var title=$("#title").val();
	    if (title.length<1)
	    {
	    	bootbox.alert({title:"提示",message:"请输入标题信息!"});
	    	return;
	    }
	    
		var date=new Date();
		var fangYuanChuShou=new Object();
		fangYuanChuShou.businessType=businessType;
		fangYuanChuShou.url="400";
		fangYuanChuShou.source="400";
		
		fangYuanChuShou.provinceId=proValue;
		fangYuanChuShou.cityId=cityValue;
		fangYuanChuShou.qyId=qyValue;
		fangYuanChuShou.sqId=sqValue;
		
		fangYuanChuShou.type=houseTypeValue;
		fangYuanChuShou.rooms=room1+"室"+room2+"厅"+room3+"卫";
		
		fangYuanChuShou.lpName="";
		fangYuanChuShou.title=title;
		//fangYuanChuShou.time=date.toLocaleDateString();
		fangYuanChuShou.time=date.getFullYear()+"/"+(date.getMonth() + 1)+"/"+date.getDate();
		fangYuanChuShou.address="";
		fangYuanChuShou.price=price + $("#price").next().text();
		fangYuanChuShou.paymentMethod="";
		fangYuanChuShou.area=$("#areaSize").val() + $("#areaSize").next().text();
		fangYuanChuShou.floor=floor+"/"+floors;
		fangYuanChuShou.direction=direction;
		fangYuanChuShou.linkman=$("#chinaName").val()+" "+$("#sex").val();
		fangYuanChuShou.phone=phone;
		fangYuanChuShou.linktype="0";
		fangYuanChuShou.imgcount="0";
		fangYuanChuShou.createtime="";
		fangYuanChuShou.recordtimes="0";
		fangYuanChuShou.remark=$("#remark").val();
		
    	var jsonData=JSON.stringify(fangYuanChuShou);
   	 	
		$.ajax({
			url: cloudPlatformUrl+"/services/newenv/lpzd/crawl/saveFangYuan/", 
			dataType: "json", 
			type: "POST", 
			contentType : "application/json; charset=utf-8",
			data : jsonData,
			success : function(result)
			{
				if(result == 1)
				{
					bootbox.alert({title:"提示",message:"录入成功!"});
					doRest();
				}
				else
					bootbox.alert({title:"提示",message:"录入失败 !"});
	    	}
		});

	}
	
	function doRest()
	{
		$("#chinaName").val('');
		$("#telephone").val('');
		$("#areaSize").val('');
		$("#price").val('');
		$("#room1").val('');
		$("#room2").val('');
		$("#room3").val('');
		$("#forward").val('');
		$("#floors").val('');
		$("#floor").val('');
		$("#title").val('');
		$("#remark").val('');
	}
	
	function checktel(input)
	{
		// var re = /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/; // 判断字符串是否为数字
		var re = /^[1-9]+[0-9]*]*$/;
		if (input.match(re))
			return true;
		
		return false;
	}
	
	
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
