<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
			UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
	long timeMillis = System.currentTimeMillis();
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
		
		<style>
			.pageOpen
			{
				color: #ffffff;
    			background-color: #8dc63f !important;
    			border-color: #80b636;    			
			}
			.text-center .btn{
				padding: 2px 0px 0px 0px;
			}
			
			.text-center .btn.btn-style{ background-color: #AAAAAA; }
			.text-center .btn.btn-size{ width:50px;height:25px;margin-bottom:1px; }

			.modal-dialog{ width:400px;  }
			.modal-dialog .modal-content { padding: 20px; }


		</style>

		<script src="./common.js?_t=<%=timeMillis%>"></script>
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		<script src="./jquery.timers-1.2.js"></script>
		
		<script src="../assets/js/page.js"></script>
		<script src="../assets/js/bootbox/bootbox.min.js"></script>
		<script src="../js/ajaxpage/pagination.js"></script>
		<script src="../js/tools.js"></script>
</head>

		<div class='onsubing' style="display:none; width:100%; height:100%; background:#fff; position:fixed; z-index:99999; opacity:0.8;-moz-opacity:0.8; filter:alpha(opacity=80); ">
			<div class="text-center" style="position:absolute; top:20%; left:50%;">
				<img src="../assets/images/loading.gif" width="176" height="220"/>
				<span> 数据正在加载中....</span>
			</div>
		</div>

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
								<a href="<%=basePath%>/crawl/index.jsp"><i class="fa-home"></i>首页</a>
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
					<div class="pull-right">
						<div class="pull-left mr10 line32">自动刷新间隔时间为：</div>
						<div class="pull-left">
							<select id="rTimer" class="form-control pull-left">
								<option value="">无刷新</option>
								<option value="30" selected>30秒</option>
								<option value="60">1分钟</option>
								<option value="600">10分秒</option>
							</select>
						</div>
					</div>

					<ul id="crawlType" class="nav nav-tabs pull-left">
						<li class="active" data-id="fangyuan_chushou">
							<a data-toggle="tab" href="#tab-01">
								<span class="visible-xs">
									<i class="fa-home"></i>
								</span>
								<span class="hidden-xs">出售</span>
							</a>
						</li>
						<li data-id="fangyuan_chuzu">
							<a data-toggle="tab" href="#tab-02">
								<span class="visible-xs">
									<i class="fa-user"></i>
								</span>
								<span class="hidden-xs">出租</span>
							</a>
						</li>
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
								<a data-toggle="tabHouseType" class="mr10 active" data-id="0" dataValue="" href="javascript:doActive('houseType','0')">全部</a>
								<a data-toggle="tabHouseType" class="mr10" data-id="1" dataValue="0" href="javascript:doActive('houseType','1')">住宅</a>
								<a data-toggle="tabHouseType" class="mr10" data-id="2" dataValue="1" href="javascript:doActive('houseType','2')">写字楼</a>
								<a data-toggle="tabHouseType" class="mr10" data-id="3" dataValue="2" href="javascript:doActive('houseType','3')">店面</a>
								<!-- <a data-toggle="tabHouseType" class="mr10" data-id="4" dataValue="3" href="javascript:doActive('houseType','4')">厂房</a> -->
								<a data-toggle="tabHouseType" class="mr10" data-id="5" dataValue="4" href="javascript:doActive('houseType','5')">别墅</a>
							</div>
						</div>
						
						<div class="col-md-12">						
							<div class="Color pull-left h5" id="roomType">
								<span>户型：</span>
								<a data-toggle="tabRoomType" class="mr10 active" data-id="0" dataValue="" href="javascript:doActive('roomType','0')">全部</a>
								<a data-toggle="tabRoomType" class="mr10" data-id="1" dataValue="1室" href="javascript:doActive('roomType','1')">一室</a>
								<a data-toggle="tabRoomType" class="mr10" data-id="2" dataValue="2室" href="javascript:doActive('roomType','2')">二室</a>
								<a data-toggle="tabRoomType" class="mr10" data-id="3" dataValue="3室" href="javascript:doActive('roomType','3')">三室</a>
								<a data-toggle="tabRoomType" class="mr10" data-id="4" dataValue="4室" href="javascript:doActive('roomType','4')">四室</a>
								<a data-toggle="tabRoomType" class="mr10" data-id="5" dataValue="5室" href="javascript:doActive('roomType','5')">五室</a>
							</div>
						</div>
						
						<div class="col-md-12" style="height:35px;vertical-align: top;">
							<div style="float:left;vertical-align: top;">
								<div class="pull-left mr10 line32">价格：</div>
								<select id="price" class="pull-left" style="with:85px;height:32px;ertical-align: top;">
									<option value="" selected>全部</option>
									<option value="0-49">50万以下</option>
									<option value="50-79">50-79万</option>
									<option value="80-99">80-99万</option>
									<option value="100-119">100-119万</option>
									<option value="120-149">120-149万</option>
									<option value="150-199">150-199万</option>
									<option value="200-299">200-299万</option>
									<option value="300-9999999">300万以上</option>
								</select>
							</div>
							<div style="float:left;vertical-align: top;">
								<div class="pull-left mr10 line32">来源：</div>
								<select id="source" style="with:85px;height:32px;ertical-align: top;">
									<option value="" selected>全部</option>
									<option value="58同城">58同城</option>
									<option value="安居客">安居客</option>
									<option value="赶集">赶集</option>
									<option value="搜房">搜房</option>
									<option value="百姓">百姓</option>
									<option value="一键委托">一键委托</option>
									<option value="400">400</option>
								</select>
							</div>
							<div class="input-group" style="width: 300px;padding-left:5px;">
								
								<input type="text" class="form-control" style="width:450px;" id="sousuo" placeholder="请输入标题名称或地址或业主信息">
								<a href="javascript:queryData(1)" class="btn btn-success input-group-addon">搜索</a>
							</div>
						</div>
					</div>
				</div>
				
				<div class="panel panel-default">
						<div>
							<span class="input-group-btn pull-left">
								<a id="xinzengfangyuan" href="400.jsp"></a>
								<button class="btn btn-secondary" data-toggle="dropdown" type="button" onclick="$(this).prev()[0].click();">新建400</button>
							</span>
						</div>
						<div class="table-wrapper">
							<div class="btn-toolbar">
								<div class="btn-group dropdown-btn-group pull-right">
									<button class="btn btn-default" onclick="showAll();">全部展示</button>
									<button class="btn btn-default dropdown-toggle" data-toggle="dropdown">筛选展示<span class="caret"></span></button>
									<ul class="dropdown-menu">
										<li class="checkbox-row">来源</li>
										<li class="checkbox-row">举报次数</li>
										<li class="checkbox-row">秒录次数</li>
									</ul>
									<ul class="dropdown-menu">
										<li class="checkbox-row">
											<input type="checkbox" id="switch2" name="switch2" value="switch2" checked><label for="switch2">房源基本信息</label>
										</li>
										<li class="checkbox-row">
											<input type="checkbox" id="switch3" name="switch3" value="switch3" checked><label for="switch3">业主信息</label>
										</li>
										<li class="checkbox-row">
											<input type="checkbox" id="switch4" name="switch4" value="switch4" checked> <label for="switch4">来源</label>
										</li>
									</ul>
								</div>
							</div>
						</div>
						
						
						<div class="table-responsive">
							<table id="tab1" class="table table-bordered table-striped table-condensed">
								
								<tbody class="middle-align" id="tbodyData">
									<tr>
										<td></td>
										<td>类型</td>
										<td>房源基本信息</td>
										<td>业主信息</td>
										<td>来源</td>
										<td>操作</td>
									</tr>
								</tbody>
							</table>
				    	</div>
				    	
				    	<div style="float:right;">
							<input id="pageNum" name="pageNum" type="hidden" value="10">
							<div id="macPageWidget"></div>
							
			      			<div class="clearfix"></div>
			      			<div class="clear"></div>
			      		</div>
				</div>
				
				<!-- Main Footer -->
			</div>
			
		</div>
	</body>


<!-- 收藏  -->
<div class="modal fade" id="Shoucang">
	<input type="hidden" id="id" value="" />
	<input type="hidden" id="type" value="" />
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">收藏</h4>
			</div>
			<div class="modal-body">
				选中1条房源，确认收藏？
				<br/><span>请在云发布出售、出租管理草稿箱中查找收藏房源！</span>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="saveShouCang();">确认</button>
				<button type="button" class="btn btn-red" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>


</html>





<script type="text/javascript">

	var uid = "<%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>";
<%-- 	var username = "<%=SecurityUserHolder.getCurrentUserLogin().getUserLogin().getUsername()%>";
	var userProfileURL = hrsUrlServices+"/services/newenv/hr/userProfile/"+username;
	var resultUserFile = $.ajax({url:userProfileURL,async:false});
	var resObj = $.parseJSON(resultUserFile.responseText);
    var couValue = "中国";
    var proValue = resObj.provinceName;
    var cityValue = resObj.cityName; --%>
	
    var couValue = "中国";
    var proValue = "";
    var cityValue = "";

	$(document).ready(function(){
		buildCountry();
		buildPro($("#usCountry").val(),false);
		buildCity($("#usPro").val(),false);
		buildQy($("#usCity").val());
		
		// 设置菜单.
		$("#menu0101").addClass("active opened");
		$("#menu0101").parent().show();
		
		doChange();
	});
	
	
	function doActive(src,val)
	{
		$("#"+src+" a").removeClass("active");
		$("#"+src+" a[data-id='"+val+"']").addClass("active");
		
		queryData();
	}
	
	
	//获取所有选中
	$('#rTimer').change(function(){
		doChange();
	});
	function doChange()
	{
		// 停止定时器
		$('body').stopTime();
		
		var time = $("#rTimer").val();
		
		if (time != '') {
			$('body').everyTime(time + 's', refresh);//启动定时器
		}
	}
	
	function showAll()
	{
		document.getElementById("switch2").checked=true;
		document.getElementById("switch3").checked=true;
		document.getElementById("switch4").checked=true;
		
		doShow();
	}
	$('#switch2').change(function()
	{
		doShow();
	});
	$('#switch3').change(function()
	{
		doShow();
	});
	$('#switch4').change(function()
	{
		doShow();
	});
	function doShow()
	{
		if($('#switch2').is(':checked'))
			$("#tab1 tr").each(function(){$("td:eq(2)",this).show()});
		else
			$("#tab1 tr").each(function(){$("td:eq(2)",this).hide()});
		
		if($('#switch3').is(':checked'))
			$("#tab1 tr").each(function(){$("td:eq(3)",this).show()});
		else
			$("#tab1 tr").each(function(){$("td:eq(3)",this).hide()});
		
		if($('#switch4').is(':checked'))
			$("#tab1 tr").each(function(){$("td:eq(4)",this).show()});
		else
			$("#tab1 tr").each(function(){$("td:eq(4)",this).hide()});
	}
	
	
	function refresh() 
	{
		// 定时器查询时置首页.
		historyPageIndex=1;
		
		queryData(1);
	} 
	
	$("#crawlType li").click(function()
	{
		$("#crawlType li").removeClass("active");
		
		$(this).addClass("active");
		
		// 修改价格值.
		var t1='<option value="" selected>全部</option><option value="0-49">50万以下</option><option value="50-79">50-79万</option><option value="80-99">80-99万</option><option value="100-119">100-119万</option><option value="120-149">120-149万</option><option value="150-199">150-199万</option><option value="200-299">200-299万</option><option value="300-9999999">300万以上</option>';
		var t2='<option value="" selected>全部</option><option value="0-499">500元以下</option><option value="500-999">500-999元</option><option value="1000-1999">1000-1999元</option><option value="2000-2999">2000-2999元</option><option value="3000-4999">3000-4999元</option><option value="5000-7999">5000-7999元</option><option value="8000-99999999">8000元以上</option>';
		
		$("#price").html("");
		var businessType=$("#crawlType li.active").attr("data-id") == null ? '' : $("#crawlType li.active").attr("data-id");
		if(businessType=="fangyuan_chushou")
			$("#price").html(t1);
		if(businessType=="fangyuan_chuzu")
			$("#price").html(t2);
		
		queryData(1);
	});
	
	var customList;
	function queryData(pageIndex)
	{
		var obj=new Object();
		
		// 分页.
		// ---------------------------------------------
		if(pageIndex==undefined || pageIndex==null)
			pageIndex=1;
	    var pageInfo=new Object();
	    pageInfo.page=pageIndex;
	    obj.pageInfo=pageInfo;
		
	    
		// 参数.
		// ---------------------------------------------
	    var businessType=$("#crawlType li.active").attr("data-id") == null ? '' : $("#crawlType li.active").attr("data-id");
	    
		var couId = $("#country a.active").attr("data-id") == null ? 0 : parseInt($("#country a.active").attr("data-id"));
	    var proId = $("#pro a.active").attr("data-id") == null ? 0 : parseInt($("#pro a.active").attr("data-id"));
	    var cityId = $("#city a.active").attr("data-id") == null ? 0 : parseInt($("#city a.active").attr("data-id"));
	    var qyId = $("#sQy a.active").attr("data-id") == null ? 0 : parseInt($("#sQy a.active").attr("data-id"));
	    var sqId = $("#sSq a.active").attr("data-id") == null ? 0 : parseInt($("#sSq a.active").attr("data-id"));

/* 		var couValue = $("#country a.active").attr("dataValue") == null ? '' : $("#country a.active").attr("dataValue");
	    var proValue = $("#pro a.active").attr("dataValue") == null ? '' : $("#pro a.active").attr("dataValue");
	    var cityValue = $("#city a.active").attr("dataValue") == null ? '' : $("#city a.active").attr("dataValue"); */
	    
	    var qyValue = $("#sQy a.active").attr("dataValue") == null ? '' : $("#sQy a.active").attr("dataValue");
	    var sqValue = $("#sSq a.active").attr("dataValue") == null ? '' : $("#sSq a.active").attr("dataValue");
	    
	    var houseTypeValue = $("#houseType a.active").attr("dataValue") == null ? '' : $("#houseType a.active").attr("dataValue");
	    var roomTypeValue = $("#roomType a.active").attr("dataValue") == null ? '' : $("#roomType a.active").attr("dataValue");
	    
	    var source = $("#source").val();
	    var gathered = $("#gathered").val();
	    var sousuo = $("#sousuo").val();
		
	    var requestParameter=new Object();
	    requestParameter.source=source;
    	requestParameter.businessType=businessType;
        requestParameter.couId=couId;
        requestParameter.proId=proId;
        requestParameter.cityId=cityId;
        requestParameter.qyId=qyId;
        requestParameter.sqId=sqId;
        requestParameter.countryValue=couValue;
        requestParameter.provinceValue=proValue;
        requestParameter.cityValue=cityValue;
        requestParameter.stressValue=qyValue;
        requestParameter.sqValue=sqValue;
        requestParameter.houseType=houseTypeValue;
        requestParameter.roomType=roomTypeValue;
        requestParameter.lpName=sousuo;
        requestParameter.reportTimes=reportTimes;
        requestParameter.price=$("#price").val();
        requestParameter.userId=uid;
	    obj.requestParameter=requestParameter;
	    
	    $('.onsubing').css("display","block");//弹出提示框
	    
	    var jsonData=JSON.stringify(obj);
	    
		$.ajax({
			url : cloudPlatformUrl+"/services/newenv/lpzd/crawl/queryCrawlGroupData/",
			dataType : "json",
			type : "POST",
			contentType : "application/json; charset=utf-8",
			data : jsonData,
			success : function(result)
			{
				customList=result.listJson.gridModel;
				
				$('.onsubing').css("display","none");//弹出提示框
				
				//$("#tbodyData").html("");
				$("#tab1 tr").eq(0).nextAll().remove();
				
				var today=new Date();
				
				$.each(result.listJson.gridModel,function(i,info)
				{
	    			var couId = $("#country a.active").attr("data-id") == null ? 0 : parseInt($("#country a.active").attr("data-id"));
	    		    var proId = $("#pro a.active").attr("data-id") == null ? 0 : parseInt($("#pro a.active").attr("data-id"));
	    		    var cityId = $("#city a.active").attr("data-id") == null ? 0 : parseInt($("#city a.active").attr("data-id"));
	    		    var qyId = $("#sQy a.active").attr("data-id") == null ? 0 : parseInt($("#sQy a.active").attr("data-id"));
	    		    var sqId = $("#sSq a.active").attr("data-id") == null ? 0 : parseInt($("#sSq a.active").attr("data-id"));
		    		    
	    	    	var ids='&couId='+couId+'&proId='+proId+'&cityId='+cityId+'&qyId='+qyId+'&sqId='+sqId;
			    	    	
	    	    	var type=encodeURIComponent(info[1])
					var paramType=type;
	    	    	if(type=="0")
	    	    		type="住宅";
	    	    	if(type=="1")
	    	    		type="写字楼";
	    	    	if(type=="2")
	    	    		type="店面";
	    	    	if(type=="3")
	    	    		type="厂房";
	    	    	if(type=="4")
	    	    		type="别墅";
	    	    	
	    	    	var newCrawl="新";
	    	    	var crawlTime=new Date(info[22]);
	    	    	var crawlTimeFormat = crawlTime.format("yyyy-MM-dd hh:mm:ss");
	    	    	if(today.getTime()-crawlTime.getTime()>86400000)
	    	    		newCrawl="";

					var source = info[10];
	    	    	var phone = "<span class='phone'>"+info[12]+"</span>";
//	    	    	if($("#source").val()=="400")
//	    	    		phone=info[9];
	    	    	
	    	    	var titleUrl=info[11];
	    	    	if(source=="400" || source=="一键委托")
	    	    		titleUrl="javascript:void(0);";
	    	    	
	    	    	var title=info[4];
	    	    	if(title==undefined || title==null)
	    	    		title="";
	    	    	if(title.length>35)
	    	    		title=title.substring(0,35)+"...";
	    	    	
	    	    	var urlCode=encodeURIComponent(info[11]);
	    	    	var urlAddress=BMSUrl+'/pages/house/toSaleResidence.action?urlCode='+urlCode;
			    	
	    	    	var mlSucess = '<a class="btn btn-success btn-size" onclick="doRecord(\''+i+'\')">秒录</a>';
	    	        var rcount = info[14];
	    	        if(rcount > 0){
	    	        	rcount = "<a href='javascript:alertMsg();'>"+rcount+"</a>";
	    	        	mlSucess = '<a class="btn btn-success btn-size btn-style" onclick="doRecord(\''+i+'\')">已秒录</a>';
	    	        }

					var jbBtn = '<a class="btn btn-success btn-size" href="javascript:doReport('+info[0]+',\''+info[9]+'\',\''+info[12]+'\')">举报</a>';
					var scBtn = '<a class="btn btn-success btn-size" onclick="goShoucang(\''+businessType+'\','+info[0]+');">收藏</a>';
					var mfBtn = '<a class="btn btn-success btn-size" onclick="goPostForm(\''+businessType+'\',\''+info[0]+'\',\''+paramType+'\');">秒发</a>';

					var jbCount = info[13];
					if(jbCount > 0){
						jbBtn = '<a class="btn btn-success btn-size btn-style" href="javascript:tooltip(&quot;不能多次举报同一条房源!&quot;);">已举报</a>';
					}
					
					var scCount = info[23];
					if(scCount > 0){
						scBtn = '<a class="btn btn-success btn-size btn-style" href="javascript:tooltip(&quot;不能多次收藏同一条房源!&quot;);">已收藏</a>';
					}

	    	    	var tr = [
	    	            '<tr>',
	    	            '<td class="text-center">', '<input type="checkbox" class="fanghaoCB" name="" value="'+info[0]+'" />', '</td>',
	    	            
	    	            '<td class="text-center">', type, '</td>',
	    	            '<td class="text-left">',
    	            		'<span class="label label-red pull-left">',info[21],' 举报</span>',
    	            		'<span class="label label-secondary pull-left">',info[2],' 图</span>',
	    	            	'<span class="label label-red pull-left">'+newCrawl+'</span>',	
		    	            '<a class="f18" target="_blank" href="',titleUrl,'">',title,'</a></br></br><span style="color:red;">地址</span>：',info[5],
		    	            '</br><span style="color:red;">价格</span>：',info[6],
		    	            '</br><span style="color:red;">户型</span>：',info[7],
		    	            '&nbsp;&nbsp;&nbsp;<span style="color:red;">面积</span>：',info[16],
		    	            '&nbsp;&nbsp;&nbsp;<span style="color:red;">楼层</span>：',info[17],
		    	        '</td>',
	    	            '<td class="text-center">', info[8], '</br>',phone,'</td>',
	    	            '<td class="text-center">', info[10], '</br>',crawlTimeFormat,'</td>',
	    	            '<td class="text-center">', mlSucess+'</br>'+jbBtn+'</br>'+scBtn+'</br>'+mfBtn, '</td>',
//						'<td class="text-center">', mlSucess+'</br>'+jbBtn, '</td>',
	    	            '</tr>'].join('');
	    	        $("#tbodyData").append(tr);
			    });
			    
				doShow();
				
				// 分页.
				$('#macPageWidget').html(pagination(result.listJson.page, result.listJson.total));
				bindPageEvent();
				
				// 分页高亮.
				if(historyPageIndex==undefined || historyPageIndex==null){
					$("li a[pagenum='"+0+"']").addClass("pageOpen");
				}else{
					$("li a[pagenum='"+historyPageIndex+"']").addClass("pageOpen");
				}
			}
		});
	};
	
	/* 为分页控件绑定事件 */
	var historyPageIndex;
	function bindPageEvent()
	{
		var links = $("#macPageWidget li").find("a");
		$.each(links, function(i, link1)
		{
			var link = $(link1);
			var pageNum = link.attr("pageNum");
			
			link.click(function()
			{
				jumpPage(pageNum);
			});
		});
	}
	function jumpPage(pageNum)
	{
		historyPageIndex=pageNum;
		var t=setTimeout(queryData(pageNum),1000);
	}
	
	function doRecord(num)
	{
		if(num!=undefined && customList!=undefined && customList.length>0)
		{
			var item=customList[num];
			
			var obj=new Object();
			
		    var requestParameter=new Object();
			// 参数.
			// ---------------------------------------------
		    var businessType=$("#crawlType li.active").attr("data-id") == null ? '' : $("#crawlType li.active").attr("data-id");
	    	requestParameter.businessType=businessType;
	    	requestParameter.id=item[0];
		    obj.requestParameter=requestParameter;
	    	
	    	var jsonData=JSON.stringify(obj);
	    	
			$.ajax({
				url: cloudPlatformUrl+"/services/newenv/lpzd/crawl/getRecordTimes/",
				dataType: "json", 
				type: "POST", 
				contentType : "application/json; charset=utf-8",
				data : jsonData,
				success : function(result)
				{
					if(result.num >= enableRecordTimesKe)
					{
						bootbox.alert({title:"提示",message:"超过每条总录入限制，取消操作!"});
						return;
					}
					
					doRecordAdd(num);
		    	}
			});
		}
	}
	
	function doRecordAdd(num)
	{
		if(num!=undefined && customList!=undefined && customList.length>0)
		{
			var item=customList[num];
			
		    var businessType=$("#crawlType li.active").attr("data-id") == null ? '' : $("#crawlType li.active").attr("data-id");

			var urlAddress="";
			var paramURL = "400-"+businessType+"-"+item[0];
			paramURL += "&businessType="+businessType+"&crawlId="+item[0];
			if(businessType=="fangyuan_chushou")
			{
				// 住宅
		    	if(item[1]=="0")
		    		urlAddress=BMSUrl+'/pages/house/toSaleResidence.action?urlCode='+paramURL;
				// 写字楼
		    	if(item[1]=="1")
		    		urlAddress=BMSUrl+'/pages/house/toSaleOffice.action?urlCode='+paramURL;
				// 商铺
		    	if(item[1]=="2")
		    		urlAddress=BMSUrl+'/pages/house/toSaleShop.action?urlCode='+paramURL;
				// 厂房
		    	if(item[1]=="3")
		    		urlAddress=BMSUrl+'/pages/house/toHighEndSaleResidence.action?urlCode='+paramURL;
				// 别墅
		    	if(item[1]=="4")
		    		urlAddress=BMSUrl+'/pages/house/toSaleVilla.action?urlCode='+paramURL;
			}
			if(businessType=="fangyuan_chuzu")
			{
				// 住宅
		    	if(item[1]=="0")
		    		urlAddress=BMSUrl+'/pages/house/toRentResidence.action?urlCode='+paramURL;
				// 写字楼
		    	if(item[1]=="1")
		    		urlAddress=BMSUrl+'/pages/house/toRentOffice.action?urlCode='+paramURL;
				// 商铺
		    	if(item[1]=="2")
		    		urlAddress=BMSUrl+'/pages/house/toRentShop.action?urlCode='+paramURL;
				// 厂房
		    	if(item[1]=="3")
		    		urlAddress=BMSUrl+'/pages/house/toHighEndRentResidence.action?urlCode='+paramURL;
				// 别墅
		    	if(item[1]=="4")
		    		urlAddress=BMSUrl+'/pages/house/toRentVilla.action?urlCode='+paramURL;
			}
            var obj=new Object();
		    var requestParameter=new Object();
			// 参数.
			// ---------------------------------------------
		    var businessType=$("#crawlType li.active").attr("data-id") == null ? '' : $("#crawlType li.active").attr("data-id");
	    	requestParameter.userId=uid;
	    	requestParameter.businessType=businessType;
	    	requestParameter.id=item[0];
		    obj.requestParameter=requestParameter;
	    	
	    	var jsonData=JSON.stringify(obj);
	    	
			$.ajax({
				url: cloudPlatformUrl+"/services/newenv/lpzd/crawl/setRecordTimes/",
				dataType: "json", 
				type: "POST", 
				contentType : "application/json; charset=utf-8",
				data : jsonData,
				success : function(result)
				{
					if(result >0 )
					{
						queryData(historyPageIndex);
					}
					else
						bootbox.alert({title:"提示",message:"网络异常请检查!"});
		    	}
			});

			try{ 
				window.parent.addTab('房源详情',urlAddress);
			}catch (e){
				console.log(e.message);
				location.href=urlAddress;
			}
	    	
		}
	}
	
	// 举报.
	function doReport(reportId,linkPhone,phone)
	{
		var obj=new Object();
		
	    var pageInfo=new Object();
	    pageInfo.page=1;
	    obj.pageInfo=pageInfo;

	    var requestParameter=new Object();
		// 参数.
		// ---------------------------------------------
	    var businessType=$("#crawlType li.active").attr("data-id") == null ? '' : $("#crawlType li.active").attr("data-id");
    	requestParameter.businessType=businessType;
    	requestParameter.id=reportId;
    	requestParameter.linkPhone=linkPhone;
    	requestParameter.phone=phone;
		requestParameter.userId=uid;
    	obj.requestParameter=requestParameter;

    	var jsonData=JSON.stringify(obj);
    	 
		$.ajax({
			url: cloudPlatformUrl+"/services/newenv/lpzd/crawl/doReport/", 
			dataType: "json", 
			type: "POST", 
			contentType : "application/json; charset=utf-8",
			data : jsonData,
			success : function(result)
			{
				if(result == 1)
				{
					bootbox.alert({title:"提示",message:"举报成功!"});
					queryData(historyPageIndex);
				}
				else
					bootbox.alert({title:"提示",message:"举报失败 !"});
	    	}
		});
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
				//$("#country").html(cHtml);
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
		proValue = $("#pro a[data-id='"+val+"']").attr("datavalue");
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
		cityValue = $("#city a[data-id='"+val+"']").attr("datavalue");
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
	
	
	function alertMsg(){
		var businessType=$("#crawlType li.active").attr("data-id");
		if(businessType = "fangyuan_chushou"){
			bootbox.alert({title:"提示",message:"该房源已秒录到BMS系统中的【我的售房】,如需查看请到BMS售房列表查看!"});
		}else if (businessType = "fangyuan_chuzu"){
			bootbox.alert({title:"提示",message:"该房源已秒录到BMS系统中的【我的租房】,如需查看请到BMS租房列表查看!"});
		}
	}

	function tooltip(msg){
		bootbox.alert({title:"提示",message:msg});
	}
	
	function goShoucang(type,id){
		$("#Shoucang #type").val(type);
		$("#Shoucang #id").val(id);
		$('#Shoucang').modal('show', {backdrop: 'fade'});
	}
	
	function saveShouCang(){
		var businessType=$("#crawlType li.active").attr("data-id");
	    var id = $("#Shoucang #id").val();
		var obj=new Object();
		var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/addFangYuanRelease/";
		var requestParameter=new Object();
    	requestParameter.businessType=businessType;
    	requestParameter.userId=uid;
    	requestParameter.id=id;
    	requestParameter.pstatus=1;
    	obj.requestParameter=requestParameter;
    	var jsonData=JSON.stringify(obj);
		var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
		var resultObj = $.parseJSON(result.responseText);
		$('#Shoucang').modal("hide");
		queryData(historyPageIndex);
	}

	function goPostForm(type,id,houseType){
		if(type == "fangyuan_chushou"){
			window.location.href = "<%=basePath%>/crawl/saleForm.jsp?type="+type+"&id="+id+"&hType="+houseType;
		}else{
			window.location.href = "<%=basePath%>/crawl/rentForm.jsp?type="+type+"&id="+id+"&hType="+houseType;
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
