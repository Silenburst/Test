<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>

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
		<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="../assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../assets/css/xenon-core.css">
		<link rel="stylesheet" href="../assets/css/xenon-forms.css">
		<link rel="stylesheet" href="../assets/css/xenon-components.css">
		<link rel="stylesheet" href="../assets/css/xenon-skins.css">
		<link rel="stylesheet" href="../assets/css/custom.css">
		<link rel="stylesheet" href="../assets/css/xiaoqu.css">
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript">
			var basepath = "<%=basePath%>";
			$("#lpid").val(0);
			$("#dongid").val(0);
			$("#danyuanid").val(0);
			$("#huxingid").val(0);
		</script>
		<style type="text/css">
		.dis{ display:block !important;}
		</style>
		<script src="<%=basePath%>/js/page.js"></script>
		<script src="<%=basePath%>/js/person/batchupdate.js"></script>
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
								<a href="<%=basePath%>/console/index.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<li>
								<a href="<%=basePath%>/person/assignmanager.jsp?p=am&k=yz">房屋分派管理</a>
							</li>
							<li class="active">
								<strong>批量修改房屋</strong>
							</li>
						</ol>

					</div>

				</div>
				<div class="panel">
					<input type="hidden" id="ids" name="condition.ids">
					<input type="hidden" id="fhids" name="condition.fhids">
					<div class="col-lg-5 panel panel-border">
						<form role="form" class="form-horizontal" id="batchupdate">
								<div class="form-group" style="margin-bottom: 10px;">
								<label class="col-sm-4 col-md-2 control-label" for="field-1">楼盘名称</label>
								<div class="col-sm-8">
<!-- 									<select class="s2example" id="lpid" onchange="queryDong(this.value)" name="condition.lpxx.id"> -->
<!-- 											<option value="0">请输入搜索楼盘</option> -->
<!-- 									</select> -->
											<script type="text/javascript">
												jQuery(document).ready(function($)
												{
													$("#lpid").select2({
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
															return "<div class='select2-user-result'>" + student.lpName + "</div>"; 
														},
														formatSelection: function(student) { 
															return  student.lpName; 
														}
														
													}) .on("change",function(e){
														//queryData("");
														queryDong(e.val);
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
											<input type="hidden" name="condition.lpxx.id"  id="lpid" />
								</div>
							</div>
							<div class="form-group-separator" style="margin-bottom: 10px;"></div>
							<div class="form-group" style="margin-bottom: 10px;">
								<label class="col-sm-4 col-md-2 control-label" for="field-1">栋座</label>
								<div class="col-sm-8">
									<select class="form-control" id="dongid"  onchange="queryDanyuan(this.value)"  name="condition.dong.id">
										<option value="0">请选择栋座</option>
									</select>
								</div>
							</div>
							<div class="form-group-separator" style="margin-bottom: 10px;"></div>
							<div class="form-group" style="margin-bottom: 10px;">
								<label class="col-sm-4 col-md-2 control-label" for="field-1">单元</label>
								<div class="col-sm-8">
									<select class="form-control" id="danyuanid" onchange="queryHuxing()"   name="condition.danyuan.id">
										<option value="0">请选择单元</option>
									</select>
								</div>
							</div>
							
							<div class="form-group" style="margin-bottom: 10px;">
								<label class="col-sm-4 col-md-2 control-label" for="field-1">户型</label>
								<div class="col-sm-8">
									<select class="form-control" id="huxingid" name="condition.fanghao.fangHao">
										<option value="0">请选择户型</option>
									</select>
								</div>
									<a class="btn btn-info btn-single" onclick="querySource(1,0)">查询</a>
							</div>
							<div class="form-group-separator" style="margin-bottom: 10px;"></div>
						</form>
						<hr />
						<div class="row">
							<div class="panel panel-default">
<!-- 								<div class="panel-heading"> -->
<!-- 									<div class="panel-options pull-left"> -->
<!-- 										<ul class="nav nav-tabs"> -->
<!-- 											<li class="active"> -->
<!-- 												<a href="#tab-1" data-toggle="tab" id="huxingtab1">全部</a> -->
<!-- 											</li> -->
<!-- 											<li> -->
<!-- 												<a href="#tab-2" data-toggle="tab" id="huxingtab1">1号户型</a> -->
<!-- 											</li> -->
<!-- 										</ul> -->
<!-- 									</div> -->
<!-- 								</div> -->
								<div class="panel-body">
									<div  class="scrollable" data-max-height="420">
										<div class="tab-pane active" id="tab-1">
												<table class="table table-bordered table-striped table-condensed">
													<thead>
														<tr>
															<th>共搜索到<span id="total">0</span>个资源</th>
														</tr>
													</thead>
													<tbody class="middle-align"  id="table1">
														<tr>
<!-- 															<td width="50" class="text-center"><input type="checkbox"  class="cbr" /></td> -->
															<td>请搜索数据....</td>
														</tr>
													</tbody>
												</table>
										</div>
									</div>
								</div>
							</div>


						</div>
					</div>
					<div class="col-lg-7">
						<div class="col-lg-2 text-center" style="position: relative;">
							<div style="position: absolute; top: 250px;">
								<button type="button" class="btn btn-info " style="font-zise:20px;width:60px;"  onclick="setClassAll(0,1)">全选&nbsp;&nbsp;<i class="fa-angle-double-right"></i></button>
								<button type="button" class="btn btn-info " style="font-zise:20px;width:60px;" onclick="setClassAll(1,0)">反选&nbsp;&nbsp;<i class="fa-angle-double-left"></i></button>
<!-- 								<button type="button" class="btn btn-info " style="width:50px">  <i class="fa-angle-left"></i></button> -->
<!-- 								<button type="button" class="btn btn-info " style="width:50px"> <i class="fa-angle-right"></i></button> -->
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="col-lg-10 panel panel-border">
							<div class="scrollable" data-max-height="420">
									<div class="table-responsive">
										<table class="table table-striped table-condensed table-hover" class="scrollable" data-max-height="420">
											<tbody id="table0">
												<tr>
													<td>请选择需要修改的户型....</td>
<!-- 													<td><a href="#"><i class="fa-trash-o"></i> 删除</a></td> -->
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div style="color:red">确定批量修改以上<span id="total1">0</span>条房屋信息？
							<hr />
							<div class="text-center">
								<input type="hidden"  id="ceng">
								<a href="javascript:void(0)" class="btn btn-info btn-single" onclick="batchUP()" id="batchUP">批量修改</a>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
				<!-- Main Footer -->
			</div>
		</div>

		<div class="go-up" style="position: fixed;right: 15px; bottom: 10px; z-index: 9999; background: #f7aa47;padding: 10px;filter:alpha(opacity=50);moz-opacity:0.5;opacity:0.5;">
			<a href="#" rel="go-top">
				<i class="fa-arrow-up" style="font-size: 3em;"></i>
			</a>
		</div>
	</body>

</html>

<!-- Bottom Scripts -->
<script src="../assets/js/bootstrap.min.js"></script>
<script src="../assets/js/TweenMax.min.js"></script>
<script src="../assets/js/resizeable.js"></script>
<script src="../assets/js/joinable.js"></script>
<script src="../assets/js/xenon-api.js"></script>
<script src="../assets/js/xenon-toggles.js"></script>
<script src="../assets/js/moment.min.js"></script>

<script src="../assets/js/rwd-table/js/rwd-table.js"></script>

<!-- Imported scripts on this page -->
<script src="../assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script src="../assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>

<!-- Imported scripts on this page  xiala-->
<link rel="stylesheet" href="../assets/js/daterangepicker/daterangepicker-bs3.css">
<link rel="stylesheet" href="../assets/js/select2/select2.css">
<link rel="stylesheet" href="../assets/js/select2/select2-bootstrap.css">
<link rel="stylesheet" href="../assets/js/multiselect/css/multi-select.css">
<script src="../assets/js/rwd-table/js/rwd-table.js"></script>
<script src="../assets/js/daterangepicker/daterangepicker.js"></script>
<script src="../assets/js/datepicker/bootstrap-datepicker.js"></script>
<script src="../assets/js/timepicker/bootstrap-timepicker.min.js"></script>
<script src="../assets/js/colorpicker/bootstrap-colorpicker.min.js"></script>
<script src="../assets/js/select2/select2.min.js"></script>
<script src="../assets/js/xenon-custom.js"></script>

<link rel="stylesheet" href="../assets/js/datepicker/bootstrap-datetimepicker.min.css">
<!-- Imported scripts on this page  xiala-->
<script type="text/javascript" src="../assets/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="../assets/js/datepicker/bootstrap-datetimepicker.zh-CN.js"></script>

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
