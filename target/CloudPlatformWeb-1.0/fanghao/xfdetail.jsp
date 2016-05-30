<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%  String basePath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="description" content="Xenon Boostrap Admin Panel" />
		<meta name="author" content="" />
		<title>新房详情</title>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/bootstrap.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/xenon-core.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/xenon-forms.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/xenon-components.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/xenon-skins.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/custom.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/xiaoqu.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/js/wysihtml5/src/bootstrap-wysihtml5.css">
		<script src="<%=request.getContextPath() %>/assets/js/jquery-1.11.1.min.js"></script>
		<script src="<%=request.getContextPath() %>/js/base/manager.js"></script>
		<script src="<%=request.getContextPath() %>/js/services.js"></script>
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
	var x='${xhjNewhouseinfo.x}';
	var y='${xhjNewhouseinfo.y}';
	var basePath="<%=basePath%>";
	$(function(){
	getzxdt();
	 $.ajax({
			url:"<%=basePath%>/newenv/lpzd/fanghaogetxhjLptp.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"lpid" : ${xhjNewhouseinfo.projectId}},
			success: function(data){
				var $imgContainer = $("#tab-1 .panel-body ");
		       	var $imgContainer2 = $("#tab-2 .panel-body ");
		       	var $imgContainer3 = $("#tab-3 .panel-body ");
		       	var $imgContainer4 = $("#tab-4 .panel-body ");
		       	var $imgContainer5 = $("#tab-5 .panel-body ");
		       	var imgnum=0;
		       	var imgnum2=0;
		       	var imgnum3=0;
		       	var imgnum4=0;
		       	var imgnum5=0;
				$.each(data, function(i,n){
				var sHtml='';
				
				if(n[3]==3){
				imgnum++;
				 sHtml= ' <div class="col-lg-6 col-xs-12 form-group"><img  src="http://imgbms.xhjfw.com/'+n[2]+'@200w_150h"  width="200" height="150" class="img-thumbnail"></div>';
					$imgContainer.append(sHtml);
					
				}
				$("#imgnum").html(imgnum);
				
				if(n[3]==1){
				imgnum2++;
				 sHtml2= ' <div class="col-lg-6 col-xs-12 form-group"><img  src="http://imgbms.xhjfw.com/'+n[2]+'@200w_150h"  width="200" height="150" class="img-thumbnail"></div>';
				$imgContainer2.append(sHtml2);
				}
				$("#imgnum2").html(imgnum2);
				if(n[3]==2){
				imgnum3++;
				 sHtml3= ' <div class="col-lg-6 col-xs-12 form-group"><img  src="http://imgbms.xhjfw.com/'+n[2]+'@200w_150h"  width="200" height="150" class="img-thumbnail"></div>';
				$imgContainer3.append(sHtml3);
				}
				$("#imgnum3").html(imgnum3);
				if(n[3]==4){
				imgnum4++;
				 sHtml4= ' <div class="col-lg-6 col-xs-12 form-group"><img  src="http://imgbms.xhjfw.com/'+n[2]+'@200w_150h"  width="200" height="150" class="img-thumbnail"></div>';
				$imgContainer4.append(sHtml4);
				}
					$("#imgnum4").html(imgnum4);
				if(n[3]==5){
				imgnum5++;
				 sHtml5= ' <div class="col-lg-6 col-xs-12 form-group"><img  src="http://imgbms.xhjfw.com/'+n[2]+'@200w_150h"  width="200" height="150" class="img-thumbnail"></div>';
				$imgContainer5.append(sHtml5);
				}
				$("#imgnum5").html(imgnum5);
           
		});
	
				
			}
	 });
	});
	
	var pageinfo=1;
	var rows=3;
	//新房最新动态信息
	function getzxdt(){
	$.ajax({
			url:"<%=basePath%>/newenv/lpzd/fanghaoxfzxdt.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"lpid" :${xhjNewhouseinfo.projectId},"pageInfo.page":pageinfo,"pageInfo.rows":rows},
			success:function(data){
			var fwdthtml='';
				$.each(data.gridModel, function(i,n){
					fwdthtml+='<tr>'
					fwdthtml+='<td width="110">'
					if(n.imgPath!=null&&n.imgPath!=''){
					fwdthtml +='<img src="http://imgbms.xhjfw.com/'+n.imgPath+'" width="100" height="130"></td>'
					}else{
					fwdthtml +='<img src="'+basePath+'/assets/images/hetong.jpg" width="100" height="130"></td>'
					}
					fwdthtml+='<td><div class="pull-left"><h4>'+n.operatorIdStr+'</h4>'+n.departmentIdStr+' '+n.tel+'</div></td>'
					fwdthtml+='<td>'+n.message+'</td>'
					fwdthtml+='<td>'+n.operateDateStr+'</td>'
					fwdthtml+='</tr>'
				});
													
				$("#zxdt").append(fwdthtml); 
			}
		});
		pageinfo++;
	}
	</script>
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
				<!-- User Info, Notifications and Menu Bar -->
		<jsp:include page="../include/top.jsp"/>
		<div class="page-title">
					<div class="breadcrumb-env pull-left">
						<ol class="breadcrumb bc-1">
							<li>
								<a href="<%=basePath%>/console/index.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<li class="active">
								<a href="<%=basePath%>/fanghao/fanghaoindex.jsp?p=house">房产信息</a>
							</li>
							<li class="active">
								<strong>新房详情</strong>
							</li>
						</ol>
					</div>
				</div> 
				<div class="row paddinglr">
					<div id="rootwizard" class="form-wizard">

						<ul class="tabs">
							<li class="active">
								<a href="#tab1" data-toggle="tab">基础信息</a>
							</li>
							<li>
								<a href="#tab2" data-toggle="tab">楼盘图库</a>
							</li>
							<li>
								<a href="#tab3" data-toggle="tab">配套设施</a>
							</li>
							<li>
								<a href="#tab4" data-toggle="tab">最新动态</a>
							</li>
						</ul>

						<div class="progress-indicator">
							<span></span>
						</div>

						<div class="tab-content">

							<!-- Tabs Content -->
							<div class="tab-pane active" id="tab1">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h3 class="panel-title"><h2>项目信息</h2></h3>
										<div class="panel-options">
											<a href="#" data-toggle="panel">
												<span class="collapse-icon">–</span>
												<span class="expand-icon">+</span>
											</a>
										</div>
									</div>
									<div class="panel-body">
										<div class="row">
											<h3>项目标题</h3>
											<hr>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">项目标题：</label>
													<input class="form-control" name="shangquan" data-validate="" readonly="readonly" placeholder="" value="${xhjNewhouseinfo.projectTitle}">
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">项目名称：</label>
													 <select class="form-control" id="" disabled="disabled">
							                        <option>${xhjNewhouseinfo.lpName}</option>
<!-- 							                          <optgroup label="请选择..."> -->
<!-- 							                          <option>新环境东塘店A组</option> -->
<!-- 							                          <option>Alaska</option> -->
<!-- 							                          <option>Arizona</option> -->
<!-- 							                          <option>Arkansas</option> -->
<!-- 							                          </optgroup> -->
							                        </select>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">合同日期：</label><div class="clearfix"></div>
													<div class="col-lg-6">
														<input type="text" class="form-control" readonly="readonly" value="${xhjNewhouseinfo.startDateStr}" id="startDate">
													</div>
													<div class="col-lg-6">
														<input type="text" class="form-control" readonly="readonly" value="${xhjNewhouseinfo.stopDateStr}" id="stopDate">
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about" style="color: #f00;">佣金比例：</label>
													<div class="input-group input-group-minimal">
														<input type="email" class="form-control" readonly="readonly" value="${xhjNewhouseinfo.commissionRate}">
														<span class="input-group-addon">
															%
														</span>
													</div>
												</div>
											</div>
											<div class="clearfix"></div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">合作协议：</label>
													<div class="clearfix"></div>
													<div class="checkbox">
														<label>
															<input type="checkbox" readonly="readonly" ${xhjNewhouseinfo.contractAgreement=='1'?"checkbox":""}>
															已签
														</label>
													</div>

												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">开盘日期：</label>
													<input class="form-control" type="text" name="xingzhi" readonly="readonly"  placeholder="" value="${xhjNewhouseinfo.openDateStr}" id="openDate" 	>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">交房日期：</label>
													<input class="form-control" type="text" name="dengji" readonly="readonly"   placeholder=""  value="${xhjNewhouseinfo.submitHouseDateStr}" id="submitHouseDate">
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about" style="color: #f00;">用途：</label>
													<select class="form-control" disabled="disabled">
														<option>${xhjNewhouseinfo.usagesStr}</option>
													</select>
												</div>
											</div>
											<div class="clearfix"></div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">剩余套数：</label>
													<div class="input-group input-group-minimal">
														<input type="email" class="form-control" readonly="readonly" value="${xhjNewhouseinfo.lastNumber}">
														<span class="input-group-addon">
															套
														</span>
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">主力户型：</label>
													<input class="form-control" name="" readonly="readonly" data-validate="" placeholder="" value="${xhjNewhouseinfo.hostApartment}">
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">均价：</label>
													<div class="input-group input-group-minimal">
														<input type="email" class="form-control" readonly="readonly" value="${xhjNewhouseinfo.avgPrice}">
														<span class="input-group-addon">
															元/㎡
														</span>
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">装修：</label>
													<select class="form-control" disabled="disabled">
														<option>${xhjNewhouseinfo.decorationStr}</option>
													</select>
												</div>
											</div>
											<div class="clearfix"></div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">项目面积：</label>
													<div class="clearfix"></div>
													<div class="col-lg-6">
														<div class="input-group input-group-minimal">
															<input type="email" class="form-control" readonly="readonly" value="${xhjNewhouseinfo.projectSizeFrom}">
															<span class="input-group-addon">
																㎡
															</span>
														</div>
													</div>
													<div class="col-lg-6">
														<div class="input-group input-group-minimal">
															<input type="email" class="form-control" readonly="readonly" value="${xhjNewhouseinfo.projectSizeTo}">
															<span class="input-group-addon">
																㎡
															</span>
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about" >销售状态：</label>
													<select class="form-control" disabled="disabled">
														<option>${xhjNewhouseinfo.salesStatusStr}</option>
													</select>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">出售单价：</label>
													<div class="clearfix"></div>
													<div class="col-lg-6">
														<div class="input-group input-group-minimal">
															<input type="email" class="form-control" readonly="readonly" value="${xhjNewhouseinfo.priceFrom}">
															<span class="input-group-addon">
																元/㎡
															</span>
														</div>
													</div>
													<div class="col-lg-6">
														<div class="input-group input-group-minimal">
															<input type="email" class="form-control" readonly="readonly" value="${xhjNewhouseinfo.priceTo}">
															<span class="input-group-addon">
																元/㎡
															</span>
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">主力总价：</label>
													<div class="clearfix"></div>
													<div class="col-lg-6">
														<div class="input-group input-group-minimal">
															<input type="email" class="form-control" readonly="readonly" value="${xhjNewhouseinfo.totalPriceFrom}">
															<span class="input-group-addon">
																万元
															</span>
														</div>
													</div>
													<div class="col-lg-6">
														<div class="input-group input-group-minimal">
															<input type="email" class="form-control" readonly="readonly" value="${xhjNewhouseinfo.totalPriceTo}">
															<span class="input-group-addon">
																万元
															</span>
														</div>
													</div>
												</div>
											</div>
											<div class="clearfix"></div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">售房地址：</label>
													<input class="form-control" name="" data-validate=""readonly="readonly"  placeholder="" value="${xhjNewhouseinfo.address}">
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">销售电话：</label>
													<input class="form-control" name="" data-validate="" readonly="readonly" placeholder="" value="${xhjNewhouseinfo.phone}">
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">许可证件号：</label>
													<input class="form-control" name="" data-validate="" readonly="readonly" placeholder=""  value="${xhjNewhouseinfo.license}">
												</div>
											</div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">开发商：</label>
													<input class="form-control" name="" data-validate="" readonly="readonly" placeholder="" value="${xhjNewhouseinfo.developers}">
												</div>
											</div>
											<div class="clearfix"></div>
											<div class="col-md-3">
												<div class="form-group">
													<label class="control-label" for="about">开发商电话：</label>
													<input class="form-control" name="" data-validate=""readonly="readonly"  placeholder="" value="${xhjNewhouseinfo.developersButtPhone}">
												</div>
											</div>
											<div class="clearfix"></div>
											<div class="col-md-12">
												<div class="form-group">
													<label class="control-label" for="about">开盘说明：</label>
<!-- 													<textarea class="form-control" readonly="readonly" rows="10">${xhjNewhouseinfo.lpremark}</textarea> -->
													<div class="form-control" style="height:auto;" id="lpremark">
													${xhjNewhouseinfo.lpremark}
													</div>
												</div>
											</div>
											<div class="col-md-12">
												<div class="form-group">
													<label class="control-label" for="about">推荐说明：</label>
<!-- 													<textarea class="form-control" readonly="readonly" rows="10">${xhjNewhouseinfo.recommendationRemark}</textarea> -->
													<div class="form-control" style="height:auto;" id="recommendationRemark">
													${xhjNewhouseinfo.recommendationRemark}
													</div>
												</div>
											</div>
											<div class="col-md-12">
												<div class="form-group">
													<label class="control-label" for="about">描述：</label>
<!-- 													<textarea class="form-control" readonly="readonly" rows="10">${xhjNewhouseinfo.remark}</textarea> -->
													<div class="form-control" style="height:auto;" id="remark">
													${xhjNewhouseinfo.remark}
													</div>
												</div>
											</div>

										</div>
										
									</div>
								</div>
							</div>

							<div class="tab-pane" id="tab2">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h3 class="panel-title"><h2>楼盘图库</h2></h3>
										<div class="panel-options">
											<a href="#" data-toggle="panel">
												<span class="collapse-icon">–</span>
												<span class="expand-icon">+</span>
											</a>
										</div>
									</div>

									<div class="panel-body">
										<form role="form" class="form-horizontal">
<!-- 											<div class="form-group"> -->
<!-- 												<label class="col-sm-2 control-label" for="field-3"><span class="red">图片类型</span></label> -->

<!-- 												<div class="col-sm-8"> -->
<!-- 													<select class="form-control" disabled> -->
<!-- 														<option>环境图</option> -->
<!-- 														<option>户型图</option> -->
<!-- 														<option>交通图</option> -->
<!-- 													</select> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 											<div class="form-group"> -->
<!-- 												<label class="col-sm-2 control-label" for="field-3"><span class="red">图片名称</span></label> -->

<!-- 												<div class="col-sm-8"> -->
<!-- 													<input type="text" class="form-control" readonly="" id="field-3" placeholder=""> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 											<div class="form-group"> -->
<!-- 												<label class="col-sm-2 control-label" for="field-3">上传图片</label> -->

<!-- 												<div class="col-sm-5"> -->
<!-- 													<input type="file" class="form-control" id="field-4"> -->
<!-- 												</div> -->
<!-- 												<span class="help-block">(请上传大小在800*640、5M以内的jpg、png、gif格式图片)</span> -->
<!-- 											</div> -->
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">全部图片</label>
												<div class="col-sm-8">

													<div class="panel-heading">
														<ul class="quanbu nav nav-tabs">
														<li class="active"><a href="#tab-1"
															data-toggle="tab">环境图（<span id="imgnum"></span>）</a></li>
														<li><a href="#tab-2" data-toggle="tab">户型图（<span id="imgnum2"></span>）</a></li>
														<li><a href="#tab-3" data-toggle="tab">交通图（<span id="imgnum3"></span>）</a></li>
														<li><a href="#tab-4" data-toggle="tab">样板间（<span id="imgnum4"></span>）</a></li>
														<li><a href="#tab-5" data-toggle="tab">效果图（<span id="imgnum5"></span>）</a></li>
														</ul>
													</div>

													<div class="tab-content">

														<div class="tab-pane active" id="tab-1">
															<div class="panel-body">
																
															</div>

														</div>

														<div class="tab-pane" id="tab-2">
															<div class="panel-body">
																
															</div>

														</div>
														<div class="tab-pane" id="tab-3">
															<div class="panel-body">
																
															</div>

														</div>

														<div class="tab-pane" id="tab-4">
															<div class="panel-body">
																
															</div>

														</div>

														<div class="tab-pane" id="tab-5">
															<div class="panel-body">
															
															</div>

														</div>

													</div>

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
											<li class="active">
												<a href="" data-toggle="tab"><h2>配套设施</h2></a>
											</li>
										</ul>
									</div>

									<div class="panel panel-default">
										<div class="tab-content">
											<jsp:include page="../include/zhoubiansousuo.jsp?x=${xhjLpfanghao.lp.x}&y=${xhjLpfanghao.lp.y}"></jsp:include>
										</div>
									</div>

								</div>
							</div>

							<div class="tab-pane" id="tab6">
								<div class="panel panel-default">
									<div class="panel-heading">
										<ul class="nav nav-tabs">
											<li class="active">
												<a href="" data-toggle="tab"><h2>成交信息</h2></a>
											</li>
										</ul>
									</div>
									<div class="panel panel-default col-md-8 col-md-offset-2">
										<div class="panel-heading">
											<ul class="nav nav-tabs">
												<li class="active">
													<a href="#ershoufan" data-toggle="tab">
														<span class="visible-xs"><i class="fa-home"></i></span>
														<span class="hidden-xs">二手房</span>
													</a>
												</li>
												<li>
													<a href="#zufan" data-toggle="tab">
														<span class="visible-xs"><i class="fa-user"></i></span>
														<span class="hidden-xs">租房</span>
													</a>
												</li>
											</ul>
										</div>

										<div class="tab-content">
											<div class="tab-pane active" id="ershoufan">
												<div class="col-md-6">
													<div class="suonvtu col-xs-2">
														<img src="<%=request.getContextPath() %>/assets/images/user-4.png" width="50" height="50">
													</div>
													<div class="col-xs-10">
														<p>小区成交量：40套</p>
														<p>环比上月 上涨2.56%，同比去年上涨150%</p>
													</div>
												</div>
												<div class="col-md-6">
													<div class="suonvtu col-xs-2">
														<img src="<%=request.getContextPath() %>/assets/images/user-4.png" width="50" height="50">
													</div>
													<div class="col-xs-10">
														<p>小区成交量：40套</p>
														<p>环比上月 上涨2.56%，同比去年上涨150%</p>
													</div>
												</div>
												<div class="panel panel-default">
													echarts表
												</div>
												<div class="row">
													<div class="panel-heading">
														<div class="col-xs-6">
															<strong>小区成交记录</strong>
														</div>
													</div>
													<div class="panel panel-default">
														<div class="row">
															<div class="col-sm-12">
																<div class="panel panel-default">
																	<div class="table-responsive">
																		<table class="table table-striped">
																			<thead>
																				<tr>
																					<th colspan="2">操作人</th>
																					<th class="col-md-4">操作记录</th>
																					<th width="200">操作时间</th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr>
																					<td width="110"><img src="<%=request.getContextPath() %>/assets/images/20150519191526.png" width="100" height="130"></td>
																					<td>
																						<div class="pull-left">
																							<h4>吴晓波先生</h4> 新门户武广新城店A组 13569032954</div>
																					</td>
																					<td>录入房源</td>
																					<td>2014-12-27 15：25:30</td>
																				</tr>
																				<tr>
																					<td width="110"><img src="<%=request.getContextPath() %>/assets/images/20150519191526.png" width="100" height="130"></td>
																					<td>
																						<div class="pull-left">
																							<h4>吴晓波先生</h4> 新门户武广新城店A组 13569032954</div>
																					</td>
																					<td>修改房源
																						<br /> 修改内容：86万改为56万
																					</td>
																					<td>2014-12-27 15：25:30</td>
																				</tr>
																				<tr>
																					<td width="110"><img src="<%=request.getContextPath() %>/assets/images/20150519191526.png" width="100" height="130"></td>
																					<td>
																						<div class="pull-left">
																							<h4>吴晓波先生</h4> 新门户武广新城店A组 13569032954</div>
																					</td>
																					<td>带看房源</td>
																					<td>2014-12-27 15：25:30</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>

																</div>
																<div class="text-center" style="color:#0033CC;">查看更多成交记录></div>
															</div>
														</div>
													</div>
												</div>

											</div>
											<div class="tab-pane" id="zufan">

												<div class="col-md-6">
													<div class="suonvtu col-xs-2">
														<img src="<%=request.getContextPath() %>/assets/images/user-4.png" width="50" height="50">
													</div>
													<div class="col-xs-10">
														<p>小区成交量：40套</p>
														<p>环比上月 上涨2.56%，同比去年上涨150%</p>
													</div>
												</div>
												<div class="col-md-6">
													<div class="suonvtu col-xs-2">
														<img src="<%=request.getContextPath() %>/assets/images/user-4.png" width="50" height="50">
													</div>
													<div class="col-xs-10">
														<p>小区成交量：40套</p>
														<p>环比上月 上涨2.56%，同比去年上涨150%</p>
													</div>
												</div>
												<div class="panel panel-default">
													echarts表
												</div>
												<div class="row">
													<div class="panel-heading">
														<div class="col-xs-6">
															<strong>小区成交记录</strong>
														</div>
													</div>
													<div class="panel panel-default">
														<div class="row">
															<div class="col-sm-12">
																<div class="panel panel-default">
																	<div class="table-responsive">
																		<table class="table table-striped">
																			<thead>
																				<tr>
																					<th colspan="2">操作人</th>
																					<th class="col-md-4">操作记录</th>
																					<th width="200">操作时间</th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr>
																					<td width="110"><img src="<%=request.getContextPath() %>/assets/images/20150519191526.png" width="100" height="130"></td>
																					<td>
																						<div class="pull-left">
																							<h4>吴晓波先生</h4> 新门户武广新城店A组 13569032954</div>
																					</td>
																					<td>录入房源</td>
																					<td>2014-12-27 15：25:30</td>
																				</tr>
																				<tr>
																					<td width="110"><img src="<%=request.getContextPath() %>/assets/images/20150519191526.png" width="100" height="130"></td>
																					<td>
																						<div class="pull-left">
																							<h4>吴晓波先生</h4> 新门户武广新城店A组 13569032954</div>
																					</td>
																					<td>修改房源
																						<br /> 修改内容：86万改为56万
																					</td>
																					<td>2014-12-27 15：25:30</td>
																				</tr>
																				<tr>
																					<td width="110"><img src="<%=request.getContextPath() %>/assets/images/20150519191526.png" width="100" height="130"></td>
																					<td>
																						<div class="pull-left">
																							<h4>吴晓波先生</h4> 新门户武广新城店A组 13569032954</div>
																					</td>
																					<td>带看房源</td>
																					<td>2014-12-27 15：25:30</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>

																</div>
																<div class="text-center" style="color:#0033CC;">查看更多成交记录></div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div style="clear:both;"></div>
								</div>
							</div>

							<div class="tab-pane" id="tab4">
								<div class="panel panel-default">
									<div class="panel-heading">
										<ul class="nav nav-tabs">
											<li class="active">
												<a href="" data-toggle="tab"><h2>最新动态</h2></a>
											</li>
										</ul>
									</div>
									<div class="table-responsive">
										<table class="table table-striped">
											<thead>
												<tr>
													<th colspan="2">操作人</th>
													<th class="col-md-4">操作记录</th>
													<th width="200">操作时间</th>
												</tr>
											</thead>
											<tbody id="zxdt">
										</tbody>
										</table>
									</div>
									<div class="text-center" style="color:#0033CC;"><a href="javascript:getzxdt()">查看更多动态记录></a></div>
								</div>
							</div>
						</div>
						<ul class="pager wizard">
							<div class="col-sm-6 col-sm-offset-3">
								<li class="previous">
									<a href="#"><i class="entypo-left-open"></i> 上一步</a>
								</li>
								<li class="next">
									<a href="#">下一步 <i class="entypo-right-open"></i></a>
								</li>
								<li>
									<a  href="javascript:void(0)" onclick="back()">取消</a>
								</li>
							</div>
						</ul>

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

		<div class="go-up" style="position: fixed;right: 15px; bottom: 10px; z-index: 9999;">
			<a href="#" rel="go-top">
				<i class="el-up-open"></i>
			</a>
		</div>
	</body>
</html>

<!-- Imported styles on this page -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/js/multiselect/css/multi-select.css">

<!-- Bottom Scripts -->
<script src="<%=request.getContextPath() %>/assets/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/TweenMax.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/resizeable.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/joinable.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/xenon-api.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/xenon-toggles.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=request.getContextPath() %>/assets/js/jquery-validate/jquery.validate.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/inputmask/jquery.inputmask.bundle.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/formwizard/jquery.bootstrap.wizard.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/datepicker/bootstrap-datepicker.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/multiselect/js/jquery.multi-select.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/selectboxit/jquery.selectBoxIt.min.js"></script>

<!-- rili-->
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/js/datepicker/bootstrap-datetimepicker.min.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/js/datepicker/bootstrap-datetimepicker.zh-CN.js"></script>
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

<!-- Imported scripts on this page  xiala-->
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/js/daterangepicker/daterangepicker-bs3.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/js/select2/select2.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/js/select2/select2-bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/js/multiselect/css/multi-select.css">
<script src="<%=request.getContextPath() %>/assets/js/rwd-table/js/rwd-table.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/daterangepicker/daterangepicker.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/datepicker/bootstrap-datepicker.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/timepicker/bootstrap-timepicker.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/colorpicker/bootstrap-colorpicker.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/select2/select2.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/xenon-custom.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".s2example-1").select2({
			placeholder: '请输入搜索条件...',
			allowClear: true
		}).on('select2-open', function() {
			// Adding Custom Scrollbar
			$(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
		});
	});
</script>