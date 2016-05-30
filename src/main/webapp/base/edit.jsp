<%@page import="com.newenv.lpzd.Utils.FileUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
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
		<script src="<%=basePath%>/assets/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="../js/plupload/plupload.full.min.js"></script>
		<script type="text/javascript" src="../js/plupload/i18n/zh_CN.js"></script>
		<script src="<%=basePath%>/js/base/schooljs.js" type="text/javascript"></script>
		<script src="<%=basePath%>/js/services.js"></script>
		<link rel="stylesheet" href="../assets/js/bootbox/bootbox.css">
		<script src="../assets/js/bootbox/bootbox.min.js"></script>
		<script type="text/javascript">
		var basepath = "<%=basePath%>";
		$(document).ready(function(){
			$("#bnSaveFw1").click(function(){
				if(!updateSchool())
				{
					return false;
				}
				bootbox.confirm({title:"确认",message:"是否跳转下一页？",callback:function(result){
			    if(result){
			      	$("#tabFwv2").click();
			    }
			    }});
			});
			$("#bnSaveFw2").click(function(){
				if(!updateSchool())
				{
					return false;
				}
					bootbox.confirm({title:"确认",message:"是否跳转下一页？",callback:function(result){
				    if(result){
				        $("#tabFwv3").click();
				    }
				    }});
			});
			$("#bnSaveFw3").click(function(){
				if(!updateSchool())
				{
					return false;
				}
					bootbox.confirm({title:"确认",message:"是否回到学校管理？",callback:function(result){
				    if(result){
				        cance();
				    }
				    }});
			});
			
			
			var countryid = ${condition.xhjLpschool.countryid}; 
			var sqid = ${condition.xhjLpschool.sqid};
			var provinceid = ${condition.xhjLpschool.provinceid};
			var cityid = ${condition.xhjLpschool.cityID}; 
			var qyid = ${condition.xhjLpschool.qyID}; 
			var schoolType = ${condition.xhjLpschool.schoolType}; 
			var kind = ${condition.xhjLpschool.kind}; 
			var schoolLevel = ${condition.xhjLpschool.schoolLevel}; 
			buildCountry();
			buildSTy();
			$("#country").val(countryid);
			buildPro(countryid);
			$("#pro").val(provinceid);
			buildCity(provinceid);
			$("#city").val(cityid);
			buildQy(cityid);
			$("#sQy").val(qyid);
			buildSq(qyid);
			$("#sSq").val(sqid);
			buildSTy();
			$("#xxlx").val(schoolType);
			$("#xxxz").val(kind);
			$("#xxdj").val(schoolLevel);
			$("#sqaddress").val($("#address").val());
			
		});
		</script>
<!-- 		<script type="text/javascript" src="<=basePath%>/js/plupload/i18n/zh_CN.js"></script> -->
<!-- 		<script src="<=basePath%>/js/base/pluploadfile.js" type="text/javascript"></script> -->
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
				<jsp:include page="../include/left.jsp"/>
			</div>
			<div class="main-content">
				<!-- User Info, Notifications and Menu Bar -->
				<jsp:include page="../include/top.jsp"/>
				<div class="page-title">
					<div class="title-env">
						<ol class="breadcrumb bc-1">
							<li>
								<a href="<%=basePath%>/console/index.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<li>
								<a href="<%=basePath%>/base/school.action?k=base&p=xq">学区管理</a>
							</li>
							<li class="active">
								<strong>学校编辑</strong>
							</li>
						</ol>
					</div>
				</div>

				<!-- Form wizard with validation starts here -->

<form role="forl" id="formWebImageofhouse"  class="form-wizard validate" method="post" action="">
<!-- <form  id="formWebImageofhouse" name="rootwizard" action="" method="post"> -->
<div id="webImageofhouse_image_hidden">
	<% int si = 0; %>
	<s:iterator value="condition.imageUrl" var="item">
		<s:if test="#item.type==1">
		 <input type="hidden" id="txtExclusiveImgFileName<%=si%>" name="condition.imageUrl[<%=si%>].img" value="${item.img}"/>
		 <input type="hidden" id="txtIndex<%=si%>" name="condition.imageUrl[<%=si%>].statuss" value="1">
		 <input type="hidden" id="txtType<%=si%>" name="condition.imageUrl[<%=si%>].type" value="1"/>
		 <% si++; %>
		</s:if>
    </s:iterator>
    <s:iterator value="condition.imageUrl" var="item">
  		<s:if test="#item.type==2">
		 <input type="hidden" id="txtExclusiveImgFileName<%=si%>" name="condition.imageUrl[<%=si%>].img" value="${item.img}"/>
		 <input type="hidden" id="txtIndex<%=si%>" name="condition.imageUrl[<%=si%>].statuss" value="1">
		 <input type="hidden" id="txtType<%=si%>" name="condition.imageUrl[<%=si%>].type" value="2"/>
		 <% si++; %>
		 </s:if>
	</s:iterator>
</div>
						<input type="hidden" id="schoolid" name="condition.schoolid"  value="${condition.schoolid}"/>
						<input type="hidden" id="id" name="condition.xhjLpschool.id" value="${condition.xhjLpschool.id}"/>
					<ul class="tabs">
						<li class="active" >
							<a href="#fwv-1" id="tabFwv1" data-toggle="tab">
							基础信息
							<span  id="jcxxtab">1</span>
							</a>
						</li>
						<li>
							<a href="#fwv-2" id="tabFwv2" data-toggle="tab" onclick="schoolCheck()">
							招生简章
							<span>2</span>
						</a>
						</li>
						<li>
							<a href="#fwv-3" id="tabFwv3" data-toggle="tab" onclick="schoolCheck()">
							学校图库
							<span>3</span>
						</a>
						</li>
<!-- 						<li> -->
<!-- 							<a href="#fwv-4" id="tabFwv4" data-toggle="tab" onclick="schoolCheck()"> -->
<!-- 							完成 -->
<!-- 							<span>4</span> -->
<!-- 						</a> -->
<!-- 						</li> -->
					</ul>

					<div class="progress-indicator">
						<span></span>
					</div>
					<div class="tab-content no-margin panel panel-default">

						<!-- Tabs Content -->
						<div class="tab-pane with-bg active" id="fwv-1">
							<div class="row">
								<h3>学校基本信息</h3>
								<hr />
										<div class="col-md-3 ">
											<div class="form-group">
											<label class="control-label" for="field-1"><span style="color:red">*国家</span></label>
												<select class="form-control" id="country" name="condition.xhjLpschool.countryid" onchange="buildPro(this.value)">
													<option value="">请选择</option>
												</select>
											</div>
											</div>

											<div class="col-md-3">
											<div class="form-group">
											<label class="control-label" for="field-1"><span style="color:red">*省份/州</span></label>
												<select class="form-control" id="pro" name="condition.xhjLpschool.provinceid" onchange="buildCity(this.value)">
													<option value="">请选择</option>
												</select>
											</div>
											</div>
											
											<div class="col-md-3">
											<div class="form-group">
											<label class="control-label" for="field-1"><span style="color:red">*城市</span></label>
												<select class="form-control" id="city" name="condition.xhjLpschool.CityID" onchange="buildQy(this.value)">
													<option value="">请选择</option>
												</select>
											</div>
											</div>
											
												<div class="col-md-3">
											<div class="form-group">
												<label class="control-label" for="field-1"><span style="color:red">*区域</span></label>
													<select class="form-control" id="sQy" name="condition.xhjLpschool.QyID" onchange="buildSq(this.value)">
														<option value="">请选择</option>
													</select>
												</div>
												</div>

												<div class="col-md-3">
											<div class="form-group">
												<label class="control-label" for="field-1"><span style="color:red">*商圈</span></label>
													<select class="form-control" id="sSq" name="condition.xhjLpschool.sqid">
														<option value="">请选择</option>
													</select>
												</div>
												</div>
												<div class="col-md-3">
											<div class="form-group">
												<label class="control-label" for="field-1"><span style="color:red">*学校类型</span></label>
													<select class="form-control" id="xxlx" name="condition.xhjLpschool.schoolType">
														<option value="">请选择</option>
													</select>
												</div>
												</div>
											<div class="col-md-3">
											<div class="form-group">
											<label class="control-label" for="field-1"><span style="color:red">*学校等级</span></label>
												<select class="form-control"   id="xxdj" name="condition.xhjLpschool.schoolLevel">
													<option value="">请选择</option>
												</select>
											</div>
											</div>
										<div class="col-md-3">
											<div class="form-group">
											<label class="control-label" for="field-1"><span style="color:red">*学校性质</span></label>
												<select class="form-control"  id="xxxz" name="condition.xhjLpschool.kind">
													<option value="">请选择</option>
												</select>
											</div>
											</div>
											
											<div class="col-md-3">
											<div class="form-group">
											<label class="control-label" for="field-1"><span style="color:red">*学校名称：</span></label>
											<input type="text" class="col-sm-10 form-control" id="schoolName" name="condition.xhjLpschool.schoolName" value="${condition.xhjLpschool.schoolName}">
											</div>
											</div>
											
											<div class="col-md-3">
											<div class="form-group">
												<label class="control-label " for="field-1"><span style="color:red">*学校地址</span></label>
												<div class="clearfix"></div>
												<div class="input-group">
													<input type="text" class="form-control" id="address" name="condition.xhjLpschool.address" value="${condition.xhjLpschool.address}">
													<a class="btn btn-secondary input-group-addon" id="loadXY"  data-toggle="modal" data-target="#map-info-windom">获取位置</a>
												</div>
												
												</div>
												<div class="clearfix"></div>
											</div>
											
											<div class="col-md-3">
											<label class="control-label" for="field-1"><span style="color:red">*坐标地址</span></label>
												<div class="clearfix"></div>
										<input type="text" class="col-xs-6 wenbenkuan1" id="xxzbx" name="condition.xxzbx" value ="${condition.xxzbx}" readonly>
										<input type="text" class="col-xs-6 wenbenkuan1" id="xxzby" name="condition.xxzby" value ="${condition.xxzby}" readonly>
											</div>
								<div class="clearfix"></div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label" for="about">联系方式：</label>
										<input type="text" class="col-sm-10 form-control" id="phone" name="condition.xhjLpschool.phone" value='${condition.xhjLpschool.phone==null?"":condition.xhjLpschool.phone}'>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label" for="about">电子信箱：</label>
										<input type="text" class="col-sm-10 form-control" id="email" name="condition.xhjLpschool.email" value='${condition.xhjLpschool.email}'>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label" for="about">学校网址：</label>
										<input type="text" class="col-sm-10 form-control" id="schoolwebsite" name="condition.xhjLpschool.schoolWebsite" value='${condition.xhjLpschool.schoolWebsite}'>
									</div>
								</div>
								<div class="clearfix"></div>

							</div>

							<div class="row">
								<h3>教学规模</h3>
								<hr />
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label" for="about">教师人数：</label>
										<input type="text" class="col-sm-10 form-control" id="teachernum" onchange="numberCheck()" name="condition.xhjLpschool.teacherNum" value='${condition.xhjLpschool.teacherNum}'>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label" for="about">学生人数：</label>
										<input type="text" class="col-sm-10 form-control" id="studentnum" onchange="numberCheck()" name="condition.xhjLpschool.studentNum" value='${condition.xhjLpschool.studentNum}'>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label" for="about">班级总数：</label>
										<input type="text" class="col-sm-10 form-control" id="classnum" onchange="numberCheck()" name="condition.xhjLpschool.classNum" value='${condition.xhjLpschool.classNum}'>
									</div>
								</div>
								<div class="col-md-12">
									<div class="form-group">
										<label class="control-label" for="about">学校简介：</label>
										<textarea class="form-control autogrow" rows="10" id="xuexiaojianjie" name="condition.xhjLpschool.schoolRemark" >
${condition.xhjLpschool.schoolRemark}
										</textarea>
									</div>
								</div>
							</div>
			<!-- Tabs Pager -->
						<ul class="pager wizard">
							<li class="previous"  style="float:left;margin-left:300px">
								<a href="#"><i class="fa-angle-double-left"></i> 上一步</a>
							</li>
							<li>
								<button type="button" id="bnSaveFw1" class="btn btn-info">保存</button>
								<button type="button" id="bnCloseFw1"   onclick="cance()" class="btn btn-info">返回列表</button>
							</li>

							<li class="next" style="float:right;margin-right:300px" >
								<a href="#" >下一步 <i class="fa-angle-double-right"></i></a>
							</li>
						</ul>
						</div>

						<div class="tab-pane with-bg" id="fwv-2">

							<div class="row">
								<h3>招生简章</h3>
								<hr />
								<div class="col-md-12">
									<div class="form-group">
										<label class="control-label" for="about">简章：</label>
										<textarea class="form-control" style="height: 500px;"  id="zhaoshengjz" name="condition.xhjLpschool.recruitStudentsInfo">
${condition.xhjLpschool.recruitStudentsInfo}
										</textarea>

									</div>
								</div>
							</div>
						<!-- Tabs Pager -->
						<ul class="pager wizard">
							<li class="previous"  style="float:left;margin-left:300px">
								<a href="#"><i class="fa-angle-double-left"></i> 上一步</a>
							</li>
							<li>
								<button type="button" id="bnSaveFw2" class="btn btn-info">保存</button>
								<button type="button" id="bnCloseFw2"   onclick="cance()" class="btn btn-info">返回列表</button>
							</li>

							<li class="next" style="float:right;margin-right:300px">
								<a href="#" >下一步 <i class="fa-angle-double-right"></i></a>
							</li>
						</ul>
						</div>

						<div class="tab-pane with-bg" id="fwv-3">

							<div class="row">
								<h3>学校图库</h3>
								<hr />
								<div class="col-md-12">
									<div class="col-md-8">
										<div class="form-group">
											<label class="control-label"  for="about" >图片类型：</label>
											<select class="form-control" id="houseExclusiveImgType">
												<option value="1">环境图</option>
												<option value="2">简章图</option>
											</select>
										</div>
									</div>
<!-- 									<div class="col-md-8"> -->
<!-- 										<div class="form-group"> -->
<!-- 											<label class="control-label" for="about" style="color: #f00;">图片名称：</label> -->
<!-- 											<input class="form-control" id="tupianming" data-validate="required" placeholder="" /> -->
<!-- 										</div> -->
<!-- 									</div> -->
									<div class="form-group">
<!-- 											<label class="col-sm-2 control-label" for="field-3">上传图片</label> -->
											<div class="col-sm-5" id="fkContainer">
												<a id="fkPickfiles" href="javascript:void(0);">
					                				<button type="button" class="btn btn-success">上传图片</button> 
					                			</a>
					                			<span class="help-block">(请上传大小在800*640、5M以内的jpg、png、gif格式图片)</span>
											</div>
									</div>
									<div class="col-md-8">
										<div class="form-group">
											<label class="control-label" for="about">全部图片：</label>
											<div class="panel panel-default">
												<div class="panel-heading">
													<div class="panel-options pull-left">
														<ul class="nav nav-tabs">
															<li class="active">
																<a href="#ulHouseExclusiveFiles1" id="houseExclusiveImgType1" data-toggle="tab">环境图</a>
															</li>
															<li>
																<a href="#ulHouseExclusiveFiles2" id="houseExclusiveImgType2" data-toggle="tab">简章图</a>
															</li>
														</ul>
													</div>
												</div>
												<div class="panel-body">
													<div class="tab-content">
														<div class="tab-pane active" id="ulHouseExclusiveFiles1">
														<div class="col-sm-5">
															<% int j = 1; %>
														<s:iterator value="condition.imageUrl" var="item">
																<s:if test="#item.type==1">
															 	<div class="col-lg-6 col-xs-12">
																<img id="file-${item.id}" width="200" height="150" class="img-thumbnail"  src="<%=FileUtil.imageUrl%>/${item.img}@200w_150h">
																	<div class="text-center">
																		<a href="javascript:void(0)" onclick="removeExclusiveImg(<%=j%>,'${item.img}', this)">删除</a>
																	</div>
																</div>
																<% j++; %>
															</s:if>
									                    </s:iterator>
														</div>
														</div>
														<div class="tab-pane" id="ulHouseExclusiveFiles2" >
														<div class="col-sm-5">
														<s:iterator value="condition.imageUrl" var="item">
																<s:if test="#item.type==2">
															 	<div class="col-lg-6 col-xs-12">
																<img id="file-${item.id}" width="200" height="150" class="img-thumbnail" src="<%=FileUtil.imageUrl%>/${item.img}@200w_150h">
																	<div class="text-center">
																		<a href="javascript:void(0)" onclick="removeExclusiveImg(<%=j%>,'${item.img}', this)">删除</a>
																	</div>
																</div>
																<% j++; %>
															</s:if>
									                    </s:iterator>
														</div>
														</div>
													</div>

												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						<!-- Tabs Pager -->
						<ul class="pager wizard">
							<li class="previous"  style="float:left;margin-left:300px">
								<a href="#"><i class="fa-angle-double-left"></i> 上一步</a>
							</li>
							<li>
								<button type="button" id="bnSaveFw3" class="btn btn-info">保存</button>
								<button type="button" id="bnCloseFw3"   onclick="cance()" class="btn btn-info">返回列表</button>
							</li>

							<li class="next" style="float:right;margin-right:300px">
								<a href="#" >下一步 <i class="fa-angle-double-right"></i></a>
							</li>
						</ul>
						</div>

						<div class="tab-pane with-bg" id="fwv-4">

							<div class="text-center">
								<div class="droppable-area">
									<button type="button" id="btnSaveWebImageofhouse" onclick="updateSchool()" class="btn btn-info">保存并发布</button>
								</div>
							</div>
						</div>

						<!-- Tabs Pager -->
<!-- 						<ul class="pager wizard"> -->
<!-- 							<li class="previous"  style="float:left;margin-left:300px"> -->
<!-- 								<a href="#"><i class="fa-angle-double-left"></i> 上一步</a> -->
<!-- 							</li> -->
<!-- 							<li> -->
<!-- 								<button type="button" id="bnUpdateFw1" onclick="updateSchool()"  class="btn btn-info">保存</button> -->
<!-- 								<button type="button" id="bnCloseFw1"   onclick="cance()" class="btn btn-info">返回列表</button> -->
<!-- 							</li> -->

<!-- 							<li class="next" style="float:right;margin-right:300px"> -->
<!-- 								<a href="#" >下一步 <i class="fa-angle-double-right"></i></a> -->
<!-- 							</li> -->
<!-- 						</ul> -->
						<div class="clearfix"></div>
					</div>

				</form>
				<!-- Main Footer -->

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
				<i class="fa-arrow-up" style="font-size: 2em;"></i>
			</a>
		</div>
	</body>

</html>

<!-- Imported styles on this page -->
<link rel="stylesheet" href="../assets/js/multiselect/css/multi-select.css">

<!-- Bottom Scripts -->
<script src="../assets/js/bootstrap.min.js"></script>
<script src="../assets/js/TweenMax.min.js"></script>
<script src="../assets/js/resizeable.js"></script>
<script src="../assets/js/joinable.js"></script>
<script src="../assets/js/xenon-api.js"></script>
<script src="../assets/js/xenon-toggles.js"></script>

<!-- Imported scripts on this page -->
<script src="../assets/js/jquery-validate/jquery.validate.js"></script>
<script src="../assets/js/inputmask/jquery.inputmask.bundle.js"></script>
<script src="../assets/js/formwizard/jquery.bootstrap.wizard.min.js"></script>
<script src="../assets/js/datepicker/bootstrap-datepicker.js"></script>
<script src="../assets/js/multiselect/js/jquery.multi-select.js"></script>
<script src="../assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="../assets/js/selectboxit/jquery.selectBoxIt.min.js"></script>

<!-- JavaScripts initializations and stuff -->
<script src="../assets/js/xenon-custom.js"></script>
 <script  src="../js/base/pluploadfile.js" type="text/javascript"></script> 

<script type="text/javascript">
	 // Sample Javascript code for this page
	jQuery(document).ready(function($) {
		// Edit Modal
		$('.gallery-env a[data-action="edit"]').on('click', function(ev) {
			ev.preventDefault();
			$('#editimg').attr("src", $(this).find("img").attr("src"));
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

<!-- Gallery Modal Image -->
<div class="modal fade" id="gallery-image-modal" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-gallery-image">
				<img src="../assets/images/tupian.jpg" id="editimg"  class="img-responsive" />
			</div>
			
			<div class="modal-body">
				
				<div class="row">
					<div class="col-md-12">
						
<!-- 						<div class="form-group"> -->
<!-- 							<label for="field-1" class="control-label">名称</label> -->
<!-- 							<input type="text" class="form-control" id="field-1" placeholder="输入图片标题"> -->
<!-- 						</div>	 -->
						
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
<!-- 地图开始 -->
<script type="text/javascript">
	houseExclusiveImgIndex =<%=si%>;
</script>
<%-- <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=cwWUeu7m6ZIclzyUBhqMrA05"></script> --%>
<div class="modal fade" id="map-info-windom">
  <div class="modal-dialog modal-lg" style="width:100%">
  	<div class="modal-header">
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