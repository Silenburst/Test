<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
			UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
	long timeMillis = System.currentTimeMillis();

	String BMSPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/BMS";
	String id = request.getParameter("id");
	String type = request.getParameter("type");
	String houseType = request.getParameter("houseType");
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
		<link rel="stylesheet" href="../assets/js/select2/select2.css">
		<link rel="stylesheet" href="../assets/js/select2/select2-bootstrap.css">
		<link rel="stylesheet" href="../assets/js/select2/select2-bootstrap.css">
		<link rel="stylesheet" href="../assets/js/multiselect/css/multi-select.css">
		
		<script src="./common.js?_t=<%=timeMillis%>"></script>
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		<script src="./jquery.timers-1.2.js"></script>
		
		<script src="../assets/js/page.js"></script>
		<script src="../assets/js/bootbox/bootbox.min.js"></script>
		<script src="../js/ajaxpage/pagination.js"></script>
		<script src="../assets/js/select2/select2.min.js"></script>
		<script src="../assets/js/select2/select2_locale_zh-CN.js"></script>
		<script src="../assets/js/xenon-custom.js"></script>
		<script src="../js/jquery.form.js"></script>
		<script type="text/javascript" src="../js/plupload/plupload.full.min.js"></script>
		<script type="text/javascript" src="../js/plupload/i18n/zh_CN.js"></script>

		<style>
			.radioLabel { padding-right: 20px; }
			.btnMultiselect { padding: 0px;font-size: 12px; }
			.errorLabel { padding: 4px;margin: 0px; display: none; }
			.img-thumbnail { width: 100px; height: 100px; padding: 0px; }
			.coverButton { margin: 5px 0px 0px 15px; border: 0px; color: #ffffff; background-color: #07b207; }
		</style>
</head>
<body class="page-body">
<iframe id="iframe" src="http://xhjbms.xhjfw.com:8963/BMS/system/ssoAction!openSSOUrl.action?ssoTargetUrl=http://42.96.137.195:8280/CloudPlatformWeb/sec/fedservlet" style="display: none;"></iframe>

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
						<a href="../index.html"><i class="fa-home"></i>首页</a>
					</li>
					<li>
						<span>房源采集</span>
					</li>
					<li class="active">
						<strong>出售秒发</strong>
					</li>
				</ol>
			</div>
		</div>
		
		<div class="panel">

				<form role="form" class="form-horizontal" id="postform" method="post" enctype="multipart/form-data">
				<div class="row">

					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">基本信息</h3>
								<div class="panel-options">
									<a href="#" data-toggle="panel"> <span class="collapse-icon">&ndash;</span> <span class="expand-icon">+</span> </a> </div>
							</div>

							<div class="panel-body">
									<br>
									<div class="messager messager-example messager-success">
										<div class="messager-content">
											<i class="icon-ok-sign"></i> 温馨提示：复制互联网房源。(本功能暂时只支持复制58同城、链家、搜房网、安居客、0731房产网的房源)
											<button type="button" class="btn-danger" onclick="$('#miaolu').modal();">秒录房源</button>
										</div>
										<div class="messager-actions">
											<button type="button" class="close action">×</button>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 小区：</label>
											<div class="col-sm-4">
												<input type="hidden" id="selectXiaoQu" />
											</div>
											<div class="col-sm-2 alert alert-danger errorLabel" role="alert" id="selectXiaoQuLabel">
												<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>请选择一个小区
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 区域：</label>
											<div class="col-sm-2" style="display: none;">
												<select class="form-control sboxit-2" id="cityId">
												</select>
											</div>
											<div class="col-sm-2">
												<select class="form-control sboxit-2" id="qyId" onchange="onQyChange();">
												</select>
											</div>
											<div class="col-sm-2">
												<select class="form-control sboxit-2" id="sqId">
												</select>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 地址：</label>
											<div class="col-sm-6">
												<input type="text" class="form-control"  name="address" id="address" placeholder="">
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 建筑面积：</label>
											<div class="col-sm-2">
												<input type="number" min="1" max="10000" name="area" id="area" class="form-control">
											</div>
											<div class="line32 text-center" style="float: left;">平方米</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 使用面积：</label>
											<div class="col-sm-2">
												<input type="number" min="1" max="10000" name="syarea" id="syarea" class="form-control">
											</div>
											<div class="line32 text-center" style="float: left;">平方米</div>
										</div>
									</div>
									<! -- 住宅、别墅 -->
									<%--<c:if test="${param.hType == 0 || param.hType == 4 || param.useageName == '住宅' || param.useageName == '别墅'}">--%>
									<div class="col-sm-12" id="hxDiv">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 户型：</label>
											<div class="col-sm-1">
												<select class="form-control" name="hx_s" id="hx_s">
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
													<option value="9">9</option>
												</select>
											</div>
											<div class="line32 text-center" style="width: 20px;float: left;">室</div>
											<div class="col-sm-1">
												<select class="form-control" name="hx_t" id="hx_t">
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
												</select>
											</div>
											<div class="line32 text-center" style="width: 20px;float: left;">厅</div>
											<div class="col-sm-1">
												<select class="form-control" name="hx_c" id="hx_c">
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
												</select>
											</div>
											<div class="line32 text-center" style="width: 20px;float: left;">厨</div>
											<div class="col-sm-1">
												<select class="form-control" name="hx_w" id="hx_w">
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
												</select>
											</div>
											<div class="line32 text-center" style="width: 20px;float: left;">卫</div>
											<div class="col-sm-1">
												<select class="form-control" name="hx_y" id="hx_y">
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
												</select>
											</div>
											<div class="line32 text-center" style="width: 30px;float: left;">阳台</div>
										</div>
									</div>
									<%--</c:if>--%>
									<div class="col-sm-12" id="lcDiv">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 楼层：</label>
											<div class="col-sm-1">
												<input type="number" min="1" max="100" name="lc_d" id="floor_c" class="form-control" placeholder="">
											</div>
											<div class="line32 text-center" style="width: 40px;float: left;">楼&nbsp;,&nbsp;共</div>
											<div class="col-sm-1">
												<input type="number" min="1" max="100" name="lc_z" id="floor_z" class="form-control" placeholder="">
											</div>
											<div class="line32 text-center" style="width: 20px;float: left;">楼</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 价位：</label>
											<div class="col-sm-4">
												<div class=" pull-left">
													<input type="number" class="form-control pull-left"  name="price" id="price" min="0">
												</div>
												<div class=" pull-left">
													<select class="form-control" id="price_unit" disabled="disabled">
														<option>万</option>
														<option>元/月</option>
													</select>
												</div>

											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" >朝向：</label>
											<div class="col-sm-2">
													<select class="form-control sboxit-2" name="direction" id="direction">
														<option value="11">暂无</option>
														<option value="1">东</option>
														<option value="2">南</option>
														<option value="3">西</option>
														<option value="4">北</option>
														<option value="5">东南</option>
														<option value="6">东西</option>
														<option value="7">西南</option>
														<option value="8">西北</option>
														<option value="9">东北</option>
														<option value="10">南北</option>
													</select>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label left" >装修：</label>
											<div class="col-sm-8">
												<label class="radio-inline">
													<input type="radio" name="fitment" value="5"><label class="radioLabel">豪华装修</label>
													<input type="radio" name="fitment" value="4"><label class="radioLabel">精装修</label>
													<input type="radio" name="fitment" checked="true" value="3"><label class="radioLabel">中等装修</label>
													<input type="radio" name="fitment" value="2"><label class="radioLabel">简装修</label>
													<input type="radio" name="fitment" value="1"><label class="radioLabel">毛坯</label>
												</label>
											</div>
										</div>
									</div>
									<div class="col-sm-12" id="lcDiv">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 建造年代：</label>
											<div class="col-sm-2">
												<input type="number" name="propertyYear" id="propertyYear" class="form-control" placeholder="" value="2000">
											</div>
											<div class="line32 text-center" style="float: left;">年</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 房源标签：</label>
											<div class="col-sm-6">
												<select id="label" multiple="multiple" style="width: 500px; "></select>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 58配套设施：</label>
											<div class="col-sm-6">
												<select id="wubalabel" multiple="multiple" style="width: 500px; "></select>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" >一句话广告：</label>
											<div class="col-sm-6">
												<input type="text" class="form-control" id="yijuhuaguanggao" placeholder="">
											</div>
										</div>
									</div>
								<div class="clearfix"></div>
							</div>
						</div>

						<c:set var="displayName" value=""/>
						<c:choose>
							<c:when test="${param.hType == 0 || param.useageName == '住宅' || param.useageName == '高端住宅' }">
								<c:set var="displayName" value="住宅信息"/>
							</c:when>
							<c:when test="${param.hType == 1 || param.useageName == '写字楼'}">
								<c:set var="displayName" value="写字楼信息"/>
							</c:when>
							<c:when test="${param.hType == 2 || param.useageName == '商铺'}">
								<c:set var="displayName" value="商铺信息"/>
							</c:when>
							<c:when test="${param.hType == 4 || param.useageName == '别墅'}">
								<c:set var="displayName" value="别墅信息"/>
							</c:when>
						</c:choose>
						<c:if test="${param.hType == 0 || param.hType == 4 || param.useageName == '住宅' || param.useageName == '别墅' || param.useageName == '高端住宅'}">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">${displayName}</h3>
								<div class="panel-options">
									<a href="#" data-toggle="panel"> <span class="collapse-icon">&ndash;</span> <span class="expand-icon">+</span> </a> </div>
							</div>
							<div class="panel-body">
								<form role="form" class="form-horizontal">
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" >房屋类别：</label>
											<div class="col-sm-8">
												<label class="radio-inline">
													<input type="radio" name="houseType" value="1" checked="checked"><label class="radioLabel">普通住宅</label>
													<input type="radio" name="houseType" value="2" ><label class="radioLabel">公寓</label>
													<input type="radio" name="houseType" value="4" ><label class="radioLabel">平房</label>
													<input type="radio" name="houseType" value="3" ><label class="radioLabel">别墅</label>
													<input type="radio" name="houseType" value="5" ><label class="radioLabel">其它</label>
													<input type="radio" name="houseType" value="7"><label class="radioLabel">商住两用</label>
												</label>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 房屋产权：</label>
											<div class="col-sm-2">
												<select class="form-control sboxit-2" name="houseProperty" id="houseProperty">
													<option value="1">商品房</option>
													<option value="2">商住两用</option>
													<option value="3">经济适用房</option>
													<option value="4">使用权</option>
													<option value="5">公房</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 产权年限：</label>
											<div class="col-sm-8">
												<label class="radio-inline">
													<input type="radio" name="propertyAge" value="70" checked="checked"><label class="radioLabel">70年产权</label>
													<input type="radio" name="propertyAge" value="50" ><label class="radioLabel">50年产权</label>
													<input type="radio" name="propertyAge" value="40" ><label class="radioLabel">40年产权</label>
												</label>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 房屋结构：</label>
											<div class="col-sm-8">
												<label class="radio-inline">
													<input type="radio" name="houseStructure" value="1" checked="checked"><label class="radioLabel">板楼</label>
													<input type="radio" name="houseStructure" value="2" ><label class="radioLabel">塔楼</label>
													<input type="radio" name="houseStructure" value="3" ><label class="radioLabel">板塔结合</label>
													<%--<input type="radio" name="houseStructure1" value="40" ><label class="radioLabel">其它</>砖混</label>--%>
													<%--<input type="radio" name="houseStructure1" value="40" ><label class="radioLabel">其它</label>--%>
												</label>
											</div>
										</div>
									</div>
									<div class="clearfix"></div>
							</div>
						</div>
						</c:if>
						<c:if test="${param.hType == 1 || param.useageName == '写字楼'}">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">${displayName}</h3>
								<div class="panel-options">
									<a href="#" data-toggle="panel"> <span class="collapse-icon">&ndash;</span> <span class="expand-icon">+</span> </a> </div>
							</div>
							<div class="panel-body">
								<div class="col-sm-12">
									<div class="form-group">
										<label class="col-sm-2 control-label" >写字楼类别：</label>
										<div class="col-sm-8">
											<label class="radio-inline">
												<input type="radio" name="houseType" value="8" checked="checked"><label class="radioLabel">写字楼</label>
												<input type="radio" name="houseType" value="9" ><label class="radioLabel">商务中心</label>
												<input type="radio" name="houseType" value="10" ><label class="radioLabel">商住公寓</label>
											</label>
										</div>
									</div>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
						</c:if>
						<c:if test="${param.hType == 2 || param.useageName == '商铺'}">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h3 class="panel-title">${displayName}</h3>
									<div class="panel-options">
										<a href="#" data-toggle="panel"> <span class="collapse-icon">&ndash;</span> <span class="expand-icon">+</span> </a> </div>
								</div>
								<div class="panel-body">
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" >商铺类别：</label>
											<div class="col-sm-8">
												<label class="radio-inline">
													<input type="radio" name="houseType" value="11" checked="checked"><label class="radioLabel">商业街卖场</label>
													<input type="radio" name="houseType" value="12" ><label class="radioLabel">写字楼配套</label>
													<input type="radio" name="houseType" value="13" ><label class="radioLabel">住宅底商</label>
													<input type="radio" name="houseType" value="14" ><label class="radioLabel">摊位柜台</label>
													<input type="radio" name="houseType" value="15" ><label class="radioLabel">其他</label>
												</label>
											</div>
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
							</div>
						</c:if>

						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">房源介绍</h3>
								<div class="panel-options">
									<a href="#" data-toggle="panel"> <span class="collapse-icon">&ndash;</span> <span class="expand-icon">+</span> </a> </div>
							</div>
							<div class="panel-body">
								<form role="form" class="form-horizontal">
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 信息标题：</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" name="title" id="title" placeholder="">
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 信息描述：</label>
											<div class="col-sm-8">
										        <textarea id="summary"></textarea>
										    </div>
										</div>
									</div>
								<div class="clearfix"></div>
							</div>
						</div>

						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">图片信息</h3>
								<div class="panel-options">
									<a href="#" data-toggle="panel"> <span class="collapse-icon">&ndash;</span> <span class="expand-icon">+</span> </a>  </div>
							</div>

							<div class="panel-body">
								<form role="form" class="form-horizontal">
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label red" >室内图：</label>
											<div class="col-sm-8">
												<div id="fkContainer" style="margin-bottom: 5px;">
													<input type="button" class="btn btn-success" id="fkPickfiles"  value="上传">
												</div>
												<%--<div data-toggle="modal" data-title="上传" onclick="initUploader();$('#picModal').modal();">
													<img src="../images/11.jpg" width="50px" height="50px"
														 onmouseover="this.src='../images/22.jpg';this.style.cursor='pointer';"
														 onmouseout="this.src='../images/11.jpg';this.style.cursor='default';">
												</div>--%>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label red" ></label>
											<div class="col-sm-8">
												最多8张图片，您可以从我的图库选择，客厅/卧室/厨房等3张以上照片可帮助您获得较好的效果！
											</div>
										</div>

									</div>

									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label red" >房型图：</label>
											<div class="col-sm-8">
												<div style="margin-bottom: 5px;" id="fkContainer1">
													<input type="button" class="btn btn-success" id="fkPickfiles1"  value="上传">
												</div>
												<%--<div data-toggle="modal" data-title="上传" onclick="initUploader();$('#picModal1').modal();">
													<img src="../images/11.jpg" width="50px" height="50px"
														 onmouseover="this.src='../images/22.jpg';this.style.cursor='pointer';"
														 onmouseout="this.src='../images/11.jpg';this.style.cursor='default';">
												</div>--%>
											</div>
										</div>

									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label red" ></label>
											<div class="col-sm-8">
												最多5张图片，您可以从我的图库选择，或者房型图库选择
											</div>
										</div>

									</div>

									
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label red" >小区图：</label>
											<div class="col-sm-8">
												<div style="margin-bottom: 5px;" id="fkContainer2">
													<input type="button" class="btn btn-success" id="fkPickfiles2"  value="上传">
												</div>
												<%--<div data-toggle="modal" data-title="上传" onclick="initUploader();$('#picModal2').modal();">
													<img src="../images/11.jpg" width="50px" height="50px"
														 onmouseover="this.src='../images/22.jpg';this.style.cursor='pointer';"
														 onmouseout="this.src='../images/11.jpg';this.style.cursor='default';">
												</div>--%>
											</div>
										</div>
									</div>

									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label red" ></label>
											<div class="col-sm-8">
												最多8张图片，您可以从我的图库选择，或者小区图库选择
											</div>
										</div>

									</div>
                                  <input type="hidden" id="houseNumber" value=""/>
                                  <input type="hidden" id="houseType" value=""/>
                                  <input type="hidden" id="createTime" value=""/>
                                  <input type="hidden" id="personalFangYuan" value=""/>
                                  <input type="hidden" id="cover" value=""/>
							</div>
						</div>

						<div class="text-center">
							<button type="button" class="btn btn-secondary" onclick="save(0);">下一步</button>
							<button type="button" class="btn btn-secondary" onclick="queryPersonalEntrustHouseForList(1);">保存草稿</button>
						</div>


					</div>
		</div>
			</form>
	</div>
</div>

<div class="modal fade custom-width" id="picModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h5 class="modal-title">上传</h5>
			</div>
			<div class="modal-body" style="height: 300px;overflow-y:auto;" id="containerFiles">
				<div id="fkContainer" style="margin-bottom: 5px;">
					<input type="button" class="btn btn-success" id="fkPickfiles"  value="上传">
				</div>
				<div id="fkFiles"></div>
			</div>
			<div class="modal-header">
				<h5 class="modal-title">上传记录</h5>
			</div>
			<div class="modal-body">
				<div id="fkContainerBox" style="margin-bottom: 5px;height: 100px;overflow-y:auto;"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="saveUserModal('fkContainer','fkFiles','containerFiles','picModal');">保存</button>
				<button type="button" class="btn btn-info" id="addLpSchoolClose" data-dismiss="modal" onclick="emptyPic('fkFiles','containerFiles')">关闭</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade custom-width" id="picModal1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h5 class="modal-title">上传</h5>
			</div>
			<div class="modal-body" style="height: 300px;overflow-y:auto;" id="container1Files">
				<div id="fkContainer1" style="margin-bottom: 5px;">
					<input type="button" class="btn btn-success" id="fkPickfiles1"  value="上传">
				</div>
				<div id="fkFiles1"></div>
			</div>
			<div class="modal-header">
				<h5 class="modal-title">上传记录</h5>
			</div>
			<div class="modal-body">
				<div id="fkContainer1Box" style="margin-bottom: 5px;height: 100px;overflow-y:auto;">

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="saveUserModal('fkContainer1','fkFiles1','container1Files','picModal1');">保存</button>
				<button type="button" class="btn btn-info" id="addLpSchoolClose1" data-dismiss="modal" onclick="emptyPic('fkFiles1','container1Files')">关闭</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade custom-width" id="picModal2">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h5 class="modal-title">上传</h5>
			</div>
			<div class="modal-body" style="height: 300px;overflow-y:auto;" id="container2Files">
				<div id="fkContainer2" style="margin-bottom: 5px;">
					<input type="button" class="btn btn-success" id="fkPickfiles2"  value="上传">
				</div>
				<div id="fkFiles2"></div>
			</div>
			<div class="modal-header">
				<h5 class="modal-title">上传记录</h5>
			</div>
			<div class="modal-body">
				<div id="fkContainer2Box" style="margin-bottom: 5px;height: 100px;overflow-y:auto;">

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="saveUserModal('fkContainer2','fkFiles2','container2Files','picModal2');">保存</button>
				<button type="button" class="btn btn-info" id="addLpSchoolClose2" data-dismiss="modal" onclick="emptyPic('fkFiles2','container2Files')">关闭</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade custom-width" id="miaolu">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h5 class="modal-title">获取房源</h5>
			</div>
			<div class="modal-body">
				<div class="input-group">
					<input type="text" id="miaoluurl" class="form-control" value=""/>
			<span class="input-group-btn">
			  <button class="btn btn-danger" type="button" id="miaolusave" onclick="miaoluSave();">复制</button>
			</span>
				</div>
				<div class="clearfix"></div>
				<div style="height: 10px;"></div>
				<div class="messager messager-example messager-huise">
					<div class="messager-content">
						<i class="icon-exclamation-sign"></i> 贴心提示：
						<br /> 1.本功能暂时只支持复制
						<span style="background-color: #fff;color: #ff5600;">58同城、链家、搜房网、安居客、0731房产网的房源</span>
						<br /> 2.复制成功房源后请注意修改相关信息。
						<br /> 3.由于某些房源信息是公司性质的定制模板，房源描述会不完整，敬请谅解。
						<br /> 4.由于部分网站上的房源照片有logo水印，所以不支持复制照片。
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>

<script type="text/javascript">
var provinceId = "<%=SecurityUserHolder.getCurrentUserLogin().getProvinceId()%>";
var cityId = "<%=SecurityUserHolder.getCurrentUserLogin().getCityId()%>";
var cityName="";
function buildPro(){
	$.ajax({ 
		url: "<%=basePath%>/cam/campus!getCity.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"pid" : provinceId},
		success: function(data){
			$.each(data, function(i,n){
				if(n.id==cityId){
					cityName=n.cityName;
				}
			});
	    }
	});
}

var uid = "<%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>";
var basepath = "<%=basePath%>";

// 第一次登录，未进入云平台，解决单点登录问题
function setUserId(userId){
	uid = userId;
	console.log(uid);
}

function initMiaoLu(){
	var url = cloudPlatformUrl+"/services/newenv/cloub/houseparse/get?type=<%=type%>&id=<%=id%>";
	var result = $.ajax({url:url,async:false});
	if(result.responseText == "")
		return;
	var obj = $.parseJSON(result.responseText);
	$("#postform input[name='address']").val(obj.address);
	$("#postform input[name='area']").val(parseFloat(obj.area));
	$("#postform input[name='syarea']").val(parseFloat(obj.area));
	var hx = obj.rooms;
	var hx_s = hx.match(/[\d]室/g);
	hx_s = hx_s == null ? 0 : parseInt(hx_s);
	var hx_t = hx.match(/[\d]厅/g);
	hx_t = hx_t == null ? 0 : parseInt(hx_t);
	var hx_c = hx.match(/[\d]厨/g);
	hx_c = hx_c == null ? 0 : parseInt(hx_c);
	var hx_w = hx.match(/[\d]卫/g);
	hx_w = hx_w == null ? 0 : parseInt(hx_w);
	var hx_y = hx.match(/[\d]阳台/g);
	hx_y = hx_y == null ? 0 : parseInt(hx_y);
	$("#hx_s").find("option[value='"+hx_s+"']").attr("selected",true);
	$("#hx_t").find("option[value='"+hx_t+"']").attr("selected",true);
	$("#hx_c").find("option[value='"+hx_c+"']").attr("selected",true);
	$("#hx_w").find("option[value='"+hx_w+"']").attr("selected",true);
	$("#hx_y").find("option[value='"+hx_y+"']").attr("selected",true);
	var floor = obj.floor;
	var floor_split = floor.split("/");
	var lc_d = parseInt(floor_split[0])
	var lc_z = parseInt(floor_split[1])
	$("#postform input[name='lc_d']").val(lc_d);
	$("#postform input[name='lc_z']").val(lc_z);
	var price = obj.price.replace(/[^\d^\.]/g,"")
	$("#price").val(price);
	$("#price_unit").get(0).selectedIndex= "<%=type%>" == "fangyuan_chushou" ?  0 : 1;
	var direction = obj.direction;
	$("#direction").find("option[value='"+direction+"']").attr("selected",true);
	$("#summary").val(obj.summary);
	var fitment = obj.fitment;
	if(fitment == "简单装修"){
		fitment = "简装修";
	}
	$("#postform input[name='fitment']").filter(function () { return $(this).val() == fitment; }).attr("checked", true);
	$("#postform input[name='title']").val(obj.title);
	lpName = obj.lpName;
	if(lpName == ""){
		lpName = obj.sqId;
	}
	return lpName;
}

function initShouCangMiaoLu(obj){
	$("#postform input[name='address']").val(obj.address);
	$("#postform input[name='area']").val(parseFloat(obj.area));
	if(obj.syarea == '' || typeof(obj.syarea) == 'undefined'){
		$("#postform input[name='syarea']").val(parseFloat(obj.area));
	}else{
		$("#postform input[name='syarea']").val(parseFloat(obj.syarea));
	}
	var hx = obj.rooms;
	if(typeof(hx) != 'undefined'){
		var hx_s = hx.match(/[\d]室/g);
		hx_s = hx_s == null ? 0 : parseInt(hx_s);
		var hx_t = hx.match(/[\d]厅/g);
		hx_t = hx_t == null ? 0 : parseInt(hx_t);
		var hx_c = hx.match(/[\d]厨/g);
		hx_c = hx_c == null ? 0 : parseInt(hx_c);
		var hx_w = hx.match(/[\d]卫/g);
		hx_w = hx_w == null ? 0 : parseInt(hx_w);
		var hx_y = hx.match(/[\d]阳台/g);
		hx_y = hx_y == null ? 0 : parseInt(hx_y);
		$("#hx_s").find("option[value='"+hx_s+"']").attr("selected",true);
		$("#hx_t").find("option[value='"+hx_t+"']").attr("selected",true);
		$("#hx_c").find("option[value='"+hx_c+"']").attr("selected",true);
		$("#hx_w").find("option[value='"+hx_w+"']").attr("selected",true);
		$("#hx_y").find("option[value='"+hx_y+"']").attr("selected",true);
	}else{
		$("#hx_s").find("option[value='"+obj.hx_s+"']").attr("selected",true);
		$("#hx_t").find("option[value='"+obj.hx_t+"']").attr("selected",true);
		$("#hx_c").find("option[value='"+obj.hx_c+"']").attr("selected",true);
		$("#hx_w").find("option[value='"+obj.hx_w+"']").attr("selected",true);
		$("#hx_y").find("option[value='"+obj.hx_y+"']").attr("selected",true);
	}
	$("#direction").find("option[value='"+obj.directionType+"']").attr("selected",true);
	$("#postform input[name='fitment']").filter(function () { return $(this).val() == obj.fitmentType; }).attr("checked", true);
	$("#postform input[name='title']").val(obj.title);
	$("#postform input[name='houseType'][value='"+obj.houseType+"']").attr("checked","checked");
	$("#postform input[name='propertyAge'][value='"+obj.propertyAge+"']").attr("checked","checked");
	var floor = obj.floor;
	if(typeof(floor) != 'undefined'){
		var floor_split = floor.split("/");
		var lc_d = parseInt(floor_split[0]);
		var lc_z = parseInt(floor_split[1]);
		$("#floor_c").val(lc_d);
		$("#floor_z").val(lc_z);
	}else{
		$("#floor_c").val(obj.floor_c);
		$("#floor_z").val(obj.floor_z);
	}
	var price = obj.price.replace(/[^\d^\.]/g,"")
	$("#price").val(price);
	$("#summary").val(obj.summary);
	$("#yijuhuaguanggao").val(obj.yijuhuaguanggao);
	$("#houseNumber").val(obj.houseNumber);
	$("#houseType").val(obj.type);
	$("#createTime").val(obj.createtime);
	$("#houseProperty").find("option[value='"+obj.houseProperty+"']").attr("selected",true);
	$("#propertyYear").val(obj.propertyYear);
	$("#postform input[name='houseStructure'][value='"+obj.houseStructure+"']").attr("checked","checked");
	$("#cover").val(obj.cover);

	var s_picture_array =  obj.s_picture.split(",");
	var s_picture_tag = "";
	var s_picture_imgtag = "";
	var j = 0;
	$.each(s_picture_array,function(i,pic){
		var timeStamp = new Date().getTime();
		timeStamp = timeStamp + j;
		if($.trim(pic) != ""){
			s_picture_tag += "<input type='hidden' name='s_picture' value='"+pic+"' id='pic"+timeStamp+"'/>";
			var img = cloudPicUrl+pic;
			s_picture_imgtag += '<div class="album-image col-lg-2"  id="img'+timeStamp+'"><img class="img-thumbnail" src="'+img+'" />';
			s_picture_imgtag += '<div class="text-center"><a href="javascript:void(0)" onclick="deleteImg(\''+timeStamp+'\');">删除</a></div>';
			s_picture_imgtag += '<div style=" position:absolute; bottom:20px;  height:40px; width:100px;border-bottom-right-radius: 6px; border-bottom-left-radius: 6px;">';
			s_picture_imgtag += '<button type="button" onclick="setCover(\''+pic+'\',this);" class="coverButton" id="'+pic+'">设为封面</button></div></div>';
		}
		j++;
	})
	$("#fkContainer").after(s_picture_imgtag);
	$("#postform").append(s_picture_tag);

	var f_picture_array =  obj.f_picture.split(",");
	var f_picture_tag = "";
	var f_picture_imgtag = "";
	$.each(f_picture_array,function(i,pic){
		var timeStamp = new Date().getTime();
		timeStamp = timeStamp + j;
		if($.trim(pic) != ""){
			f_picture_tag += "<input type='hidden' name='f_picture' value='"+pic+"' id='pic"+timeStamp+"'/>";
			var img = cloudPicUrl+pic;
			f_picture_imgtag += '<div class="album-image col-lg-2" id="img'+timeStamp+'"><img class="img-thumbnail" src="'+img+'" />';
			f_picture_imgtag += '<div class="text-center"><a href="javascript:void(0)" onclick="deleteImg(\''+timeStamp+'\');">删除</a></div>';
			f_picture_imgtag += '<div style=" position:absolute; bottom:20px;  height:40px; width:100px;   border-bottom-right-radius: 6px; border-bottom-left-radius: 6px;">';
//			f_picture_imgtag += '<button type="button" onclick="setCover(\''+pic+'\',this);" class="coverButton" id="'+pic+'">设为封面</button></div></div>';
		}
		j++;
	})
	$("#fkContainer1").after(f_picture_imgtag);
	$("#postform").append(f_picture_tag);

	var x_picture_array =  obj.x_picture.split(",");
	var x_picture_tag = "";
	var x_picture_imgtag = "";
	$.each(x_picture_array,function(i,pic){
		var timeStamp = new Date().getTime();
		timeStamp = timeStamp + j;
		if($.trim(pic) != ""){
			x_picture_tag += "<input type='hidden' name='x_picture' value='"+pic+"' id='pic"+timeStamp+"'/>";
			var img = cloudPicUrl+pic;
			x_picture_imgtag += '<div class="album-image col-lg-2" id="img'+timeStamp+'"><img class="img-thumbnail" src="'+img+'" />';
			x_picture_imgtag += '<div class="text-center"><a href="javascript:void(0)" onclick="deleteImg(\''+timeStamp+'\');">删除</a></div>';
			x_picture_imgtag += '<div style=" position:absolute; bottom:20px;  height:40px; width:100px;   border-bottom-right-radius: 6px; border-bottom-left-radius: 6px;">';
//			x_picture_imgtag += '<button type="button" onclick="setCover(\''+pic+'\',this);" class="coverButton" id="'+pic+'">设为封面</button></div></div>';
		}
		j++;
	})
	$("#fkContainer2").after(x_picture_imgtag);
	$("#postform").append(x_picture_tag);

	var isSetCover = false;
	var defaultCover = null;
	$(".coverButton").each(function(i){
		if(defaultCover == null ){
			defaultCover = this;
		}
		if(obj.cover == $(this).attr("id")){
			$(this).css("backgroundColor","#72a230");
			$(this).text("当前封面");
			isSetCover = true;
		}else{
			$(this).css("backgroundColor","#07b207");
		}
	})
	if(!isSetCover){
		$(defaultCover).css("backgroundColor","#72a230");
		$(defaultCover).text("当前封面");
		$("#cover").val($(defaultCover).attr("id"));
	}

	return obj.lpName;
}


function onQyChange(){
	$("#sqId").empty();
	var qyId = $("#qyId").val();
	initShangQuan();
}

function getLpName(){
	$("#selectXiaoQu").select2({
		minimumInputLength: 1,
		placeholder: '请输入小区名称搜索',
		ajax: {
			url: cloudPlatformUrl+"/services/newenv/lpzd/crawl/getLouPan/",
			type: "GET",
			dataType: 'json',
			quietMillis: 100,
			data: function(term, page) {
				return {
					"keyword": term,
					"cityName": cityName
				};
			},
			results: function(data, page ) {
				return { results: data.result }
			}
		},
		formatResult: function(obj) { 
			return "<div class='select2-user-result'>" + obj.name + "</div>";
		},
		formatSelection: function(obj) {
			$("#select2-chosen-1").css("color","#444");
			$("#qyId").find("option[value='"+obj.areaid+"']").attr("selected",true);
			onQyChange();
			$("#sqId").find("option[value='"+obj.wubapid+"']").attr("selected",true);
			$("#postform input[name='address']").val(obj.address);
			$("#selectXiaoQuLabel").hide();
			return obj.name; 
		}
	}).on("change",function(e){
		
	});;
}

function checkLpName(lpName){
	var state = false;
	if(lpName != ""){
		var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/getLouPan?keyword="+lpName+"&cityName="+cityName;
		var result = $.ajax({url:url,async:false});
		var resObj = $.parseJSON(result.responseText);
		var obj = resObj.result;
		$.each(obj,function(i,n){
			var searchLpName = obj[i].name;
			if(searchLpName == lpName){
				$("#qyId").find("option[value='"+obj[i].areaid+"']").attr("selected",true);
				onQyChange();
				$("#sqId").find("option[value='"+obj[i].wubapid+"']").attr("selected",true);
				$("#selectXiaoQu").val(obj[i].id);
				$("#select2-chosen-3").css("color","#444");
				$("#select2-chosen-3").text(lpName);
				$("#address").val(obj[i].address);
				state = true;
			}
		});
	}
	if(!state){
		$("#select2-chosen-3").text(lpName);
		errorAnchor("selectXiaoQuLabel");
//		alert("因为不同站点对小区的命名有所差别，请在列表中选择对应的小区并核实信息再发布!");
	}
}

function initArea(){
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/getArea?cityName="+cityName;
	var result = $.ajax({url:url,async:false});
	var resObj = $.parseJSON(result.responseText);
	var cityIds = resObj.result;
	$.each(cityIds,function (idx){
		var areaName = cityIds[idx].areaName;
		var areaId = cityIds[idx].areaId;
		$("#qyId").append("<option value='"+areaId+"'>"+areaName+"</option>");
	})
}

function initShangQuan(){
	var qyId = $("#qyId").val();
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/getShangQuan?id="+qyId;
	var result = $.ajax({url:url,async:false});
	var resObj = $.parseJSON(result.responseText);
	var cityIds = resObj.result;
	$.each(cityIds,function (idx){
		var sqName = cityIds[idx].sqName;
		var sqId = cityIds[idx].sqId;
		$("#sqId").append("<option value='"+sqId+"'>"+sqName+"</option>");
	})
}

function save(id){

	//验证
	var lpName = $("#select2-chosen-3").text();
	if(lpName == "请输入小区名称搜索" || !$("#selectXiaoQuLabel").is(":hidden")){
		errorAnchor("selectXiaoQuLabel");
		return;
	}
	
	if(id == 0){
		var isNotEmpty = validateEmpty();
		if(!isNotEmpty){
			return;
		}
	}
	
	var type = 0
	if("${param.useageName}" == "写字楼"){
		type = 1;
	}else if("${param.useageName}" == "商铺"){
		type = 2;
	}else if("${param.useageName}" == "别墅"){
		type = 4;
	}
	<c:if test="${not empty param.hType}">
	type = ${param.hType};
	</c:if>
	
	var fangYuanChuShouRelease=new Object();
	fangYuanChuShouRelease.id="${param.scId}";
	fangYuanChuShouRelease.businessType="fangyuan_chushou";
	fangYuanChuShouRelease.type=type;
//	fangYuanChuShouRelease.lpName=$("#select2-chosen-3").text();
	fangYuanChuShouRelease.status=id;
	fangYuanChuShouRelease.currentUserName="<%=SecurityUserHolder.getCurrentUserLogin().getUserLogin().getUsername()%>";
	fangYuanChuShouRelease.employeeId=uid;
	fangYuanChuShouRelease.crawlId="<%=id%>";
	if(fangYuanChuShouRelease.crawlId == "null"){
		fangYuanChuShouRelease.crawlId=null;
	}
	if("${param.houseNumber}" != ""){
		fangYuanChuShouRelease.houseNumber = "${param.houseNumber}";
	}
	fangYuanChuShouRelease.lpName=lpName;
	fangYuanChuShouRelease.title=$("#title").val();
	fangYuanChuShouRelease.address=$("#address").val();
	fangYuanChuShouRelease.area=$("#area").val();
	fangYuanChuShouRelease.syarea=$("#syarea").val();
	fangYuanChuShouRelease.price=$("#price").val();
	fangYuanChuShouRelease.directionType=$("#direction").val();
	fangYuanChuShouRelease.fitmentType=$("#postform input[name='fitment']:checked").val();
	fangYuanChuShouRelease.xqid=$("#selectXiaoQu").val();
	fangYuanChuShouRelease.hx_s=$("#hx_s").val();
	fangYuanChuShouRelease.hx_t=$("#hx_t").val();
	fangYuanChuShouRelease.hx_c=$("#hx_c").val();
	fangYuanChuShouRelease.hx_w=$("#hx_w").val();
	fangYuanChuShouRelease.hx_y=$("#hx_y").val();
	fangYuanChuShouRelease.floor_c=$("#floor_c").val();
	fangYuanChuShouRelease.floor_z=$("#floor_z").val();
	var label = $("#label").val();
	if($.trim(label) != "" && label.length>0){
		label = label.join(",");
	}
	var wubalabel = $("#wubalabel").val();
	if($.trim(wubalabel) != "" && wubalabel.length>0){
		wubalabel = wubalabel.join(",");
	}
	fangYuanChuShouRelease.label=label;
	fangYuanChuShouRelease.wubalabel=wubalabel;
	fangYuanChuShouRelease.houseProperty=$("#houseProperty").val();
	fangYuanChuShouRelease.propertyYear=$("#propertyYear").val();
	fangYuanChuShouRelease.houseStructure=$("#postform input[name='houseStructure']:checked").val();
	fangYuanChuShouRelease.houseType=$("#postform input[name='houseType']:checked").val();
	fangYuanChuShouRelease.propertyAge=$("#postform input[name='propertyAge']:checked").val();
	fangYuanChuShouRelease.summary=$("#summary").val();
	fangYuanChuShouRelease.pstatus = id;
	fangYuanChuShouRelease.yijuhuaguanggao = $("#yijuhuaguanggao").val();
	fangYuanChuShouRelease.houseNumber = $("#houseNumber").val();
//	fangYuanChuZuRelease.type = $("#houseType").val();
	fangYuanChuShouRelease.houseId = "${param.saleOrRentId}";
	fangYuanChuShouRelease.cityId = getCityName();
	fangYuanChuShouRelease.provinceId = getProvinceName();
	fangYuanChuShouRelease.qyId = $("#qyId option:selected").text();
	fangYuanChuShouRelease.sqId = $("#sqId option:selected").text();
	fangYuanChuShouRelease.personalFangYuan = $("#personalFangYuan").val();
	fangYuanChuShouRelease.cover = $("#cover").val();
	
	
	var array = [];
	$.each($("input[name='s_picture']"),function(i,n){
		array.push($(this).val());
	})
	var array1 = [];
	$.each($("input[name='f_picture']"),function(i,n){
		array1.push($(this).val());
	})
	var array2 = [];
	$.each($("input[name='x_picture']"),function(i,n){
		array2.push($(this).val());
	})
	
	if(id == 0){
		var flag = validatePicNum(fangYuanChuShouRelease.houseNumber,array,array1,array2);
		if(!flag){
			return;
		}
	}
	
	fangYuanChuShouRelease.s_picture = array.join(",");
	fangYuanChuShouRelease.f_picture = array1.join(",");
	fangYuanChuShouRelease.x_picture = array2.join(",");
	var jsonData=JSON.stringify(fangYuanChuShouRelease);
	$.ajax({
		url: cloudPlatformUrl+"/services/newenv/lpzd/crawl/saveFangYuanRelease/", 
		dataType: "json", 
		type: "POST", 
		contentType : "application/json; charset=utf-8",
		data : jsonData,
		success : function(result){
			var paramType = "${param.hType}";
			if(paramType == ""){
				paramType = type;
			}
			if(result != null){
				if(result.houseNumber == null || result.houseNumber == ""){
					window.location.href = "<%=basePath%>/crawl/saleManagment.jsp?from="+id+"&id="+result.id+"&hType="+paramType;
				}else{
					window.location.href = "<%=basePath%>/crawl/saleManagment.jsp?from="+id+"&id="+result.id+"&houseNumber="+result.houseNumber+"&hType="+paramType;
				}
			}else{
				bootbox.alert({title:"提示",message:"录入失败 !"});
			}
    	}
	});
}

function errorAnchor(id){
	$("#"+id).show();
//	$('html,body').animate({scrollTop: $("#"+id).offset().top - 50}, 500);
}

function validateEmpty(){
	var flag = true;
	var address = $.trim($("#address").val());
	var area = $.trim($("#area").val());
	var syarea = $.trim($("#syarea").val());
	var price = $.trim($("#price").val());
	var summary = $.trim($("#summary").val());
	var label = $("#label").val();
	var wubalabel = $("#wubalabel").val();
	var propertyYear = $("#propertyYear").val();
	var title = $("#title").val();

	var reg= /^d+(.d+)?$/;
	var floor_c = $.trim($("#floor_c").val());
	var floor_z = $.trim($("#floor_z").val());

	if(floor_c == "" || floor_z == "" ){
		flag = false;
		bootbox.alert({title:"提示",message:"楼层信息填写有误!"});
	}else if(parseInt(floor_z) < parseInt(floor_c)){
		flag = false;
		bootbox.alert({title:"提示",message:"总楼层须大于等于当前楼层!"});
	}else if(address == "" || address.length > 150){
		flag = false;
		bootbox.alert({title:"提示",message:"地址不能为空并且长度不能超过150个字符!"});
	}else if(area == ""){
		flag = false;
		bootbox.alert({title:"提示",message:"建筑面积不能为空 !"});
	}else if(syarea == ""){
		flag = false;
		bootbox.alert({title:"提示",message:"使用面积不能为空 !"});
	}else if(price == ""){
		flag = false;
		bootbox.alert({title:"提示",message:"价格不能为空!"});
	}else if(propertyYear == ""){
		flag = false;
		bootbox.alert({title:"提示",message:"建造年代不能为空!"});
	}else if(label == null || label.length == 0){
		flag = false;
		bootbox.alert({title:"提示",message:"房源标签不能为空!"});
	}else if(wubalabel == null || wubalabel.length == 0){
		flag = false;
		bootbox.alert({title:"提示",message:"58配套设施不能为空!"});
	}else if($.trim(title) == "" || $.trim(title).length > 30){
		flag = false;
		bootbox.alert({title:"提示",message:"标题不能为空且最多只能输入30个字（包括空格）!"});
	}else if(summary == "" || summary.length < 10){
		flag = false;
		bootbox.alert({title:"提示",message:"描述不得少于10个字以下!"});
	}
	return flag;
}

function initLabel(obj){
	if(obj != null && obj.label &&  obj.label != ""){
		$.each(obj.label.split(','),function(i,n){
			$("#label option[value='"+n+"']").attr("selected",true);
		})
	}
	if(obj != null && obj.wubalabel && obj.wubalabel != ""){
		$.each(obj.wubalabel.split(','),function(i,n){
			$("#wubalabel option[value='"+n+"']").attr("selected",true);
		})
	}
	$("#label").select2({ maximumSelectionSize: 3,language: "zh-CN"});
	$("#wubalabel").select2({ maximumSelectionSize: 3,language: "zh-CN" });
}

function buildLabel(){
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/getInfoLabel";
	var result = $.ajax({url:url,async:false});
	var resObj = $.parseJSON(result.responseText);
	$.each(resObj,function (idx){
		$("#label").append('<option value="'+resObj[idx].name+'">'+resObj[idx].name+'</option>');
	})
}
function buildWubaLabel(){
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/getInfoWubaLabel";
	var result = $.ajax({url:url,async:false});
	var resObj = $.parseJSON(result.responseText);
	$.each(resObj,function (idx){
		$("#wubalabel").append('<option value="'+resObj[idx].name+'">'+resObj[idx].name+'</option>');
	})
}

function checkFangYuanRelease(houseNumber){
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/getFangYuanRelease/";
	var obj=new Object();
	var requestParameter=new Object();
	requestParameter.userId=<%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>;
	requestParameter.businessType="fangyuan_chushou";
	requestParameter.houseNumber= "${param.houseNumber}";
	if(houseNumber != null){
		requestParameter.houseNumber= houseNumber;
	}
	requestParameter.scId= "${param.scId}";
	requestParameter.id="${param.id}";
	obj.requestParameter=requestParameter;
	var jsonData=JSON.stringify(obj);
	var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
	var responseText = result.responseText;
	return responseText == "" ? null : $.parseJSON(responseText);
}

$(document).ready(function(){
	var from = "${param.from}";
	if(from == "3"){   //新增房源
		buildPro();
		buildLabel();
		buildWubaLabel();
		initLabel(obj);
		initArea();
		initShangQuan();
		getLpName();
		$("#personalFangYuan").val(3);
	}else{
		buildPro();
		var lpName = "";
		var resObj = null;
		var houseNumber = null;
		if(from == "bms"){
			resObj = fromBMSInit();
			if(resObj != null){
				houseNumber = resObj.number;
			}
		}
		var obj = checkFangYuanRelease(houseNumber);
		if(obj != null){
			lpName = initShouCangMiaoLu(obj);
		}else if(from == "bms"){
			lpName = initBMS(resObj);
		}else{
			lpName = initMiaoLu();
		}
		buildLabel();
		buildWubaLabel();
		initLabel(obj);
		initArea();
		initShangQuan();
		getLpName();
		checkLpName(lpName);
	}
});


function fromBMSInit(){
	buildPro();
	var object = new Object();
	var imgArr = [];
	var imgStr = "";
	object.houseType = "${param.houseType}";
	object.saleOrRentId = "${param.saleOrRentId}";
	object.houseSourceId = "${param.houseSourceId}";
	var jsonData = JSON.stringify(object);
	var result =  $.ajax({ 
        type:"POST", 
        url: BMSService + "/newenv/bms/AgentAppHouseInfoService/houseDetail", 
        dataType:"json",  
        contentType : "application/json; charset=utf-8",
        data:jsonData,
        async:false,
     });
	if(typeof(result.responseJSON) == "undefined" || result.responseJSON == null){
		return null;
	}else{
		var resultObject = result.responseJSON.result;
		resultObject = convertFromBMS(resultObject);
		return resultObject;
	}
}

function initBMS(resultObject){
	if(resultObject == null){
		return "";
	}else{
		var obj = new Object();
		obj.area = resultObject.buildingSize;
		obj.hx_s = resultObject.roomNumber;
		obj.hx_t = resultObject.hallNumber;
		obj.hx_c = resultObject.toiletNumber;
		obj.hx_w = resultObject.toiletNumber;
		obj.hx_y = resultObject.toiletNumber;
		obj.directionType = resultObject.orientationName;
		obj.fitmentType = resultObject.decorationStandard;
		obj.title = null;
		obj.houseType = resultObject.housetype;
		obj.propertyAge = resultObject.propertyAge;
		obj.floor_c = resultObject.ceng;
		obj.floor_z = resultObject.totalFloor;
		obj.price = resultObject.totalPrice;
		obj.summary = null;
		obj.label = null;
		obj.wubalabel = null;
		obj.yijuhuaguanggao = null;
		/* var imgStr = "";
		if(resultObject.imgpaths == null){
			imgStr = "";
		}else{
			imgArr = resultObject.imgpaths;
			for(var i = 0;i < imgArr.length;i++){
				var img = imgArr[i] + ",";
				imgStr += img;
			}
			imgStr = imgStr.substring(0,imgStr.length-1);
		} */
		var s_picture_array =  getMultiTypePic(2).split(",");
		var s_picture_tag = "";
		var s_picture_imgtag = "";
		var k = 0;
		$.each(s_picture_array,function(i,pic){
			if($.trim(pic) != ""){
				var timeStamp = new Date().getTime();
				timeStamp = timeStamp + k;
				s_picture_tag += "<input type='hidden' name='s_picture' value='"+pic+"' id='pic"+timeStamp+"'/>";
				var img = cloudPicUrl+pic;
				s_picture_imgtag += '<div class="album-image col-lg-2" id="img'+timeStamp+'"><img class="img-thumbnail" src="'+img+'"/>';
				s_picture_imgtag += '<div class="text-center"><a href="javascript:void(0)" onclick="deleteImg(\''+timeStamp+'\');">删除</a></div>';
				s_picture_imgtag += '<div style=" position:absolute; bottom:20px;  height:40px; width:100px;border-bottom-right-radius: 6px; border-bottom-left-radius: 6px;">';
				s_picture_imgtag += '<button type="button" onclick="setCover(\''+pic+'\',this);" class="coverButton" id="'+pic+'">设为封面</button></div></div>';
			}
			k++;
		})
//		$("#fkContainerBox").append(s_picture_imgtag);
		$("#fkContainer").after(s_picture_imgtag);
		$("#postform").append(s_picture_tag);
		
		var f_picture_array =  getMultiTypePic(1).split(",");
		var f_picture_tag = "";
		var f_picture_imgtag = "";
		$.each(f_picture_array,function(i,pic){
			if($.trim(pic) != ""){
				var timeStamp = new Date().getTime();
				timeStamp = timeStamp + k;
				f_picture_tag += "<input type='hidden' name='f_picture' value='"+pic+"' id='pic"+timeStamp+"'/>";
				var img = cloudPicUrl+pic;
				f_picture_imgtag += '<div class="album-image col-lg-2" id="img'+timeStamp+'"><img class="img-thumbnail" src="'+img+'"/>';
				f_picture_imgtag += '<div class="text-center"><a href="javascript:void(0)" onclick="deleteImg(\''+timeStamp+'\');">删除</a></div>';
				f_picture_imgtag += '<div style=" position:absolute; bottom:20px;  height:40px; width:100px;border-bottom-right-radius: 6px; border-bottom-left-radius: 6px;">';
				f_picture_imgtag += '<button type="button" onclick="setCover(\''+pic+'\',this);" class="coverButton" id="'+pic+'">设为封面</button></div></div>';
			}
			k++;
		})
//		$("#fkContainer1Box").append(f_picture_imgtag);
		$("#fkContainer1").after(f_picture_imgtag);
		$("#postform").append(f_picture_tag);

		/* var x_picture_array =  getMultiTypePic(0).split(",");
		var x_picture_tag = "";
		var x_picture_imgtag = "";
		$.each(x_picture_array,function(i,pic){
			if($.trim(pic) != ""){
				x_picture_tag += "<input type='hidden' name='x_picture' value='"+pic+"'/>";
				var img = cloudPicUrl+pic;
				x_picture_imgtag += '<div class="album-image col-lg-2"><img class="img-thumbnail" src="'+img+'" onclick="selectBoxImg(\''+pic+'\',\'fkFiles2\',\'container2Files\');"/>';
				x_picture_imgtag += '<div class="text-center"><a href="javascript:void(0)" onclick="removeExclusiveImg(0,\''+pic+'\',this);">删除</a></div></div>';
			}
		})
//		$("#fkContainer2Box").append(x_picture_imgtag);
		$("#fkContainer2").after(x_picture_imgtag);
		$("#postform").append(x_picture_tag);  */
		obj.s_picture = "";
		obj.f_picture = "";
		obj.x_picture = "";
		obj.houseNumber = resultObject.number;
		obj.lpName = resultObject.lpname;
		obj.type = resultObject.useage;
		obj.createtime = resultObject.createDate;
		obj.propertyYear = resultObject.buildingage;
		obj.syarea = resultObject.innerSize;
		var lpName1 = initShouCangMiaoLu(obj);
		return lpName1;
	}
}

function convertFromBMS(obj){
	if(obj.orientationName == "东"){
		obj.orientationName = "1";
	}else if(obj.orientationName == "南"){
		obj.orientationName = "2";
	}else if(obj.orientationName == "西"){
		obj.orientationName = "3";
	}else if(obj.orientationName == "北"){
		obj.orientationName = "4";
	}else if(obj.orientationName == "东南"){
		obj.orientationName = "5";
	}else if(obj.orientationName == "东西"){
		obj.orientationName = "6";
	}else if(obj.orientationName == "西南"){
		obj.orientationName = "7";
	}else if(obj.orientationName == "西北"){
		obj.orientationName = "8";
	}else if(obj.orientationName == "东北"){
		obj.orientationName = "9";
	}else if(obj.orientationName == "南北"){
		obj.orientationName = "10";
	}
	
	if(obj.useage == 41){
		obj.useage = 0;
	}else if(obj.useage == 42){
		obj.useage = 1;
	}else if(obj.usage == 43){
		obj.useage = 2;
	}else if(obj.usage == 44){
		obj.useage = 4;
	}else{
		obj.useage = 0;
	}
	
	if(obj.decorationStandard == 255){
		obj.decorationStandard = 1;
	}else if(obj.decorationStandard == 256){
		obj.decorationStandard = 2;
	}else if(obj.decorationStandard == 257){
		obj.decorationStandard = 3;
	}else if(obj.decorationStandard == 259){
		obj.decorationStandard = 4;
	}else if(obj.decorationStandard == 260){
		obj.decorationStandard = 5;
	}
	return obj;
}

function getCityName(){
	var provinceId = "<%=SecurityUserHolder.getCurrentUserLogin().getProvinceId()%>";
	var cityId = "<%=SecurityUserHolder.getCurrentUserLogin().getCityId()%>";
	var cityName = "";
	var result = $.ajax({ 
		url: "<%=basePath%>/cam/campus!getCity.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"pid" : provinceId},
	});
	if(null != result.responseJSON){
		if(result.responseJSON.length > 0){
			for(var i = 0;i < result.responseJSON.length;i++){
				if(result.responseJSON[i].id == cityId){
					cityName = result.responseJSON[i].cityName;
					break;
				}
			}
		}
	}
	return cityName;
};

function getProvinceName(){
	var countryId = "<%=SecurityUserHolder.getCurrentUserLogin().getCountryId()%>";
	var provinceId = "<%=SecurityUserHolder.getCurrentUserLogin().getProvinceId()%>";
	var provinceName = "";
	var result = $.ajax({ 
		url: "<%=basePath%>/cam/campus!getPro.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"cid" : countryId},
	});
	if(null != result.responseJSON){
		if(result.responseJSON.length > 0){
			for(var i = 0;i < result.responseJSON.length;i++){
				if(result.responseJSON[i].id == provinceId){
					provinceName = result.responseJSON[i].pname;
					break;
				}
			}
		}
	}
	return provinceName;
};	

function validatePicNum(houseNumber,arr,arr1,arr2){
	var flag = true;
	if(houseNumber == null || houseNumber == ""){
		if(arr.length > 8){
			alert("室内图片不能多于8张");
			flag = false;
		}else if(arr1.length > 5){
			alert("房型图不能多于5张");
			flag = false;
		}else if(arr2.length > 8){
			alert("小区图不能多于8张");
			flag = false;
		} 
	}else{
		if(arr.length < 3 || arr.length > 8){
			alert("室内图片不能少于3张不能多于8张");
			flag = false;
		}else if(arr1.length < 1 || arr1.length > 5){
			alert("房型图不能少于1张不能多于5张");
			flag = false;
		}else if(arr2.length < 1 || arr2.length > 8){
			alert("小区图不能少于1张不能多于8张");
			flag = false;
		}
	}
	return flag;
}

function miaoluSave(){
	var miaoluurl = $("#miaoluurl").val();
	if($.trim(miaoluurl) == ''){
		alert("复制链接不能为空!");
		return;
	}
	$('.onsubing').show();
	miaoluurl=encodeURIComponent(miaoluurl);
	var url = mlUrlService+"get?url="+miaoluurl;
	$.getJSON(url,
			function(result) {
				console.log(result);
				$("#address").val(result.jbxx_scdz);
				$("#area").val(result.jbxx_cqmj);
				$("#syarea").val(result.jbxx_cqmj);
				$("#syarea").val(result.jbxx_cqmj);
				if(result.jbxx_hx!="" && typeof(result.jbxx_hx)!='undefined' && result.jbxx_hx.indexOf(",")>0){
					var hx_s = result.jbxx_hx.split(",")[0];
					$("#hx_s").find("option[value='"+hx_s+"']").attr("selected",true);
					var hx_t = result.jbxx_hx.split(",")[1];
					$("#hx_t").find("option[value='"+hx_t+"']").attr("selected",true);
					var hx_c = result.jbxx_hx.split(",")[2];
					$("#hx_c").find("option[value='"+hx_c+"']").attr("selected",true);
					var hx_w = result.jbxx_hx.split(",")[3];
					$("#hx_w").find("option[value='"+hx_w+"']").attr("selected",true);
					var hx_y = result.jbxx_hx.split(",")[4];
					$("#hx_y").find("option[value='"+hx_y+"']").attr("selected",true);
				}
				//楼层
				var jbxx_lc = result.jbxx_lc;
				if(jbxx_lc!="" && typeof(jbxx_lc)!='undefined' && jbxx_lc.indexOf("/")>0){
					$("#floor_c").val(jbxx_lc.split("/")[0]);
					$("#floor_z").val(jbxx_lc.split("/")[1]);
				}else{
					$("#floor_z").val(jbxx_lc);
				}
				$("#price").val(result.wtxx_zj);
				$('#direction option').filter(function () { return $(this).text() == result.jbxx_cx; }).attr("selected", true);
				$("#propertyYear").val(result.jbxx_jznd);
				$("#houseProperty").find("option[value='"+result.jbxx_lx+"']").attr("selected",true);
				$("#title").val(result.jbxx_bt);
				KindEditor.html('summary', result.jbxx_nr);

				checkLpName(result.jbxx_fwmc);
				$('#miaolu').modal("hide");
				setTimeout("$('.onsubing').hide();",200);
			}
	).error(errorHandler=function(jqXHR, textStatus, errorThrown){
		setTimeout("$('.onsubing').hide();",200);
	});
}

function getMultiTypePic(type){
	var imgStr = "";
	var url = BMSService + "/newenv/bms/AgentAppHouseInfoService/getSurveyImage";
	var object =  new Object();
	object.saleOrRentId = "${param.saleOrRentId}";
	object.imageType = type;
	var JSONData = JSON.stringify(object);
	var data = $.ajax({
		url : url,
	    dataType : "json",
	    async : false,
	    type : "POST",
	    data : JSONData,
	    contentType : "application/json; charset=utf-8",
	})
	if(typeof(data.responseJSON.result) == "undefined" || data.responseJSON.result == null){
		
	}else{
		if(data.responseJSON.result.length > 0){
			for(var i = 0;i < data.responseJSON.result.length;i++){
				var img = data.responseJSON.result[i].imagePath;
				imgStr += img + ",";
			}
		}
	}
	if($.trim(imgStr).length > 0){
		imgStr = imgStr.substring(0,imgStr.length-1);
	}
	return imgStr;
}

function selectBoxImg(pic,containerName,container){
	var img = cloudPicUrl+pic;
	var flag = false;
	if($("#" + container +" img").length > 0){
		$("#" + container +" img").each(function(i){
			if($(this).attr("src") == img && $(this).parent().css("display") != "none"){
				flag = true;
			}
		})
	}
	if(flag){
		alert("该图片已经添加过");
		return;
	}
	if(containerName == "fkFiles"){
		var s_picture_tag = "";
		var s_picture_imgtag = "";
		var timeStamp = new Date().getTime();
		s_picture_tag += "<input type='hidden' name='s_picture' value='"+pic+"' id='pic"+timeStamp+"'/>";
		s_picture_imgtag += '<div class="album-image col-lg-2" id="img'+timeStamp+'"><img class="img-thumbnail" src="'+img+'" /></div>';
		$("#"+containerName).append(s_picture_imgtag);
		$("#postform").append(s_picture_tag);
	}else if(containerName == "fkFiles1"){
		var f_picture_tag = "";
		var f_picture_imgtag = "";
		var timeStamp = new Date().getTime();
		f_picture_tag += "<input type='hidden' name='f_picture' value='"+pic+"' id='pic"+timeStamp+"'/>";
		f_picture_imgtag += '<div class="album-image col-lg-2" id="img'+timeStamp+'"><img class="img-thumbnail" src="'+img+'" /></div>';
		$("#"+containerName).append(f_picture_imgtag);
		$("#postform").append(f_picture_tag);
	}else if(containerName == "fkFiles2"){
		var x_picture_tag = "";
		var x_picture_imgtag = "";
		var timeStamp = new Date().getTime();
		x_picture_tag += "<input type='hidden' name='x_picture' value='"+pic+"' id='pic"+timeStamp+"'/>";
		x_picture_imgtag += '<div class="album-image col-lg-2" id="img'+timeStamp+'"><img class="img-thumbnail" src="'+img+'" /></div>';
		$("#"+containerName).append(x_picture_imgtag);
		$("#postform").append(x_picture_tag);
	}
}

function saveUserModal(container,file,containerFile,modal){
	var html = $("#" + file).html();
	$("#" + file).empty();
	$("#"+container).after(html);
	$('#'+containerFile +' div' ).each(function(i){
		if($(this).css("display") == "none"){
			$(this).remove();
			var id = $(this).attr("id");
			if(typeof(id) == "undefined" || id == null){
				
			}else{
				if(id.length > 3){
					id = id.substring(3,id.length);
					$("#pic" +id).remove();
				}
			}
			
		}
	})
	$('#'+modal).modal("hide");
}
function emptyPic(file,container){
	$("#" + file).empty();
	$('#'+container +' div' ).each(function(i){
		if($(this).css("display") == "none"){
			var id = "#" + $(this).attr("id");
			$(id).css("display","block");
		}
	})
}


function removeImg(object){
	$("#img" +object).css("display","none"); 
	/* $("#pic" +object).remove(); */
}

// 设置封面
function setCover(coverPath,object){
	$(".coverButton").each(function(i){
		$(this).css("backgroundColor","#07b207");
		$(this).text("设为封面");
	})
	$(object).css("backgroundColor","#72a230");
	$(object).text("当前封面");
	$("#cover").val($(object).attr("id"));
}

function queryPersonalEntrustHouseForList(pageIndex){
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/queryPersonalEntrustHouseForList/";
	var obj=new Object();
	// 分页
	if(pageIndex==undefined || pageIndex==null)
		pageIndex=1;
    var pageInfo=new Object();
    pageInfo.page=pageIndex;
    obj.pageInfo=pageInfo;
	
    var requestParameter=new Object();
    requestParameter.sqValue="";
	requestParameter.qyValue="";
    requestParameter.minPrice=null;
    requestParameter.maxPrice=null;
    requestParameter.shi="";
    requestParameter.ting="";
    requestParameter.wei="";
    requestParameter.order="desc";
    requestParameter.rows=2;
    requestParameter.employeeId=<%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>;
    obj.requestParameter=requestParameter;
    
    var jsonData=JSON.stringify(obj);
	var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
	if(result.responseJSON.listJson.gridModel == null){
		
	}
}

function queryEntrustHouseForList(){
	var requestParameter = new Object();
	requestParameter.employeeId=12;
	requestParameter.businessType="hasNotEntrustHouseSum";
	var jsonData= JSON.stringify(requestParameter);
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/queryEntrustHouseForList/";
	var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
if(result == null){
		
	}
}

function deleteEntrustHouseRecord(){
	var ids = "16-fangyuanchushou";
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/deleteEntrustHouseRecord?ids="+ids;
	var result = $.ajax({url:url,async:false});
if(result == null){
		
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

<script type="text/javascript" src="../js/campus/pluploadfile.js?_t=<%=timeMillis%>"></script>

<script type="text/javascript" src="../js/kindeditor/kindeditor-min.js" charset="UTF-8"></script>
<script type="text/javascript">
		KE.show({
			 id : "summary",
		     width : "100%",
		     height : "300px",
		     resizeMode : 1,
		     allowFileManager : true,
		     items : [
		     	"source","preview","|","fullscreen","undo","redo",
				"plainpaste","wordpaste","|","justifyleft","justifycenter","justifyright","justifyfull",
				"insertorderedlist","insertunorderedlist","indent","outdent",
				"date","time","|","-","title","fontname","fontsize","|","textcolor","bgcolor","bold","italic","underline",
				"strikethrough","removeformat","|","image","flash","media","specialchar"
			 ],
		     /*图片上传的SERVLET路径*/
		     imageUploadJson : "<%=path%>/file!KEUpload.action",
		     /*图片管理的SERVLET路径*/
		     fileManagerJson : "<%=path%>/file!KEUpload.action",
		     /*允许上传的附件类型*/
		     accessoryTypes : "doc|xls|pdf|txt|ppt|rar|zip|xlsx|docx",
		     /*附件上传的SERVLET路径*/
		     accessoryUploadJson : "<%=path%>/file!KEUpload.action"
		});
</script>
