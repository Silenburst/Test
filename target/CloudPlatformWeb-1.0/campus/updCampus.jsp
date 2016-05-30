<%@page import="com.newenv.lpzd.Utils.FileUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>修改小区</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="Xenon Boostrap Admin Panel" />
<meta name="author" content="" />
<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/linecons/css/linecons.css">
<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/fontawesome/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=basePath%>/assets/css/bootstrap.css">
<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-core.css">
<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-forms.css">
<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-components.css">
<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-skins.css">
<link rel="stylesheet" href="<%=basePath%>/assets/css/custom.css">
<link rel="stylesheet" href="<%=basePath%>/assets/css/xiaoqu.css">
<link rel="stylesheet" href="<%=basePath%>/assets/js/wysihtml5/src/bootstrap-wysihtml5.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/js/ext/exttab/css/ext-all.css"> 
<link rel="stylesheet" href="<%=basePath%>/assets/js/bootbox/bootbox.css">
<script type="text/javascript">
	var basepath = "<%=basePath%>";
	var fromPageTab = "${param.fromPageTab}";	//来源页面当前的页签
</script>
<script src="<%=basePath%>/assets/js/jquery-1.11.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath%>/js/ext/exttab/js/ext-base.js" ></script> 
<script type="text/javascript" src="<%=basePath%>/js/ext/exttab/js/ext-all.js" ></script> 
<script src="<%=basePath%>/assets/js/bootbox/bootbox.min.js"></script>
<script src="<%=basePath%>/assets/js/page.js"></script>
<script src="<%=basePath%>/js/comm/commInfo.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/campus/updCampus.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/campus/lpDong.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/campus/facilities.js" type="text/javascript"></script>
<style type="text/css">
	table .active a{ color:red;}
</style>
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
		<div class="main-content">
			<jsp:include page="../include/top.jsp"/>
			<div class="page-title">
				<div class="breadcrumb-env pull-left">
					<ol class="breadcrumb bc-1">
						<li>
							<a href="javascript:void(0)"><i class="fa-home"></i>首页</a>
						</li>
						<s:if test='#parameters.from[0]=="check"'>
							<li>
								<a href="javascript:cancel()">采盘及地址审核列表</a>
							</li>
							<li class="active">
								<strong>小区信息</strong>
							</li>
						</s:if>
						<s:else>
							<li>
								<a href="<%=basePath%>/cam/campus.action?p=xq&k=lp">小区信息</a>
							</li>
							<li class="active">
								<strong>修改小区</strong>
							</li>
						</s:else>
					</ol>
				</div>
			<div class="row paddinglr">

				<div id="rootwizard" class="form-wizard">

					<ul class="tabs">
						<li class="active"><a href="#tab1" data-toggle="tab">基础信息</a>
						</li>
						<li><a id="tabWy" href="#tab2" data-toggle="tab">物业信息</a></li>
						<li><a id="tabTk" href="#tab3" data-toggle="tab">楼盘图库</a></li>
						<li><a id="tabDz" href="#tab4" data-toggle="tab">栋座资料</a></li>
						<li><a id="tabSs" href="#tab5" data-toggle="tab">配套设施</a></li>
					</ul>

					<div class="progress-indicator">
						<span></span>
					</div>
					<div class="tab-content">
						<!-- Tabs Content -->
						<div class="tab-pane active" id="tab1">
							<div class="panel panel-default">
								<div class="panel-heading">
									<ul class="nav nav-tabs">
										<li class="active"><a href="" data-toggle="tab"><h2>小区基本信息</h2></a>
										</li>
									</ul>
								</div>
								<div class="panel-body">
									<form role="form" class="form-horizontal" id="lpxxForm">
										<input type="hidden" id="lpxxid" value="${loadLpxx.id}" name="lpxx.id"/>
										<input type="hidden" name="from" value="${param.from}"/>
										<input type="hidden" name="lpxx.checkStatus" value="${loadLpxx.checkStatus}"/>
										<div class="form-group">
											<div class="col-md-12">

												<label class="control-label col-md-1" for="field-1"><span style="color:red">国家</span></label>

												<div class="col-md-3 ">
													<select class="form-control" id="country" data-value="${loadLpxx.countryid}" name="lpxx.countryid" onchange="buildPro(this.value,false)">
														<option value="" >请选择</option>
													</select>
												</div>

												<label class="control-label col-md-1" for="field-1"><span style="color:red">省份/州</span></label>

												<div class="col-md-3">
													<select class="form-control" id="pro" data-value="${loadLpxx.provinceid}" name="lpxx.provinceid" onchange="buildCity(this.value,false)">
														<option value="">请选择</option>
													</select>
												</div>
												
												<label class="control-label col-md-1" for="field-1"><span style="color:red">城市</span></label>

												<div class="col-md-3">
													<select class="form-control" id="city" data-value="${loadLpxx.cityId}" name="lpxx.cityId" onchange="buildQy(this.value,false)">
														<option value="">请选择</option>
													</select>
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-12">

												<label class="control-label col-md-1" for="field-1"><span style="color:red">区域</span></label>

												<div class="col-md-3">
													<select class="form-control" id="sQy" data-value="${loadLpxx.stressId}" name="lpxx.stressId" onchange="buildSq(this.value,false)">
														<option value="">请选择</option>
													</select>
												</div>

												<label class="control-label col-md-1" for="field-1"><span style="color:red">商圈</span></label>

												<div class="col-md-3">
													<select class="form-control" id="sSq" data-value="${loadLpxx.sqId}" name="lpxx.sqId">
														<option value="">请选择</option>
													</select>
												</div>
												<label class="control-label col-md-1" for="field-1"><span style="color:red">楼盘用途</span></label>
												<div class="col-md-3">
													<select class="form-control" id="yongtu" data-value="${loadLpxx.yongTu}" name="lpxx.yongTu">
														<option value="">请选择</option>
													</select>
												</div>
											</div>
										</div>

										<div class="form-group-separator"></div>

										<div class="form-group">
											<div class="col-md-12">
												<label class="control-label col-md-1" for="field-1"><span style="color:red">楼盘名称</span></label>

												<div class="col-md-3">
													<input type="text" class="col-sm-10 form-control" id="lpName" value="${loadLpxx.lpName}" name="lpxx.lpName">
												</div>
												<label class="control-label col-md-1" for="field-1"><span style="color:red">行政地址</span></label>

												<div class="col-md-3">
													<input type="text" class="col-sm-10 form-control" id="address" value="${loadLpxx.address}" name="lpxx.address">
												</div>
											</div>
										</div>
										
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-12">
												<label class="control-label col-md-1" for="field-1"><span style="color:red">坐标地址</span></label>

												<div class="col-md-3">
													<input type="text" class="col-xs-6 wenbenkuan1" id="xxzbx" name="lpxx.x" value="${loadLpxx.x}" readonly>
													<input type="text" class="col-xs-6 wenbenkuan1" id="xxzby" name="lpxx.y" value="${loadLpxx.y}" readonly>
												</div>
												<a class="btn btn-secondary" id="loadXY"  data-toggle="modal" data-target="#map-info-windom">获取位置</a>
											</div>
										</div>

										<div class="form-group-separator"></div>

										<div class="form-group">
											<div class="col-md-12">
												<label class="col-sm-1 control-label"><span style="color:red">产权地址</span></label>

												<div class="col-sm-11">
													<input type="text" class="form-control" id="propertyAddress" value="${loadLpxx.propertyAddress}" name="lpxx.propertyAddress">
												</div>
											</div>
										</div>

										<div class="form-group-separator"></div>

										<div class="form-group">
											<div class="col-md-12">
												<label class="col-sm-1 control-label" for="field-3">别名</label>

												<div class="col-sm-3">
													<input type="text" class="col-sm-10 form-control" value="${loadLpxx.bieMing}"  name="lpxx.bieMing">
												</div>
												<label class="col-sm-1 control-label" for="field-3">容积率</label>

												<div class="col-sm-3">
													<div class="input-group input-group-minimal">
														<input type="text" class="form-control" value="${loadLpxx.rjl}" name="lpxx.rjl">
														<div class="input-group-addon">
															<a href="#">%</a>
														</div>
													</div>
												</div>
												<label class="col-sm-1 control-label" for="field-3">绿化率</label>

												<div class="col-sm-3">
													<div class="input-group input-group-minimal">
														<input type="text" class="form-control" value="${loadLpxx.lhl}" name="lpxx.lhl">

														<div class="input-group-addon">
															<a href="#">%</a>
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="form-group-separator"></div>

										<div class="form-group">
											<div class="col-md-12">	
												<label class="col-sm-1 control-label" for="field-3">总建筑面积</label>

												<div class="col-sm-3">
													<div class="input-group input-group-minimal">
														<input type="text" class="form-control" value="${loadLpxx.sumJz}" name="lpxx.sumJz">
														<div class="input-group-addon">
															<a href="#">㎡</a>
														</div>
													</div>
												</div>
												<label class="col-sm-1 control-label" for="field-3">总占地面积</label>

												<div class="col-sm-3">
													<div class="input-group input-group-minimal">
														<input type="text" class="form-control" value="${loadLpxx.sumZd}" name="lpxx.sumZd">
														<div class="input-group-addon">
															<a href="#">㎡</a>
														</div>
													</div>
												</div>
												<label class="col-sm-1 control-label" for="field-3">锁盘</label>
												<div class="col-sm-3">
													<div class="input-group input-group-minimal">
														<div class="radio col-sm-6">
															<label>
																<input type="radio" name="lpxx.statuss" value="2" <s:if test="#loadLpxx.statuss==2">checked="checked"</s:if>>是
															</label>
														</div>
														<div class="radio col-sm-6">
															<label>
																<input type="radio" name="lpxx.statuss" value="1" <s:if test="#loadLpxx.statuss==1">checked="checked"</s:if>> 否
															</label>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-12">
												<label class="col-sm-1 control-label" for="field-3">总户数</label>
												<div class="col-sm-3">
													<input type="text" class="form-control" value="${loadLpxx.hjs}" name="lpxx.hjs">
												</div>
												<label class="col-sm-1 control-label" for="field-3">街道办事处</label>
												<div class="col-sm-3">
													<input type="text" class="form-control" value="${loadLpxx.jieDao}" name="lpxx.jieDao">
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-12">
												<label class="col-sm-1 control-label" for="field-3">销售代理</label>
												<div class="col-sm-3">
													<input type="text" class="form-control" value="${loadLpxx.xsdl}" name="lpxx.xsdl">
												</div>
												<label class="col-sm-1 control-label" for="field-3">栋数</label>
												<div class="col-sm-3">
													<input type="text" class="form-control" value="${loadLpxx.djs}" name="lpxx.djs">
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-12">
												<label class="col-sm-1 control-label" for="field-3">施工单位</label>
												<div class="col-sm-3">
													<input type="text" class="form-control" value="${loadLpxx.sgdw}" name="lpxx.sgdw">
												</div>
												<label class="col-sm-1 control-label" for="field-3">所获奖项</label>
												<div class="col-sm-3">
													<input type="text" class="form-control" value="${loadLpxx.lpJiangX}" name="lpxx.lpJiangX">
												</div>
												<label class="col-sm-1 control-label" for="field-3">建筑年代</label>
												<div class="col-sm-3">
													<input type="text" class="form-control" value="${loadLpxx.buildingAge}" name="lpxx.buildingAge">
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group ">
											<div class="col-md-12">
												<label class="col-sm-1 control-label" for="field-3">小区群</label>
												<div class="col-sm-3">
													<input type="text" class="form-control" value="${loadLpxx.qq}" name="lpxx.qq">
												</div>
												<label class="col-sm-1 control-label" for="field-3">开发商</label>
												<div class="col-sm-3">
													<input type="text" class="form-control" value="${loadLpxx.kaiFa}" name="lpxx.kaiFa">
												</div>
												<label class="col-sm-1 control-label" for="field-3">人车分离</label>
												<div class="col-sm-3">
													<div class="input-group input-group-minimal">
														<div class="radio col-sm-6">
															<label>
																<input type="radio" name="lpxx.renChe" value="1" <s:if test="#loadLpxx.renChe==1">checked="checked"</s:if>>是
															</label>
														</div>
														<div class="radio col-sm-6">
															<label>
																<input type="radio" name="lpxx.renChe" value="0" <s:if test="#loadLpxx.renChe==0">checked="checked"</s:if>>是
															</label>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-12">
												<label class="col-sm-1 control-label" for="field-3">得房率</label>
												<div class="col-sm-3">
													<div class="input-group input-group-minimal">
														<input type="text" class="form-control" value="${loadLpxx.roomRate}" name="lpxx.roomRate">
														<div class="input-group-addon">
															<a href="#">%</a>
														</div>
													</div>
												</div>
												<label class="col-sm-1 control-label" for="field-3">开发商号码</label>
												<div class="col-sm-3">
													<input type="text" class="form-control" value="${loadLpxx.kaiFaPhone}" name="lpxx.kaiFaPhone">
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-12">
												<label class="col-sm-1 control-label" for="field-11">楼盘标签</label>
												<div class="col-sm-10">
													<div class="form-block" id="lptag" data-value="${loadLpxx.lpTag}">
													</div>
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-12">
												<label class="col-sm-1 control-label" for="field-11">内部设施</label>
												<div class="col-sm-10">
													<div class="form-block" id="supporting" data-value="${loadLpxx.propertySupporting}">
													</div>
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-12">
												<label class="col-sm-1 control-label" for="field-11">楼盘简介</label>
												<div class="compose-message-editor col-sm-10">
													<textarea id="more" name="lpxx.more">${loadLpxx.more}</textarea>
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-12">
												<label class="col-sm-1 control-label" for="field-11">车库说明</label>
												<div class="col-sm-10">
													<textarea id="PNum" name="lpxx.PNum">${loadLpxx.PNum}</textarea>
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-12">
												<div class="col-sm-4 col-sm-offset-3">
													<input type="submit" class="btn btn-success" value="保存"/>
													<input type="button" class="btn btn-success" onclick="cancel()" value="返回列表"/>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>

						<div class="tab-pane" id="tab2">
							<div class="panel panel-default">
								<div class="panel-heading">
									<ul class="nav nav-tabs">
										<li class="active"><a href="" data-toggle="tab"><h2>物业信息</h2></a>
										</li>
									</ul>
								</div>
								<div class="panel-body">
									<form role="form" class="form-horizontal" id="wyForm">
										<input type="hidden" name="wyxx.id" id="wuyeid" value="${wuye.id}"/>
										<input type="hidden" name="wyxx.xhjLpxx.id" id="wuyelpid" value="${loadLpxx.id}"/>
										<div class="form-group">
											<div class="col-md-10">
												<label class="col-sm-2 control-label"><span style="color:red">物业公司名称</span></label>
												<div class="col-sm-5">
													<input type="text" class="form-control" value="${wuye.wyName}" id="wyName" name="wyxx.wyName">
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-10">
												<label class="col-sm-2 control-label"><span style="color:red">物业公司地址</span></label>

												<div class="col-sm-5">
													<input type="text" class="form-control" value="${wuye.wydz}" id="wydz" name="wyxx.wydz">
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-10">
												<label class="col-sm-2 control-label"><span style="color:red">物业公司电话</span></label>
												<div class="col-sm-5">
													<input type="text" class="col-xs-5 wenbenkuan1" value="${wuye.telephone}" id="telephone" name="wyxx.telephone">
													<div class="col-xs-2 text-center magin-top5">一</div>
													<input type="text" class="col-xs-5 wenbenkuan1" value="${wuye.telephone1}" id="telephone1" name="wyxx.telephone1">
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-10">
												<label class="col-sm-2 control-label">物业费</label>
												<div class="col-sm-3">
													<div class="input-group input-group-minimal">
														<input type="text" class="form-control" value="${wuye.wuYe}" name="wyxx.wuYe">

														<div class="input-group-addon">
															<a href="#">元/㎡/月</a>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-10 ">
												<label class="col-sm-2 control-label" for="field-11">物业简介</label>
												<div class="col-sm-10">
													<textarea class="form-control" name="wyxx.remark" id="wyRemark">${wuye.remark}</textarea>
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-10 ">
												<label class="col-sm-2 control-label" for="field-3">停车费</label>
												<div class="col-sm-3">
													<div class="input-group input-group-minimal">
														<input type="text" class="form-control" value="${wuye.parkingFee}" name="wyxx.parkingFee">

														<div class="input-group-addon">
															<a href="#">元/㎡</a>
														</div>
													</div>
												</div>
												<label class="col-sm-1 control-label" for="field-3">门禁系统</label>
												<div class="col-sm-3">
													<div class="input-group input-group-minimal">
														<div class="radio col-sm-6">
															<label>
																<input type="radio" name="wyxx.menJin" value="1" <s:if test="#wuye.menJin==1">checked="checked"</s:if>> 是
															</label>
														</div>
														<div class="radio col-sm-6">
															<label> 
																<input type="radio" name="wyxx.menJin" value="0" <s:if test="wuye.menJin==0">checked="checked"</s:if>>否
															</label>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
										<div class="form-group">
											<div class="col-md-10 ">
												<label class="col-sm-2 control-label" for="field-3">监控系统</label>
												<div class="col-sm-3">
													<div class="input-group input-group-minimal">
														<div class="radio col-sm-6">
															<label>
																<input type="radio" name="wyxx.jianKong" value="1" <s:if test="#wuye.jianKong==1">checked="checked"</s:if>>是
															</label>
														</div>
														<div class="radio col-sm-6">
															<label> 
																<input type="radio" name="wyxx.jianKong" value="0" <s:if test="#wuye.jianKong==0">checked="checked"</s:if>>否
															</label>
														</div>
													</div>
												</div>
												<label class="col-sm-1 control-label" for="field-3">物业租赁</label>
												<div class="col-sm-6">
													<div class="radio col-xs-2">
														<label>
															<input type="radio" name="wyxx.zuShou" value="1" <s:if test="#wuye.zuShou==1">checked="checked"</s:if>>出租
														</label>
													</div>
													<div class="radio col-xs-2">
														<label>
															<input type="radio" name="wyxx.zuShou" value="2" <s:if test="#wuye.zuShou==2">checked="checked"</s:if>>出售
														</label>
													</div>
													<div class="radio col-xs-3">
														<label>
															<input type="radio" name="wyxx.zuShou" value="3" <s:if test="#wuye.zuShou==3">checked="checked"</s:if>>租售均可
														</label>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group-separator"></div>
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
										<input type="hidden" name="tuplpid" id="tuplpid" value="${loadLpxx.id}">
										<div id="webImageofhouse_image_hidden">
											<% int si = 1; %>
											<s:iterator value="lptp" var="item">
												 <input type="hidden" id="txtExclusiveImgFileName<%=si%>" name="imageUrl[<%=si%>].img" value="${item.img}"/>
												 <input type="hidden" id="txtIndex<%=si%>" name="imageUrl[<%=si%>].statuss" value="1">
												 <input type="hidden" id="txtType<%=si%>" name="imageUrl[<%=si%>].imgType" value="${item.imgType}"/>
												 <% si++; %>
							                </s:iterator>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3"><span class="red">图片类型</span></label>
											<div class="col-sm-8">
												<select class="form-control" id="houseExclusiveImgType">
													<option value="3">环境图</option>
													<option value="1">户型图</option>
													<option value="2">交通图</option>
													<option value="4">样板图</option>
													<option value="5">效果图</option>
												</select>
											</div>
										</div>
<!-- 										<div class="form-group"> -->
<!-- 											<label class="col-sm-2 control-label" for="field-3">图片名称</label> -->
<!-- 											<div class="col-sm-8"> -->
<!-- 												<input type="input" class="form-control" id="imgNameAll" name="imgNameAll" placeholder=""> -->
<!-- 											</div> -->
<!-- 										</div> -->
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3">上传图片</label>
											<div class="col-sm-5" id="fkContainer">
												<a id="fkPickfiles" href="javascript:void(0);">
					                				<button type="button" class="btn btn-success">上传</button> 
					                			</a>
											</div>
											<span class="help-block">(请上传大小在800*640、5M以内的jpg、png、gif格式图片)</span>
										</div>
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
														<% int j = 1; %>
															<s:iterator value="lptp" var="item">
																<s:if test="#item.imgType==3">
																 	<div class="col-lg-6 col-xs-12">
																 	<a href="#" class="thumb" data-action="edit">
																		<img width="200" height="150" class="img-thumbnail" src="<%=FileUtil.imageUrl%>/${item.img}@200w_150h">
																	</a>
																		<div class="text-center">
																			<a href="javascript:void(0)" onclick="removeExclusiveImg(<%=j%>,'${item.img}', this)">删除</a>
																		</div>
																	</div>
																</s:if>
																<% j++; %>
										                    </s:iterator>
														</div>
													</div>
													<div class="tab-pane" id="ulHouseExclusiveFiles2">
														<div class="panel-body">
															<% j = 1;%>
															<s:iterator value="lptp" var="item">
																<s:if test="#item.imgType==2">
																 	<div class="col-lg-6 col-xs-12">
																 		<a href="#" class="thumb" data-action="edit">
																			<img width="200" height="150" class="img-thumbnail" src="<%=FileUtil.imageUrl%>/${item.img}@200w_150h">
																		</a>
																		<div class="text-center">
																			<a href="javascript:void(0)" onclick="removeExclusiveImg(<%=j%>,'${item.img}', this)">删除</a>
																		</div>
																	</div>
																</s:if>
																<% j++; %>
										                    </s:iterator>
														</div>
													</div>
													<div class="tab-pane" id="ulHouseExclusiveFiles1">
														<div class="panel-body">
															<% j = 1;%>
															<s:iterator value="lptp" var="item">
																<s:if test="#item.imgType==1">
																 	<div class="col-lg-6 col-xs-12">
																 		<a href="#" class="thumb" data-action="edit">
																			<img width="200" height="150" class="img-thumbnail" src="<%=FileUtil.imageUrl%>/${item.img}@200w_150h">
																		</a>
																		<div class="text-center">
																			<a href="javascript:void(0)" onclick="removeExclusiveImg(<%=j%>,'${item.img}', this)">删除</a>
																		</div>
																	</div>
																</s:if>
																<% j++; %>
									                    	</s:iterator>
														</div>
													</div>
													<div class="tab-pane" id="ulHouseExclusiveFiles4">
														<div class="panel-body">
															<% j = 1;%>
															<s:iterator value="lptp" var="item">
															<s:if test="#item.imgType==4">
															 	<div class="col-lg-6 col-xs-12">
															 		<a href="#" class="thumb" data-action="edit">
																		<img width="200" height="150" class="img-thumbnail" src="<%=FileUtil.imageUrl%>/${item.img}@200w_150h">
																	</a>
																	<div class="text-center">
																		<a href="javascript:void(0)" onclick="removeExclusiveImg(<%=j%>,'${item.img}', this)">删除</a>
																	</div>
																</div>
															</s:if>
															<% j++; %>
									                    </s:iterator>
														</div>
													</div>
													<div class="tab-pane" id="ulHouseExclusiveFiles5">
														<div class="panel-body">
															<% j = 1;%>
															<s:iterator value="lptp" var="item">
															<s:if test="#item.imgType==5">
															 	<div class="col-lg-6 col-xs-12">
															 		<a href="#" class="thumb" data-action="edit">
																		<img width="200" height="150" class="img-thumbnail" src="<%=FileUtil.imageUrl%>/${item.img}@200w_150h">
																	</a>
																	<div class="text-center">
																		<a href="javascript:void(0)" onclick="removeExclusiveImg(<%=j%>,'${item.img}', this)">删除</a>
																	</div>
																</div>
															</s:if>
															<% j++; %>
									                    </s:iterator>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-md-5 col-md-offset-5">
												<input type="submit" class="btn btn-success" value="保存">
												<input type="button" class="btn btn-success" onclick="cancel()" value="返回列表"/>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>

						<div class="tab-pane" id="tab4">
								<div class="panel panel-default">
									<div class="panel-heading">
										<ul class="nav nav-tabs">
											<li class="active">
												<a href="" data-toggle="tab">栋座资料</a>
											</li>
										</ul>
									</div>
									<div>
										<div class="panel-body col-lg-3">
											<div class="input-group" style="padding-bottom: 10px;">
											<input type="text" class="form-control no-right-border form-focus-purple" placeholder="请输入栋座名称" id="lpdong_lpdName">
											<span class="input-group-btn">
												<a href="javascript:queryDong()" class="btn btn-success" >搜索</a>
											</span>
										</div>
										<div>
											<a href="" class="btn btn-success btn-xs" data-toggle="modal" onclick="showAddDongDlg()" data-target="#Donglou">新增栋座</a>
										</div>
											<div class="col-lg-12">
												<div class="table-responsive scrollable" data-max-height="500">
													<table class="table table-bordered table-striped" id="tblLpdong">
														<thead>
															<tr>
																<th>序列</th>
																<th>栋座</th>
																<th>操作</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="dongTbody">
														</tbody>
													</table>
												</div>
											</div>
										</div>				
									
										<div class="panel-body col-lg-5">
											<div class="col-lg-12" style="padding-top: 42px;">
												<button class="btn btn-success btn-xs" onclick="showAddDanyuanDlg()">新增单元</button>
												<a data-toggle="modal" id="addDanYuan" data-target="#Danyuan"></a>
											</div>
											<div class="col-lg-7">
												<div class="table-responsive scrollable" data-max-height="500">
													<table class="table table-bordered table-striped" id="tblLpdanyuan">
														<thead>
															<tr>
																<th>序列</th>
																<th>单元名称</th>
																<th>操作</th>
															</tr>
														</thead>
														<tbody class="middle-align">
															
														</tbody>
													</table>
												</div>
											</div>
											<div class="col-lg-5">
												<div class="table-responsive scrollable" data-max-height="500">
													<table class="table table-bordered table-striped"  id="tblLpceng">
														<thead>
															<tr>
																<th>序列</th>
																<th>层号名称</th>
															</tr>
														</thead>
														<tbody class="middle-align">
															
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
																<th><input type="checkbox" class="cbALL"/></th>
																<th>序列</th>
																<th>房号名称</th>
																<th>操作</th>
															</tr>
														</thead>
														<tbody class="middle-align">
															
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
									<div class="panel-body">
										<div class="text-center ">
											<textarea class="form-control" id="dzRemark" cols="5" id="field-5">${loadLpxx.dzRemark}</textarea>
											<br>
											<button onclick="saveDzRemark()" class="btn btn-success">保存备注</button>
											<input type="button" class="btn btn-success" onclick="cancel()" value="返回列表"/>
										</div>
									</div>								
								</div>
							</div>
						
						<div class="tab-pane" id="tab5">
							<div class="panel panel-default">
								<div class="panel-heading">
									<ul class="nav nav-tabs">
										<li class="active"><a href="" data-toggle="tab"><h2>配套设施</h2></a>
										</li>
									</ul>
								</div>

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
													<a href="#" data-toggle="modal" id="showSchoolAdd" data-target="#xinzenhuapian"></a>
													<a href="#" data-toggle="modal" id="showUpd" data-target="#xinzenhuapian1"></a>
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

					<!-- Tabs Pager
					<ul class="pager wizard">
						<div class="col-sm-6 col-sm-offset-3">
							<li class="previous"><a href="#"><i
									class="entypo-left-open"></i> 上一步</a></li>
							<li class="next"><a href="#">下一步 <i
									class="entypo-right-open"></i></a></li>
							<li><a href="#">取消</a></li>
						</div>
					</ul>
					 -->
					 
				</div>
			</div>

		</div>
	</div>

	</div>
	<div class="both"></div>
	</div>

	<!-- Main Footer -->
	</div>
	</div>

	<div class="go-up"
		style="position: fixed; right: 15px; bottom: 10px; z-index: 9999;">
		<a href="#" rel="go-top"> <i class="el-up-open"></i>
		</a>
	</div>
</body>

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
</html>

<!-- JavaScripts initializations and stuff -->
<script src="<%=basePath%>/assets/js/xenon-custom.js"></script>
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
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table" id="tblAddDong">
						<tbody>
							<tr>
								<td width="90">新增方式</td>
								<td>
									<label class="radio-inline"> 
										<input type="radio" id="status1" name="dongAddType" value="Single" checked="checked" class="checkbox" onclick="dongAddTypeClicked(this)"> <span>单个添加</span>
									</label>
									<label class="radio-inline"> 
										<input type="radio" id="status1" name="dongAddType" value="Batch" onclick="dongAddTypeClicked(this)"> <span>批量新增</span>
									</label>
								</td>
							</tr>
							<!-- 点击批量新增出现 -->
							<tr class="dongBatch">
								<td>名称前缀</td>
								<td><input type="text" name="prefix" class="form-control" placeholder=""></td>
							</tr>
							<tr class="dongBatch">
								<td><font color="#f00">批量序号</font></td>
								<td><div class="col-md-3">
										<input type="text" name="start" class="form-control" placeholder="">
									</div>
									<div class=" pull-left">-</div><div class="col-md-3">
										<input type="text" name="end" class="form-control" placeholder="">
									</div>
								</td>
							</tr>
							<tr class="dongBatch">
								<td>名称后缀</td>
								<td><input type="text" name="suffix" class="form-control" placeholder=""></td>
							</tr>
							<!-- 单个新增点击隐藏 End -->
							<tr class="dongSingle">
								<td><font color="#f00">栋座名称</font></td>
								<td><input type="text" name="lpdName" class="form-control" placeholder=""></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="doAddDong()">保存</button>
				<button type="button" class="btn btn-danger" id="dongClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal 4 (新增单元)-->
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
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table" id="tblAddDanyuan">
						<tbody>
							<tr>
								<td width="90">新增方式</td>
								<td>
									<label class="radio-inline" for="status1">
										<input type="radio" id="status1" name="danyuanAddType" value="Single" class="checkbox" onclick="danyuanAddTypeClicked(this)">
										<span>单个添加</span>
									</label>
									<label class="radio-inline" for="status1">
										<input type="radio" id="status1" name="danyuanAddType" value="Batch" class="checkbox" onclick="danyuanAddTypeClicked(this)">
										<span>批量新增</span>
									</label>
								</td>
							</tr>
							<!-- 点击批量新增出现 -->
							<tr class="danyuanBatch">
								<td>名称前缀</td>
								<td><input type="text" name="prefix" class="form-control" placeholder=""></td>
							</tr>
							<tr class="danyuanBatch">
								<td><font color="#f00">批量序号</font></td>
								<td>
									<div class="col-md-3">
										<input type="text" name="start" class="form-control" placeholder="">
									</div>
									<div class=" pull-left">-</div>
									<div class="col-md-3">
										<input type="text" name="end" class="form-control" placeholder="">
									</div>
								</td>
							</tr>
							<tr class="danyuanBatch">
								<td>名称后缀</td>
								<td><input type="text" name="suffix" class="form-control" placeholder=""></td>
							</tr>
							<!-- 单个新增点击隐藏 End -->
							<tr class="danyuanSingle">
								<td><font color="#f00">单元名称</font></td>
								<td><input type="text" name="dyName" class="form-control" placeholder=""></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="doAddDanyuan()">保存</button>
				<button type="button" class="btn btn-danger" id="danyClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>


<!-- Modal 4 (修改)-->
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
			<div class="modal-body" id="formUpdateDong">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td><span class="red">栋座名称</span></td>
								<td>
									<input type="hidden" name="lpdong.id">
									<input type="input" class="form-control" name="lpdong.lpdName">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="lpDongUpd()">修改</button>
				<button type="button" class="btn btn-danger" id="dongUpdClose" data-dismiss="modal">关闭</button>
			</div>
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
			<div class="modal-body" id="formUpdateDanyuan">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td><span class="red">栋座名称</span></td>
								<td>
									<input type="hidden" name="lpdanyuan.id">
									<input type="input" class="form-control" name="lpdanyuan.dyName">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="danYuanUpd()">修改</button>
				<button type="button" class="btn btn-danger" id="danyUpdClose" data-dismiss="modal">关闭</button>
			</div>
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
			<div class="modal-body">
				<div class="scrollable" data-max-height="400" id="formAddFanghao">
					<table class="table" id="tblAddFanghao">
			              <tr>
			              	<td width="90">新增方式</td>
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
									<input type="radio" id="status1" name="leixing" value="0" checked="checked" class="checkbox">
									<span>住宅</span>
								</label>
								<label class="radio-inline" for="status1">
									<input type="radio" id="status1" name="leixing" value="1" class="checkbox">
									<span>商铺</span>
								</label>
								</div>
							</td>
						  </tr>
			              <tr class="fanghaoSingle">
						  	  <td>
						  	  	  <font color="#f00">层数</font>
						  	  </td>
							  <td>
							  	  <input type="number" name="ceng" class="form-control">
							  </td>
						  </tr>
						  <tr class="fanghaoSingle">
							  <td><font color="#f00">房号名称</font></td>
							  <td><input type="text" name="fangHao" class="form-control"></td>
						  </tr>
			              <tr class="fanghaoBatch">
			              	<td>名称前缀</td>
			                <td>
								<input type="text" class="form-control" id="txtFhPrefix">
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
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="doAddLpFanghao(this)">保存</button>
				<button type="button" class="btn btn-danger" id="fanghaoClose" data-dismiss="modal">关闭</button>
			</div>
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
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table" id="formUpdateFanghao">
						<tbody>
							<tr>
								<td width="100">房号类型</td>
								<td>
									<label class="radio-inline"> 
										<input type="radio" name="leixing" value="0"> 住宅
									</label>
									<label class="radio-inline">
										<input type="radio" name="leixing" value="1"> 商铺
									</label>
								</td>
							</tr>
							<tr>
								<td>门牌名称</td>
								<td>
									<input type="text" class="form-control" name="fangHao">
								</td>
							</tr>
							<tr>
								<td>单元房号</td>
								<td>
									<input type="text" class="form-control" name="fhName">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="doUpdateFanghao(this)">保存</button>
				<button type="button" class="btn btn-danger" id="fanghaoUpdClose" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!--修改划片-->
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
<!-- Modal 4 (新增责任盘)-->
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
<!-- Modal 4 (新增维护盘)-->
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
<!-- Modal 4 (新增范围盘)-->
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
<script type="text/javascript" src="<%=basePath%>/js/kindeditor/kindeditor-min.js" charset="UTF-8"></script>
<script type="text/javascript">
	// Sample Javascript code for this page
	jQuery(document).ready(function($) {
		// Edit Modal
		$('a[data-action="edit"]').on('click', function(ev) {
			ev.preventDefault();
			$('#editimg').attr("src", $(this).find("img").attr("src"));
			$("#gallery-image-modal").modal('show');
		});
	});
</script>
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
<script type="text/javascript" src="<%=basePath%>/js/plupload/plupload.full.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/plupload/i18n/zh_CN.js"></script>
<script src="<%=basePath%>/js/campus/pluploadfile.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
	$(document).ready(function () {
		$(".xuequleixin div").click(function(){
			$(this).css("background-color", "#f4f4f4").siblings().css("background-color","#fff");
		});

	});
	$(document).ready(function($){
		$(".s2example-1").select2({
			placeholder: '请输入搜索条件...',
			allowClear: true
		}).on('select2-open', function()
		{
			// Adding Custom Scrollbar
			$(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
		});
		
	});
	
</script>
<div class="modal fade" id="infoModal" data-backdrop="static"></div>
<script>
	function buindModel() {
		$("a[href=#infoModal]").click(function(){
		    $("#infoModal").load($(this).attr("data-url"));
		});
	}
</script>
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

<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/xenon-widgets.js"></script>
<script src="<%=basePath%>/assets/js/select2/select2.min.js"></script>
<script src="<%=basePath%>/assets/js/multiselect/js/jquery.multi-select.js"></script>
<script src="<%=basePath%>/assets/js/formwizard/jquery.bootstrap.wizard.min.js"></script>
<script src="<%=basePath%>/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="<%=basePath%>/assets/js/selectboxit/jquery.selectBoxIt.min.js"></script>
<script src="<%=basePath%>/assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script src="<%=basePath%>/assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>
<script src="<%=basePath%>/assets/js/toastr/toastr.min.js"></script>
<script src="<%=basePath%>/assets/js/wysihtml5/lib/js/wysihtml5-0.3.0.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/wysihtml5/src/bootstrap-wysihtml5.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="<%=basePath%>/assets/js/tocify/jquery.tocify.min.js"></script>
<%-- <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=cwWUeu7m6ZIclzyUBhqMrA05"></script> --%>
<div class="modal fade" id="map-info-windom">
  <div class="modal-dialog modal-lg" style="width:100%">
  	<div class="modal-header">
<!--       <button type="button" class="close" id="mapModalClose" onclick="$('#mapModal').modal('hide')" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button> -->
      <h4 class="modal-title">地图</h4>
    </div>
    <div class="modal-content">
     	<iframe name ="bankWaterRecordList" id="bankWaterRecordList" src="<%=basePath%>/include/seekCoord.jsp" width="100%" height="500px" frameborder="0" marginheight="0" marginwidth="0" border="0"></iframe>
	    <div class="modal-footer">
			<button type="button" id="windowClose" class="btn btn-danger" data-dismiss="modal">关闭</button>
		</div>
    </div>
  </div>
</div>

<div class="modal fade" id="gallery-image-modal" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-gallery-image">
				<img src="../assets/images/tupian.jpg"  id="editimg" class="img-responsive" />
			</div>

			<div class="modal-body">

				<div class="row">
					<div class="col-md-12">

<!-- 						<div class="form-group"> -->
<!-- 							<label for="field-1" class="control-label">名称</label> -->
<!-- 							<input type="text" class="form-control" id="field-1" placeholder="输入图片标题"> -->
<!-- 						</div> -->

					</div>
				</div>

			</div>

			<div class="modal-footer modal-gallery-top-controls">
<!-- 				<button type="button" class="btn btn-xs btn-secondary">保存</button> -->
				<button type="button" class="btn btn-xs btn-white" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>