<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>

<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page isELIgnored="false"%>

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
<title>采集详情</title>
<link rel="stylesheet" href="<%=basePath%>/assets/css/bootstrap.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-core.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-forms.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-components.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-skins.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/custom.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xiaoqu.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/js/bootbox/bootbox.css">
		
		<script type="text/javascript">
			var basepath = "<%=basePath%>";
		</script>
		<script type="text/javascript" src="<%=basePath%>/assets/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/assets/js/page.js"></script>
		<script type="text/javascript" src="<%=basePath%>/assets/js/bootbox/bootbox.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/js/ext/exttab/js/ext-base.js" ></script> 
		<script type="text/javascript" src="<%=basePath%>/js/ext/exttab/js/ext-all.js" ></script> 
		<script type="text/javascript" src="<%=basePath%>/js/comm/commInfo.js"></script>
		
		<script type="text/javascript" src="<%=basePath%>/js/campus/addCampusBySpider.js"></script>
		<script type="text/javascript" src="<%=basePath%>/js/campus/facilities.js"></script>
		<script type="text/javascript" src="./weihudanwei.js"></script>
		<script type="text/javascript" src="./liveCost.js"></script>
		<script type="text/javascript" src="./image.js"></script>
		<script type="text/javascript" src="./uplptp.js"></script>
		<script type="text/javascript" src="./lpDong.js"></script>
		<script type="text/javascript" src="./jquery.zclip.min.js"></script>
		<script type="text/javascript" src="./pluploadfile.js" type="text/javascript"></script>	
		<script src="./jquery.rotate.js" type="text/javascript"></script>
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
								<a href="./index.jsp?p=spider&k=cjzl">
								<strong>采集数据处理</strong>
								</a>
							</li>
							<li class="active">
								<strong>保存数据</strong>
							</li>
						</ol>
					</div>
				</div>
				<div id="rootwizard" class="form-wizard">
				<ul class="tabs" id="navtabs">
					<li class="active"><a href="#tab1" data-toggle="tab">基础信息</a></li>
					<li><a href="#tab2" data-toggle="tab" onclick="mantenanceQuery();">楼盘维护</a></li>
					<li><a href="#tab3" data-toggle="tab" onclick="initUploader()">楼盘图库</a></li>

					<li><a href="#tab4" data-toggle="tab">栋座资料</a></li>
					<li><a href="#tab5" data-toggle="tab">配套设施</a></li>
				</ul>
				
				<div class="tab-content">
					<div class="tab-pane active" id="tab1">
						<div class="panel panel-default">
							<div class="panel-body">

								<form id="lpxxForm" class="form-horizontal" role="form">
								
									<input type="hidden" id="usCountry" value="<%=SecurityUserHolder.getCurrentUserLogin().getCountryId()%>">
									<input type="hidden" id="usPro" value="${proId}">
									<input type="hidden" id="usCity" value="${cityId}">
									<input type="hidden" id="usQyId" value="${qyId}">
									<input type="hidden" id="usSqId" value="${sqId}">
									
									<table class="table table-bordered table-striped table-condensed">
										<tr>
											<td>
												<div class="input-group input-group-minimal">
													<span class="input-group-addon red">国家：</span>
													<select class="form-control s2example" id="country" name="lpxx.countryid" onchange="buildCountry(this.value)">
														<option>请选择</option>
													</select>
												</div>
											</td>
											<td>
												<div class="input-group input-group-minimal">
													<span class="input-group-addon red">省份/州：</span>
													<select class="form-control s2example" id="pro" name="lpxx.provinceid" onchange="buildCity(this.value)">
														<option>请选择</option>
													</select>
												</div>
											</td>
											<td>
												<div class="input-group input-group-minimal">
													<span class="input-group-addon red">城市：</span>
													<select class="form-control s2example" id="city" name="lpxx.cityId" onchange="buildQy(this.value)">
														<option>请选择</option>
													</select>
												</div>
											</td>
											<td style="width:320px;"></td>
										</tr>
									</table>
								
									<input id="lpxxid" name="lpxx.id" type="hidden" value="0">
									
									<table class="table table-bordered table-striped table-condensed">
										<thead>
											<tr>
												<td width="13%" align="center"><strong>采集字段</strong></td>
												<td width="27%" align="center"><strong>系统字段</strong></td>
												<td width="20%" align="center"><strong>搜房</strong></td>
												<td width="20%" align="center"><strong>安居客</strong></td>
												<td width="20%" align="center"><strong>0731新房网</strong></td>
											</tr>
										</thead>
										<tbody class="middle-align" id="tbodyDetailData">
										</tbody>
									</table>
									
									<div>
										<div style="float:left;width:135px;padding-left:10px;">来源</div>
										<div style="float:left;width:300px;">&nbsp;</div>
										<div style="float:left;width:217px;"><input id="url1" type="text" size="13" style="float:left;" /><input class="copy_btn" type="button" value="复制"/></div>
										<div style="float:left;width:217px;"><input id="url2" type="text" size="13" style="float:left;" /><input class="copy_btn" type="button" value="复制"/></div>
										<div style="float:left;width:217px;"><input id="url3" type="text" size="13" style="float:left;" /><input class="copy_btn" type="button" value="复制"/></div>
									</div>
									
									<table class="table table-bordered table-striped table-condensed">
										<tr>
											<td align="center"><input type="button" class="btn btn-success" onclick="queryFloorInfo()" value="保存"/></td>
										</tr>
									</table>
									<div id="macPageWidget1" style="display:none;"></div>
								</form>
							</div>
						</div>
					</div>
					
						<div class="tab-pane" id="tab2">
							<div class="panel panel-default">
								<div class="panel-body">
<!-- 									<form role="form" class="form-horizontal" id="wyForm"> -->
										<input type="hidden" name="wyxx.id" id="wuyeid"/>
										<input type="hidden" name="wyxx.xhjLpxx.id" id="wuyelpid"/>
										<div class="panel-heading">
										<div class="panel-options pull-left">
											<ul class="nav nav-tabs">
												<li class="active">
													<a href="#tab-1" onclick="mantenanceQuery();" data-toggle="tab">维护单位</a>
												</li>
												<li>
													<a href="#tab-2" onclick="costQuery();" data-toggle="tab">居住成本</a>
												</li>
											</ul>
										</div>
									</div>

									<div class="panel-body">
										<div class="tab-content">
											<div class="tab-pane active" id="tab-1">
												<div>
													<button class="btn btn-secondary" data-toggle="modal" onclick="mantenanceInitial();"><i class="fa-plus"></i> 新增 </button>
													<a href="#" data-toggle="modal" id="weihudanweiApp" data-target="#weihudanwei"></a>
												</div>
												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<th width="50">
																	<div class="cbr-replaced">
																		<div class="cbr-input">
																			<input type="checkbox" class="cbr cbr-done">
																		</div>
																		<div class="cbr-state"><span></span></div>
																	</div>
																</th>
																<th>类型</th>
																<th>企业单位名称</th>
																<th>联系方式</th>
																<th>单位地址</th>
																<th>备注</th>
																<th>操作</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="tbodyData">
														</tbody>
													</table>
												</div>
											</div>

											<div class="tab-pane" id="tab-2">
												<div>
													<button class="btn btn-secondary" data-toggle="modal" onclick="costInitial();"><i class="fa-plus"></i> 新增 </button>
														<a href="#" data-toggle="modal" id="juzhuchengbenAdd" data-target="#juzhuchengben"></a>
												</div>
												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<th width="50">
																	<div class="cbr-replaced">
																		<div class="cbr-input">
																			<input type="checkbox" class="cbr cbr-done">
																		</div>
																		<div class="cbr-state"><span></span></div>
																	</div>
																</th>
																<th>费用类型</th>
																<th>计收方式</th>
																<th>金额/单价</th>
																<th>计量单位</th>
																<th>备注</th>
																<th>操作</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="costBody">
														</tbody>
													</table>
												</div>
											</div>
										</div>

									</div>
								</div>
							</div>
						</div>

						<div class="tab-pane" id="tab3">
							<div class="panel panel-default">
								<div class="panel-heading">
									<ul class="nav nav-tabs">
										<li class="active"><a href="" data-toggle="tab">小区图库</a>
										</li>
									</ul>
								</div>

								<div class="panel-body">
									<form role="form" class="form-horizontal" id="lpimageForm">
										<input type="hidden" name="tuplpid" id="tuplpid">
										<div id="webImageofhouse_image_hidden"></div>

										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3"><span class="red">图片选择</span></label>
											<div class="col-sm-8">
												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<!--
															<tr>
																<th>搜房</th>
																<th>安居客</th>
																<th>0731新房网</th>
																<th>58同城</th>
															</tr>
															-->
															<tr>
																<th>来源</th>
																<th>图片</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="imageListBody">
														</tbody>
													</table>
													<div id="imagePageWidget"></div>
												</div>
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3"><span class="red">图片类型</span></label>
											<div class="col-sm-8">
												<select class="form-control" id="houseExclusiveImgType" onchange="imageQuery();">
													<option value="3">环境图</option>
													<option value="1">户型图</option>
													<option value="2">交通图</option>
													<option value="4">样板图</option>
													<option value="5">效果图</option>
												</select>
											</div>
										</div>
										<div style="display:none" id="selectshi">
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3" ><span class="red">居室：</span></label>
											<div class="col-sm-8">
											<select class="form-control" id="jushi">
												<option value="1">一居室</option>
												<option value="2">二居室</option>
												<option value="3">三居室</option>
												<option value="4">四居室</option>
												<option value="5">N居室</option>
											</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3" ><span class="red">厅：</span></label>
											<div class="col-sm-8">
											<select class="form-control" id="tpting">
												<option value="1">一厅</option>
												<option value="2">二厅</option>
												<option value="3">三厅</option>
												<option value="4">四厅</option>
												<option value="5">N厅</option>
											</select>
										</div>
									   </div>
										<div class="form-group" >
											<label class="col-sm-2 control-label" for="field-3" ><span class="red">卫：</span></label>
											<div class="col-sm-8">
											<select class="form-control" id="tpwei">
												<option value="1">一卫</option>
												<option value="2">二卫</option>
												<option value="3">三卫</option>
												<option value="4">四卫</option>
												<option value="5">N卫</option>
											</select>
										</div>
									</div>
									</div>
									<div id="fenggediv" style="display: none;">
											<div class="form-group">
														<label class="col-sm-2 control-label" for="field-3"><span class="red">风格：</span></label>
														<div class="col-sm-8">
														<select class="form-control" id="fengge">
															<option value="1">新古典</option>
															<option value="2">美式</option>
															<option value="3">现代简约</option>
															<option value="4">公寓</option>
															<option value="5">地中海风格</option>
															<option value="6">厨卫</option>
														</select>
													</div>
											</div>
										</div>
										<div class="form-group" style="display: none;">
											<label class="col-sm-2 control-label" for="field-3"><span class="red">图片名称</span></label>

											<div class="col-sm-8">
												<input type="input" class="form-control" id="imgNameAll" name="imgNameAll" placeholder="">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3">上传图片</label>
											
											<div class="col-sm-5" id="fkContainer">
												<input type="button" class="btn btn-success" id="fkPickfiles"  value="上传"> 
												<span style="color:red;">(请上传大小在800*640、5M以内的jpg、png、gif格式图片)</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3">全部图片</label>
											<div class="col-sm-8">
												<div class="panel-heading">
													<ul class="quanbu nav nav-tabs">
														<li class="active"><a href="#ulHouseExclusiveFiles3" id="houseExclusiveImgType3" data-toggle="tab">环境图</a></li>
														<li><a href="#ulHouseExclusiveFiles1" id="houseExclusiveImgType1" data-toggle="tab">户型图</a></li>
														<li><a href="#ulHouseExclusiveFiles2" id="houseExclusiveImgType2" data-toggle="tab">交通图</a></li>
														<li><a href="#ulHouseExclusiveFiles4" id="houseExclusiveImgType4" data-toggle="tab">样板图</a></li>
														<li><a href="#ulHouseExclusiveFiles5" id="houseExclusiveImgType5" data-toggle="tab">效果图</a></li>
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
										<div class="form-group">
											<div class="col-md-5 col-md-offset-5">
												<button type="submit" class="btn btn-success">保存</button>
												<input type="button" class="btn btn-success" onclick="cancel()" value="返回列表"/>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
						
						
						
						
						<div class="tab-pane with-bg" id="tab4">
							<div class="panel-body col-lg-3">
										<div class="input-group" style="padding-bottom: 10px;">
											<input type="text" class="form-control no-right-border form-focus-purple"  placeholder="请输入栋座名称" id="lpdong_lpdName">
											<span class="input-group-btn">
												<a href="javascript:queryDong()" class="btn btn-success">搜索</a>
											</span>
										</div>
										<div>
											<a href="" class="btn btn-success btn-xs" data-toggle="modal" onclick="showAddDongDlg()" data-target="#Donglou">新增栋楼</a>
											<button class="btn btn-danger btn-xs" onclick="batchDeleteLpD()">批量删除</button>
										</div>
											<div class="col-lg-12">
												<div class="table-responsive scrollable" data-max-height="500">
													<table class="table table-bordered" id="tblLpdong">
														<thead >
															<tr>
																<th class="center-text" ><input type="checkbox" class="lpdz"/></th>
																<th  class="center-text" class="thfont">序列</th>
																<th  class="center-text"  class="thfont">栋座</th>
																<th  class="center-text" class="thfont">操作</th>
															</tr>
														</thead>
														<tbody class="middle-align Color" id="dongTbody">
														</tbody>
													</table>
												</div>
											</div>
										</div>		
							<div class="panel-body col-lg-5">
										<div class="input-group" style="padding-bottom: 10px;">
													<input type="text" class="form-control no-right-border form-focus-purple"  placeholder="请输入层名称" id="fangHao_ceng">
													<span class="input-group-btn">
														<a href="javascript:queryCeng()" class="btn btn-success">搜索</a>
													</span>
										</div>
											<div class="col-lg-12" style="padding-top: 42px;">
												<button class="btn btn-success btn-xs" onclick="showAddDanyuanDlg()">新增单元</button>
												<a data-toggle="modal" id="addDanYuan" data-target="#Danyuan"></a>
												<a data-toggle="modal" id="updateDanYan" data-target="#danyuanxiugai"></a>
												<button class="btn btn-success btn-xs" onclick="showCorHouseInitDanYan()">查询关联房源</button>
												<a href="" data-toggle="modal" id="showCrrHouseModalDanYan" data-target="#Guanlianfangyuan"></a>
												<button class="btn btn-danger btn-xs" onclick="batchdeleteDanyuan()">批量删除</button>
											</div>
											<div class="col-lg-7">
												<div class="table-responsive scrollable" data-max-height="500">
													<table class="table table-bordered " id="tblLpdanyuan">
														<thead>
															<tr>
															<th  class="center-text"><input type="checkbox" class="lpdy"/></th>
																<th class="thfont center-text">序列</th>
																<th  class="thfont center-text">单元</th>
																<th  class="thfont center-text">操作</th>
															</tr>
														</thead>
														<tbody class="middle-align Color">
															
														</tbody>
													</table>
												</div>
											</div>
											
											<div class="col-lg-5">
												<div class="table-responsive scrollable" data-max-height="500">
													<table class="table table-bordered table-striped"  id="tblLpceng">
														<thead>
															<tr>
																<th class="thfont center-text">序列</th>
																<th class="thfont center-text">层号</th>
															</tr>
														</thead>
														<tbody class="middle-align Color">
															
														</tbody>
													</table>
												</div>
											</div>
										</div>
										
										
							<div class="panel-body col-lg-4">
											<div class="col-lg-12" style="padding-top: 42px;">
											<button class="btn btn-success btn-xs" onclick="showAddFanghaoDlg()">新增房号</button>
											<a data-toggle="modal" id="addFanghao" data-target="#Fanghao"></a>
											<a data-toggle="modal" id="updFanghao" data-target="#Fanghaoxiugai"></a>
											<button class="btn btn-success btn-xs" onclick="showCorHouseInit()">查询关联房源</button>
											<a href="" data-toggle="modal" id="showCrrHouseModal" data-target="#Guanlianfangyuan"></a>
											<button class="btn btn-danger btn-xs" onclick="batchDeleteFanghao()">批量删除</button>
										</div>
											<div class="col-lg-12">
												<div class="table-responsive scrollable" data-max-height="500">
													<table class="table table-bordered table-striped" id="tblLpfanghao">
														<thead>
															<tr>
																<th  class="center-text"><input type="checkbox" class="cbALL"/></th>
																<th class="thfont center-text">序列</th>
																<th class="thfont center-text">房号</th>
																<th class="thfont center-text">操作</th>
															</tr>
														</thead>
														<tbody class="middle-align Color">
															
														</tbody>
													</table>
												</div>
											</div>
										</div>
										<div class="panel-body">
										<div class="text-center ">
											<textarea class="form-control" id="dzRemark" cols="5" id="field-5" >${loadLpxx.dzRemark}</textarea>
											<br>
											<button onclick="saveDzRemark()" class="btn btn-success">保存备注</button>
											<input type="button" class="btn btn-success" onclick="cancel()" value="返回列表"/>
										</div>
									</div>		
							<div class="clearfix"></div>
						</div>
						
						
						
						
						<div class="tab-pane" id="tab5">
							<div class="panel panel-default">
								<div class="panel panel-default">
									<div class="panel-heading">
										<ul class="nav nav-tabs">
											<li class="active"><a href="#tab-98" data-toggle="tab">划片学校</a></li>
											<li><a href="#tab-99" data-toggle="tab">服务网点</a></li>
											<li><a href="#tab-97" data-toggle="tab">地铁</a></li>
										</ul>
									</div>
									
									<div class="tab-content">
										<div class="tab-pane active" id="tab-98">
											<div class="panel-body">
												<div>
													<button class="btn btn-success" onclick="schoolInit();">新增</button>
													<a href="" data-toggle="modal" id="showSchoolAdd" data-target="#xinzenhuapian"></a>
													<a href="" data-toggle="modal" id="showUpd" data-target="#xinzenhuapian1"></a>
												</div>
											</div>
											<div class="table-responsive">
												<table class="table table-bordered table-striped">
													<thead>
														<tr>
															<th>学校类型</th>
															<th>学校名称</th>
															<th>划片范围</th>
															<th>划片类型</th>
															<th>操作</th>
														</tr>
													</thead>
													<tbody class="middle-align" id="lpSchoolInfo">
													
													</tbody>
												</table>
											</div>
										</div>
										<div class="tab-pane" id="tab-99">

											<div class="panel-body">
												<div class="col-lg-3">
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

												<div class="col-lg-3">
													<div class="form-group">
														<div
															class="input-group input-group-sm input-group-minimal">
															<span class="input-group-addon">服务网点：</span>
															<select class="form-control s2example-1" id="serviceWD">
															</select>
														</div>
													</div>
												</div>
												<div class="col-lg-3">
													<div class="form-group">
														<button class="btn btn-secondary" onclick="loadLpFuzh()">查询</button>
													</div>
												</div>
												<div class="clearfix"></div>
											</div>

											<div class="panel-body">
												<div>
													<button class="btn btn-success" onclick="addZerenInit()">新增责任盘</button>
													<a data-toggle="modal" id="zerenModal" data-target="#xinzenhuapian4"></a>
													<button class="btn btn-success" onclick="addWeihInit('weih')">新增维护盘</button>
													<a data-toggle="modal" id="weihModal" data-target="#xinzenhuapian2"></a>
													<button class="btn btn-success" onclick="addWeihInit('fanw')">新增范围盘</button>
													<a data-toggle="modal" id="fanwModal" data-target="#xinzenhuapian3"></a>
												</div>
											</div>
											<div class="table-responsive">
												<table class="table table-bordered table-striped">
													<thead>
														<tr>
															<th>
																<input type="checkbox" class="cbr" />
															</th>
															<th>服务范围</th>
															<th>服务来源</th>
															<th>服务网店（店组）</th>
															<th>网点地址</th>
															<th>服务电话</th>
															<th>操作</th>
														</tr>
													</thead>
													<tbody class="middle-align" id="showLpHuaPanInfo">
														
													</tbody>
												</table>
												<div id="macPageWidget"></div>
											</div>
										</div>
										<div class="tab-pane" id="tab-97">
											<div class="panel-body">
												<div>
													<button class="btn btn-success" onclick="addMetorInit(this)"; >新增地铁</button>
													<a data-toggle="modal" herf="" data-target="#xinzendite1"></a>
												</div>
											</div>
											<div class="table-responsive">
												<table class="table table-bordered table-striped">
													<thead>
														<tr>
															<th>序号</th>
															<th>线路</th>
															<th>名称</th>
															<th>操作</th>
														</tr>
													</thead>
													<tbody class="middle-align" id="metorInfo">
													</tbody>
												</table>
											</div>
										</div>


									</div>
									<!-- tab-content  -->
									<input type="button" class="btn btn-success" onclick="cancel()" value="返回列表"/>
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




<!--part2: 维护单位-->
<div class="modal fade" id="weihudanwei" data-backdrop="static">
	<div class="modal-dialog" style="width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">编辑维护单位</h4>
			</div>
			<div class="modal-body">
				<input type="hidden" class="form-control" id ="lpmId" value="0"/>
				
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th>采集字段</th>
							<th>编辑内容</th>
							<th>搜房</th>
							<th>安居客</th>
							<th>0731新房网</th>
						</tr>
					</thead>
					<tbody class="middle-align" id="mantenanceEditorTable">
						<tr>
							<td>类型</td>
							<td style="word-wrap:break-word;"><select class="form-control s2example" id="maintenanceType" onchange="updateMaintenanceTable();"></select></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="saveMantenance()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="buttong()">关闭</button>
			</div>
		</div>
	</div>
</div>

<!--part3:居住成本-->
<div class="modal fade" id="juzhuchengben" data-backdrop="static">
	<div class="modal-dialog" style="width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">编辑居住成本</h4>
			</div>
			
			<div class="modal-body">
				<input type="hidden" class="form-control" id ="costId" value="0"/>
				
				<!--
				<input type="hidden" class="form-control" id ="costlpid"  value="${loadlpxx.id}"/>
				-->
				
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th>采集字段</th>
							<th>编辑内容</th>
							<th>搜房</th>
							<th>安居客</th>
							<th>0731新房网</th>
						</tr>
					</thead>
					<tbody class="middle-align" id="coseEditorTable">
						<tr>
							<td>类型</td>
							<td style="word-wrap:break-word;"><select class="form-control s2example" id="ctype" onchange="updateLiveTable();"></select></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>计收方式</td>
							<td style="word-wrap:break-word;"><select class="form-control s2example" id="payingWay" onchange="updateUnit();"></select></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="costSave();">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="costWindowClose();">关闭</button>
			</div>
		</div>
	</div>
</div>



<!--part 4.1:新增栋座-->
<div class="modal fade" id="Donglou" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增栋座</h4>
			</div>
			<form role="form" class="form-horizontal" id="donglouForm">
			<div class="modal-body">
				<div class="scrollable" data-max-height="600">
					<table class="table" id="tblAddDong">
						<tbody>
							<tr>
								<td width="90">新增方式</td>
								<td>
									<label class="radio-inline"> 
										<input type="radio" id="status1" name="xhjLpdong.type" value="Single" checked="checked" class="checkbox" onclick="dongAddTypeClicked(this)"> <span>单个添加</span>
									</label>
									<label class="radio-inline"> 
										<input type="radio" id="status1" name="xhjLpdong.type" value="Batch" onclick="dongAddTypeClicked(this)"> <span>批量新增</span>
									</label>
								</td>
							</tr>
							<input type="hidden" id="xhjLpdonglpId" name="xhjLpdong.lpId" value="${lpxx.id}">
							<!--点击批量新增出现 -->
							<tr class="dongBatch">
								<td>名称前缀</td>
								<td><input type="text" name="xhjLpdong.prefix" class="form-control"  placeholder=""></td>
							</tr>
							<tr class="dongBatch">
								<td><font color="#f00">批量序号</font></td>
								<td><div class="col-md-3">
										<input type="text" name="xhjLpdong.start" class="form-control" placeholder="">
									</div>
									<div class=" pull-left">-</div><div class="col-md-3">
										<input type="text" name="xhjLpdong.end" class="form-control" placeholder="">
									</div>
								</td>
							</tr>
							<tr class="dongBatch">
								<td>名称后缀</td>
								<td><input type="text" name="xhjLpdong.suffix" class="form-control" placeholder=""></td>
							</tr>
						<!-- 单个新增点击隐藏 End -->
							<tr class="dongSingle">
								<td><font color="#f00">栋座名称</font></td>
								<td><input type="text" name="xhjLpdong.lpdName" class="form-control" placeholder=""></td>
							</tr>
						</tbody>
						
					</table>
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th colspan="4">栋座其他信息</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>单元定义类型</td>
									<td>
										<select class="form-control" id = "dType" name ="xhjLpdong.dtype">
											<option value="0">请选择</option>
											<option value="1">不限</option>
										</select>
									</td>
									<td>每栋总单元数</td>
									<td><input type="text" class="form-control" id ="dyNum" name = "xhjLpdong.dyNum"></td>
								</tr>
								<tr>
									<td>建筑年代</td>
									<td><input type="text" class="form-control" id ="ages" name = "xhjLpdong.ages"></td>
									<td>建筑面积</td>
									<td><input type="text" class="form-control" id ="size" name ="xhjLpdong.size"></td>
								</tr>
								<tr>
									<td>地上总层数</td>
									<td><input type="text" class="form-control" id ="topNum" name ="xhjLpdong.topNum"></td>
									<td>地下总层数</td>
									<td><input type="text" class="form-control" id ="underNum" name = "xhjLpdong.underNum"></td>
								</tr>
								<tr>
									<td>座落</td>
									<td>
										<select class="form-control" id ="located" name= "xhjLpdong.located">
											<option value="0">请选择</option>
											<option value="1">不限</option>
										</select>
									</td>
									<td>权属</td>
									<td>
										<select class="form-control" id ="ownership" name ="xhjLpdong.ownership">
											<option value="0">请选择</option>
											<option value="1">不限</option>										
										</select>
									</td>
								</tr>
								<tr>
									<td>备注</td>
									<td colspan="3">
										<textarea class="form-control" rows="5" id ="remarks" name ="xhjLpdong.remarks"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="doAddDong()">保存</button>
				<button type="button" class="btn btn-danger" id="dongClose" data-dismiss="modal">关闭</button>
			</div>
		</form>
		</div>
	</div>
</div>




<!-- Modal 4.2 (新增单元)-->
<div class="modal fade" id="Danyuan" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增单元</h4>
			</div>
			<form role="form" class="form-horizontal" id="danyuanForm">
			<div class="modal-body">
				<div class="scrollable" data-max-height="600">
					<table class="table" id="tblAddDanyuan">
						<tbody>
							<tr>
								<td width="90">新增方式</td>
								<input type="hidden" name="lpid" value="${loadLpxx.id}">
							<input type="hidden" id="dydzid"  name="xhjLpdanyuan.dzid"/>
								<td>
									<label class="radio-inline" for="status1">
										<input type="radio" id="status1" name="xhjLpdanyuan.type" value="Single" class="checkbox" onclick="danyuanAddTypeClicked(this)">
										<span>单个添加</span>
									</label>
									<label class="radio-inline" for="status1">
										<input type="radio" id="status1" name="xhjLpdanyuan.type" value="Batch" class="checkbox" onclick="danyuanAddTypeClicked(this)">
										<span>批量新增</span>
									</label>
								</td>
							</tr>
							<!-- 点击批量新增出现 -->
							<tr class="danyuanBatch">
								<td>名称前缀</td>
								<td><input type="text" name="xhjLpdanyuan.prefix" class="form-control" placeholder=""></td>
							</tr>
							<tr class="danyuanBatch">
								<td><font color="#f00">批量序号</font></td>
								<td>
									<div class="col-md-3">
										<input type="text" name="xhjLpdanyuan.start" class="form-control" placeholder="">
									</div>
									<div class=" pull-left">-</div>
									<div class="col-md-3">
										<input type="text" name="xhjLpdanyuan.end" class="form-control" placeholder="">
									</div>
								</td>
							</tr>
							<tr class="danyuanBatch">
								<td>名称后缀</td>
								<td><input type="text" name="xhjLpdanyuan.suffix" class="form-control" placeholder=""></td>
							</tr>
							<!-- 单个新增点击隐藏 End -->
							<tr class="danyuanSingle">
								<td><font color="#f00">单元名称</font></td>
								<td><input type="text" name="xhjLpdanyuan.dyName" class="form-control" placeholder=""></td>
							</tr>
						</tbody>
					</table>
					<div class="table-responsive">
						<table class="table">
						<tbody>
							<thead>
								<tr>
									<th colspan="4">单元其他信息</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>楼层定义类型</td>
									<td>
										<select class="form-control"  id ="dType1" name = "xhjLpdanyuan.dtype">
											<option value="0" selected="selected">请选择</option>
											<option value="1">不限</option>
										</select>
									</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>地上总层数</td>
									<td><input type="text" class="form-control"  id ="topNum1" name = "xhjLpdanyuan.topNum"></td>
									<td>地下总层数</td>
									<td><input type="text" class="form-control"  id ="underNum1" name = "xhjLpdanyuan.underNum"></td>
								</tr>
								<tr>
									<td>每单元总楼层数</td>
									<td><input type="text" class="form-control"  id ="totalNum" name = "xhjLpdanyuan.totalNum"></td>
									<td>一梯几户</td>
									<td><input type="text" class="form-control"  id ="dihu" name = "xhjLpdanyuan.dihu"></td>
								</tr>
								<tr>
									<td>备注</td>
									<td colspan="3">
										<textarea class="form-control" rows="5"   id ="remarks1" name = "xhjLpdanyuan.remarks"></textarea>
									</td>
								</tr>
						</tbody>
						</table>
					
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="doAddDanyuan()">保存</button>
				<button type="button" class="btn btn-danger" id="danyClose" data-dismiss="modal" onclick="Empty1()">关闭</button>
			</div>
		</div>
		</form>
	</div>
</div>
</div>


<!-- Modal 4.2.1 (修改)-->
<div class="modal fade" id="Xiugai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">修改栋座</h4>
			</div>
			<form role="form" class="form-horizontal" id="donglouUpForm">
			<div class="modal-body" id="formUpdateDong">
				<div class="scrollable" data-max-height="600">
					<table class="table">
						<tbody>
							<tr>
								<td><span class="red">栋座名称</span></td>
								<td>
									<input type="hidden" id="xhjLpdonglpId" name="xhjLpdong.lpId" value="${lpxx.id}">
									<input type="hidden" name="xhjLpdong.id">
									<input type="input" class="form-control" name="xhjLpdong.lpdName">
								</td>
							</tr>
						</tbody>
					</table>
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th colspan="4">栋座其他信息</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>单元定义类型</td>
									<td>
										<select class="form-control" id = "dTypeup" name ="xhjLpdong.dtype">
											<option value="0">请选择</option>
											<option value="1">不限</option>
										</select>
									</td>
									<td>每栋总单元数</td>
									<td><input type="text" class="form-control" id ="dyNumup" name = "xhjLpdong.dyNum"></td>
								</tr>
								<tr>
									<td>建筑年代</td>
									<td><input type="text" class="form-control" id ="agesup" name = "xhjLpdong.ages"></td>
									<td>建筑面积</td>
									<td><input type="text" class="form-control" id ="sizeup" name ="xhjLpdong.size"></td>
								</tr>
								<tr>
									<td>地上总层数</td>
									<td><input type="text" class="form-control" id ="topNumup" name ="xhjLpdong.topNum"></td>
									<td>地下总层数</td>
									<td><input type="text" class="form-control" id ="underNumup" name = "xhjLpdong.underNum"></td>
								</tr>
								<tr>
									<td>座落</td>
									<td>
										<select class="form-control" id ="locatedup" name= "xhjLpdong.located">
											<option value="0">请选择</option>
											<option value="1">不限</option>
										</select>
									</td>
									<td>权属</td>
									<td>
										<select class="form-control" id ="ownershipup" name ="xhjLpdong.ownership">
											<option value="0">请选择</option>
											<option value="1">不限</option>									
										</select>
									</td>
								</tr>
								<tr>
									<td>备注</td>
									<td colspan="3">
										<textarea class="form-control" rows="5" id ="remarksup" name ="xhjLpdong.remarks"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="lpDongUpd()">修改</button>
				<button type="button" class="btn btn-danger" id="dongUpdClose" data-dismiss="modal">关闭</button>
			</div>
			</form>
		</div>
	</div>
</div>

<!-- Modal 4 (修改)-->
<div class="modal fade" id="XiugaiDy" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">修改单元</h4>
			</div>
			<form role="form" class="form-horizontal" id="danyuanUpForm">
			<div class="modal-body" id="formUpdateDanyuan">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
							<input type="hidden" name="lpid" value="${loadLpxx.id}">
								<td><span class="red">单元名称</span></td>
								<td>
									<input type="hidden" name="xhjLpdanyuan.id">
									<input type="input" class="form-control" name="xhjLpdanyuan.dyName">
								</td>
							</tr>
						</tbody>
					</table>
					<div class="table-responsive">
						<table class="table">
						<tbody>
							<thead>
								<tr>
									<th colspan="4">单元其他信息</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>楼层定义类型</td>
									<td>
										<select class="form-control"  id ="dTypeup1" name = "xhjLpdanyuan.dtype">
											<option value="0">请选择</option>
											<option value="1">不限</option>
										</select>
									</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>地上总层数</td>
									<td><input type="text" class="form-control"  id ="topNumup1" name = "xhjLpdanyuan.topNum"></td>
									<td>地下总层数</td>
									<td><input type="text" class="form-control"  id ="underNumup1" name = "xhjLpdanyuan.underNum"></td>
								</tr>
								<tr>
									<td>每单元总楼层数</td>
									<td><input type="text" class="form-control"  id ="totalNumup" name = "xhjLpdanyuan.totalNum"></td>
									<td>一梯几户</td>
									<td><input type="text" class="form-control"  id ="dihuup" name = "xhjLpdanyuan.dihu"></td>
								</tr>
								<tr>
									<td>备注</td>
									<td colspan="3">
										<textarea class="form-control" rows="5"   id ="remarksup1" name = "xhjLpdanyuan.remarks"></textarea>
									</td>
								</tr>
						</tbody>
						</table>
					
				</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="danYuanUpd()">修改</button>
				<button type="button" class="btn btn-danger" id="danyUpdClose" data-dismiss="modal">关闭</button>
			</div>
			</form>
		</div>
	</div>
</div>


<!-- Modal 4 (新增房号)-->
<div class="modal fade" id="Fanghao" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增房号</h4>
			</div>
			<form role="form" class="form-horizontal" id="fanghaoForm">
			<div class="modal-body">
				<div class="scrollable ps-container ps-active-y" data-max-height="600" id="formAddFanghao">
					<table class="table" id="tblAddFanghao">
					<tbody>
			              <tr>
			              	<td width="90">新增方式</td>
			              	<input type="hidden" name="xhjLpfanghao.lpid" value="${loadLpxx.id}" />
							<input type="hidden" id="fanghaodyId"  name="xhjLpfanghao.dyId"/>
							<td>
								<div class="qwe">
									<label class="radio-inline" for="status1">
										<input type="radio" id="status1" name="fanghaoAddType" value="Batch" onclick="fanghaoAddTypeClicked(this)">
										<span>批量新增</span>
									</label>
									<label class="radio-inline" for="status1">
										<input type="radio" id="status1" name="fanghaoAddType" value="Single" checked="checked" class="checkbox" onclick="fanghaoAddTypeClicked(this)">
									<span>单个添加</span>
								</label>
								</div>
							</td>
			              </tr>
			              <tr>
					      	<td>房号类型</td>
							<td>
								<div class="qwe">
								<label class="radio-inline" for="status1">
									<input type="radio" id="status1" name="xhjLpfanghao.leixing" value="41" checked="checked" class="checkbox">
									<span>住宅</span>
								</label>
								<label class="radio-inline" for="status1">
									<input type="radio" id="status1" name="xhjLpfanghao.leixing" value="43" class="checkbox">
									<span>商铺</span>
								</label>
								</div>
							</td>
						  </tr>
						  <!--  <tr class="fanghaoBatch">
								<td width="90">命名规则</td>
								<td>
									<label class="radio-inline">
										<input type="radio" name="namingrules" checked value="1"> 层+编号
									</label>
									<label class="radio-inline">
										<input type="radio" name="namingrules" value="2"> 前缀+编号
									</label>
									<label class="radio-inline">
										<input type="radio" name="namingrules" value="3"> 编号+后缀
									</label>
									<label class="radio-inline">
										<input type="radio" name="namingrules" value="4"> 前缀+层+编号
									</label>
								</td>
							</tr> -->
			              <tr class="fanghaoSingle">
						  	  <td>
						  	  	  <font color="#f00">层数</font>
						  	  </td>
							  <td>
							  	  <input type="number" name="xhjLpfanghao.ceng" class="form-control">
							  </td>
						  </tr>
						  <tr class="fanghaoSingle">
							  <td><font color="#f00">房号名称</font></td>
							  <td><input type="text" name="xhjLpfanghao.fangHao" class="form-control"></td>
						  </tr>
			              <tr class="fanghaoBatch">
			              	<td>名称前缀</td>
			                <td>
								<input type="text" class="form-control" id="txtFhPrefix" >
			              	</td>
			              </tr>
			              <tr class="fanghaoBatch">
			              	<td><span class="red">起始层数</span></td>
			                <td>
								<div class="col-lg-4">
										<input type="text" id="txtFhFloorStart" class="form-control">
									</div>
								<div class="col-lg-1"><span>-</span></div>
								<div class="col-lg-4">
										<input type="text" id="txtFhFloorEnd" class="form-control">
								</div>
			              	</td>
			              </tr>
			              <tr class="fanghaoBatch">
			              	<td><span class="red">起始编号</span></td>
			                <td>
								<div class="col-lg-4">
										<input type="text" id="txtFhStart" class="form-control">
									</div>
								<div class="col-lg-1"><span>-</span></div>
								<div class="col-lg-4">
										<input type="text" id="txtFhEnd" class="form-control">
								</div>
			              	</td>
			              </tr>
			              <tr class="fanghaoBatch">
			              	<td>名称后缀</td>
			                <td>
								<input type="email" class="form-control" id="txtFhSuffix">
			              	</td>
			              </tr>
			              <tr class="fanghaoBatch">
			              	<td colspan="2" align="center">
			              		<button type="button" class="btn btn-info" onclick="previewFanghao()">生成房号</button>
			              	</td>
			              	<input type="hidden" name="datas" id="datas">
			              </tr>
			              <tr class="fanghaoBatch">
							<td colspan="2" class="text-center">
								<div id="tdFanghaoPreview" style="width:480px;overflow-x:auto">
								</div>
							</td>
			              </tr>
			              <tr>
			              	<td colspan="2">
			              		<div class="col-lg-4">
										<input type="text" class="form-control">
								</div>
								<div class="col-lg-4">
										<input type="text" class="form-control">
								</div>
								<div class="col-lg-4">
										<input type="text" class="form-control">
								</div>
			              	</td>
			              </tr>
			           	 
			            </tbody>
		          </table>
		          
		          <div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th colspan="4">房号其他信息</th>
								</tr>
							</thead>
							<tbody>
							 <tr class="fanghaoBatch">
			              	<td>总层数</td>
			                <td>
								<input type="text" class="form-control" id="totalFloor" name="xhjLpfanghao.totalFloor">
			              	</td>
			              </tr>
								<tr>
									<td>户型</td>
									<td colspan="3">
										<div class="input-group input-group-minimal">
											<input type="text" class="form-control" id ="shi" name="xhjLpfanghao.shi"/>
											<span class="input-group-addon">室</span>
											<input type="text" class="form-control" id ="ting" name="xhjLpfanghao.ting"/>
											<span class="input-group-addon">厅</span>
											<input type="text" class="form-control" id ="chu" name="xhjLpfanghao.chu"/>
											<span class="input-group-addon">厨</span>
											<input type="text" class="form-control" id ="wei" name="xhjLpfanghao.wei"/>
											<span class="input-group-addon">卫</span>
										</div>
									</td>
								</tr>
								<tr>
									<%-- <td>用途</td>
									<td>
										<select class="form-control" id ="leibei2">
											<option value="1">请选择</option>
										</select>
									</td> --%>
									<td>朝向</td>
									<td>
										<select class="form-control" id ="chaoXiang" name="xhjLpfanghao.chaoXiang">
											<option value="1">请选择</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>装修情况</td>
									<td>
										<select class="form-control" id ="decorationStandard" name="xhjLpfanghao.decorationStandard">
											<option value="1">请选择</option>
										</select>
									</td>
									<td>建筑面积</td>
									<td><input type="text" class="form-control" id= "cqmj" name="xhjLpfanghao.cqmj"></td>
								</tr>
								<tr>
									<td>使用面积</td>
									<td><input type="text" class="form-control" id ="tnmj" name="xhjLpfanghao.tnmj"></td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>房屋点评</td>
									<td colspan="3">
										<textarea class="form-control" rows="5" id ="remark2" name="xhjLpfanghao.beiZhu"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="doAddLpFanghao(this)">保存</button>
				<button type="button" class="btn btn-danger" id="fanghaoClose" data-dismiss="modal">关闭</button>
			</div>
			</form>
		</div>
	</div>
</div>


<!-- Modal 4 (查看关联房源)-->
<div class="modal fade custom-width" id="Guanlianfangyuan">
	<div class="modal-dialog" style="width: 80%;">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">查看关联房源</h4>
			</div>

			<div class="tab-content">
				<div class="panel-body">
					<div class="col-lg-12">
						<div class="table-responsive">
							<table class="table table-bordered table-striped table-condensed">
								<thead>
									<tr>
										<th>房号</th>
										<th>房源编号</th>
										<th>租售类型</th>
										<th>归属人</th>
										<th>归属人部门</th>
										<th>录入人</th>
										<th>录入人部门</th>
										<th>房源状态</th>
										<th>房东姓名</th>
										<th>房东电话</th>
										<th>创建时间</th>
									</tr>
								</thead>
								<tbody class="middle-align" id="crrHouse">
								</tbody>
							</table>
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

<!-- Modal 4 (修改房号)-->
<div class="modal fade" id="Fanghaoxiugai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">修改房号</h4>
			</div>
			<form role="form" class="form-horizontal" id="fangHaoUpForm">
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table" id="formUpdateFanghao">
						<tbody>
							<tr>
								<td width="100">房号类型</td>
								<input type="hidden"  class="form-control" name="xhjLpfanghao.dyId" id="fanghaoDyid" />
								<input type="hidden" class="form-control" name="xhjLpfanghao.id" id="fangHaoId" />
								<input type="hidden" class="form-control" name="xhjLpfanghao.lpid"  value="${loadLpxx.id}" />
								<td>
									<label class="radio-inline"> 
										<input type="radio" name="xhjLpfanghao.leixing" dd="41" value="41" > 住宅
									</label>
									<label class="radio-inline">
										<input type="radio" name="xhjLpfanghao.leixing" dd="43" value="43"> 商铺
									</label>
								</td>
							</tr>
							<tr>
								<td><font color="#f00">门牌名称</font></td>
								<td >
									<input type="text" class="form-control" name="xhjLpfanghao.fangHao">
								</td>
							</tr>
							<tr>
								<td><font color="#f00">单元房号</font></td>
								<td>
									<input type="text" class="form-control" name="xhjLpfanghao.fhName">
								</td>
							</tr>
							<tr>
			              	<td>总层数</td>
			                <td>
								<input type="text" class="form-control" id="totalFloorup" name="xhjLpfanghao.totalFloor">
			              	</td>
			              </tr>
						</tbody>
					</table>
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th colspan="4">房号其他信息</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>户型</td>
									<td colspan="3">
										<div class="input-group input-group-minimal">
											<input type="text" class="form-control" id = "shiup" name="xhjLpfanghao.shi"/>
											<span class="input-group-addon">室</span>
											<input type="text" class="form-control" id ="tingup" name="xhjLpfanghao.ting"/>
											<span class="input-group-addon">厅</span>
											<input type="text" class="form-control" id ="chuup" name="xhjLpfanghao.chu"/>
											<span class="input-group-addon">厨</span>
											<input type="text" class="form-control" id ="weiup" name="xhjLpfanghao.wei"/>
											<span class="input-group-addon">卫</span>
										</div>
									</td>
								</tr>
								<tr>
									<td>朝向</td>
									<td>
										<select class="form-control" id ="chaoXiangup" name="xhjLpfanghao.chaoXiang">
											<option value="1">请选择</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>装修情况</td>
									<td>
										<select class="form-control" id ="decorationStandardup" name="xhjLpfanghao.decorationStandard">
											<option value="1">请选择</option>
										</select>
									</td>
									<td>建筑面积</td>
									<td><input type="text" class="form-control" id= "cqmjup" name="xhjLpfanghao.cqmj"></td>
								</tr>
								<tr>
									<td>使用面积</td>
									<td><input type="text" class="form-control" id ="tnmjup" name="xhjLpfanghao.tnmj"></td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>房屋点评</td>
									<td colspan="3">
										<textarea class="form-control" rows="5" id ="remarkup2" name="xhjLpfanghao.beiZhu"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="doUpdateFanghao(this)">保存</button>
				<button type="button" class="btn btn-danger" id="fanghaoUpdClose" data-dismiss="modal">关闭</button>
			</div>
			</form>
		</div>
	</div>
</div>




<!--5.1 修改划片-->
<div class="modal fade custom-width" id="xinzenhuapian1">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">修改划片</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">学校类型</td>
								<td>
									<input id="lpschoolpUpdId" type="hidden"/>
									<input id="lpschoolpUpdType" type="hidden"/>
									<select class="form-control" id="schoolUpdType" onchange="showSchoolUpdDetail(this.value)";>
									</select>
								</td>
							</tr>
							<tr>
								<td width="100">学校名称</td>
								<td>
									<select class="form-control  s2example-1" id="schoolUpdNameDetail">
									</select>
								</td>
							</tr>
							<tr>
								<td>类型</td>
								<td>
									<div class="row">
										<div class="form-block nav nav-tabs xuequleixin">
											<div class="col-sm-4 text-center" style="line-height: 25px; background-color: #f4f4f4;"
												href="#tab10" data-toggle="tab">
												<label id="schoolTitle">学区</label>
											</div>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td>选择户型</td>
								<td>
									<div class="tab-content">
										<div class="tab-pane active" id="tab10">
											<div class="form-block">
												<div class="row" id="schoolUpdDong" style="height:200px; OVERFLOW-Y:auto;">
												</div>
												<div class="row" id="schoolUpdFang" style="height:200px; OVERFLOW-Y:auto;">
												</div>
											</div>
											</div>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="updSchool();">修改</button>
				<button type="button" class="btn btn-info" id="addLpSchoolUpdClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>


<!-- Modal 5.2.1 (新增责任盘)-->
<div class="modal fade custom-width" id="xinzenhuapian4">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">责任盘</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">服务范围</td>
								<td>责任盘</td>
							</tr>
							<tr>
								<td width="100">服务来源</td>
								<td>
									<select class="form-control" id="zeirSource">
										<option value="0">请选择</option>
										<option value="1">公司内部</option>
										<option value="2">外部加盟</option>
										<option value="3">其他</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>服务网点</td>
								<td>
									<div class="w200">
										<select class="form-control s2example-1" id="addZrService" onchange="setAddress(this.value,'ser')">
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td>网点地址</td>
								<td><label id="serAddress"></label></td>
							</tr>
							<tr>
								<td>服务电话</td>
								<td><label id="serTel"></label></td>
							</tr>
							<tr>
								<td>栋座信息</td>
								<td>
									<div class="row" id="zerDong" style="height:200px; OVERFLOW-Y:auto;">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="saveZeren(1);">保存</button>
				<button type="button" class="btn btn-info" id="zerModalClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>


<!-- Modal 5.2.2 (新增维护盘)-->
<div class="modal fade custom-width" id="xinzenhuapian2">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">维护盘</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">服务范围</td>
								<td>维护盘</td>
							</tr>
							<tr>
								<td width="100">服务来源</td>
								<td>
									<select class="form-control" id="weihSource">
										<option value="0">请选择</option>
										<option value="1">公司内部</option>
										<option value="2">外部加盟</option>
										<option value="3">其他</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>服务网点</td>
								<td>
									<div class="w200">
										<select class="form-control s2example-1" id="weihaddService" onchange="setAddress(this.value,'weih')">
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td>网点地址</td>
								<td><label id="weihAddress"></label></td>
							</tr>
							<tr>
								<td>服务电话</td>
								<td><label id="weihTel"></label></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="saveWeih(2,'weih')">保存</button>
				<button type="button" class="btn btn-info" id="weihModalClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal 5.2.3 (新增范围盘)-->
<div class="modal fade custom-width" id="xinzenhuapian3">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">范围盘</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">服务范围</td>
								<td>范围盘</td>
							</tr>
							<tr>
								<td width="100">服务来源</td>
								<td>
									<select class="form-control" id="fanwSource">
										<option value="0">请选择</option>
										<option value="1">公司内部</option>
										<option value="2">外部加盟</option>
										<option value="3">其他</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>服务网点</td>
								<td>
									<div class="w200">
										<select class="form-control s2example-1" id="fanwaddService" onchange="setAddress(this.value,'fanw')">
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td>网点地址</td>
								<td><label id="fanwAddress"></label></td>
							</tr>
							<tr>
								<td>服务电话</td>
								<td><label id="fanwTel"></label></td>
							</tr>
							<tr class="fuzDong">
								<td>栋座信息</td>
								<td>
									<div class="row" id="zerDong">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" onclick="saveWeih(3,'fanw')" class="btn btn-white">保存</button>
				<button type="button" id="fanwModalClose" class="btn btn-info" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<!--修改-->
<div class="modal fade custom-width" id="xinzenhuapian5">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">修改</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">服务范围</td>
								<td class="fuzTitle"></td>
							</tr>
							<tr>
								<td width="100">服务来源</td>
								<td>
									<input id="fanwUpdId" type="hidden">
									<input id="fanwUpdSta" type="hidden">
									<select class="form-control" id="fanwUpdSource">
										<option value="0">请选择</option>
										<option value="1">公司内部</option>
										<option value="2">外部加盟</option>
										<option value="3">其他</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>服务网点</td>
								<td>
									<div class="w200">
										<select class="form-control s2example-1" id="updFuzhuWd" onchange="setAddress(this.value,'fuz')">
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td>网点地址</td>
								<td><label id="fuzAddress"></td>
							</tr>
							<tr >
								<td>服务电话</td>
								<td><label id="fuzTel"></td>
							</tr>
							<tr class="fuzDong">
								<td>栋座信息</td>
								<td>
									<div class="row" id="fuzDong" style="height:200px; OVERFLOW-Y:auto;">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="updLpFuzh();">保存</button>
				<button type="button" class="btn btn-info" id="updLpFuzModelClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- 小区点评  -->
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


<!--(新增地铁)-->
<div class="modal fade custom-width" id="xinzendite1">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增地铁</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="800">
					<table class="table" id="addMetros">
						<tbody>
							<tr>
								<td width="100">地铁线路</td>
								<td>
									<select class="form-control" id="dtxianlu" onchange="loadZhan(this.value)">
										<option value="0">请选择</option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div style="height:320px;overflow-y:auto">
										<table class="table table-bordered table-striped">
											<thead>
											<tr>
												<th class="no-sorting"></th>
												<th>名称</th>
											</tr>
										</thead>
										<tbody class="middle-align" id="zhanTbody">
										</tbody>
									</table>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="saveMetorsInfo()">保存</button>
				<button  type="button" class="btn btn-danger" data-dismiss="modal" id="addMetorClose">关闭</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade custom-width" id="xinzenhuapian">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增学校</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="800">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">学校类型</td>
								<td>
									<select class="form-control" id="schoolType" onchange="showSchoolDetail(this.value)";>
									</select>
								</td>
							</tr>
							<tr>
								<td width="100">学校名称</td>
								<td>
								<select class="form-control s2example-1" id="schoolNameDetail">
								</select>
								</td>
							</tr>
							<tr>
								<td>类型</td>
								<td>
									<div class="row">
										<div class="form-block nav nav-tabs xuequleixin">
											<div class="col-sm-4 text-center"
												style="line-height: 25px; background-color: #f4f4f4;"
												href="#tab9" data-toggle="tab">
												<label> 学区 </label>
											</div>
											<div class="col-sm-4 text-center" style="line-height: 25px;"
												href="#tab8" data-toggle="tab">
												<label> 学位 </label>
											</div>

										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td>选择户型</td>
								<td>
									<div class="tab-content">
										<div class="tab-pane active" id="tab9">
											<div class="form-block">
												<div class="row" id="schoolDong" style="height:200px; OVERFLOW-Y:auto;">
												</div>
											</div>
										</div>
										<div class="tab-pane" id="tab8">
											<div class="form-block">
												<div class="row" id="schoolFang" style="height:200px; OVERFLOW-Y:auto;">
													
												</div>
											</div>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" onclick="saveSchool()">保存</button>
				<button type="button" class="btn btn-info" id="addLpSchoolClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="shitp">
<input type="hidden" id="fenggetp">
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
						<a href="#" class='Homeslide_bigpicdiv_mask'>loading...</a>
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


<div class="modal fade" id="map-info-windom">
  <div class="modal-dialog modal-lg" style="width:100%">
  	<div class="modal-header">
<!--       <button type="button" class="close" id="mapModalClose" onclick="$('#mapModal').modal('hide')" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button> -->
      <h4 class="modal-title">地图</h4>
    </div>
    <div class="modal-content">
     	<iframe name ="bankWaterRecordList" id="bankWaterRecordList" src="" width="100%" height="500px" frameborder="0" marginheight="0" marginwidth="0" border="0"></iframe>
	    <div class="modal-footer">
			<button type="button" id="windowClose" class="btn btn-danger" data-dismiss="modal">关闭</button>
		</div>
    </div>
  </div>
</div>


<script type="text/javascript" src="<%=basePath%>/js/kindeditor/kindeditor-min.js" charset="UTF-8"></script>
<script type="text/javascript">

		KE.show({
			 id : "more",
		     width : "100%",
		     height : "200px",		    
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
		     imageUploadJson : "<%=basePath%>/uploadImages", 
		     /*图片管理的SERVLET路径*/
		     fileManagerJson : "<%=basePath%>/uploadImgManager",
		     /*允许上传的附件类型*/
		     accessoryTypes : "doc|xls|pdf|txt|ppt|rar|zip|xlsx|docx",
		     /*附件上传的SERVLET路径*/
		     accessoryUploadJson : "<%=basePath%>/uploadAccessory"
		});
		
		KE.show({
			 id : "PNum",
		     width : "100%",
		     height : "200px",		    
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
		     imageUploadJson : "<%=basePath%>/uploadImages", 
		     /*图片管理的SERVLET路径*/
		     fileManagerJson : "<%=basePath%>/uploadImgManager",
		     /*允许上传的附件类型*/
		     accessoryTypes : "doc|xls|pdf|txt|ppt|rar|zip|xlsx|docx",
		     /*附件上传的SERVLET路径*/
		     accessoryUploadJson : "<%=basePath%>/uploadAccessory"
		});
		
		KE.show({
			 id : "wyRemark",
		     width : "100%",
		     height : "200px",		    
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
		     imageUploadJson : "<%=basePath%>/uploadImages", 
		     /*图片管理的SERVLET路径*/
		     fileManagerJson : "<%=basePath%>/uploadImgManager",
		     /*允许上传的附件类型*/
		     accessoryTypes : "doc|xls|pdf|txt|ppt|rar|zip|xlsx|docx",
		     /*附件上传的SERVLET路径*/
		     accessoryUploadJson : "<%=basePath%>/uploadAccessory"
		});
</script>

<script src="<%=basePath%>/assets/js/xenon-custom.js"></script>
<script src="<%=basePath%>/js/plupload/plupload.full.min.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/plupload/i18n/zh_CN.js" type="text/javascript"></script>


<script type="text/javascript">

	var couId = ${couId};
	var proId = ${proId};
	var cityId = ${cityId};
	var qyId = ${qyId};
	var sqId = ${sqId};

	var countryValue = '${countryValue}';
	var provinceValue = '${provinceValue}';
	var cityValue = '${cityValue}';
	var qyValue = '${qyValue}';
	var sqValue = '${sqValue}';
	var lpname = '${lpname}';
	
	var imgUrl="";
	
	function updateId(id)
	{
		if(id>0)
		{
			$("#lpxxid").val(id);
			// 物业.
			$("#wuyelpid").val(id);
			// 图片.
			$("#tuplpid").val(id);
			// 楼盘信息.
			$("#xhjLpdong.lpId").val(id);
		}
	}
	
	$(document).ready(function()
	{
		// 更新相关楼盘id.
		updateId(${lpxx.id});
		
		// 加载采集数据.
		queryDetailData();
	});
	
	var curTabId = "";
	//选项卡的内容是否已加载
	var tabStatus = {"tab1":true, "tab2":false, "tab3":false, "tab4":false, "tab5":false};
	$(function()
	{
		$('#navtabs a[data-toggle="tab"]').on('show.bs.tab', function (e)
		{
			curTabId = e.target.hash.substring(1);
			tabStatustable(curTabId);
		});
	});
	
	function tabStatustable(curTabId)
	{
		         if(tabStatus[curTabId]==false){
		    				switch(curTabId){
		    					case "tab2":
		    						//	维护单位
		    						queryData();
		    						
		    						//	居住成本
		    						queryData1();
		    						
		    						getSyscsTypeCheck("维护单位","mType");
		    						getSyscsTypeCheck("居住成本","ctype");
		    						getSyscsTypeCheck("租赁支付方式","payingWay");
		    						break;
		    					case "tab3":
		    						//	图片
		    						uplptp();
		    						break;
		    					case "tab4":
		    					//加载所有栋信息
		    					showDongInfo($("#lpxxid").val());
		    					getSyscsTypeCheck("房屋朝向","chaoXiang");
		    					getSyscsTypeCheck("装修情况","decorationStandard");
		    					getSyscsTypeCheck("房屋朝向","chaoXiangup");
		    					getSyscsTypeCheck("装修情况","decorationStandardup");
		    						break;
		    					case "tab5":
		    					loadLpSchoolInfo();
		    					//加载地铁线路
		    					showAddMetor();
		    					//加载部门
		    					showDepart();
		    					//加载学校类型
		    					showShchoolAllType();
		    						//加载划分盘信息
		    						loadLpFuzh();
		    						//加载地铁信息
		    						metorInfo();
		    					 break;
		    				}
		    				tabStatus[curTabId]=true;
		    			}
	}	
	
	function queryProvince()
	{
		if(proId==0)
		{
			$.ajax(
			{
				url : "<%=basePath%>/spider/spiderAction!queryProvinceId.action", 
				dataType : "json", 
				type : "POST",
				data : {"couId":couId,"provinceValue":provinceValue},
				success : function(result)
				{
					if(result.data == "success") 
					{
						bootbox.alert({title:"提示",message:"锁盘成功!"});
						queryData();
					} 
					else
					{
						bootbox.alert({title:"提示",message:"锁盘失败 : " + result.data});
					}
		    	}
			});
		}
	}
	
	
	
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
	            '<td class="text-center">', '<input type="checkbox" class="fanghaoCB" name="" value="'+info[5]+'" />', '</td>',
	            '<td class="text-center">', info[0], '</td>',
	            '<td class="text-center">', info[1], '</td>',
	            '<td class="text-center">', info[2], '</td>',
	            '<td class="text-center">', info[3], '</td>',
	            '<td class="text-center">', info[4], '</td>',
	            '<td class="text-left">', info[5], '</td>',
	            '<td class="text-center">', '<a class="btn btn-success" href="<%=basePath%>/spider/spiderAction!doGather.action?countryid='+info[0]+'&provinceid='+info[1]+'&cityid='+info[2]+'&qyid='+info[3]+'&sqid='+info[4]+'&lpname='+info[5]+'">采集</a>', '</td>',
	            '</tr>'].join('');
	    });
	};
	
	
	
	
	// 查询详情
	function queryDetailData()
	{
	    var url = "<%=basePath%>/spider/spiderAction!queryGatherData.action";
	    $("#macPageWidget1").asynPage(url, "#tbodyDetailData", queryDetailDataResult, true, true,
	    { 	
	        'spiderCoummunityEntity.countryValue': countryValue,
	        'spiderCoummunityEntity.provinceValue': provinceValue,
	        'spiderCoummunityEntity.cityValue': cityValue,
	        'spiderCoummunityEntity.stressValue': qyValue,
	        'spiderCoummunityEntity.sqValue': sqValue,
	        
	        'spiderCoummunityEntity.lpName': lpname
	    });
	};
	
	var sourceIndex=59;
	var crawlDataList;
	function queryDetailDataResult(list)
	{
		crawlDataList=list;
		
		$("#tbodyDetailData").html("");
		
		// 匹配表达式.
		// title~key~index~store
		// 标题~爬虫键~爬虫键列索引~存储的名称.
		var fileds = new Array();
		
		fileds[0]='<span style="color:#ff0000;">区域</span>~qyid~0~qyid';
		fileds[1]='<span style="color:#ff0000;">商圈</span>~sqid~1~sqid';
		fileds[2]='<span style="color:#ff0000;">用途</span>~yongtu~2~yongTu';
		fileds[3]='<span style="color:#ff0000;">楼盘名称</span>~lpName~3~lpName';
		fileds[4]='<span style="color:#ff0000;">别名</span>~bieMing~4~bieMing';
		fileds[5]='楼盘类型(建筑类型)~ltype~5~ltype';
		fileds[6]='<span style="color:#ff0000;">楼盘地址</span>~address~6~address';
		fileds[7]='坐标地址X~xxzbx~7~x';
		fileds[8]='坐标地址Y~xxzby~8~y';
		fileds[9]='行政地址~xzgx~9~xzgx';
		fileds[10]='环线位置~linkLocAtion~10~linkLocAtion';
		fileds[11]='产权地址~propertyAddress~11~propertyAddress';
		
		fileds[12]='锁盘~statuss~12~statuss';
		fileds[13]='备注~beiZ~13~beiZ';
		fileds[14]='占地面积~sumZd~14~sumZd';
		fileds[15]='建筑面积~sumJz~15~sumJz';
		fileds[16]='建筑年代~buildingAge~16~buildingAge';
		fileds[17]='容积率~rjl~17~rjl';
		fileds[18]='绿化率~lhl~18~lhl';
		fileds[19]='总栋数~djs~19~djs';
		fileds[20]='总户数~hjs~20~hjs';
		fileds[21]='入住总户数~rzhs~21~rzhs';
		
		fileds[22]='所获奖项~lpJiangX~22~lpJiangX';
		fileds[23]='小区群~qq~23~qq';
		fileds[24]='得房率~roomRate~24~roomRate';
		fileds[25]='街道办事处~jieDao~25~jieDao';
		fileds[26]='人车分离~renChe~26~renChe';
		fileds[27]='内部设施~propertySupporting~27~propertySupporting';
		fileds[28]='楼盘简介~more~28~more';
		fileds[29]='车库说明~PNum~29~PNum';
		fileds[30]='土地使用年限~propertyAge~30~propertyAge';
		fileds[31]='权属~propertyInfo~31~propertyInfo';
		
		fileds[32]='供气方式~airSupply~32~airSupply';
		fileds[33]='采暖方式~heatingWay~33~heatingWay';
		fileds[34]='供水方式~waterSupply~34~waterSupply';
		fileds[35]='供电方式~powerSupply~35~powerSupply';
		fileds[36]='通讯配置~configuration~36~configuration';
		fileds[37]='社区安全设置~communitySafety~37~communitySafety';
		fileds[38]='门窗材料~materials~38~materials';
		fileds[39]='电梯品牌~brand~39~brand';
		fileds[40]='外墙处理方~facadesProcessing~40~facadesProcessing';
		fileds[41]='建筑类型~buildingType~41~buildingType';
		
		fileds[42]='建筑结构~buildingStructure~42~buildingStructure';
		fileds[43]='系统报价单价~openingPrice~43~openingPrice';
		fileds[44]='开盘起价~price~44~price';
		fileds[45]='开盘均价~openingAvgPrice~45~openingAvgPrice';
		fileds[46]='当前均价~avgPrice~46~avgPrice';
		
		// 搜房
		var source1=new Array();
		// 安居客
		var source2=new Array();
		// 0731新房网
		var source3=new Array();
		
	    for(var i=0;i<list.length;i++) 
   	    {
	    	var source = list[i][sourceIndex];
	    	if(source=="搜房")
	    		source1=list[i];
	    	if(source=="安居客")
	    		source2=list[i];
	    	if(source=="0731新房网")
	    		source3=list[i];
   	    }
		
   	    // 组装图片URL。
   	    imgUrl="";
   	    if(source1!=null && source1.length>0)
   	    	imgUrl=imgUrl+source1[sourceIndex+1]+"～";
   	    if(source2!=null && source2.length>0)
   	    	imgUrl=imgUrl+source2[sourceIndex+1]+"～";
   	    if(source3!=null && source3.length>0)
   	    	imgUrl=imgUrl+source3[sourceIndex+1]+"～";
   	    if(imgUrl!=null && imgUrl.length>0)
   	    	imgUrl=imgUrl.substring(0,imgUrl.length-1);
		
   	    // 基本信息.
		var htmlData="";
		for(var i=0;i<fileds.length;i++)
		{
			var field=fileds[i].split("~");
			var title=field[0];
			var key=field[1];
			var index=field[2];
			var store=field[3];
			
			var s1=source1[index];
			if(s1==undefined)
				s1='';
			var s2=source2[index];
			if(s2==undefined)
				s2='';
			var s3=source3[index];
			if(s3==undefined)
				s3='';
			
			
			htmlData=htmlData+'<tr>';
			htmlData=htmlData+'<td style="word-wrap:break-word;">'+title+'</td>';

			if(key=="qyid")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="sQy" name="lpxx.stressId" onchange="buildSq(this.value)"><option value="">请选择</option></select></td>';
			else if(key=="sqid")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="sSq" name="lpxx.sqId"><option value="">请选择</option></select></td>';
			else if(key=="yongtu")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="yongtu" name="lpxx.yongTu"><option value="">请选择</option></select></td>';
			else if(key=="ltype")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="ltype" name="lpxx.ltype"><option value="">请选择</option></select></td>';
			else if(key=="linkLocAtion")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="linkLocAtion" name="lpxx.linkLocAtion"><option value="">请选择</option></select></td>';

			else if(key=="airSupply")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="airSupply" name="lpxx.airSupply"><option value="">请选择</option></select></td>';
			else if(key=="heatingWay")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="heatingWay" name="lpxx.heatingWay"><option value="">请选择</option></select></td>';
			else if(key=="waterSupply")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="waterSupply" name="lpxx.waterSupply"><option value="">请选择</option></select></td>';
			else if(key=="powerSupply")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="powerSupply" name="lpxx.powerSupply"><option value="">请选择</option></select></td>';
			else if(key=="configuration")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="configuration" name="lpxx.configuration"><option value="">请选择</option></select></td>';
			else if(key=="communitySafety")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="communitySafety" name="lpxx.communitySafety"><option value="">请选择</option></select></td>';
			else if(key=="materials")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="materials" name="lpxx.materials"><option value="">请选择</option></select></td>';
			else if(key=="brand")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="brand" name="lpxx.brand"><option value="">请选择</option></select></td>';
			else if(key=="facadesProcessing")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="facadesProcessing" name="lpxx.facadesProcessing"><option value="">请选择</option></select></td>';
			else if(key=="buildingType")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="buildingType" name="lpxx.buildingType"><option value="">请选择</option></select></td>';
			else if(key=="buildingStructure")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="buildingStructure" name="lpxx.buildingStructure"><option value="">请选择</option></select></td>';
			else if(key=="propertyInfo")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="propertyInfo" name="lpxx.propertyInfo"><option value="">请选择</option></select></td>';
			
				
			else if(key=="beiZ")
				htmlData=htmlData+'<td><textarea id="'+key+'" name="lpxx.'+store+'" class="form-control" rows="5"></textarea></td>';
			else if(key=="more")
				htmlData=htmlData+'<td><textarea id="'+key+'" name="lpxx.'+store+'" class="form-control" rows="5"></textarea></td>';
			else if(key=="PNum")
				htmlData=htmlData+'<td><textarea id="'+key+'" name="lpxx.'+store+'" class="form-control" rows="5"></textarea></td>';
				
			// 默认不锁定.
			else if(key=="statuss")
				htmlData=htmlData+'<td style="word-wrap:break-word;"><select id="'+key+'" name="lpxx.'+store+'"><option value="0">已锁定</option><option selected value="1">未锁定</option></select></td>';
			else if(key=="renChe")
				htmlData=htmlData+'<td style="word-wrap:break-word;"><select id="'+key+'" name="lpxx.'+store+'"><option value="1">是</option><option value="0" selected>否</option></select></td>';
			else if(key=="propertySupporting")
				htmlData=htmlData+'<td><div class="form-block" id="supporting" data-value="121"><label class="cbr-inline"><input type="checkbox" name="lpxx.propertySupporting" value="836">篮球场</label><label class="cbr-inline"><input type="checkbox" name="lpxx.propertySupporting" value="837">游泳馆</label><label class="cbr-inline"><input type="checkbox" name="lpxx.propertySupporting" value="838">网球场</label><label class="cbr-inline"><input type="checkbox" name="lpxx.propertySupporting" value="839">羽毛球馆</label></div></td>';

			// 设定为地图.
			else if(key=="xxzbx")
				htmlData=htmlData+'<td style="word-wrap:break-word;"><input id="'+key+'" name="lpxx.'+store+'" type="number" value="" style="width:75px;float:left;"></input><div style="width:75px;height:25px;float:left;padding-left:5px;"><a href="#" class="input-group-addon" id="loadX" data-toggle="modal" data-target="#map-info-windom">选择</a></div></td>';
			else if(key=="xxzby")
				htmlData=htmlData+'<td style="word-wrap:break-word;"><input id="'+key+'" name="lpxx.'+store+'" type="number" value="" style="width:75px;float:left;"></input><div style="width:75px;height:25px;float:left;padding-left:5px;"><a href="#" class="input-group-addon" id="loadY" data-toggle="modal" data-target="#map-info-windom">选择</a></div></td>';
				
			// 设定为数字.
			else if(key=="sumZd")
				htmlData=htmlData+'<td style="word-wrap:break-word;"><input id="'+key+'" name="lpxx.'+store+'" type="number" value=""></input>㎡</td>';
			else if(key=="sumJz")
				htmlData=htmlData+'<td style="word-wrap:break-word;"><input id="'+key+'" name="lpxx.'+store+'" type="number" value=""></input>㎡</td>';
			else if(key=="rjl")
				htmlData=htmlData+'<td style="word-wrap:break-word;"><input id="'+key+'" name="lpxx.'+store+'" type="number" value=""></input>%</td>';
			else if(key=="lhl")
				htmlData=htmlData+'<td style="word-wrap:break-word;"><input id="'+key+'" name="lpxx.'+store+'" type="number" value=""></input>%</td>';
			else if(key=="buildingAge")
				htmlData=htmlData+'<td><select style="width:95px;float:left;text-height:30px;" class="form-control" id="'+key+'" name="lpxx.'+store+'"><option value="">请选择</option></select><div style="padding-top:10px;">年</div></td>';
			else if(key=="propertyAge")
				htmlData=htmlData+'<td><select style="width:95px;" class="form-control" id="'+key+'" name="lpxx.'+store+'"><option value="">请选择</option></select></td>';
			else if(key=="xxzbx" || key=="xxzby" || key=="djs" || key=="hjs" || key=="rzhs" 
					|| key=="qq" || key=="openingPrice" || key=="price" || key=="openingAvgPrice" || key=="avgPrice")
				htmlData=htmlData+'<td style="word-wrap:break-word;"><input id="'+key+'" name="lpxx.'+store+'" type="number" value=""></input></td>';
			
			else
				htmlData=htmlData+'<td style="word-wrap:break-word;"><input id="'+key+'" name="lpxx.'+store+'" type="text" value=""></input></td>';
			
			htmlData=htmlData+'<td onclick="clickUpdate(\''+key+'\',this);" style="cursor:pointer;"><div style="width:125px;word-wrap:break-word;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="'+s1+'">'+s1+'</div></td>';
			htmlData=htmlData+'<td onclick="clickUpdate(\''+key+'\',this);" style="cursor:pointer;"><div style="width:125px;word-wrap:break-word;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="'+s2+'">'+s2+'</div></td>';
			htmlData=htmlData+'<td onclick="clickUpdate(\''+key+'\',this);" style="cursor:pointer;"><div style="width:125px;word-wrap:break-word;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="'+s3+'">'+s3+'</div></td>';
			htmlData=htmlData+'</tr>';
		}
		
		
		$("#tbodyDetailData").append(htmlData);
		
		
		
		// 物业信息.
		// ---------------------------------------------
		var thingOperationFields = new Array();
		thingOperationFields[0]='物业公司~wy~45~wy';
		thingOperationFields[1]='物业公司电话~wyPhone~46~wyPhone';
		thingOperationFields[2]='物业地址~wyAdress~47~wyAdress';
		thingOperationFields[3]='物业支付方式~wuyePayingWay~48~wuyePayingWay';
		thingOperationFields[4]='物业费~wuyePrice~49~wuyePrice';
		thingOperationFields[5]='物业计量单位~wuyeUnit~50~wuyeUnit';
		
   	    // 物业信息.
   	    var thingOperationBodyHtml="";
		for(var i=0;i<thingOperationFields.length;i++)
		{
			var field=thingOperationFields[i].split("~");
			var title=field[0];
			var key=field[1];
			var index=field[2];
			var store=field[3];
			
			var s1=source1[index];
			if(s1==undefined)
				s1='';
			var s2=source2[index];
			if(s2==undefined)
				s2='';
			var s3=source3[index];
			if(s3==undefined)
				s3='';
			
			thingOperationBodyHtml=thingOperationBodyHtml+'<tr>';
			thingOperationBodyHtml=thingOperationBodyHtml+'<td style="word-wrap:break-word;">'+title+'</td>';
			
			thingOperationBodyHtml=thingOperationBodyHtml+'<td style="word-wrap:break-word;"><input id="'+store+'" name="lpxx.'+store+'" type="text" value=""></input></td>';
			
			thingOperationBodyHtml=thingOperationBodyHtml+'<td onclick="clickUpdate(\''+store+'\',this);" style="cursor:pointer;"><div style="width:125px;word-wrap:break-word;overflow:hidden;text-overflow:ellipsis;" title="'+s1+'">'+s1+'</div></td>';
			thingOperationBodyHtml=thingOperationBodyHtml+'<td onclick="clickUpdate(\''+store+'\',this);" style="cursor:pointer;"><div style="width:125px;word-wrap:break-word;overflow:hidden;text-overflow:ellipsis;" title="'+s2+'">'+s2+'</div></td>';
			thingOperationBodyHtml=thingOperationBodyHtml+'<td onclick="clickUpdate(\''+store+'\',this);" style="cursor:pointer;"><div style="width:125px;word-wrap:break-word;overflow:hidden;text-overflow:ellipsis;" title="'+s3+'">'+s3+'</div></td>';
			thingOperationBodyHtml=thingOperationBodyHtml+'</tr>';
		}
		$("#thingOperationBody").append(thingOperationBodyHtml);
   	    
   	    
		// 更新来源.
	    for(var i=0;i<list.length;i++) 
   	    {
	    	var urlText="";
	    	var source = list[i][sourceIndex];
	    	if(source=="搜房")
	    	{
	    		urlText=list[i][sourceIndex+1];
	    		if(urlText!=undefined && urlText!=null && urlText.length>0)
	    			$("#url1").val(urlText);
	    	}
	    	if(source=="安居客")
	    	{
	    		urlText=list[i][sourceIndex+1];
	    		if(urlText!=undefined && urlText!=null && urlText.length>0)
	    			$("#url2").val(urlText);
	    	}
	    	if(source=="0731新房网")
	    	{
	    		urlText=list[i][sourceIndex+1];
	    		if(urlText!=undefined && urlText!=null && urlText.length>0)
	    			$("#url3").val(urlText);
	    	}
   	    }

		
		getSyscsOPTION(446,"yongtu");
		getSyscsOPTION(10,"ltype");
		getSyscsOPTION(952,"linkLocAtion");
		
		getSyscsOPTION(4,"buildingAge");
		getSyscsOPTION(783,"propertyAge");
		getSyscsOPTION(14,"propertyInfo");
		getSyscsOPTION(941,"airSupply");
		getSyscsOPTION(942,"heatingWay");
		getSyscsOPTION(943,"waterSupply");
		getSyscsOPTION(944,"powerSupply");
		getSyscsOPTION(945,"configuration");
		getSyscsOPTION(946,"communitySafety");
		getSyscsOPTION(947,"materials");
		getSyscsOPTION(948,"brand");
		getSyscsOPTION(949,"facadesProcessing");
		getSyscsOPTION(10,"buildingType");
		getSyscsOPTION(950,"buildingStructure");
		
		// 加载区域、社区.
		buildQy($("#usCity").val());
		buildSq($("#usQyId").val());
		
		updateStatus();
	};
	
	function copyToClipBoard(id)
	{
		var txt=$("#"+id).val();
		copyToClip(txt);
	}	
	function copyToClip(maintext)
	{
		  if (window.clipboardData)
		  {
		    window.clipboardData.setData("Text", maintext);
		  }
		  else if (window.netscape)
		  {
		      try
		      {
		        netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
		    }
		      catch(e)
		     {
		        alert("该浏览器不支持一键复制！n请手工复制文本框链接地址～");
		    }

		    var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
		    if (!clip) return;
		    var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
		    if (!trans) return;
		    trans.addDataFlavor('text/unicode');
		    var str = new Object();
		    var len = new Object();
		    var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
		    var copytext=maintext;
		    str.data=copytext;
		    trans.setTransferData("text/unicode",str,copytext.length*2);
		    var clipid=Components.interfaces.nsIClipboard;
		    if (!clip) return false;
		    clip.setData(trans,null,clipid.kGlobalClipboard);
		  }
		  alert(maintext);
		}	
	
	
	
	
	
	
	// 加载保存数据.
	function updateStatus()
	{
		$("#lpxxid").val('${lpxx.id}');
		// 物业
		$("#wuyelpid").val('${lpxx.id}');
		// 图片
		$("#tuplpid").val('${lpxx.id}');
		
		// 楼盘信息
		$("#xhjLpdong.lpId").val('${lpxx.id}');
		
		<s:if test="lpxx.yongTu!=null">
		var lpxx_yongtu=${lpxx.yongTu};
		if(lpxx_yongtu!=null && lpxx_yongtu>0)
			updateChangeSelect($("#yongtu"),lpxx_yongtu);
		</s:if>
		
		var lpxx_lpName='${lpxx.lpName}';
		$("#lpName").val(lpxx_lpName);
		
		var lpxx_bieMing='${lpxx.bieMing}';
		if(lpxx_bieMing==null || lpxx_bieMing.length<1)
			lpxx_bieMing=lpxx_lpName;
		$("#bieMing").val(lpxx_bieMing);
		
		<s:if test="lpxx.ltype!=null">
		var lpxx_ltype=${lpxx.ltype};
		if(lpxx_ltype!=null && lpxx_ltype>0)
			updateChangeSelect($("#ltype"),lpxx_ltype);
		</s:if>
		
		$("#address").val('${lpxx.address}');
		
		$("#xxzbx").val('${lpxx.x}');
		$("#xxzby").val('${lpxx.y}');
		$("#xzgx").val('${lpxx.xzgx}');
		
		$("#linkLocAtion").val('${lpxx.linkLocAtion}');
		
		<s:if test="lpxx.buildingAge!=null">
		var lpxx_buildingAge='${lpxx.buildingAge}';
		
		var yearRegExp=/\d*/;
		var arr = yearRegExp.exec(lpxx_buildingAge);
		if(arr!=null && arr.length>0)
			lpxx_buildingAge=arr[0];
		else
			lpxx_buildingAge=0;
		lpxx_buildingAge=parseInt(lpxx_buildingAge);
		if(lpxx_buildingAge!=null && lpxx_buildingAge>0)
			updateChangeSelect($("#buildingAge"),lpxx_buildingAge);
		</s:if>
		
		<s:if test="lpxx.propertyAge!=null">
		var lpxx_propertyAge=${lpxx.propertyAge};
		if(lpxx_propertyAge!=null && lpxx_propertyAge>0)
			updateChangeSelect($("#propertyAge"),lpxx_propertyAge);
		</s:if>
		$("#propertyAddress").val('${lpxx.propertyAddress}');
		
		$("#beiZ").val('${lpxx.beiZ}');
		
		$("#sumZd").val('${lpxx.sumZd}');
		$("#sumJz").val('${lpxx.sumJz}');
		
		$("#rjl").val('${lpxx.rjl}');
		$("#lhl").val('${lpxx.lhl}');
		$("#djs").val('${lpxx.djs}');
		$("#hjs").val('${lpxx.hjs}');
		$("#rzhs").val('${lpxx.rzhs}');
		$("#lpJiangX").val('${lpxx.lpJiangX}');
		$("#qq").val('${lpxx.qq}');
		$("#roomRate").val('${lpxx.roomRate}');
		$("#jieDao").val('${lpxx.jieDao}');
		
		var moreText='${lpxx.more}';
		$("#more").val(moreText);
		
		//$("#more").val('${lpxx.more}');
		$("#PNum").val('${lpxx.PNum}');
		$("#propertyAge").val('${lpxx.propertyAge}');
		$("#propertyInfo").val('${lpxx.propertyInfo}');
		
		//------------------------------------------
		$("#openingPrice").val('${lpxx.openingPrice}');
		$("#price").val('${lpxx.price}');
		$("#openingAvgPrice").val('${lpxx.openingAvgPrice}');
		$("#avgPrice").val('${lpxx.avgPrice}');
		
		<s:if test="lpxx.statuss!=null">
		var lpxx_statuss=${lpxx.statuss};
		if(lpxx_statuss!=undefined && lpxx_statuss!=null)
			updateChangeSelect($("#statuss"),lpxx_statuss);
		</s:if>
		
		<s:if test="lpxx.renChe!=null">
		var lpxx_renChe=${lpxx.renChe};
		if(lpxx_renChe!=undefined && lpxx_renChe!=null)
			updateChangeSelect($("#renChe"),lpxx_renChe);
		</s:if>
		
		<s:if test="lpxx.propertySupporting!=null">
		var lpxx_propertySupporting="${lpxx.propertySupporting}";
		if(lpxx_propertySupporting!=undefined && lpxx_propertySupporting!=null)
			updateRadioSelect($("#supporting"),lpxx_propertySupporting);
		</s:if>
		
		<s:if test="lpxx.propertyInfo!=null">
		var lpxx_propertyInfo=${lpxx.propertyInfo};
		if(lpxx_propertyInfo!=undefined && lpxx_propertyInfo!=null)
			updateChangeSelect($("#propertyInfo"),lpxx_propertyInfo);
		</s:if>

		<s:if test="lpxx.airSupply!=null">
		var lpxx_airSupply=${lpxx.airSupply};
		if(lpxx_airSupply!=undefined && lpxx_airSupply!=null)
			updateChangeSelect($("#airSupply"),lpxx_airSupply);
		</s:if>

		<s:if test="lpxx.heatingWay!=null">
		var lpxx_heatingWay=${lpxx.heatingWay};
		if(lpxx_heatingWay!=undefined && lpxx_heatingWay!=null)
			updateChangeSelect($("#heatingWay"),lpxx_heatingWay);
		</s:if>
		
		<s:if test="lpxx.waterSupply!=null">
		var lpxx_waterSupply=${lpxx.waterSupply};
		if(lpxx_waterSupply!=undefined && lpxx_waterSupply!=null)
			updateChangeSelect($("#waterSupply"),lpxx_waterSupply);
		</s:if>
		
		<s:if test="lpxx.powerSupply!=null">
		var lpxx_powerSupply=${lpxx.powerSupply};
		if(lpxx_powerSupply!=undefined && lpxx_powerSupply!=null)
			updateChangeSelect($("#powerSupply"),lpxx_powerSupply);
		</s:if>
		
		<s:if test="lpxx.configuration!=null">
		var lpxx_configuration=${lpxx.configuration};
		if(lpxx_configuration!=undefined && lpxx_configuration!=null)
			updateChangeSelect($("#configuration"),lpxx_configuration);
		</s:if>
		
		<s:if test="lpxx.communitySafety!=null">
		var lpxx_communitySafety=${lpxx.communitySafety};
		if(lpxx_communitySafety!=undefined && lpxx_communitySafety!=null)
			updateChangeSelect($("#communitySafety"),lpxx_communitySafety);
		</s:if>
		
		<s:if test="lpxx.materials!=null">
		var lpxx_materials=${lpxx.materials};
		if(lpxx_materials!=undefined && lpxx_materials!=null)
			updateChangeSelect($("#materials"),lpxx_materials);
		</s:if>
		
		<s:if test="lpxx.brand!=null">
		var lpxx_brand=${lpxx.brand};
		if(lpxx_brand!=undefined && lpxx_brand!=null)
			updateChangeSelect($("#brand"),lpxx_brand);
		</s:if>
		
		<s:if test="lpxx.facadesProcessing!=null">
		var lpxx_facadesProcessing=${lpxx.facadesProcessing};
		if(lpxx_facadesProcessing!=undefined && lpxx_facadesProcessing!=null)
			updateChangeSelect($("#facadesProcessing"),lpxx_facadesProcessing);
		</s:if>
		
		<s:if test="lpxx.buildingType!=null">
		var lpxx_buildingType=${lpxx.buildingType};
		if(lpxx_buildingType!=undefined && lpxx_buildingType!=null)
			updateChangeSelect($("#buildingType"),lpxx_buildingType);
		</s:if>
		
		<s:if test="lpxx.buildingStructure!=null">
		var lpxx_buildingStructure=${lpxx.buildingStructure};
		if(lpxx_buildingStructure!=undefined && lpxx_buildingStructure!=null)
			updateChangeSelect($("#buildingStructure"),lpxx_buildingStructure);
		</s:if>
		
		//$("#loadXY").attr("display","block");
		//$("#loadX").css("display","block"); 
		//$("#loadY").css("display","block");
		
		// 延迟加载地图.
		var iframeSrc="<%=basePath%>/include/seekCoord.jsp";
		$("#bankWaterRecordList").attr("src",iframeSrc);
		
		// 维护初始化.
		mantenanceQuery();

		//bankWaterRecordList
		
		
		// 初始化复制.
		$(".copy_btn").zclip({
			path:'./ZeroClipboard.swf',
			copy:function(){return $(this).prev('input').val();},
			afterCopy:function(){alert('复制成功！');}
		});

	}
	function updateChangeSelect(src,val)
	{
		src.find("option[value='"+val+"']").attr("selected",true);
	}
	function updateRadioSelect(src,val)
	{
		$('input:checkbox').each(function() 
		{
			if(val.indexOf($(this).val())!=-1)
	        	$(this).attr('checked', true);
	    });
	}
	
	function clickUpdate(obj1,txt)
	{
		if(obj1=="openingPrice" || obj1=="price" || obj1=="openingAvgPrice" 
				|| obj1=="avgPrice"	|| obj1=="sumZd" || obj1=="sumJz"
				|| obj1=="rjl" || obj1=="lhl" || obj1=="djs"
				|| obj1=="hjs" || obj1=="rzhs"|| obj1=="propertyAge")
		{
			//var txtc=txt.textContent;
			//txtc=txtc.replace(/[^0-9.\-]*/g,"");
			//$("#"+obj1).val(txtc);
			
			var nums = txt.textContent;
	        var reg = /[0-9.]*/g;
	        var numList = nums.match(reg);
	        if(numList != null)
	        {
	        	$("#"+obj1).val(numList[0]);
	        }
		}
		else
		{
			$("#"+obj1).val(txt.textContent);
		}
	}
	
	function queryFloorInfo()
	{
		var temp=$("#country").val();
		if(temp==null || temp==0)
		{
			alert("请选择国家");
			return;
		}
		
		var temp=$("#pro").val();
		if(temp==null || temp==0)
		{
			alert("请选择省份");
			return;
		}
		
		var temp=$("#city").val();
		if(temp==null || temp==0)
		{
			alert("请选择城市");
			return;
		}
		
		var temp=$("#sQy").val();
		if(temp==null || temp==0)
		{
			alert("请选择街道");
			return;
		}
		
		var sbt=$("#lpxxForm");
		sbt.submit();
		
		if(crawlDataList!=null && crawlDataList.length>0)
		{
			var idList="";
			for(var i=0;i<crawlDataList.length;i++)
			{
				var tempId=crawlDataList[i][sourceIndex+2];
				if(tempId!=undefined && tempId!=null && tempId.toString().length>0)
				{
					idList=idList+tempId+",";
				}
			}
			if(idList.length>0)
			{
				idList=idList.substring(0,idList.length-1);
				
				// 保存采集状态.
				jQuery.ajax(
				{
						url : "<%=basePath%>/spider/spiderAction!updateCrawlStatus.action", 
						dataType: "json",
						data: {"idList" : idList}, 
						type: "POST",
						async :false,
						success: function(result)
						{
							if(result.data == 1) 
							{
								alert("update crawl status success.");
							}
							else 
							{
								alert("update crawl status fail.");
							}
						}
				});
			}
		}
	}
	
	
	// 查询小区信息，区分插入或更新.
	function saveFloorInfo(delId)
	{
			jQuery.ajax({
				url: basepath + "/cam/campus!saveLpxx.action",
				dataType: "json",
				data: $('#lpxxForm').serialize(), 
				type: "POST",
				async :false,
				beforeSend: function(){
					//在异步提交前要做的操作
					return lpxxCheck();
				},
				success: function(result){
					if(result.data == "success") {
						//在异步提交成功后要做的操作
						bootbox.alert({title:"提示",message:"保存成功!"});
						$("#tabWy").attr("href","#tab2").attr("data-toggle","tab");
						$("#tabTk").attr("href","#tab3").attr("data-toggle","tab");
						$("#tabDz").attr("href","#tab4").attr("data-toggle","tab");
						$("#tabSs").attr("href","#tab5").attr("data-toggle","tab");
						$("#lpxxid").val(result.id);
						$("#wuyelpid").val(result.id);	//物业
						$("#tuplpid").val(result.id);	//图片
						$('.onsubing').css("display","none");//弹出提示框
						$("#tabWy").click();
						//跳到下一步
					} else {
						$('.onsubing').css("display","none");//弹出提示框
						return false;
					}
				}
			});
			
			//弹出提示框
			$('.onsubing').css("display","none");
				return false;
	}
	
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
<script src="<%=basePath%>/assets/js/bootstrap.min.js"></script>
<script src="<%=basePath%>/assets/js/TweenMax.min.js"></script>
<script src="<%=basePath%>/assets/js/resizeable.js"></script>
<script src="<%=basePath%>/assets/js/joinable.js"></script>
<script src="<%=basePath%>/assets/js/xenon-api.js"></script>
<script src="<%=basePath%>/assets/js/xenon-toggles.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/xenon-widgets.js"></script>
<script src="<%=basePath%>/assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script src="<%=basePath%>/assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>
<script src="<%=basePath%>/assets/js/toastr/toastr.min.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/jquery-ui/jquery-ui.js"></script>
<script src="<%=basePath%>/assets/js/tocify/jquery.tocify.min.js"></script>


<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/select2/select2.min.js"></script>
<script src="<%=basePath%>/assets/js/multiselect/js/jquery.multi-select.js"></script>
<script src="<%=basePath%>/assets/js/formwizard/jquery.bootstrap.wizard.min.js"></script>
<script src="<%=basePath%>/assets/js/selectboxit/jquery.selectBoxIt.min.js"></script>
<script src="<%=basePath%>/assets/js/toastr/toastr.min.js"></script>
<script src="<%=basePath%>/assets/js/wysihtml5/lib/js/wysihtml5-0.3.0.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/wysihtml5/src/bootstrap-wysihtml5.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="<%=basePath%>/assets/js/tocify/jquery.tocify.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/assets/images/new_file.js"></script>

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
