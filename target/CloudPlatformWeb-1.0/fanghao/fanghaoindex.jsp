<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %> 
<%  String basePath = request.getContextPath();
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
		<title>房产信息</title>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/bootstrap.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/xenon-core.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/xenon-forms.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/xenon-components.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/xenon-skins.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/custom.css">
		<script src="<%=request.getContextPath() %>/assets/js/jquery-1.11.1.min.js"></script>
		<script src="<%=request.getContextPath() %>/js/jquery.form.js"></script>
		<script src="<%=request.getContextPath() %>/js/services.js"></script>
		<script src="<%=request.getContextPath() %>/js/fanghao/fanghaolist.js"></script>
		<script src="<%=request.getContextPath() %>/js/fanghao/fanghaodtlist.js"></script>
		<script src="<%=request.getContextPath() %>/js/fanghao/fanghaoxqlist.js"></script>
		<script src="<%=request.getContextPath() %>/js/fanghao/fanghaoxflist.js"></script>
		<script src="<%=request.getContextPath() %>/assets/js/page.js"></script>
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
	var basePath="<%=basePath%>";
	var basepath="<%=basePath%>";
	var cityId="<%=cityId%>";
	var countryId="<%=countryId%>";
	var provinceId="<%=provinceId%>";
	function showTab(tabId){
		$(".tab-pane").removeClass("active");
		$("#"+tabId).addClass("active");
	}
	function mpty(){
		$("#fwztId").val(-1);
		$("#schoolid").val(0);
	
	}
	function mptyxf(){
		$("#ltypexf").val(-1);
		$("#schoolidxf").val(0);
	}
	
	function empty(){
		$("#country option[value='"+countryId+"']").attr("selected", true); 
		$("#pro option[value='"+provinceId+"']").attr("selected", true); 
		$("#cityId option[value='"+cityId+"']").attr("selected", true);
		buildQy(cityId);
		$("#sQq").html("");
		var build = $("div.tiaojian a.bg2").parent().find(".removeCondition");
		for(var i = 0 ; i < build.length ; i++) {
			var conditionName = $(build[i]).closest("a").attr("data-conditionName");
			pagerForm[conditionName].value = "0";
			var container = $("div.fysearch-right[data-conditionName='" + conditionName + "']");
			container.find("a").removeClass("active");
			container.find("a[data-conditionValue='0']").addClass("active");
		}
		showShaiXuanTianJian();
	}
	
	function emptyxf(){
		$("div.tiaojianxf").on("click", ".bg2", function(){
		var build = $(this).parent().find(".removeCondition");
		for(var i = 0 ; i < build.length ; i++) {
			var conditionName = $(build[i]).closest("a").attr("data-conditionName");
			pagerFormxf[conditionName].value = "0";
			var container = $("div.fysearch-rightxf[data-conditionName='" + conditionName + "']");
			container.find("a").removeClass("active");
			container.find("a[data-conditionValue='0']").addClass("active");
		}
		showShaiXuanTianJianxf();
		queryDataxf(0,-1);
	});
	
	}
	
	
	var curTabId = "";
	//选项卡的内容是否已加载
	var tabStatus = {"tab-1":true, "tab-2":false, "tab-3":false, "tab-4":false};
	$(function(){
		$('#navtabs a[data-toggle="tab"]').on('show.bs.tab', function (e){
			curTabId = e.target.hash.substring(1);
			tabStatustable(curTabId);
        });       
      
     });
     
     function tabStatustable(curTabId){
     if(tabStatus[curTabId]==false){
				switch(curTabId){
					case "tab-2":
						getXianLu();
						getshi(804,"dtsHx");
						gettnmj(806,"dtsMj");
						gettnmj(938,"dtsjl");
						buildQydt(cityId);	
						getSyscsOPTIONdt("房屋朝向","dtsCx","朝向不限");
						getSyscsOPTIONdt("房屋用途","dtsYt","用途不限");
						getSyscsOPTIONdt("装修标准","dtsZx","装修不限");
						getSyscsOPTIONdt("建筑类别","dtsFwjg","结构不限");
						$("#fanghaodt").html("加载中...").load(basePath+"/newenv/lpzd/fanghaodt.action"); 
						break;
					case "tab-3":
						buildQyxq(cityId);
						getSyscsOPTIONxq("学校类别","xqType");
						$("#fanghaoxq").html("加载中...").load(basePath+"/newenv/lpzd/fanghaoxq.action"); 
						break;
					case "tab-4":
						buildQyxf(cityId);
					getSyscsOPTIONxf(767,"xfType");
						gettnmj(937,"xfsJg");
						break;
				}
				tabStatus[curTabId]=true;
			}
     }
	
	</script>
	<style type="text/css">
		.dis{ display:block !important;}
	</style>
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
								<a href="javascript:void(0)"><i class="fa-home"></i>首页</a>
							</li>
							<li class="active">
								<strong><a href="<%=basePath%>/fanghao/fanghaoindex.jsp?p=house">房产信息</a></strong>
							</li>
						</ol>
					</div>
				</div>
				
				
				
				
					<!-- Add class "collapsed" to minimize the panel -->
					
						<div class="panel-options">
							<ul class="nav nav-tabs" id="navtabs">
								<li class="active">
									<a href="#tab-1" data-toggle="tab" onclick="mpty(),empty();queryData(0,-1);">全部房屋</a>
								</li>
								<li>
									<a href="#tab-2" data-toggle="tab" >地铁房</a>
								</li>
								<li>
									<a href="#tab-3" data-toggle="tab" onclick="showTab('tab-3')">学区房</a>
								</li>
								<li>
									<a href="#tab-4" data-toggle="tab" onclick="mptyxf(),emptyxf(),fanghaoxf(0,2)">新房</a>
								</li>
							</ul>
						</div>
					
					<div class="panel panel-default">
						<div class="tab-content">
							<div class="tab-pane active" id="tab-1">
								<form name="pagerForm" id="pagerForm" action="" method="post">
							    <input type="hidden" name="sFw" value="0"/>
							    <input type="hidden" name="sQy" value="0"/>
							    <input type="hidden" name="sSq" value="0"/>
							    <input type="hidden" name="sHx" value="0"/>
							    <input type="hidden" name="sMj" value="0"/>
							    <input type="hidden" name="sZj" value="0"/>
							    <input type="hidden" name="fwzt" id="fwztId" value="-1"/>
							    <input type="hidden" name="schoolid" id="schoolid" value="0"/>
								<div class="table-responsive">
									<table class="table table-condensed">
										<tbody>
											<tr>
												<td width="100" class="text-right"><div class="line32">搜索：</div></td>
												<td>
													<select class="form-control w100 pull-left ml10" onchange="buildProfw(this)" id="country">
														<option value="">国家</option>
													</select>
													<select class="form-control w100 pull-left ml10" onchange="buildCity(this)" id="pro">
														<option value="">省份</option>
													</select>
													<select class="form-control w100 pull-left ml10" id="cityId" onchange="buildQy(this)">
														<option value="">城市</option>
													</select>
																							
												</td>
											</tr>
											<tr>
												<td class="text-right"><div class="line32">小区名称：</div></td>
												<td>
													<div>		
<!-- 														<div class="w150 pull-left"> -->
<!-- 															<select class="form-control  s2example-1" id="lp" > -->
<!-- 																  <option></option> -->
<!-- 															</select>		 -->
<!-- 														</div>															 -->
														<div class="w150 pull-left">
															<div class="ml10">
									<script type="text/javascript">
										jQuery(document).ready(function($)
										{
											$("#lp").select2({
												minimumInputLength: 1,
												placeholder: '请输入搜索',
												ajax: {
													url: basePath+"/newenv/lpzd/fanghaogetByLpName.action",
													type: "POST",
													dataType: 'json',
													quietMillis: 100,
													data: function(term, page) {
														return {
															limit: -1,
															"lpName": term
														};
													},
													results: function(data, page ) {
														return { results: data }
													}
												},
												formatResult: function(student) { 
													return "<div class='select2-user-result'>" + student.lpName + "</div>"; 
												},
												formatSelection: function(student) { 
													return  student.lpName; 
												}
												
											}) .on("change",function(e){
												//queryData("");
												getBYLpId(e.val);
												if($('#select2-chosen-1').html()!=''&&$('#select2-chosen-1').html()!=null)       
      										 	{
      										 	$(".select2-search-choice-close").addClass("dis");
      										 	}
      										 	else
      										 	{
      										 		$(".select2-search-choice-close").removeClass("dis");
      										 	}
												
											});
											$(".select2-search-choice-close").click(function(){
												$(".select2-search-choice-close").removeClass("dis");
											});
	
										});
									</script>
									
									<input type="hidden" name="s2example-4" id="lp" />
										
								</div>

													</div>
														<div class="pull-left mr10 line32">栋座</div>
														<select class="form-control w80 pull-left ml08" id="ld" onchange="queryData('')">
														</select>
<!-- 														<div class="pull-left mr10 line32">单元</div> -->
<!-- 														<select class="form-control w80 pull-left ml08" id="dyId" onchange="getBYceng(this)"> -->
<!-- 														</select> -->
<!-- 														<div class="pull-left mr10 line32">层</div> -->
<!-- 														<select class="form-control w80 pull-left ml08"  id="ceng" onchange="getBYfangHao(this)" > -->
<!-- 														</select> -->
														<div class="pull-left mr10 line32">房号</div>
<!-- 														<select class="form-control w80 pull-left ml08" id="fangHao" onchange="queryData('')"> -->
<!-- 														</select> -->
														<input type="text" class="form-control w80 pull-left"  id="fangHao" name="fangHao">
														<div class="pull-left mr10 line32">房屋编号</div>
														<input type="text" class="form-control w120 pull-left" name="number" id="number">										
														<button class=" ml10 btn btn-secondary" type="button" onclick="queryData('')">搜索</button>
													</div>		
												</td>
											</tr>
											<tr id="tdsQy">
											</tr>
											<tr id="sQq">
											</tr>
											<tr>
												<td class="text-right"><div class="line32" >户型：</div></td>
												<td>
													<div class="fysearch-right pull-left Color line32"  id="shi" data-conditionName="sHx">
													</div>
													<div class="fysearch-right pull-left" style="width: 350px;">
														<input type="text" class="form-control w55 pull-left" name="sHxS" id="sHxS"/>
														<div class="pull-left mr10 line32">室</div>
														<input type="text" class="form-control w55 pull-left"   name="sHxT" id="sHxT"/>
														<div class="pull-left mr10 line32 ">厅</div>
														<input type="text" class="form-control w55 pull-left"  name="sHxW" id="sHxW"/>
														<div class="pull-left mr10 line32">卫</div>
														<button class="btn btn-secondary" type="button" onclick="submitSearch('sHx')">筛选</button>
													</div>
												</td>
											</tr>
											<tr>
												<td class="text-right"><div class="line32" data-conditionName="sMj">面积：</div></td>
												<td>
													<div class="fysearch-right pull-left Color line32" id="mianji"  data-conditionName="sMj">
													</div>
													<div class="fysearch-right pull-left" style="width: 248px;">
														<input type="text" class="form-control w55 pull-left" id="startmj" name="startmj"/>
														<div class="pull-left mr10 line32">-</div>
														<input type="text" class="form-control w55 pull-left" id="endmj" name="endmj"/>
														<div class="pull-left mr10 line32">㎡</div>
														<button class="btn btn-secondary" type="button"   onclick="submitSearch('sMj')">筛选</button>
													</div>
												</td>
											</tr>
											<tr>
												<td class="text-right"><div class="line32">筛选：</div></td>
												<td>
													<div class="pull-left pr10">
														<select onChange="submitSearch('sCx')" id="CsCx" name="sCx" class="form-control w108 pull-left ml10">
															  <option value="">朝向</option>
														</select>
													</div>
													<div class="pull-left pr10">
														<select onChange="submitSearch('sYt')"  id="YsYt"name="sYt" class="form-control w108 pull-left ml10">
															<option value="">用途</option>
														</select>
													</div>
													<div class="pull-left pr10">
														<select onChange="submitSearch('sZx')" id="ZsZx" name="sZx" class="form-control w108 pull-left ml10">
															<option value="">装修程度</option>
														</select>
													</div>
													<div class="pull-left pr10">
														<select onChange="submitSearch('sFwjg')" id="sFwjg" name="sFwjg" class="form-control w108 pull-left ml10">
															<option value="">房屋结构</option>
														</select>
													</div>
													<div class="pull-left pr10">
														<select onChange="submitSearch('fwxz')"  id="fwxz" name="fwxz" class="form-control w108 pull-left ml10">
															<option value="">现状不限</option>
															<option value="1">在售</option>
															<option value="2">在租</option>
															<option value="3">既售既租</option>
															<option value="0">空置</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td class="text-right"><div class="shaixuan-left"><em></em>条件：</div></td>
												<td>
													<div class="shaixuan-right">
													<div class="pull-left">
														<div class="tiaojian">
														</div>
													</div>
												</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</form>
								<div class="clearfix"></div>
						<div class="pull-right line32" id="fwts">
						</div>
						<div class="clearfix"></div>
						<%-- <div class="btn-group">
							<button type="button" class="btn btn-blue dropdown-toggle" data-toggle="dropdown">
								操作 <span class="caret"></span>
							</button>
							<ul class="dropdown-menu dropdown-blue" role="menu">
								<li>
									<a href="新增-修改住宅.html">住宅</a>
								</li>
								<li>
									<a href="新增商铺.html">商铺</a>
								</li>
								<li>
									<a href="新增写字楼.html">写字楼</a>
								</li>
								<li>
									<a href="新增别墅.html">别墅</a>
								</li>
								<li>
									<a href="新增新房.html">新房</a>
								</li>
							</ul>
						</div> --%>
<!-- 						<div class="btn-group"> -->
<!-- 									<button type="button" class="btn btn-blue dropdown-toggle" data-toggle="dropdown"> -->
<!-- 										操作 <span class="caret"></span> -->
<!-- 									</button> -->
<!-- 									<ul class="dropdown-menu dropdown-blue" role="menu"> -->
<!-- 										<li> -->
<!-- 											<a href="javascript:void(0)" onclick="queryData('41')">住宅</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="javascript:void(0)" onclick="queryData('43')">商铺</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="javascript:void(0)" onclick="queryData('42')">写字楼</a> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</div> -->
						
						<div class="table-responsive">
						<table class="table table-bordered table-striped table-condensed">
							<thead>
								<tr>
									<th width="50" class="text-center"><input type="checkbox"  onclick="checkAll(this)"/></th>
									<th colspan="2">房屋</th>
									<th>状态</th>
									<th>数据来源</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody class="middle-align" id="tbodyData">
								
							</tbody>
						</table>
						<div id="macPageWidget"></div>
			    	</div>
							</div>
							<div class="tab-pane" id="tab-2">
							<form name="pagerFormdt" id="pagerFormdt" action="" method="post">
							    <input type="hidden" name="dtsFw" value="0"/>
							    <input type="hidden" name="dtsQy" value="0"/>
							    <input type="hidden" name="dtsSq" value="0"/>
							    <input type="hidden" name="dtsHx" value="0"/>
							    <input type="hidden" name="dtsMj" value="0"/>
							    <input type="hidden" name="dtsZj" value="0"/>
							    <input type="hidden" name="dtxianLu" value="0"/>
							     <input type="hidden" name="dtsjl" value="0"/>
							        <input type="hidden" name="fwztdt" id="fwztIddt" value="-1"/>
								<div class="table-responsive">
									<table class="table table-condensed">
										<tbody>
											<tr>
												<td class="text-right" width="100"><div class="line32">线路：</div></td>
												<td>
													<div class="fysearch-rightdt pull-left Color line32" id="dtxianLu" data-conditionName="dtxianLu">
													</div>
												</td>
											</tr>
													<tr>
												<td class="text-right">
												<div class="line32">区域：</div></td>
												<td>
													<div class="fysearch-rightdt pull-left Color line32" id="dtsQy" data-conditionName="dtsQy">
													</div>
												</td>
											</tr>
											<tr id="sQqdt"></tr>
											<tr>
												<td class="text-right"><div class="line32" >户型：</div></td>
												<td>
													<div class="fysearch-rightdt pull-left Color line32" id="dtsHx" data-conditionName="dtsHx">
													</div>
													<div class="pull-left" style="width: 350px;">
														<input type="text" class="form-control w55 pull-left"  id="dtsHxS" name="dtsHxS"/>
														<div class="pull-left mr10 line32">室</div>
														<input type="text" class="form-control w55 pull-left" id="dtsHxT"  name="dtsHxT"/>
														<div class="pull-left mr10 line32">厅</div>
														<input type="text" class="form-control w55 pull-left" id="dtsHxW"  name="dtsHxW"/>
														<div class="pull-left mr10 line32">卫</div>
														<button class="btn btn-secondary" type="button"onclick="submitSearchdt('dtsHx')">筛选</button>
													</div>
												</td>
											</tr>
											<tr>
												<td class="text-right"><div class="line32" >面积：</div></td>
												<td>
													<div class="fysearch-rightdt pull-left Color line32" id="dtsMj"   data-conditionName="dtsMj">
														
													</div>
													<div class="fysearch-rightdt pull-left" style="width: 248px;">
														<input type="text" class="form-control w55 pull-left" id="startmjdt" name="startmjdt"/>
														<div class="pull-left mr10 line32">-</div>
														<input type="text" class="form-control w55 pull-left" id="endmjdt"  name="endmjdt"/>
														<div class="pull-left mr10 line32">㎡</div>
														<button class="btn btn-secondary" type="button" onclick="submitSearchdt('dtsMj')">筛选</button>
													</div>
												</td>
											</tr>
											<tr>
												<td class="text-right"><div class="line32">距离：</div></td>
												<td>
													<div class="fysearch-rightdt pull-left Color line32" id="dtsjl"   data-conditionName="dtsjl">
													</div>
												</td>
											</tr>
											<tr>
												<td class="text-right"><div class="line32">筛选：</div></td>
												<td>
													<div class="pull-left pr10">
													<select onChange="submitSearchdt('dtsCx')" name="dtsCx" id="dtsCx" class="form-control w108 pull-left ml10">
													</select>
													</div>
													<div class="pull-left pr10">
													<select onChange="submitSearchdt('dtsYt')"  name="dtsYt" id="dtsYt" class="form-control w108 pull-left ml10">
													</select>
													</div>
													<div class="pull-left pr10">
													<select onChange="submitSearchdt('dtsZx')"  name="dtsZx" id="dtsZx"  class="form-control w108 pull-left ml10">
													</select>
													</div>
													<div class="pull-left pr10">
													<select onChange="submitSearchdt('dtsFwjg')"  name="dtsFwjg"  id="dtsFwjg"  class="form-control w108 pull-left ml10">
													</select>
													</div>
													<div class="pull-left pr10">
													<select onChange="submitSearchdt('dtfwxz')"  id="dtfwxz" name="dtfwxz" class="form-control w108 pull-left ml10">
														<option value="">现状不限</option>
														<option value="1">在售</option>
														<option value="2">在租</option>
														<option value="3">既售既租</option>
														<option value="0">空置</option>
													</select>
													</div>
												</td>
											</tr>
											<tr>
												<td class="text-right"><div class="shaixuan-left"><em></em>条件：</div></td>
												<td>
													<div class="shaixuan-right">
													<div class="pull-left">
														<div class="tiaojiandt">
														</div>
													</div>
												</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								</form>
								<div class="clearfix"></div>
								<div class="pull-right line32" id="fwtsdt">
								</div>
								<div class="clearfix"></div>
<!-- 								<div class="btn-group"> -->
<!-- 									<button type="button" class="btn btn-blue dropdown-toggle" data-toggle="dropdown"> -->
<!-- 										操作 <span class="caret"></span> -->
<!-- 									</button> -->
<!-- 									<ul class="dropdown-menu dropdown-blue" role="menu"> -->
<!-- 										<li> -->
<!-- 											<a href="javascript:void(0)" onclick="queryDatadt('41')">住宅</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="javascript:void(0)" onclick="queryDatadt('43')">商铺</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="javascript:void(0)" onclick="queryDatadt('42')">写字楼</a> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</div> -->
										<div id="fanghaodt"></div>
							</div>
							<div class="tab-pane" id="tab-3" >
								<form name="pagerFormxq" id="pagerFormxq" action="" method="post">
							    <input type="hidden" name="xqsQy" value="0"/>
							    <input type="hidden" name="xqType" value="0"/>
							     <input type="hidden" name="xqsSq" value="0"/>
								<div class="table-responsive" style="display:block;">
									<table class="table table-condensed">
										<tbody>
											<tr>
												<td class="text-right" width="100"><div class="line32">区域：</div></td>
												<td>
													<div class="fysearch-rightxq pull-left Color line32" data-conditionName="xqsQy" id="xqsQy">
													</div>
												</td>
											</tr>
											<tr id="sQqxq"></tr>
											<tr>
												<td class="text-right"><div class="line32">类型：</div></td>
												<td >
													<div class="fysearch-rightxq pull-left Color line32" data-conditionName="xqType" id="xqType">
													</div>
												</td>
											</tr>
												<tr>
												<td class="text-right"><div class="shaixuan-left"><em></em>条件：</div></td>
												<td>
													<div class="shaixuan-right">
													<div class="pull-left">
														<div class="tiaojianxq">
														</div>
													</div>
												</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								</form>
								<div class="row">						
									<div class="input-group" style="width: 300px;">
										<input type="text" class="form-control" id="schoolName" placeholder="请输入学校名称">
										<a href="javascript:queryDataxq" class="btn btn-success input-group-addon" >搜索</a>
									</div>
								</div>
								<div class="clearfix"></div>
								<div class="pull-right line32" id="fwtsxq">
								</div>
							<%-- 	<div class="btn-group">
									<button type="button" class="btn btn-blue dropdown-toggle" data-toggle="dropdown">
										操作 <span class="caret"></span>
									</button>
									<ul class="dropdown-menu dropdown-blue" role="menu">
										<li>
											<a href="javascript:void(0)" onclick="queryDatadt('41')">住宅</a>
										</li>
										<li>
											<a href="javascript:void(0)" onclick="queryDatadt('43')">商铺</a>
										</li>
										<li>
											<a href="javascript:void(0)" onclick="queryDatadt('42')">写字楼</a>
										</li>
									</ul>
								</div> --%>
								
								<div class="table-responsive">
								<div id="fanghaoxq" style="display: block;"></div>
								<div id="fanghaoxqcs" style="display:none"></div>
								
					    	</div>
								
								
							</div>
							<div class="tab-pane" id="tab-4">
								
								<div class="table-responsive">
								<form name="pagerFormxf" id="pagerFormxf" action="" method="post">
							    <input type="hidden" name="xfsQy" value="0"/>
							     <input type="hidden" name="xfsJg" value="0"/>
							     <input type="hidden" name="xfsSq" value="0">
							       <input type="hidden" name="schoolid" id="schoolidxf" value="0"/>
							    <input type="hidden" name="ltype" id="ltypexf" value="-1"/>
									<table class="table table-condensed">
										<tbody>
											<tr>
												<td class="text-right" width="100">
												<div class="line32">区域：</div></td>
												<td>
													<div class="fysearch-rightxf pull-left Color line32"  id="xfsQy" data-conditionName="xfsQy">
													</div>
												</td>
											</tr>
											<tr id="sQqxf"></tr>
											<tr>
												<td class="text-right"><div class="line32">价格：</div></td>
												<td>
													<div class="fysearch-rightxf pull-left Color line32" data-conditionName="xfsJg" id="xfsJg">
													</div>
												</td>
											</tr>
											<tr>
												<td class="text-right"><div class="shaixuan-left"><em></em>条件：</div></td>
												<td>
													<div class="shaixuan-right">
													<div class="pull-left">
														<div class="tiaojianxf">
														</div>
													</div>
												</div>
												</td>
											</tr>
										</tbody>
									</table>
									</form>
								</div>
								<div class="row">						
									<!--<div class="Color pull-left h4">
										<input type="text" class="form-control" id="lpNamexf" placeholder="请输入楼盘名称">
										<a href="javascript:queryDataxf(0,2)" class="btn btn-success" >搜索</a>
									</div>-->
									<div class="clearfix"></div>
									<div class="pull-right line32" id="fwtsxf">
									</div>
									<div class="input-group" style="width: 300px;">
										<input type="text" class="form-control" id="lpNamexf" placeholder="请输入楼盘名称">
										<a href="javascript:queryDataxf(0,2)" class="btn btn-success input-group-addon" >搜索</a>
									</div>
								</div>
								<div class="clearfix"></div>
<!-- 								<div class="btn-group"> -->
<!-- 									<button type="button" class="btn btn-blue dropdown-toggle" data-toggle="dropdown"> -->
<!-- 										操作 <span class="caret"></span> -->
<!-- 									</button> -->
<!-- 									<ul class="dropdown-menu dropdown-blue" role="menu"> -->
<!-- 										<li> -->
<!-- 											<a href="#">住宅</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="#">商铺</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="#">写字楼</a> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</div> -->
								
								<div class="table-responsive">
								<div id="fanghaoxf"></div>
					    	</div>
								
								
							</div>
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
			</a> Chat
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
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/js/select2/select2.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/js/select2/select2-bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/js/multiselect/css/multi-select.css">

<!-- Bottom Scripts -->
<script src="<%=request.getContextPath() %>/assets/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/TweenMax.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/resizeable.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/joinable.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/xenon-api.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/xenon-toggles.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=request.getContextPath() %>/assets/js/xenon-widgets.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/select2/select2.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/multiselect/js/jquery.multi-select.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/formwizard/jquery.bootstrap.wizard.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/selectboxit/jquery.selectBoxIt.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/toastr/toastr.min.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=request.getContextPath() %>/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/tocify/jquery.tocify.min.js"></script>
<!-- JavaScripts initializations and stuff -->
<script src="<%=request.getContextPath() %>/assets/js/xenon-custom.js"></script>

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
							<div class="col-sm-8">
								<div class="input-group input-group-minimal">
									<input type="text" class="form-control">
									<a href="#" class="input-group-addon"><i class="fa-plus"></i></a>
								</div>
								<br>
								<div class="input-group input-group-minimal">
									<input type="text" class="form-control">
									<a href="#" class="input-group-addon"><i class="fa-plus"></i></a>
									<a href="#" class="input-group-addon"><i class="fa-trash-o"></i></a>
								</div>
							</div>
						</div>
						<div class="form-group-separator"></div>
					</form>

				</div>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-info">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="lei-gai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">编辑</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
					<form role="form" class="form-horizontal">
						<div class="form-group">
							<div class="input-group input-group-minimal">
								<input type="email" class="form-control" value="幼儿园">
								<a href="#" class="input-group-addon" title="点击删除">
									<i class="fa-trash-o"></i>
								</a>
							</div>
						</div>
						<div class="form-group-separator"></div>

						<div class="form-group">
							<div class="input-group input-group-minimal">
								<input type="email" class="form-control" value="小学">
								<a href="#" class="input-group-addon" title="点击删除">
									<i class="fa-trash-o"></i>
								</a>
							</div>
						</div>
						<div class="form-group-separator"></div>

						<div class="form-group">
							<div class="input-group input-group-minimal">
								<input type="email" class="form-control" value="初中">
								<a href="#" class="input-group-addon" title="点击删除">
									<i class="fa-trash-o"></i>
								</a>
							</div>
						</div>
						<div class="form-group-separator"></div>

						<div class="form-group">
							<div class="input-group input-group-minimal">
								<input type="email" class="form-control" value="高中">
								<a href="#" class="input-group-addon" title="点击删除">
									<i class="fa-trash-o"></i>
								</a>
							</div>
						</div>
						<div class="form-group-separator"></div>

					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-info">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

		<script language="javascript" type="text/javascript">													
													$(document).ready(function($)
														{
															$(".s2example-1").select2({
																placeholder: '请输入搜索条件.',
																allowClear: true
															}).change('select2-open', function()
															{
															queryData("");
															getBYLpId($(this).val());
																$(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
															});
															
														});
												</script>	