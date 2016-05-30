<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>
<%@page import="com.newenv.lpzd.lp.domain.XhjLpfanghao"%>
<%@ page isELIgnored="false"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
Integer userid = userLogin.getUserProfile().getId();
Integer loginid = userLogin.getUserLogin().getId();
Integer departmentId = userLogin.getDepartment().getId();
String provinceId = userLogin.getProvinceId();
String countryId = userLogin.getCountryId();
String cityId = userLogin.getCityId();
String action=(String)request.getParameter("action");
%>
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
		<script src="<%=basePath%>/assets/js/bootbox/bootbox.min.js"></script>
		<script src="<%=basePath%>/js/comm/commInfo.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/person/fanghaoadd.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/person/personpublic.js"></script>
				<script src="<%=basePath%>/js/services.js"></script>
		<script type="text/javascript">
		var basepath="<%=basePath%>";
		var action ="<%=action%>";
		var dzid='${fanghao.dzId}';
		var dyid='${fanghao.dyId}';
		var ceng='${fanghao.ceng}';
		</script>
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

	</head>
	<div class='onsubing' style="display:none; width:100%; height:100%; background:#fff; position:fixed; z-index:99999; opacity:0.8;-moz-opacity:0.8; filter:alpha(opacity=80); ">
		<div class="text-center" style="position:absolute; top:20%; left:50%;">
			<img src="<%=basePath%>/images/loading.gif" width="176" height="220"/>
		</div>
	</div>
	<body class="page-body">
		<div class="page-container">
			<!-- add class "sidebar-collapsed" to close sidebar by default, "chat-visible" to make chat appear always -->

			<!-- Add "fixed" class to make the sidebar fixed always to the browser viewport. -->
			<!-- Adding class "toggle-others" will keep only one menu item open at a time. -->
			<!-- Adding class "collapsed" collapse sidebar root elements and show only icons. -->
			<div class="sidebar-menu toggle-others fixed">
				<jsp:include page="../include/left.jsp" />
			</div>
			<div class="main-content" >
				<!-- User Info, Notifications and Menu Bar -->
				<jsp:include page="../include/top.jsp"/>
				<div class="page-title">

					<div class="breadcrumb-env pull-left">
						<ol class="breadcrumb bc-1">
							<li>
								<a href="<%=basePath%>/console/index.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<li>
								<a href="小区列表.html">业主资料</a>
							</li>
							<li class="active">
								<strong>修改房屋</strong>
							</li>
						</ol>

					</div>

				</div>
				<form role="form" class="form-horizontal" id="fanghaoForm">
				<div id="webImageofhouse_image_hidden"></div>
				<div class="panel-default">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								业主资料信息
							</div>
							<div class="panel-body">
								<div class="row col-lg-10 col-md-12 col-xs-12 col-sm-12">
									<div class="col-md-4 col-sm-4">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon red">楼盘名称：</span>
												<input type="hidden"  name="fanghao.lpid" id="fanghaolpid" value="${fanghao.lpid}"/>
												<% 
												if(action.equals("save")){
												%>
												<input type="hidden"  id="lpName"   id="lpName" />
												<% }else if(action.equals("update")){
												%>
												
												<input type="text" id="lpName" class="form-control"   value="${fanghao.lpName}" readonly="readonly"/>
												<% }%>
												<script type="text/javascript">
										
										jQuery(document).ready(function($)
										{
											if(action=="save"){
											getLpName();
											}
											
										});
										
										function getLpName(){
										
										$("#lpName").select2({
												minimumInputLength: 1,
												placeholder: '请输入搜索',
												ajax: {
													url: basepath+"/newenv/lpzd/fanghaogetByLpName.action",
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
													return "<div class='select2-user-result' >" + student.lpName + "</div>"; 
												},
												formatSelection: function(student) { 
													return  student.lpName; 
												}
												
											}) .on("change",function(e){
												getBYLDong(e.val);
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
										}
									</script>
											</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon red">栋座：</span>
												<select class="form-control" id="LDong" data-value="${fanghao.dzId}" onchange="getBYdzId(this)">
													<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon red">单元：</span>
												<select class="form-control"  id="dyId" data-value="${fanghao.dyId}" name="fanghao.dyId" onchange="getBYceng(this)">
													<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon red">层号：</span>
												<select class="form-control" id="ceng" data-value="${fanghao.ceng}" name="fanghao.ceng" onchange="getBYfangHao(this)">
													<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon red">房号：</span>
												<input type="hidden" name="fanghao.yzid" id="yzid" value="${fanghao.yzid}"/>
												<select class="form-control" id="fangHao" data-value="${fanghao.id}"  name="fanghao.id">
													<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				
				
				<div class="panel-default">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								房屋基本信息
							</div>
							<div class="panel-body">
								<div class="row col-lg-10 col-md-12 col-xs-12 col-sm-12">
									<div class="col-md-12 col-sm-12">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon red">户型：</span>
												<select class="form-control"  id="shi" name="fanghao.shi" data-value="${fanghao.shi}">
												<option value="0">请选择</option>
												<option value="1" ${fanghao.shi=='1'?"selected=true":""}>一室</option>
												<option value="2" ${fanghao.shi=='2'?"selected=true":""}>二室</option>
												<option value="3" ${fanghao.shi=='3'?"selected=true":""}>三室</option>
												<option value="4" ${fanghao.shi=='4'?"selected=true":""}>四室</option>
												<option value="5" ${fanghao.shi=='5'?"selected=true":""}>五室</option>
												<option value="6" ${fanghao.shi=='6'?"selected=true":""}>五室以上</option>
												</select>
												<span class="input-group-addon">-</span>
												<select class="form-control"  id="ting" name="fanghao.ting" data-value="${fanghao.ting}">
												<option value="0">请选择</option>
												<option value="1" ${fanghao.ting=='1'?"selected=true":""} >一厅</option>
												<option value="2" ${fanghao.ting=='2'?"selected=true":""}>二厅</option>
												<option value="3" ${fanghao.ting=='3'?"selected=true":""}>三厅</option>
												<option value="4" ${fanghao.ting=='4'?"selected=true":""}>四厅</option>
												</select>
												<span class="input-group-addon">-</span>
												<select class="form-control"  id="chu" name="fanghao.chu" data-value="${fanghao.chu}">
												<option value="0">请选择</option>
												<option value="1" ${fanghao.chu=='1'?"selected=true":""}>一厨</option>
												<option value="2" ${fanghao.chu=='2'?"selected=true":""}>二厨</option>
												<option value="3" ${fanghao.chu=='3'?"selected=true":""}>三厨</option>
												<option value="4" ${fanghao.chu=='4'?"selected=true":""}>四厨</option>
												</select>
												<span class="input-group-addon">-</span>
												<select class="form-control"  id="wei" name="fanghao.wei" data-value="${fanghao.wei}">
												<option value="0">请选择</option>
												<option value="1" ${fanghao.wei=='1'?"selected=true":""}>一卫</option>
												<option value="2" ${fanghao.wei=='2'?"selected=true":""}>二卫</option>
												<option value="3" ${fanghao.wei=='3'?"selected=true":""}>三卫</option>
												<option value="4" ${fanghao.wei=='4'?"selected=true":""}>四卫</option>
												</select>
												<span class="input-group-addon">-</span>
												<select class="form-control" name="fanghao.yang">
													<option value="0" >请选择</option>
													<option value="1" ${fanghao.yang=='1'?"selected=true":""}>一阳台</option>
													<option value="2" ${fanghao.yang=='2'?"selected=true":""}>二阳台</option>
													<option value="3" ${fanghao.yang=='3'?"selected=true":""}>三阳台</option>
													<option value="4" ${fanghao.yang=='4'?"selected=true":""}>四阳台</option>
												</select>
											</div>
										</div>
									</div>
									<div class="clearfix"></div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">房屋朝向：</span>
												<select class="form-control"  id="chaoXiang" name="fanghao.chaoXiang" data-value="${fanghao.chaoXiang}">
												<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">产权性质：</span>
												<select class="form-control"  id="cqxz" name="fanghao.cqxz" data-value="${fanghao.cqxz}">
												<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">套内面积：</span>
												<input type="text" class="form-control" name="fanghao.tnmj" value="${fanghao.tnmj}">
												<span class="input-group-addon">㎡</span>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">房屋类型：</span>
												<select class="form-control"  id="leixing" name="fanghao.leixing" data-value="${fanghao.leixing}">
												<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">产权地址：</span>
												<input type="text" class="form-control" name="fanghao.propertyAddress" value="${fanghao.propertyAddress}">
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">产权编码：</span>
												<input type="text" class="form-control" name="fanghao.propertyNumber" value="${fanghao.propertyNumber}">
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">产权年限：</span>
												<select class="form-control"  id="propertyAg" name="fanghao.propertyAge" data-value="${fanghao.propertyAge}">
												<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">产权面积：</span>
												<input type="text" class="form-control" name="fanghao.cqmj" value="${fanghao.cqmj}">
												<span class="input-group-addon" >㎡</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="panel-default">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								业主基本信息
							</div>
							<div class="panel-body">
								<div class="row col-lg-10 col-md-12 col-xs-12 col-sm-12">
									<div class="col-md-4 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon red">业主姓名：</span>
												<input type="text" class="form-control"  id="yezhuname" name="yezhu.name"  value="${yezhu.name}"/>
												<input type="hidden" class="form-control"   name="yezhu.id"  value="${yezhu.id}"/>
												<span class="input-group-addon" style="padding: 0;"></span>
												<select class="form-control" style="width: 80px;" name="yezhu.gender">
													<option value="">请选择</option>
													<option value="0" ${yezhu.gender=='0'?"selected=true":""}>男士</option>
													<option value="1" ${yezhu.gender=='1'?"selected=true":""} >女士</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-5 col-sm-3">
									<div id="addButton">
										<div class="form-group" >
											<div class="input-group input-group-minimal">
												<span class="input-group-addon red">联系电话：</span>
												
												<input type="text" class="form-control" name="contact[0].telephone"  id="telephone"/>
												<span class="input-group-addon" style="padding: 0;"></span>
												 <select class="form-control"  id="relationType0" name="contact[0].relationType"  style="width: 80px">
												<option value="0">请选择</option>
												</select> 
												<span class="input-group-addon" onclick="adddiv()"><i class="fa-plus" ></i></span>
												
											</div>
											<p class="help-block red">系统查询到该联系方式下有3位经纪人维护<a href="#">查询</a></p>
										</div>
										</div>
									</div>
									<div class="clearfix"></div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">微信：</span>
												<input type="text" class="form-control" name="yezhu.weXin"  id="weXin" value="${yezhu.weXin}"/>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">QQ：</span>
												<input type="text" class="form-control" name="yezhu.qq"  id="qq" value="${yezhu.qq}"/>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">身份证：</span>
												<input type="text" class="form-control" name="yezhu.identityCode" id="identityCode" value="${yezhu.identityCode}"/>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">国籍：</span>
												<select class="form-control"  id="nationality" name="yezhu.nationality"  data-value="${yezhu.nationality}">
												<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">所在城市：</span>
												<select class="form-control"  id="cityId" name="yezhu.cityId"  data-value="${yezhu.cityId}">
													<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">电子信箱：</span>
												<input type="text" class="form-control" name="yezhu.email" id="email"  value="${yezhu.email}"/>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<button type="button" class="btn btn-info btn-single" onclick="Openmore()">展开更多选项 <i class="fa-caret-right"></i></button>
										</div>
									</div>
									<div class="clearfix"></div>
									<div class="row" style="display:none" id="openmore">
										<div class="col-md-3 col-sm-3">
											<div class="form-group">
												<div class="input-group input-group-minimal">
													<span class="input-group-addon">消费观念：</span>
													<select class="form-control"  id="consumptionConcept" name="yezhu.consumptionConcept"  data-value="${yezhu.consumptionConcept}">
														<option value="0">请选择</option>
													</select>
												</div>
											</div>
										</div>
										<div class="col-md-3 col-sm-3">
											<div class="form-group">
												<div class="input-group input-group-minimal">
													<span class="input-group-addon">教育程度：</span>
													<select class="form-control"  id="education" name="yezhu.education"  data-value="${yezhu.education}">
														<option value="0">请选择</option>
													</select>
												</div>
											</div>
										</div>
										<div class="col-md-3 col-sm-3">
											<div class="form-group">
												<div class="input-group input-group-minimal">
													<span class="input-group-addon">工作性质：</span>
													<select class="form-control"  id="workType" name="yezhu.workType"  data-value="${yezhu.workType}">
														<option value="0">请选择</option>
													</select>
												</div>
											</div>
										</div>
										<div class="col-md-3 col-sm-3">
											<div class="form-group">
												<div class="input-group input-group-minimal">
													<span class="input-group-addon">出生日期：</span>
													<input type="text" class="form-control form_date"  readonly="readonly" name="yezhu.birthday" value="${birthday}"/>
												</div>
											</div>
										</div>
										 <div class="col-md-3 col-sm-3">
											<div class="form-group">
												<div class="input-group input-group-minimal">
													<span class="input-group-addon">工作单位：</span>
													<input type="text" class="form-control" name="yezhu.workPlace" value="${yezhu.workPlace}"/>
												</div>
											</div>
										</div>
										<div class="col-md-3 col-sm-3">
											<div class="form-group">
												<div class="input-group input-group-minimal">
													<span class="input-group-addon">单位地址：</span>
													<input type="text" class="form-control" name="yezhu.officeAddress" value="${yezhu.officeAddress}"/>
												</div>
											</div>
										</div>
										<div class="col-md-6 col-sm-6">
											<div class="form-group">
												<div class="input-group input-group-minimal">
													<span class="input-group-addon">现家庭地址：</span>
													<input type="text" class="form-control" name="yezhu.homeAddress"  value="${yezhu.homeAddress}"/>
												</div>
											</div>
										</div>
										
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				
				
				<div class=" panel-default">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								户型图
							</div>
							<div class="panel-body">
								
								<div class="col-lg-10">
									<div class="col-lg-4">
										<div class="form-group">
											<div class="input-group input-group-minimal"  id="fkContainer">
											<span class="input-group-addon">上传图片：</span>
												<div class="col-sm-3" id="fkContainer">
												<a id="fkPickfiles" href="javascript:void(0);">
					                				<button type="button" class="btn btn-success">上传</button> 
					                			</a>
											</div>
											</div>
										</div>
									</div>
									<div class="clearfix"></div>
									<section class="gallery-env">

										<div class="row">
											<!-- Gallery Album Optipns and Images -->
											<div class="gallery-left col-lg-12">
	
												<!-- Album Images -->
												<div class="tab-pane active" id="ulHouseExclusiveFiles0">
														<div class="panel-body">
														</div>
													</div>
	
											</div>
	
											<!-- Gallery Sidebar -->
										</div>
	
									</section>
								</div>

							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class=" panel-default">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								证件图
							</div>
							<div class="panel-body">
								
								<div class="col-lg-10">
									<div class="col-lg-4">
										<div class="form-group">
											<div class="input-group input-group-minimal"  id="fkContainer">
											<span class="input-group-addon">上传图片：</span>
												<div class="col-sm-5" id="fkyzContainer">
												<a id="fkyzPickfiles" href="javascript:void(0);">
					                				<button type="button" class="btn btn-success">上传</button> 
					                			</a>
											</div>
											</div>
										</div>
									</div>
									<div class="clearfix"></div>
									<section class="gallery-env ">

										<div class="row">
											<!-- Gallery Album Optipns and Images -->
											<div class="gallery-left col-lg-12">
	
												<!-- Album Images -->
												<div class="tab-pane active" id="ulHouseExclusiveFiles1">
														<div class="panel-body">
														</div>
													</div>
	
											</div>
	
											<!-- Gallery Sidebar -->
										</div>
	
									</section>
								</div>

							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				
				<div class="text-center">
					<input type="button" class="btn btn-success"  onclick="saveFanghao()" id="btnSavefanghao" value="保存"/>
					<input type="button" class="btn btn-success" onclick="historyback()" value="返回"/>
				</div>
				

				<!-- Main Footer -->
			</div>
			</form>

		</div>
</div>
		<div class="go-up" style="position: fixed;right: 15px; bottom: 10px; z-index: 9999; background: #f7aa47;padding: 10px;filter:alpha(opacity=50);moz-opacity:0.5;opacity:0.5;">
			<a href="#" rel="go-top">
				<i class="fa-arrow-up" style="font-size: 3em;"></i>
			</a>
		</div>
	</body>

</html>
<script type="text/javascript" src="<%=basePath%>/js/plupload/plupload.full.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/plupload/i18n/zh_CN.js"></script>
<script src="<%=basePath%>/js/person/pluploadfile.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/person/pluploadfileyz.js" type="text/javascript"></script>
<!-- Bottom Scripts -->
<script src="<%=basePath%>/assets/js/bootstrap.min.js"></script>
<script src="<%=basePath%>/assets/js/TweenMax.min.js"></script>
<script src="<%=basePath%>/assets/js/resizeable.js"></script>
<script src="<%=basePath%>/assets/js/joinable.js"></script>
<script src="<%=basePath%>/assets/js/xenon-api.js"></script>
<script src="<%=basePath%>/assets/js/xenon-toggles.js"></script>
<script src="<%=basePath%>/assets/js/moment.min.js"></script>

<script src="<%=basePath%>/assets/js/rwd-table/js/rwd-table.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script src="<%=basePath%>/assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>

<!-- Imported scripts on this page  xiala-->
<link rel="stylesheet" href="<%=basePath%>/assets/js/daterangepicker/daterangepicker-bs3.css">
<link rel="stylesheet" href="<%=basePath%>/assets/js/select2/select2.css">
<link rel="stylesheet" href="<%=basePath%>/assets/js/select2/select2-bootstrap.css">
<link rel="stylesheet" href="<%=basePath%>/assets/js/multiselect/css/multi-select.css">
<script src="<%=basePath%>/assets/js/rwd-table/js/rwd-table.js"></script>
<script src="<%=basePath%>/assets/js/daterangepicker/daterangepicker.js"></script>
<script src="<%=basePath%>/assets/js/datepicker/bootstrap-datepicker.js"></script>
<script src="<%=basePath%>/assets/js/timepicker/bootstrap-timepicker.min.js"></script>
<script src="<%=basePath%>/assets/js/colorpicker/bootstrap-colorpicker.min.js"></script>
<script src="<%=basePath%>/assets/js/select2/select2.min.js"></script>
<script src="<%=basePath%>/assets/js/xenon-custom.js"></script>

<link rel="stylesheet" href="<%=basePath%>/assets/js/datepicker/bootstrap-datetimepicker.min.css">
<!-- Imported scripts on this page  xiala-->
<script type="text/javascript" src="<%=basePath%>/assets/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/datepicker/bootstrap-datetimepicker.zh-CN.js"></script>

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
	$(".form_datetime").datetimepicker({
		format: 'yyyy-mm-dd:hh:ii',
		language: 'zh-CN',
	});
</script>

<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".s2example").select2({
			placeholder: 'Select your country...',
			allowClear: true
		}).on('select2-open', function() {
			// Adding Custom Scrollbar
			$(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
		});
	});
</script>

<script type="text/javascript">
	// Sample Javascript code for this page
	jQuery(document).ready(function($) {
		// Edit Modal
		$('.gallery-env a[data-action="edit"]').on('click', function(ev) {
			ev.preventDefault();
			$("#gallery-image-modal").modal('show');
		});
		// Delete Modal
		$('.gallery-env a[data-action="trash"]').on('click', function(ev) {
			ev.preventDefault();
			$("#gallery-image-delete-modal").modal('show');
		});
		// Sortable
		$('.gallery-env a[data-action="sort"]').on('click', function(ev) {
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

