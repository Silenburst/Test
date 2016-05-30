<%@page import="com.newenv.lpzd.Utils.FileUtil"%>
<%@page import="com.newenv.lpzd.person.Condition"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>
<%@taglib uri="/struts-tags" prefix="s" %>
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
		<script type="text/javascript" src="<%=basePath%>/js/plupload/plupload.full.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/js/plupload/i18n/zh_CN.js"></script>
		<script src="<%=basePath%>/assets/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript">
			var basepath = "<%=basePath%>";
			var zuoyous ="["+${condition.fhids}+"]";
			var chaoXiang = ${xhjfanghao.chaoXiang}+"";
			var cqxz =  ${xhjfanghao.cqxz}+"";
			var leixing =${xhjfanghao.leixing}+"";
			var propertyAge= ${xhjfanghao.propertyAge}+"";
			var cqmj=${xhjfanghao.cqmj}+"";
			var tnmj = ${xhjfanghao.tnmj}+"";
		</script>
		<script src="<%=basePath%>/js/person/batchupdateinfo.js" type="text/javascript"></script>
		
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

	</head>
		<div class='onsubing' style="display:none; width:100%; height:100%; background:#fff; position:fixed; z-index:99999; opacity:0.8;-moz-opacity:0.8; filter:alpha(opacity=80); ">
			<div class="text-center" style="position:absolute; top:20%; left:50%;">
				<img src="<%=basePath%>/images/loading.gif" width="176" height="220"/>
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
								<a href="#"><i class="fa-home"></i>首页</a>
							</li>
							<li>
								<a href="<%=basePath%>/person/assignmanager.jsp?p=am&k=yz">房屋分派管理</a>
							</li>
							<li>
								<a href="<%=basePath%>/person/batchupdate.jsp">批量修改</a>
							</li>
							<li class="active">
								<strong>批量修改房屋信息</strong>
							</li>
						</ol>

					</div>

				</div>
				<form role="form" class="form-horizontal" id="batchFanghaoForm">
				<div id="webImageofhouse_image_hidden"></div>
				<input type="hidden" id="zuoyou" name = "condition.fhids">
				<div class="panel">
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
												<select class="form-control"  id="shi" name="condition.fanghao.shi" data-value="${xhjfanghao.shi}">
												<option value="0">请选择</option>
												<option value="1" ${xhjfanghao.shi=='1'?"selected=true":""}>一室</option>
												<option value="2" ${xhjfanghao.shi=='2'?"selected=true":""}>二室</option>
												<option value="3" ${xhjfanghao.shi=='3'?"selected=true":""}>三室</option>
												<option value="4" ${xhjfanghao.shi=='4'?"selected=true":""}>四室</option>
												<option value="5" ${xhjfanghao.shi=='5'?"selected=true":""}>五室</option>
												<option value="6" ${xhjfanghao.shi=='6'?"selected=true":""}>五室以上</option>
												</select>
												<span class="input-group-addon">-</span>
												<select class="form-control"  id="ting" name="condition.fanghao.ting" data-value="${xhjfanghao.ting}">
												<option value="0">请选择</option>
												<option value="1" ${xhjfanghao.ting=='1'?"selected=true":""} >一厅</option>
												<option value="2" ${xhjfanghao.ting=='2'?"selected=true":""}>二厅</option>
												<option value="3" ${xhjfanghao.ting=='3'?"selected=true":""}>三厅</option>
												<option value="4" ${xhjfanghao.ting=='4'?"selected=true":""}>四厅</option>
												</select>
												<span class="input-group-addon">-</span>
												<select class="form-control"  id="chu" name="condition.fanghao.chu" data-value="${xhjfanghao.chu}">
												<option value="0">请选择</option>
												<option value="1" ${xhjfanghao.chu=='1'?"selected=true":""}>一厨</option>
												<option value="2" ${xhjfanghao.chu=='2'?"selected=true":""}>二厨</option>
												<option value="3" ${xhjfanghao.chu=='3'?"selected=true":""}>三厨</option>
												<option value="4" ${xhjfanghao.chu=='4'?"selected=true":""}>四厨</option>
												</select>
												<span class="input-group-addon">-</span>
												<select class="form-control"  id="wei" name="condition.fanghao.wei" data-value="${xhjfanghao.wei}">
												<option value="0">请选择</option>
												<option value="1" ${xhjfanghao.wei=='1'?"selected=true":""}>一卫</option>
												<option value="2" ${xhjfanghao.wei=='2'?"selected=true":""}>二卫</option>
												<option value="3" ${xhjfanghao.wei=='3'?"selected=true":""}>三卫</option>
												<option value="4" ${xhjfanghao.wei=='4'?"selected=true":""}>四卫</option>
												</select>
												<span class="input-group-addon">-</span>
												<select class="form-control" name="condition.fanghao.yang">
													<option value="0" >请选择</option>
													<option value="1" ${xhjfanghao.yang=='1'?"selected=true":""}>一阳台</option>
													<option value="2" ${xhjfanghao.yang=='2'?"selected=true":""}>二阳台</option>
													<option value="3" ${xhjfanghao.yang=='3'?"selected=true":""}>三阳台</option>
													<option value="4" ${xhjfanghao.yang=='4'?"selected=true":""}>四阳台</option>
												</select>
											</div>
										</div>
									</div>
									<div class="clearfix"></div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">房屋朝向：</span>
												<select class="form-control"  id="chaoXiang" name="condition.fanghao.chaoXiang" data-value="${xhjfanghao.chaoXiang}">
												<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">产权性质：</span>
												<select class="form-control"  id="cqxz" name="condition.fanghao.cqxz" data-value="${xhjfanghao.cqxz}">
													<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">套内面积：</span>
												<input type="text" class="form-control" id="tnmj" name="condition.fanghao.tnmj" value="${xhjfanghao.tnmj}">
												<span class="input-group-addon">㎡</span>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">房屋类型：</span>
												<select class="form-control"  id="leixing" name="condition.fanghao.leixing" data-value="${xhjfanghao.leixing}">
												<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">产权年限：</span>
												<select class="form-control"  id="propertyAg" name="condition.fanghao.propertyAge" data-value="${xhjfanghao.propertyAge}">
												<option value="0">请选择</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">产权面积：</span>
												<input type="text" class="form-control" name="condition.fanghao.cqmj" value="${xhjfanghao.cqmj}">
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
				<div class="panel panel-default">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								户型图
							</div>
							<div class="panel-body">
								<div class="col-lg-10">
									<div class="col-lg-4">
										<div class="form-group">
<!-- 											<label class="col-sm-2 control-label" for="field-3">上传图片</label> -->
											<div class="col-sm-5" id="fkContainer">
												<a id="fkPickfiles" href="javascript:void(0);">
					                				<button type="button" class="btn btn-success">上传图片</button> 
					                			</a>
											<span class="help-block">(请上传大小在800*640、5M以内的jpg、png、gif格式图片)</span>
											</div>
									</div>
									</div>
									
									<section class="gallery-env">

										<div class="row">
											<!-- Gallery Album Optipns and Images -->
											<div class="gallery-left">
													<!-- Album Images -->
												<div class="album-images row">
													<!-- Album Image -->
													<div class="tab-pane active" id="ulHouseExclusiveFiles1">
															<!-- Album Image -->
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
					<button type="button" style="margin-left:500px;margin-right:500px" onclick="batchUpdate()" class="btn btn-info">保存</button>
					<button type="button" style="display:none" id="close" class="btn btn-danger" data-dismiss="modal" >关闭</button>
					<div class="clearfix"></div>
				</div>
				<!-- Main Footer -->
			</form>
			</div>
		</div>

		<div class="go-up" style="position: fixed;right: 15px; bottom: 10px; z-index: 9999; background: #f7aa47;padding: 10px;filter:alpha(opacity=50);moz-opacity:0.5;opacity:0.5;">
			<a href="#" rel="go-top">
				<i class="fa-arrow-up" style="font-size: 3em;"></i>
			</a>
		</div>
	</body>

<script  src="<%=basePath%>/js/person/batchpluploadfile.js" type="text/javascript"></script> 
</html>
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

