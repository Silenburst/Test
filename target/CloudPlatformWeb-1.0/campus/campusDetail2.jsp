<%@page import="java.util.List"%>
<%@page import="com.newenv.lpzd.Utils.FileUtil"%>
<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
		UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="description" content="Xenon Boostrap Admin Panel" />
		<meta name="author" content="" />
		<title>Xenon - Dashboard</title>
		<link rel="stylesheet" href="<%=basePath%>/assets/css/bootstrap.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-core.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-forms.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-components.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-skins.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/custom.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xiaoqu.css">
		<script src="<%=basePath%>/assets/js/jquery-1.11.1.min.js"></script>
		<script src="../assets/js/bootbox/bootbox.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/js/ext/exttab/css/ext-all.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/js/bootbox/bootbox.css">
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=cwWUeu7m6ZIclzyUBhqMrA05"></script>
		<script type="text/javascript" src="<%=basePath%>/js/ext/exttab/js/ext-base.js" ></script> 
		<script type="text/javascript" src="<%=basePath%>/js/ext/exttab/js/ext-all.js" ></script> 
		<script src="<%=basePath%>/assets/js/page.js"></script>
		<script src="<%=basePath%>/js/comm/commInfo.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/campus/detailCampus.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/campus/lpDongDetail.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/campus/facilitiesDetail.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/campus/lptp.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/campus/jquery.rotate.js" type="text/javascript"></script>
		
		<script type="text/javascript">
			var basepath = "<%=basePath%>";
			var curTabId = "";
			//选项卡的内容是否已加载
			var tabStatus = {"tab1":true, "tab2":false, "tab3":false, "tab4":false, "tab5":false, "tab6":false, "tab7":false};
			$(function(){
		$('#navtabs a[data-toggle="tab"]').on('show.bs.tab', function (e){
			curTabId = e.target.hash.substring(1);
			tabStatustable(curTabId);
        });       
      
     });
     
     function tabStatustable(curTabId){
     if(tabStatus[curTabId]==false){
				switch(curTabId){
					case "tab2":
						//维护单位
						maintain();
						//居住成本
						livingcosts();
						queryLpzj();
						break;
					case "tab3":
						lptp();
						break;
					case "tab4":
					//加载所有栋信息
					showDongInfo($("#wuyelpid").val());
					//楼盘栋信息
					showDongInfo($("#tuplpid").val());
					//加载所有房号数据
					queryFanghaoInfo($("#tuplpid").val());
					 setValue(0,"quxianld");
						break;
					case "tab5":
					//加载划分盘信息
					loadLpFuzh();
					//加载地铁信息
					metorInfo();
					//加载学校信息
					loadLpSchoolInfo();
					//加载部门
					showDepart();
					 break;
					case "tab6":
					setValue(0,"quxiancj");
					//加载成交出售
					getChengjiaoInfo(1);
					//加载成交租房数据
					getChengjiaoInfo(2);
						break;
					case "tab7":
					//最新动态
					dirLog();
					
					//点评记录
					dpLpReview();
						break;
				}
				tabStatus[curTabId]=true;
			}
     }
     
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
			url: basepath + "/cam/campus!savelpReview.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"userID" : $("#userID").val(),"lpId":$("#lpReview_lpid").val(),"content":$("#lpReview_content").val()},
			success: function(result){
					if(result.data == "success") {
							jQuery('#lpReview_xz').modal('hide');
							//点评记录
							 dpPage = 1;
							 dpRow = 5;
							dpLpReview();
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
				<jsp:include page="../include/left.jsp" />
			</div>
			<div class="main-content">
			<jsp:include page="../include/top.jsp"/>
				<div class="page-title">

					<div class="breadcrumb-env pull-left">
						<ol class="breadcrumb bc-1">
							<li>
								<a href="<%=basePath%>/console/index.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<li>
							<a href="<%=basePath%>/cam/campus.action?p=xq&k=lp">楼盘管理</a>
							</li>
							<li class="active">
								<strong>小区详细</strong>
							</li>
						</ol>

					</div>

				</div>

				<div id="rootwizard" class="form-wizard">

					<ul class="tabs" id="navtabs">
						<li class="active">
							<a href="#tab1" data-toggle="tab">楼盘信息</a>
						</li>
						<li class="">
							<a href="#tab2" data-toggle="tab">楼盘维护</a>
						</li>
						<li class="">
							<a href="#tab3" data-toggle="tab">楼盘图库</a>
						</li>
						<li class="">
							<a href="#tab4" data-toggle="tab">栋座资料</a>
						</li>
						<li class="">
							<a href="#tab5" data-toggle="tab">配套设施</a>
						</li>
						<li class="">
							<a href="#tab6" data-toggle="tab">成交记录</a>
						</li>
						<li class="">
							<a href="#tab7" data-toggle="tab">动态信息</a>
						</li>
					</ul>

					<div class="progress-indicator" style="width: 0%;">
						<span></span>
					</div>

					<div class="panel">
						<div class="tab-content">

							<!-- Tabs Content -->
							<div class="tab-pane active" id="tab1">
								<h4>基础信息</h4>
								<hr>
								<div class="row">
									<input type="hidden" name="tuplpid" id="tuplpid" value="${loadLpxx.id}">
									<input type="hidden" name="wyxx.xhjLpxx.id" id="wuyelpid" value="${loadLpxx.id}"/>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">城市：${loadLpxxVo.cityName}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">城区：${loadLpxxVo.qyName}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">商圈：${loadLpxxVo.sqName}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">用途：${loadLpxxVo.yongTuStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">楼盘类型：${loadLpxxVo.ltypeStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">楼盘名称：${loadLpxx.lpName}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">别名：${loadLpxx.bieMing}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">完成度：★ ★ ★ ☆ ☆</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">楼盘地址：${loadLpxx.address}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">地图坐标：${loadLpxx.x},${loadLpxx.y}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">行政地址：${loadLpxx.xzgx}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">环线位置：${loadLpxxVo.linkLocAtionStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">产权地址：${loadLpxx.propertyAddress}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">锁盘：${loadLpxxVo.spStr}</div>
									<div class="form-group col-lg-12 col-xs-12 col-md-12">备注：${loadLpxx.beiZ}</div>
								</div>
								<h4>拓展信息</h4>
								<hr>
								<div class="row">
							  	    <div class="form-group col-lg-3 col-xs-6 col-md-4">占地面积：${loadLpxx.sumZd}㎡</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">建筑面积：${loadLpxx.sumJz}㎡</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">建筑年代：${loadLpxxVo.buildingAgeStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">容积率：${loadLpxx.rjl}%</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">绿化率：${loadLpxx.lhl}%</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">总栋数：${loadLpxx.djs}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">总户数：${loadLpxx.hjs}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">入住总户数：${loadLpxx.rzhs}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">所获奖项：${loadLpxx.lpJiangX}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">小区群：${loadLpxx.qq}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">得房率：${loadLpxx.roomRate}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">街道办事处：${loadLpxx.jieDao}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">人车分离：${loadLpxxVo.renCheStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">内部设施：${loadLpxxVo.propertySupporting}</div>
									<div class="form-group col-lg-12 col-xs-12 col-md-12">楼盘简介：${loadLpxx.more}</div>
									<div class="form-group col-lg-12 col-xs-12 col-md-12">车库说明：${loadLpxx.PNum}</div>
								</div>
								<h4>权属信息</h4>
								<hr>
								<div class="row">
									<div class="form-group col-lg-3 col-xs-6 col-md-4">土地使用年限：${loadLpxxVo.propertyAgeStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">权属：${loadLpxxVo.propertyInfoStr}</div>
								</div>
								<h4>配套信息</h4>
								<hr>
								<div class="row">
									<div class="form-group col-lg-3 col-xs-6 col-md-4">供气方式：${loadLpxxVo.airSupplyStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">采暖方式：${loadLpxxVo.heatingWayStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">供水方式：${loadLpxxVo.waterSupplyStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">供电方式：${loadLpxxVo.powerSupplyStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">通讯配置：${loadLpxxVo.configurationStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">社区安全设置：${loadLpxxVo.communitySafetyStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">门窗材料：${loadLpxxVo.materialsStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">电梯品牌：${loadLpxxVo.brandStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">外墙处理方式：${loadLpxxVo.facadesProcessingStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">建筑类型：${loadLpxxVo.buildingTypeStr}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">建筑结构：${loadLpxxVo.buildingStructure}</div> 
								</div>
								<h4>系统配置</h4>
								<hr>
								<div class="row">
									<div class="form-group col-lg-3 col-xs-6 col-md-4">系统报价单价：${loadLpxx.price}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">开盘起价：${loadLpxx.openingPrice}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">开盘均价：${loadLpxx.openingAvgPrice}</div>
									<div class="form-group col-lg-3 col-xs-6 col-md-4">当前均价：${loadLpxx.avgPrice}</div>
								</div>
							</div>

							<div class="tab-pane" id="tab2">
								<h4>楼盘维护</h4>
								<hr>
								<div class="panel panel-default">
									<div class="panel-heading">
										<div class="panel-options pull-left">
											<ul class="nav nav-tabs">
												<li class="active">
													<a href="#tab-1" data-toggle="tab">维护单位</a>
												</li>
												<li>
													<a href="#tab-2" data-toggle="tab">居住成本</a>
												</li>
												<li>
													<a href="#tab-3" data-toggle="tab">楼盘专家</a>
												</li>
											</ul>
										</div>
									</div>

									<div class="panel-body">
										<div class="tab-content">
											<div class="tab-pane active" id="tab-1">
												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<th>类型</th>
																<th>企业单位名称</th>
																<th>联系方式</th>
																<th>单位地址</th>
																<th>备注</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="maintainHtml">
														</tbody>
													</table>
												</div>
											</div>

											<div class="tab-pane" id="tab-2">
												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<th>费用类型</th>
																<th>计收方式</th>
																<th>金额/单价</th>
																<th>计量单位</th>
																<th>备注</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="costsHtml">
														</tbody>
													</table>
												</div>
											</div>

											<div class="tab-pane" id="tab-3">

												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<th>日期</th>
																<th>门店名称</th>
																<th>专家姓名</th>
																<th>联系方式</th>
																<th>门店地址</th>
																<th>备注</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="tbodyDataqueryLpzj">
														</tbody>
													</table>
												</div>
												<div id="macPagequeryLpzj"></div>
											</div>

										</div>

									</div>
								</div>
								<div class="clearfix"></div>
							</div>

							<div class="tab-pane" id="tab3">
								<div class="panel panel-default">
								<div class="panel-heading">
									<ul class="nav nav-tabs">
										<li class="active"><a href="" data-toggle="tab"><h2>小区图库</h2></a>
										</li>
									</ul>
								</div>

								<div class="panel-body">
									<form role="form" class="form-horizontal" id="lpimageForm">
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3">全部图片</label>
											<div class="col-sm-8">
												<div class="panel-heading">
													<ul class="quanbu nav nav-tabs">
														<li class="active"><a href="#ulHouseExclusiveFiles3" data-toggle="tab">环境图</a></li>
														<li><a href="#ulHouseExclusiveFiles1" data-toggle="tab">户型图</a></li>
														<li><a href="#ulHouseExclusiveFiles2" data-toggle="tab">交通图</a></li>
														<li><a href="#ulHouseExclusiveFiles4" data-toggle="tab">样板图</a></li>
														<li><a href="#ulHouseExclusiveFiles5" data-toggle="tab">效果图</a></li>
													</ul>
												</div>
												<div class="tab-content">
													<div class="tab-pane active" id="ulHouseExclusiveFiles3">
														<div class="panel-body">
														</div>
													</div>
													<div class="tab-pane" id="ulHouseExclusiveFiles2">
														<div class="panel-body">
														</div>
													</div>
													<div class="tab-pane" id="ulHouseExclusiveFiles1">
														<div class="panel-body">
														</div>
													</div>
													<div class="tab-pane" id="ulHouseExclusiveFiles4">
														<div class="panel-body">
														</div>
													</div>
													<div class="tab-pane" id="ulHouseExclusiveFiles5">
														<div class="panel-body">
														</div>
													</div>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
								<div class="clearfix"></div>
							</div>
							<div class="tab-pane" id="tab4">
								<h4>栋座资料</h4>
								<hr>
								<div class="panel panel-default">
								<% List list = (List)request.getAttribute("fhCount"); %>
									<div class="col-lg-3 col-xs-6 col-md-3">
										<div class="xe-widget xe-counter">
											<div class="xe-widget xe-counter-block">
												<div class="xe-label">
													<h3>小区在售<%=list.get(0)%>套</h3>
													<h5 class="plr">内部系统：<%=list.get(1)%>套</h5>
													<h5 class="plr">合作网站：<%=list.get(2)%>套</h5>
													<h4>环比上月<b class="plr">上涨</b><%=list.get(3)%>%</h4>
												</div>
											</div>
										</div>
									</div>

									<div class="col-lg-3 col-xs-6 col-md-3">
										<div class="xe-widget xe-counter">
											<div class="xe-widget xe-progress-counter xe-progress-counter-pink">
												<div class="xe-label">
													<h3>小区在租<%=list.get(4)%>套</h3>
													<h5 class="plr">内部系统：<%=list.get(5)%>套</h5>
													<h5 class="plr">合作网站：<%=list.get(6)%>套</h5>
													<h4>环比上月<b class="plr">上涨</b><%=list.get(7)%>%</h4>
												</div>
											</div>
										</div>
									</div>

									<div class="col-lg-3 col-xs-6 col-md-3">
										<div class="xe-widget xe-counter">
											<div class="xe-widget xe-counter-block xe-counter-block-blue">
												<div class="xe-label">
													<h3>小区空置<%=list.get(8)%>套</h3>
													<h5 class="plr">内部系统：<%=list.get(9)%>套</h5>
													<h5 class="plr">合作网站：<%=list.get(10)%>套</h5>
													<h4>环比上月<b class="plr">上涨</b><%=list.get(11)%>%</h4>
												</div>
											</div>
										</div>
									</div>

									<div class="clearfix"></div>
								</div>
								<h4><span class="pull-right f12 plr">更新日期：<%=list.get(20)%></span><span class="pull-right f12 plr">数据来源：新环境房屋系统</span>小区房屋走势</h4>
								<hr>
								<div class="panel panel-default">
									<div class="panel-heading">
										<div class="panel-options pull-left">
											<ul class="nav nav-tabs">
												<li class="active">
													<a href="#tab-11" data-toggle="tab" onclick="setValue(0,'quxianld')">全部</a>
												</li>
												<li>
													<a href="#tab-12" data-toggle="tab" onclick="setValue(1,'quxianld')">在售</a>
												</li>
												<li>
													<a href="#tab-13" data-toggle="tab" onclick="setValue(2,'quxianld')">在租</a>
												</li>
											</ul>
										</div>
									</div>
							<div id="quxianld"></div>
								</div>
								<div style="height: 10px;"></div>
								<div class="table-responsive">
									<table class="table table-bordered table-striped">
										<thead>
											<tr>
												<th class="text-center">序号</th>
												<th class="text-center">栋座</th>
												<th class="text-center">总数</th>
												<th class="text-center">出售数</th>
												<th class="text-center">出租数</th>
												<th class="text-center">空置数</th>
											</tr>
										</thead>
										<tbody class="middle-align" id="fangHInfo">
										</tbody>
									</table>
									<div id="macPageWidget"></div>
								</div>

							</div>

							<div class="tab-pane" id="tab5">

								<h3>配套设施</h3>
								<hr>
								<div class="panel panel-default">
									<!-- Add class "collapsed" to minimize the panel -->
									<div class="panel-heading">
										<div class="panel-options pull-left">
											<ul class="nav nav-tabs">
												<li class="active">
													<a href="#tab-001" data-toggle="tab">划片学校</a>
												</li>
												<li class="">
													<a href="#tab-002" data-toggle="tab">服务网点</a>
												</li>
												<li class="">
													<a href="#tab-003" data-toggle="tab">地铁</a>
												</li>
												<li class="">
													<a href="#tab-004" data-toggle="tab">地图配套</a>
												</li>
											</ul>
										</div>
									</div>
									<div class="panel-body">
										<div class="tab-content">
											<div class="tab-pane active" id="tab-001">
												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<th>学校类型</th>
																<th>学校名称</th>
																<th>划片范围</th>
																<th>划片类型</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="lpSchoolInfo">
													</tbody>
													</table>
												</div>
											</div>
											<div class="tab-pane" id="tab-002">
												<div class="row">
													<div class="col-lg-3 col-md-3 col-sm-3">
														<div class="form-group">
														<div class="input-group input-group-sm input-group-minimal">
															<span class="input-group-addon">服务范围：</span> 
															<select class="form-control" id="serFindFw">
																<option value="0">请选择</option>
																<option value="1">责任盘</option>
																<option value="2">维护盘</option>
																<option value="3">范围盘</option>
															</select>
														</div>
													</div>
													</div>
													<div class="col-lg-3 col-md-3 col-sm-3">
														<div class="form-group">
														<div
															class="input-group input-group-sm input-group-minimal">
															<span class="input-group-addon">服务网点：</span>
															<select class="form-control s2example-1" id="serviceWD">
															</select>
														</div>
													</div>
													</div>
													<div class="col-lg-3 col-md-3 col-sm-3">
														<div class="form-group">
															<button class="btn btn-secondary" onclick="loadLpFuzh()">查询</button>
														</div>
													</div>
												</div>
												<div class="clearfix"></div>
												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<th>服务范围</th>
																<th>服务来源</th>
																<th>服务网店（店组）</th>
																<th>网点地址</th>
																<th>服务电话</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="showLpHuaPanInfo">
														</tbody>
														</table>
												</div>
												<div id="macPageWidgetWd"></div>
											</div>
											<div class="tab-pane" id="tab-003">
												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<th>序号</th>
																<th>路线</th>
																<th>名称</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="metorInfo">
													</tbody>
													</table>
												</div>
											</div>
											<div class="tab-pane" id="tab-004">
												<div class="tab-content" >
												<jsp:include page="../include/zhoubiansousuo.jsp?x=${loadLpxx.x}&y=${loadLpxx.y}"></jsp:include>
												</div>
											</div>

										</div>

									</div>
								</div>
							</div>
							<div class="tab-pane" id="tab6">
								<h3>成交记录</h3>
								<hr>
								<div class="panel-heading">
										<div class="panel-heading">
									<ul class="nav nav-tabs" >
										<li class="active"><a href="#ershoufan" data-toggle="tab">
												<span class="visible-xs"><i class="fa-home"></i></span> <span
												class="hidden-xs">二手房</span>
										</a></li>
										<li><a href="#zufan" data-toggle="tab" onclick="setValue(0,'quxiancjcz')"> <span
												class="visible-xs"><i class="fa-user"></i></span> <span
												class="hidden-xs" >租房</span>
										</a></li>
									</ul>
									</div>
								</div>
								<div class="panel-body">
									<div class="tab-content">
										<div class="tab-pane active" id="ershoufan">
											<div class="panel panel-default">
												<div class="col-lg-3 col-xs-6 col-md-3">
													<div class="xe-widget xe-counter">
													<div class="xe-widget xe-counter-block">
														<div class="xe-label">
															<h3>小区成交量</h3>
															<h4><%=list.get(12)%>套</h4>
															<h4>环比上月<b class="plr">上涨</b><%=list.get(13)%>%</h4>
														</div>
													</div>
													</div>
												</div>
												
												<div class="col-lg-3 col-xs-6 col-md-3">
													<div class="xe-widget xe-counter">
													<div class="xe-widget xe-progress-counter xe-progress-counter-pink">
														<div class="xe-label">
															<h3>小区成交均价</h3>
															<h4><%=list.get(16)%>元/平方</h4>
															<h4>环比上月<b class="plr">上涨</b><%=list.get(18)%>%</h4>
														</div>
													</div>
													</div>
												</div>
												
												<div class="clearfix"></div>
											</div>
											<h4><span class="pull-right f12 plr">更新日期：<%=list.get(20)%></span><span class="pull-right f12 plr">数据来源：新环境房屋系统</span>小区房屋走势</h4>
											<hr>
											
											<div class="panel panel-default">
									<div class="panel-heading">
										<div class="panel-options pull-left">
										<input type="hidden" id ="tabValue"> 
											<ul class="nav nav-tabs">
												<li class="active">
													<a href="#"  data-toggle="tab" id="quanbu" onclick="setValue(0,'quxiancj')">全部</a>
												</li>
												<li>
													<a href="#" data-toggle="tab" id="yiju" onclick="setValue(1,'quxiancj')">一居</a>
												</li>
												<li>
													<a href="#"  data-toggle="tab" id="erju" onclick="setValue(2,'quxiancj')">二居</a>
												</li>
												<li>
													<a href="#"  data-toggle="tab" id="sanju" onclick="setValue(3,'quxiancj')">三居</a>
												</li>
												<li>
													<a href="#" data-toggle="tab" id="qita" onclick="setValue(4,'quxiancj')">其他</a>
												</li>
											</ul>
										</div>
									</div>
									<div id="quxiancj"></div>
								</div>
												
											<div style="height: 10px;"></div>
											<h4>小区成交记录</h4>
											<hr>
											<div class="table-responsive">
												<table class="table table-bordered table-striped">
													<thead>
														<tr>
															<th class="text-center">房屋户型</th>
															<th class="text-center">房屋编号</th>
															<th class="text-center">房源编号</th>
															<th class="text-center">合同编号</th>
															<th class="text-center">面积</th>
															<th class="text-center">签约时间</th>
															<th class="text-center">成交价</th>
															<th class="text-center">成交单价</th>
															<th class="text-center">经纪人</th>
															<th class="text-center">数据来源</th>
														</tr>
													</thead>
													<tbody class="ershoufan">
													</tbody>
												</table>
											</div>
										<div class="text-center" style="color: #0033CC;">
											<button onclick="getChengjiaoInfo(1)">查看更多成交记录</button>
										</div>
										</div>
										<div class="tab-pane" id="zufan">
													<div class="panel panel-default">
												<div class="col-lg-3 col-xs-6 col-md-3">
													<div class="xe-widget xe-counter">
													<div class="xe-widget xe-counter-block">
														<div class="xe-label">
															<h3>小区成交量</h3>
															<h4><%=list.get(14)%>套</h4>
															<h4>环比上月<b class="plr">上涨</b><%=list.get(15)%>%</h4>
														</div>
													</div>
													</div>
												</div>
												
												<div class="col-lg-3 col-xs-6 col-md-3">
													<div class="xe-widget xe-counter">
													<div class="xe-widget xe-progress-counter xe-progress-counter-pink">
														<div class="xe-label">
															<h3>小区成交均价</h3>
															<h4><%=list.get(17)%>元/月</h4>
															<h4>环比上月<b class="plr">上涨</b><%=list.get(19)%>%</h4>
														</div>
													</div>
													</div>
												</div>
												
												<div class="clearfix"></div>
											</div>
											<h4><span class="pull-right f12 plr">更新日期：<%=list.get(20)%></span><span class="pull-right f12 plr">数据来源：新环境房屋系统</span>小区房屋走势</h4>
											<hr>
											<div class="panel-heading">
										<div class="panel-options pull-left">
										<input type="hidden" id ="tabValue"> 
											<ul class="nav nav-tabs">
												<li class="active">
													<a href="#"  data-toggle="tab"  onclick="setValue(0,'quxiancjcz')">全部</a>
												</li>
												<li>
													<a href="#" data-toggle="tab"  onclick="setValue(1,'quxiancjcz')">一居</a>
												</li>
												<li>
													<a href="#"  data-toggle="tab"  onclick="setValue(2,'quxiancjcz')">二居</a>
												</li>
												<li>
													<a href="#"  data-toggle="tab"  onclick="setValue(3,'quxiancjcz')">三居</a>
												</li>
												<li>
													<a href="#" data-toggle="tab"  onclick="setValue(4,'quxiancjcz')">其他</a>
												</li>
											</ul>
										</div>
									</div>
											<div id="quxiancjcz"></div>
											<div style="height: 10px;"></div>
											<h4>小区成交记录</h4>
											<hr>
											<div class="table-responsive">
												<table class="table table-bordered table-striped">
													<thead>
														<tr>
															<th class="text-center">房屋户型</th>
															<th class="text-center">房屋编号</th>
															<th class="text-center">房源编号</th>
															<th class="text-center">合同编号</th>
															<th class="text-center">面积</th>
															<th class="text-center">签约时间</th>
															<th class="text-center">装修标准</th>
															<th class="text-center">成交单价(每月租金)</th>
															<th class="text-center">经纪人</th>
															<th class="text-center">数据来源</th>
														</tr>
													</thead>
													<tbody class="zufan">
													</tbody>
												</table>
											</div>
											<div class="text-center" id="rentShowAdd" style="color: #0033CC;">
												<button onclick="getChengjiaoInfo(2)">查看更多成交记录</button>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="tab-pane" id="tab7">
								<h3>动态信息</h3>
								<hr>
								<div class="panel panel-default panel-tabs">
									<!-- Add class "collapsed" to minimize the panel -->
									<div class="panel-heading">
										<div class="panel-options pull-left">
											<ul class="nav nav-tabs">
												<li class="active">
													<a href="#dongtai1" data-toggle="tab">点评记录</a>
												</li>
												<li class="">
													<a href="#dongtai2" data-toggle="tab">最新动态</a>
												</li>
											</ul>
										</div>
									</div>
									<div class="panel-body">
										<div class="tab-content">
											<div class="tab-pane active" id="dongtai1">
												<div>
													<button class="btn btn-secondary" onclick="lpReviewxz(${loadLpxx.id})"><i class="fa-plus"></i> 新增点评 </button>
												</div>
												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<th class="col-lg-1">点评人</th>
																<th>点评部门</th>
																<th>点评内容</th>
																<th>点评时间</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="LpReview">
														</tbody>
													</table>
												</div>
												<div class="text-center" id="rentShowAdd" style="color: #0033CC;">
													<button onclick="dpLpReview()">查看更多点评记录</button>
												</div>
											</div>
											<div class="tab-pane" id="dongtai2">
												<div class="table-responsive">
													<table class="table table-striped">
										                <thead>
										                  <tr>
										                    <th colspan="2">操作人</th>
										                    <th class="col-md-4">操作记录</th>
										                    <th width="200">操作时间</th>
										                  </tr>
										                </thead>
										                 <tbody class="dirLog">
							               				 </tbody>
										              </table>
													</div>
												<div class="text-center" id="rentShowAdd" style="color: #0033CC;">
													<button onclick="dirLog()">查看更多最新动态</button>
												</div>
											</div>
										</div>
									</div>
								</div>
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

<!-- Imported styles on this page -->
<link rel="stylesheet" href="<%=basePath%>/assets/js/daterangepicker/daterangepicker-bs3.css">
<link rel="stylesheet" href="<%=basePath%>/assets/js/select2/select2.css">
<link rel="stylesheet" href="<%=basePath%>/assets/js/select2/select2-bootstrap.css">
<link rel="stylesheet" href="<%=basePath%>/assets/js/multiselect/css/multi-select.css">

<!-- Bottom Scripts -->
<script src="<%=basePath%>/assets/js/bootstrap.min.js"></script>
<script src="<%=basePath%>/assets/js/TweenMax.min.js"></script>
<script src="<%=basePath%>/assets/js/resizeable.js"></script>
<script src="<%=basePath%>/assets/js/joinable.js"></script>
<script src="<%=basePath%>/assets/js/xenon-api.js"></script>
<script src="<%=basePath%>/assets/js/xenon-toggles.js"></script>
<script src="<%=basePath%>/assets/js/moment.min.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/daterangepicker/daterangepicker.js"></script>
<script src="<%=basePath%>/assets/js/datepicker/bootstrap-datepicker.js"></script>
<script src="<%=basePath%>/assets/js/timepicker/bootstrap-timepicker.min.js"></script>
<script src="<%=basePath%>/assets/js/colorpicker/bootstrap-colorpicker.min.js"></script>
<script src="<%=basePath%>/assets/js/select2/select2.min.js"></script>
<script src="<%=basePath%>/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="<%=basePath%>/assets/js/selectboxit/jquery.selectBoxIt.min.js"></script>
<script src="<%=basePath%>/assets/js/tagsinput/bootstrap-tagsinput.min.js"></script>
<script src="<%=basePath%>/assets/js/typeahead.bundle.js"></script>
<script src="<%=basePath%>/assets/js/handlebars.min.js"></script>
<script src="<%=basePath%>/assets/js/multiselect/js/jquery.multi-select.js"></script>

<!-- JavaScripts initializations and stuff -->
<script src="<%=basePath%>/assets/js/xenon-custom.js"></script>
<link rel="stylesheet" href="<%=basePath%>/assets/js/datepicker/bootstrap-datetimepicker.min.css">
<!-- Imported scripts on this page  xiala-->
<script type="text/javascript" src="<%=basePath%>/assets/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/datepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<!-- JavaScripts initializations and stuff -->
<script src="<%=basePath%>/assets/js/xenon-custom.js"></script>
<script type="text/javascript" src="<%=basePath%>/assets/images/new_file.js"></script>

<script type="text/javascript">
	$('.form_date').datetimepicker({
	        language: 'zh-CN',
	        weekStart: 1,
	        todayBtn: 1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0
	    });
	    
	    $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd:hh:ii',language: 'zh-CN',});
</script>

<!-- JavaScripts initializations and stuff -->
<script src="<%=basePath%>/assets/js/xenon-custom.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($)
	{
		$(".s2example").select2({
			placeholder: 'Select your country...',
			allowClear: true
		}).on('select2-open', function()
		{
			// Adding Custom Scrollbar
			$(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
		});
		
	});
</script>

<script type="text/javascript">
	// Sample Javascript code for this page
	jQuery(document).ready(function($) {
		// Delete Modal
	$('a[data-action="trash"]').on('click', function(ev) {
		ev.preventDefault();
		$("#gallery-image-delete-modal").modal('show');
	});
		// Sortable		//.gallery-env 
		$('.panel-body a[data-action="sort"]').on('click', function(ev) {
			ev.preventDefault();
			var is_sortable = $(".album-images").sortable('instance');
			if (!is_sortable) {
				$(".gallery-env .album-images").sortable({
					items: '> div'
				});
				$(".album-sorting-info").stop().slideDown(300);
			} else {
				$(".album-images").sortable('destroy');
				$(".album-sorting-info").stop().slideUp(300);
			}
		});
	});
</script>

<!-- Gallery Modal Image -->
<div class="modal fade" id="gallery-image-modal" data-backdrop="static">
	<div class="modal-dialog" style="width:600px;heigth:450px">
		<div>
			<div class="modal-gallery-image">
<!-- 				<img src="../assets/images/tupian.jpg"  id="editimg" class="img-responsive" /> -->
			</div>
<!-- 			<div class="modal-body"> -->
<!-- 				<div class="row"> -->
<!-- 					<div class="col-md-12"> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label for="field-1" class="control-label">名称</label> -->
<!-- 							<input type="text" class="form-control" id="field-1" placeholder="输入图片标题"> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="modal-gallery-top-controls" style="margin-left:300px">
				<button type="button" class="btn btn-xs btn-secondary"  onclick="zuoxuanzhuan($('#editimg'))">左旋转（90°）</button>
				<button type="button" class="btn btn-xs btn-secondary" onclick="youxuanzhuan($('#editimg'))">右旋转（90°）</button>
				<button type="button" class="btn btn-xs btn-white" data-dismiss="modal" onclick="closeImage()">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- 图库删除图像（确认）-->
<div class="modal fade" id="gallery-image-delete-modal" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<h4 class="modal-title">确认图像删除</h4>
			</div>

			<div class="modal-body">
				你真的要删除这个图片吗？
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-danger">删除</button>
				<button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal 4 (幻灯片)-->
<div class="modal fade" id="huandengpian" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">图库</h4>
			</div>
			<div class="modal-body">
				<div class='Homeslide'>
					<div class='Homeslide_bigwrap'>
						<div class='Homeslide_hand0'></div>
						<div class='Homeslide_hand1'></div>
						<div class='Homeslide_bigpicdiv'>
							<a href='#'><img src=""></a>
						</div>
					</div>
					<div class="hidden-xs">
						<div class='Homeslide_thumb'>
							<ul>loading...</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
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

