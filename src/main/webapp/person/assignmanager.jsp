<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
Integer userid = userLogin.getUserProfile().getId();
Integer loginid = userLogin.getUserLogin().getId();
Integer departmentId = userLogin.getDepartment().getId();
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
		<script src="<%=basePath%>/assets/js/jquery-1.11.1.min.js"></script>
		<script src="<%=basePath%>/js/services.js"></script>
		<link rel="stylesheet" href="../assets/js/bootbox/bootbox.css">
		<script src="../assets/js/bootbox/bootbox.min.js"></script>
		<script type="text/javascript">
			var basepath = "<%=basePath%>";
		</script>
		<script src="<%=basePath%>/js/page.js"></script>
		<script src="<%=basePath%>/js/person/batch.js"></script>
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
				<jsp:include page="../include/top.jsp"/>
				<div class="page-title">

					<div class="breadcrumb-env pull-left">
						<ol class="breadcrumb bc-1">
							<li>
								<a href="<%=basePath%>/console/index.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<li>
								<a href="<%=basePath%>/person/assignmanager.jsp?p=bat&k=yz">房屋分派管理</a>
							</li>
							<li class="active">
								<strong>批量修改</strong>
							</li>
						</ol>

					</div>

				</div>
				<div class="panel panel-default">
					<div class="table-responsive">
						<table class="table table-condensed">
							<tbody class="middle-align">
								<tr>
									<td>楼盘</td>
									<td>
										<div style="width: 200px; margin-bottom: 0px;">
												<input type="text" class="form-control text-center"  id="lpName">
										</div>
									</td>
									<td>房屋地址</td>
									<td>
										<div class="form-group" style="width: 300px; margin-bottom: 0px;">
											<div class="input-group input-group-minimal">
												<input type="text" class="form-control text-center"  id="dyName">
												<span class="input-group-addon">单元</span>
												<input type="text" class="form-control text-center" id="lpdName">
												<span class="input-group-addon">栋座</span>
												<input type="text" class="form-control text-center"  id="fhName">
												<span class="input-group-addon">房号</span>
											</div>
										</div>
									</td>
									<td>产权面积</td>
									<td>
										<div class="form-group" style="width: 200px; margin-bottom: 0px;">
											<div class="input-group input-group-minimal">
												<input type="text" class="form-control text-center"  id="smj">
												<span class="input-group-addon">-</span>
												<input type="text" class="form-control text-center"  id="emj">
											</div>
										</div>
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>楼层</td>
									<td>
										<div class="form-group" style="width: 200px; margin-bottom: 0px;">
											<div class="input-group input-group-minimal">
												<input type="text" class="form-control text-center"  id="sc">
												<span class="input-group-addon">-</span>
												<input type="text" class="form-control text-center"  id="ec">
											</div>
										</div>
									</td>
									<td>户型</td>
									<td>
										<div class="form-group" style="width: 300px; margin-bottom: 0px;">
											<div class="input-group input-group-minimal">
												<input type="text" class="form-control text-center"  id="sh">
												<span class="input-group-addon">-</span>
												<input type="text" class="form-control text-center"  id="eh">
											</div>
										</div>
									</td>
									<td>更新时间</td>
									<td>
										<div class="form-group" style="width: 200px; margin-bottom: 0px;">
											<div class="input-group input-group-minimal">
												<input type="text" class="form-control text-center form_date"  id="sd">
												<span class="input-group-addon">-</span>
												<input type="text" class="form-control text-center form_date"  id="ed">
											</div>
										</div>
									</td>
									<td>
										<button class="btn btn-secondary" type="button" onclick="queryData()">搜索</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="panel panel-default">
					<div>
<!-- 						<form name="uploadForm" action="<=basePath%>excel!readExcel.action" method="post" enctype="multipart/form-data"> -->
<!--  							<input type="file"  name="myFile" id="myFile"   > -->
<!--  							<input type="submit" id="submit"  class="btn btn-secondary"  value="批量上传"> -->
<!-- 						</form> -->
						<button type="button" class="btn btn-secondary" onclick="showDlgBatch()">批量分派</button>
						<a type="button" class="btn btn-secondary" style="display:none"  data-toggle="modal"  id="PiliangP"   data-target="#Piliang"></a>
						<a href="batchupdate.jsp" class="btn btn-secondary" id="batchUpdate">批量修改房号</a>
					</div>
					<div>
						<table class="table table-bordered table-striped table-condensed">
							<thead>
								<tr>
									<!-- <th width="50" class="text-center" style="display:none">
										<input type="checkbox" id="table_ckall" class="cbr" /></th>
									</th> -->
									<th class="text-center">户型图</th>
									<th class="text-center" width="88">房屋编号</th>
									<th class="text-center col-lg-2">楼盘</th>
									<th class="text-center col-lg-1">责任人</th>
									<th class="text-center">最后更新</th>
									<th class="text-center">更新来源</th>
									<th class="text-center">委托状态</th>
									<th class="text-center">房屋状态</th>
									<th class="text-center">点击次数</th>
									<th class="text-center">操作</th>
								</tr>
							</thead>
							<tbody class="middle-align"  id="tbodyData">
							</tbody>
						</table>
					</div>
					<div class="clearfix"></div>
			    	<div style="height:10px;"></div>
						<div id="macPageWidget"></div>
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
	$('#myFile').change(function(){
//     	ajaxFileUpload();
		$("#submit").click();
	});
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
<div class="modal fade" id="xiangqing" data-backdrop="static" style="display:none">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
				<h4 class="modal-title">详情</h4>
			</div>
			<div class="modal-body">
				<div class="table-responsive">
					<table class="table table-bordered table-condensed table-hover">
						<tbody>
							<tr>
								<td>房屋编号：</td>
								<td>楼盘：</td>
							</tr>
							<tr>
								<td>房屋地址：</td>
								<td>层号：</td>
							</tr>
							<tr>
								<td colspan="2">户型：</td>
							</tr>
							<tr>
								<td>房号：</td>
								<td>房屋朝向：</td>
							</tr>
							<tr>
								<td>产权面积（㎡）：</td>
								<td>套内面积（㎡）：</td>
							</tr>
							<tr>
								<td>房屋类型：</td>
								<td>房屋用途：</td>
							</tr>
							<tr>
								<td>产权地址：</td>
								<td>产权编码：</td>
							</tr>
							<tr>
								<td>产权年限：</td>
								<td>产权性质：</td>
							</tr>
							<tr>
								<td>业主姓名：不知道,男士</td>
								<td>联系电话：13875999474,朋友</td>
							</tr>
							<tr>
								<td>微信：</td>
								<td>QQ：</td>
							</tr>
							<tr>
								<td>身份证：</td>
								<td>国籍：</td>
							</tr>
							<tr>
								<td>所在城市：</td>
								<td>电子信箱：</td>
							</tr>
							<tr>
								<td>微信：</td>
								<td>QQ：</td>
							</tr>
							<tr>
								<td>消费观念：</td>
								<td>教育程度：</td>
							</tr>
							<tr>
								<td>工作性质：</td>
								<td>出生日期：</td>
							</tr>
							<tr>
								<td>工作单位：</td>
								<td>单位地址：</td>
							</tr>
							<tr>
								<td colspan="2">现家庭地址：</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="Fenpai" data-backdrop="static">
	<form role="form" class="form-horizontal"  id="FenpaiForm"  name = "FenpaiForm">
	<input type="hidden" id="fhidsfp" name="condition.fhids">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
				<h4 class="modal-title">分派</h4>
			</div>
			<div class="modal-body">
				<div class="table-responsive">
					<table class="table">
						<tbody class="middle-align">
							<tr>
								<td colspan="3">楼盘名称：<span  id="lpNamefp"></span> </td>
							</tr>
							<tr>
								<td colspan="3">
<!-- 								确定分派<span id="totalfp">0</span>条资源给以下接收人员？ -->
									<span id="tixingfp" style="display:none;color:red">[提醒:如不选择接受经纪人，将直接分派给所选择的店组.]</span>
								</td>
							</tr>
							<tr>
								<td>接受人： </td>
								<td>
									<input id="userid" type="hidden" value="<%=userid%>"  name="condition.assign.assignPerson"/>
<!-- 												<input type ="radio" id="bm2" name ="dianzu"> -->
<!-- 									<select class="form-control s2example" id="dianzufp" onchange="queryBMJL(this.value,'fp')" name="condition.assign.bmid"> -->
<!-- 										<option value="0">请选择接收店组</option> -->
<!-- 									</select> -->
									<input type="hidden" name="condition.assign.bmid"  id="dianzufp" />
								</td>
								<td>
									<select class="form-control s2example" id="jinjirenfp" onchange="changeDisplay('fp')" name="condition.assign.userid">
										<option value="0">请选择接受经纪人</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick=" insertBatchFenpai('FenpaiForm','fp')">保存</button>
				<button type="button" class="btn btn-danger" id="closefp" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
	</form>
</div>

<div class="modal fade" id="Piliang" data-backdrop="static">
	<form role="form" class="form-horizontal"  id="batchForm"  name = "batchForm">
	<input type="hidden" id="ids" name="condition.ids">
	<input type="hidden" id="fhids2" name="condition.fhids">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
				<h4 class="modal-title">批量分派</h4>
			</div>
			<div class="modal-body">
				<div class="table-responsive">
					
					
					<div class="panel">
					<div class="col-lg-5 panel panel-border">
							<div class="form-group" style="margin-bottom: 10px;">
								<label class="col-sm-4 col-md-2 control-label" for="field-1">楼盘名称</label>
								<div class="col-sm-8">
<!-- 									<select class="s2example" id="lpid" onchange="queryDong(this.value)" name="condition.lpxx.id"> -->
<!-- 											<option value="0">请选择楼盘</option> -->
<!-- 									</select> -->
									<script type="text/javascript">
												jQuery(document).ready(function($)
												{
													$("#lpid").select2({
														minimumInputLength: 1,
														placeholder: '请输入楼盘搜索',
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
										<option value="0">请选择</option>
									</select>
								</div>
							</div>
							<div class="form-group-separator" style="margin-bottom: 10px;"></div>
							<div class="form-group" style="margin-bottom: 10px;">
								<label class="col-sm-4 col-md-2 control-label" for="field-1">单元</label>
								<div class="col-sm-8">
									<select class="form-control" id="danyuanid" name="condition.danyuan.id">
										<option value="0">请选择</option>
									</select>
								</div>
									<a class="btn btn-info btn-single" onclick="querySource('tbodyid1',1)">查询</a>
							</div>
						<hr />
						<div  class="scrollable" data-max-height="420">
							
							<div class="table-responsive">
								<table class="table table-striped table-condensed table-hover">
									<thead>
										<tr>
											<th>共搜索到<span id="total">0</span>个资源</th>
										</tr>
									</thead>
									<tbody class="middle-align" id="tbodyid1" >
										<tr>
											<td>请搜索数据....</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="col-lg-7">
						<div class="col-lg-2 text-center" style="position: relative;">
							<div style="position: absolute; top: 250px;">
								<button type="button" class="btn btn-info " style="width:50px" onclick="setClassAll(2)">  <i class="fa-angle-double-left"></i></button>
<!-- 								<button type="button" class="btn btn-info " style="width:50px">  <i class="fa-angle-left"></i></button> -->
<!-- 								<button type="button" class="btn btn-info " style="width:50px"> <i class="fa-angle-right"></i></button> -->
								<button type="button" class="btn btn-info " style="width:50px" onclick="setClassAll(1)">  <i class="fa-angle-double-right"></i></button>
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="col-lg-10 panel panel-border">
							<div class="table-responsive">
								<table class="table">
									<tbody class="middle-align">
										<tr>
											<td colspan="2">确定分派<span id="total2">0</span>条资源给以下接收人员？
											<p><span id="tixing2" style="display:none;color:red">[提醒:如不选择接受经纪人，将直接分派给所选择的店组.]</span>
											</td>
										</tr>
<!-- 										<tr style="width:130px"> -->
<!-- 											<td >店组： </td> -->
<!-- 											<td> -->
<!-- 												<input type ="radio" id="bm1" name ="dianzu" checked="checked"> -->
<!-- 												<select class="form-control s2example" id="dianzu1"> -->
<!-- 													<option value="0">请选择接收店组</option> -->
<!-- 												</select> -->
<!-- 											</td> -->
<!-- 										</tr> -->
										<tr>
											<td>接受店组： </td>
											<td>
												<input id="userid" type="hidden" value="<%=userid%>"  name="condition.assign.assignPerson"/>
<!-- 												<input type ="radio" id="bm2" name ="dianzu"> -->
<!-- 												<select class="s2example" id="dianzu2" onchange="queryBMJL(this.value,'2')" name="condition.assign.bmid"> -->
<!-- 													<option value="0">请选择接收店组</option> -->
<!-- 												</select> -->
												<script type="text/javascript">
												jQuery(document).ready(function($)
												{
													$("#dianzu2").select2({
														minimumInputLength: 1,
														placeholder: '请输入店组搜索',
														ajax: {
															url: basepath+"/personInfo!queryBM.action",
															type: "POST",
															dataType: 'json',
															quietMillis: 100,
															data: function(term, page) {
																return {
																	limit: -1,
																	"condition.dianzuName": term
																};
															},
															results: function(data, page ) {
																return { results: data }
															}
														},
														formatResult: function(student) { 
															return "<div class='select2-user-result'>" + student[1] + "</div>"; 
														},
														formatSelection: function(student) {
														alert(student+"=="+ student[1]);
															return  student[1]; 
														}
														
													}) .on("change",function(e){
													//	queryDong(e.val);
														queryBMJL(e.val,'fp');
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
											<input type="hidden" name="condition.assign.bmid"  id="dianzu2" />
											</td>
										</tr>
										<tr>
											<td>接受经纪人： </td>
											<td>
												<select class="s2example" id="jinjiren2" onchange="changeDisplay('2')" name="condition.assign.userid">
													<option value="0">请选择接受经纪人</option>
												</select>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div style="height: 10px;"></div>
							<div class="scrollable" data-max-height="420">
									<div class="table-responsive">
										<table class="table table-striped table-condensed table-hover">
											<tbody class="middle-align" id="tbodyid2">
												<tr>
													<td>请从左边选择将要分派的数据....</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							<hr />
							<div class="text-center">
								<button type="button" class="btn btn-info btn-single" onclick="insertBatchFenpai('batchForm',2)">确认分派</button>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
					
					
					
				</div>
			</div>
<!-- 			<div class="modal-footer"> -->
<!-- 				<button type="button" class="btn btn-info">保存</button> -->
				<button type="button" style="display:none" id="close2" class="btn btn-danger" data-dismiss="modal" >关闭</button>
<!-- 			</div> -->
		</div>
	</div>
</form>
</div>
