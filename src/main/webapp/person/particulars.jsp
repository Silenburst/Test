<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
String cityId= SecurityUserHolder.getCurrentUserLogin().getCityId();
String countryId= SecurityUserHolder.getCurrentUserLogin().getCountryId();
String provinceId=SecurityUserHolder.getCurrentUserLogin().getProvinceId();
%>
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
		<meta name="description" content="Xenon Boostrap Admin Panel" />
		<meta name="author" content="" />
		<title>首页</title>
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/bootstrap.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-core.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-forms.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-components.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-skins.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/custom.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/elusive/css/elusive.css">
		<link href="<%=basePath%>/assets/css/style-responsive.css" rel="stylesheet" type="text/css" />
		<script src="<%=basePath%>/assets/js/jquery-1.11.1.min.js"></script>
		<script src="<%=basePath%>/assets/js/bootbox/bootbox.min.js"></script>
		<script src="<%=basePath%>/js/comm/commInfo.js" type="text/javascript"></script>
		<script src="<%=basePath%>/assets/js/page.js"></script>
		<script src="<%=basePath%>/js/person/personinfo.js"></script>
		<script src="<%=basePath%>/js/person/personpublic.js"></script>
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
	var basepath = "<%=basePath%>";
	</script>
	</head>
<!-- 	<div class='onsubing' style="display:none; width:100%; height:100%; background:#fff; position:fixed; z-index:99999; opacity:0.8;-moz-opacity:0.8; filter:alpha(opacity=80); "> -->
<!-- 		<div class="text-center" style="position:absolute; top:20%; left:50%;"> -->
<!-- 			<img src="<=basePath%>/images/loading.gif" width="176" height="220"/> -->
<!-- 		</div> -->
<!-- 	</div> -->
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
							<li> <a href="<%=basePath%>/console/index.jsp"><i class="fa-home"></i>首页</a> </li>
							<li class="active"> <strong> <a href="personInfo!queryByLFId.action?lfid='+$('#lpid').val()+'">详情</a></strong> </li>
						</ol>
					</div>
				</div>
				<script>
					var xenonPalette = ['#68b828'];
					var basepath = "<%=basePath%>";
				</script>
				<div class="panel">
					<div class="panel-body">
						<pre>房屋编号：${fangwubase[10]}</pre>
						<div class="col-lg-4">
							<div class="pull-left pr10">
								<div class="xe-image">
								<%     	Object[] fangwubase = (Object[]) request.getAttribute("fangwubase");  
								if(fangwubase[15]!=null && fangwubase[15] != ""){
								
								%>
										<img src='http://imgbms.xhjfw.com/${fangwubase[15]}' width="150">
								<%}else { %>
								<img src="../assets/images/20150519191526.png" width="150"> 
								<%} %>
								</div>
							</div>
							<div class="pull-left">
								<div style="font-size: 18px;">楼盘名称:${fangwubase[11]}</div>
								<h6><button type="button" class="btn btn-success" data-toggle="modal" data-target="#Hexin" onclick="selectlpfaohao(${fangwubase[16]})">查看核心信息</button></h6>
								<h6>
				          		<div class="btn-group">
									<button type="button" class="btn btn-success" data-toggle="dropdown">操作</button>
									<button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu dropdown-green" role="menu">
									<input type="hidden"  id="yzid" value="${fangwubase[16]}"/>
										<li><a href="javascript:void(0)" onclick="person()">新增联系方式</a></li>
										<li><a href="<%=basePath%>/personInfo!getxhjFangHao.action?action=update&fanghaoId=${fangwubase[9]}">修改房屋</a></li>
										<li><a href="javascript:void(0)" onclick="genjin(${fangwubase[9]})">跟进</a></li>
									</ul>
								</div>
			          		</h6>
							</div>
						</div>
						
						<div class="col-lg-5">
							<p>房屋地址：${fangwubase[12]}</p>
							<p>层号：${fangwubase[13]}</p>
							<p>房号：${fangwubase[14]}</p>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>

				<div class="panel">
					<!-- Add class "collapsed" to minimize the panel -->
					<div class="panel-heading">
						<div class="panel-options pull-left">
							<ul class="nav nav-tabs">
								
								<li class="active"><a href="#tab-1" data-toggle="tab">房屋信息</a></li>
								<li><a href="#tab-2" data-toggle="tab">跟进记录</a></li>
								<li><a href="#tab-3" data-toggle="tab">动态</a></li>
								<li><a href="#tab-4" data-toggle="tab">历史委托记录</a></li>
							</ul>
						</div>
					</div>
					<div class="panel-body">
						<div class="tab-content">
							<div class="tab-pane active" id="tab-1">
								<h3>基本信息</h3>
								<hr />
								<div class="">
									<div class="col-lg-3 form-group">
										户型：${fangwubase[0]}
									</div>
									<div class="col-lg-3 form-group">
										房屋朝向：${fangwubase[1]}
									</div>
									<div class="col-lg-3 form-group">
										房屋类型：${fangwubase[2]}
									</div>
									<div class="col-lg-3 form-group">
										套内面积(㎡)：${fangwubase[3]}
									</div>
									<div class="col-lg-3 form-group">
										产权面积(㎡)：${fangwubase[4]}
									</div>
									<div class="col-lg-3 form-group">
										产权地址：${fangwubase[5]}
									</div>
									<div class="col-lg-3 form-group">
										产权性质：${fangwubase[6]}
									</div>
									<div class="col-lg-3 form-group">
										产权年限：${fangwubase[7]}
									</div>
									<div class="col-lg-3 form-group">
										产权编码：${fangwubase[8]}
										<input type="hidden" class="form-control text-center" id = "lpid"  value="${fangwubase[9]}">
									</div>
								</div>
							</div>
							<div class="tab-pane" id="tab-2">
								<div class="table-responsive">
									<table class="table table-striped">
						                <tbody class="middle-align" id ="tbodyData1">
						            	</tbody>
						            </table>
								</div>
								<div class="clearfix"></div>
						    	<div style="height:10px;"></div>
								<div id="macPageWidget"></div>
						    	<div class="clearfix"></div>
							</div>
							<div class="tab-pane" id="tab-3">
								<div class="table-responsive">
									<table class="table table-striped">
						                <thead>
						                  <tr>
						                    <th>操作人</th>
						                    <th>操作记录</th>
						                    <th>操作时间</th>
						                  </tr>
						                </thead>
						                <tbody class="middle-align" id ="tbodyData2">
						                </tbody>
					            	</table>
								</div>
									<div class="clearfix"></div>
							    	<div style="height:10px;"></div>
									<div id="macPageWidget1"></div>
							    	<div class="clearfix"></div>
							</div>
							<div class="tab-pane" id="tab-4">
								<div class="table-responsive">
									<table class="table table-striped">
						                <thead>
						                  <tr>
						                    <th>操作人</th>
						                    <th>委托记录</th>
						                    <th>操作时间</th>
						                  </tr>
						                </thead>
						                <tbody class="middle-align" id ="tbodyData3">
						                </tbody>
					            		</table>
									</div>
								<div class="clearfix"></div>
						    	<div style="height:10px;"></div>
								<div id="macPageWidget2"></div>
						    	<div class="clearfix"></div>
							</div>

						</div>
					</div>
				</div>
			</div>

			<!-- Bottom Scripts -->
			<script src="<%=basePath%>/assets/js/bootstrap.min.js"></script>
			<script src="<%=basePath%>/assets/js/TweenMax.min.js"></script>
			<script src="<%=basePath%>/assets/js/resizeable.js"></script>
			<script src="<%=basePath%>/assets/js/joinable.js"></script>
			<script src="<%=basePath%>/assets/js/xenon-api.js"></script>
			<script src="<%=basePath%>/assets/js/xenon-toggles.js"></script>
			<script src="<%=basePath%>/assets/js/moment.min.js"></script>

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
			<script src="<%=basePath%>/assets/js/jquery-ui/jquery-ui.min.js"></script>
			<script src="<%=basePath%>/assets/js/selectboxit/jquery.selectBoxIt.min.js"></script>
			<script src="<%=basePath%>/assets/js/tagsinput/bootstrap-tagsinput.min.js"></script>
			<script src="<%=basePath%>/assets/js/typeahead.bundle.js"></script>
			<script src="<%=basePath%>/assets/js/handlebars.min.js"></script>
			<script src="<%=basePath%>/assets/js/multiselect/js/jquery.multi-select.js"></script>
			<script src="<%=basePath%>/assets/js/datatables/js/jquery.dataTables.min.js"></script>
			<!-- Imported scripts on this page -->
			<script src="<%=basePath%>/assets/js/datatables/dataTables.bootstrap.js"></script>
			<script src="<%=basePath%>/assets/js/datatables/yadcf/jquery.dataTables.yadcf.js"></script>
			<script src="<%=basePath%>/assets/js/datatables/tabletools/dataTables.tableTools.min.js"></script>
			<script type="text/javascript">
				jQuery(document).ready(function($) {
					$(".sboxit-4").selectBoxIt({
						showEffect: 'fadeIn',
						hideEffect: 'fadeOut'
					});
				});
				jQuery(document).ready(function($) {
					$(".s2example-1").select2({
						placeholder: '请输入搜索条件...',
						allowClear: true
					}).on('select2-open', function() {
						// Adding Custom Scrollbar
						$(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
					});
				});
				 // This JavaScript Will Replace Checkboxes in dropdown toggles
				jQuery(document).ready(function($) {
					setTimeout(function() {
						$(".checkbox-row input").addClass('cbr');
						cbr_replace();
					}, 0);
				});
				
			</script>
			<!-- jiesu -->
			<script src="../assets/js/xenon-custom.js"></script>
	</body>

</html>


<!-- /.核心信息 -->
<div class="modal fade" id="Hexin" data-backdrop="static" aria-hidden="false">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">查看核心资料</h4>
			</div>
			<div class="modal-body">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th colspan="2">业主信息</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="col-lg-6">业主姓名：<span id ="username"></span></td>
								<td class="col-lg-6">联系电话：<span id ="phone"></span></td>
							</tr>
							<tr>
								<td>电子信箱：<span id ="email1"></span></td>
								<td>QQ：<span id ="qq1"></span></td>
							</tr>
							<tr>
								<td colspan="2">微信：<span id ="wexin1"></span></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th colspan="2">历史联系方式</th>
							</tr>
						</thead>
						<thead>
							<tr>
								<th class="text-center">序号</th>
								<th class="text-center">业主姓名</th>
								<th class="text-center">联系电话</th>
								<th class="text-center">电子邮箱</th>
								<th class="text-center">QQ</th>
								<th class="text-center">操作</th>
							</tr>
						</thead>
						<tbody  class="middle-align" id ="tbodyData4">
						</tbody>
					</table>
				</div>
				<div class="clearfix"></div>
		    	<div style="height:10px;"></div>
				<div id="macPageWidget3"></div>
		    	<div class="clearfix"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<!-- /.核心详情 -->
<div class="modal fade" id="Hexinxiangqing" data-backdrop="static" aria-hidden="false">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">查看详情</h4>
			</div>
			<div class="modal-body">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th colspan="2">业主详情</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="col-lg-6">业主姓名：<span id ="uname"></span></td>
								<td class="col-lg-6">联系电话：<span id ="iphone"></span></td>
							</tr>
							<tr>
								<td>电子信箱：<span id ="email"></span></td>
								<td>QQ：<span id="qq"></span></td>
							</tr>
							<tr>
								<td>微信：<span id ="wexin"></span></td>
								<td>国籍：<span id ="nationality"></span></td>
							</tr>
							<tr>
								<td>所在城市：<span id ="city"></span></td>
								<td>现家庭地址：<span id ="dizhi"></span></td>
							</tr>
							<tr>
								<td>身份证：<span id ="shenfenz"></span></td>
								<td>出生日期：<span id ="riqi"></span></td>
							</tr>
							<tr>
								<td colspan="2">工作单位：<span id ="danwei"></span></td>
							</tr>
							<tr>
								<td colspan="2">单位地址：<span id ="dydz"></span></td>
							</tr>
							<tr>
								<td>工作性质：<span id ="gzxz"></span></td>
								<td>教育程度：<span id ="jycd"></span></td>
							</tr>
							<tr>
								<td colspan="2">消费观念：<span id ="xfgn"></span></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<!-- /.新增联系方式 -->
<div class="modal fade" id="Xinzeng" data-backdrop="static" aria-hidden="false">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增联系方式</h4>
			</div>
				<form role="form" class="form-horizontal" id="yezhuForm">
			<div class="modal-body">
				<div class="panel-default">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								业主基本信息
							</div>
							<div class="panel-body">
								<div class="row col-lg-12 col-md-12 col-xs-12 col-sm-12">
									<div class="col-md-4 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon red">业主姓名：</span>
												<input type="text" class="form-control" id="yezhuname" name="yezhu.name"  value="${yezhu.name}"/>
												<input type="hidden" class="form-control"   name="yezhu.id"  value="${yezhu.id}"/>
												<span class="input-group-addon" style="padding: 0;"></span>
												<select class="form-control" style="width: 80px;" name="yezhu.gender">
													<option>请选择</option>
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
												<input type="text" class="form-control" name="yezhu.weXin" id="yzweXin" value="${yezhu.weXin}"/>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">QQ：</span>
												<input type="text" class="form-control" name="yezhu.qq"  id="yzqq" value="${yezhu.qq}"/>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">身份证：</span>
												<input type="text" class="form-control" name="yezhu.identityCode" id="yzidentityCode" value="${yezhu.identityCode}"/>
											</div>
										</div>
									</div>
									<div class="col-md-3 col-sm-3">
										<div class="form-group">
											<div class="input-group input-group-minimal">
												<span class="input-group-addon">国籍：</span>
												<select class="form-control"  id="yznationality" name="yezhu.nationality"  data-value="${yezhu.nationality}">
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
												<input type="text" class="form-control" name="yezhu.email" id="yzemail" value="${yezhu.email}"/>
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
													</select>												</div>
											</div>
										</div>
										<div class="col-md-3 col-sm-3">
											<div class="form-group">
												<div class="input-group input-group-minimal">
													<span class="input-group-addon">出生日期：</span>
													<input type="text" class="form-control form_date" readonly="readonly"  name="yezhu.birthday" value="${birthday}"/>
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
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="personbtn" onclick="saveyezhu()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<!-- /.跟进 -->
<div class="modal fade" id="Genjin" data-backdrop="static" aria-hidden="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">跟进</h4>
			</div>
			<form role="form" class="form-horizontal" id="lpUpdatingRecordForm">
			<input type="hidden"  name="lpUpdatingRecord.id" value="0">
			<input type="hidden"  name="lpUpdatingRecord.fhid" id="fhid">
			<div class="modal-body">
				<table class="table">
					<tbody>
						<tr>
							<td width="90">跟进类型</td>
							<td>
								<select class="form-control" id="utpye" data-value="${lpUpdatingRecord.utpye}"  name="lpUpdatingRecord.utpye">
									<option value="0">请选择跟进类型</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>跟进内容</td>
							<td>
								<textarea class="form-control" name="lpUpdatingRecord.messages"  id="messages"  rows="5">${lpUpdatingRecord.messages}</textarea>
							</td>
						</tr>
					</tbody>
				</table>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="lpUpdatingRecordbtn" onclick="savelpUpdatingRecord()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<link rel="stylesheet" href="<%=basePath%>/assets/js/datepicker/bootstrap-datetimepicker.min.css">
<!-- Imported scripts on this page  xiala-->
<script type="text/javascript" src="<%=basePath%>/assets/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/datepicker/bootstrap-datetimepicker.zh-CN.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		queryData1($("#lpid").val());
		queryData2($("#lpid").val());
		queryData3($("#lpid").val());
		queryData4($("#yzid").val());
	});
	//跟进记录
	function queryData1(lpid){
	  	 	var url ="<%=basePath%>/personInfo!queryUpdateRecord.action?lfid="+lpid;
		   $("#macPageWidget").asynPage(url, "#tbodyData1", buildDataHtml1, true, true, {
		   });
		};
	function buildDataHtml1(list) {
			$("#tbodyData1").html("");
			   $.each(list, function (i, info) { 
			   var newTime = new Date(info[2]); 
	    		var nowStr = newTime.format("yyyy-MM-dd hh:mm:ss"); 
			       var tr = [
			           '<tr>',
			           '<td valign="top"><b class="f16">',info[7], '</b>', info[9],' ',info[8],'<br>',
			           '<strong>跟进: </strong>',info[3],'</td>',
			           '<td>',nowStr,'</td>',
			           '</tr>'].join('');
			       $("#tbodyData1").append(tr);
			   });
			};
		//动态
		function queryData2(lpid){
		  	 	var url ="<%=basePath%>/personInfo!queryFHLog.action?lfid="+lpid;
			   $("#macPageWidget1").asynPage(url, "#tbodyData2", buildDataHtml2, true, true, {
			   });
			};
		function buildDataHtml2(list) {
			$("#tbodyData2").html("");
			   $.each(list, function (i, info) { 
			   var newTimel = new Date(info[5]); 
	    		var nowStrl = newTimel.format("yyyy-MM-dd hh:mm:ss"); 
	    		var sHtml="";
	    			sHtml +="<tr>";
		    			sHtml +="<td>";
		    			sHtml += "<div class='pull-left'>";
						sHtml += "<h6>"+info[11]+"</h6>"+info[13]+""+info[12]+"";
						sHtml += "</div>";
						sHtml += "</td>";
						sHtml += "<td>"+info[7]+"</td>";
						sHtml += "<td>"+nowStrl+"</td>";
					sHtml +="</tr>";
			       $("#tbodyData2").append(sHtml);
			   });
			};
		//历史委托记录
		function queryData3(lpid){
		  	 	var url ="<%=basePath%>/personInfo!queryWeiTuoJiLu.action?lfid="+lpid;
			   $("#macPageWidget2").asynPage(url, "#tbodyData3", buildDataHtml3, true, true, {
			   });
			};
		function buildDataHtml3(list) {
			$("#tbodyData3").html("");
			
			   $.each(list, function (i, info) { 
			   var newTime1 = new Date(info[4]); 
	    		var nowStr1 = newTime1.format("yyyy-MM-dd hh:mm:ss"); 
	    		var sHtml="";
	    			sHtml += "<tr>";
						sHtml += "<td>";
						sHtml += "<div class='pull-left'>";
						sHtml += "<h6>"+info[1]+"</h6>"+info[2]+"";
						sHtml += "</div>";
						sHtml += "</td>";
						sHtml += "<td>"+info[5]+"</td>";
						sHtml += "<td>"+nowStr1+"</td>";
					sHtml += "</tr>";
			       $("#tbodyData3").append(sHtml);
			   });
			};
			
		//业主核心信息
		function queryData4(yzid){
	  	 	var url ="<%=basePath%>/personInfo!queryYeZXX.action?lfid="+yzid;
		   $("#macPageWidget3").asynPage(url, "#tbodyData4", buildDataHtml4, true, true, {
		   });
		};
		function buildDataHtml4(list) {
			$("#tbodyData4").html("");
			   $.each(list, function (i, info) { 
	    			 var tr = [
			            '<tr>',
			            '<td class="text-center">', info[0]=="null" ||info[0]=="" || info[0]==null?"":info[0], '</td>',
			            '<td class="text-center">', info[1]=="null" ||info[1]=="" || info[1]==null?"":info[1], '</td>',
			            '<td class="text-center">', info[2]=="null" ||info[2]=="" || info[2]==null?"":info[2], '</td>',
			            '<td class="text-center">', info[5]=="null" ||info[5]=="" || info[5]==null?"":info[5], '</td>',
			            '<td class="text-center">', info[3]=="null" ||info[3]=="" || info[3]==null?"":info[3], '</td>',
			            '<td><a href="#" class="pr10" data-toggle="modal" onclick="selectYEzhu('+info[6]+')"><i class="fa-trash-o"></i> 详情 </a></td>',
			            '</tr>'].join('');
			       $("#tbodyData4").append(tr);
			   });
			};
function selectYEzhu(id){
 $.ajax({
		url: "<%=basePath%>/personInfo!selectState.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"id":id},
		success: function(data){
				$("#uname").html(data.name);
				$("#iphone").html(data.telephone);
				$("#email").html(data.email);
				$("#qq").html(data.qq);
				$("#wexin").html(data.weXin);
				$("#nationality").html(data.nationality);
				$("#city").html(data.cityID);
				$("#dizhi").html(data.homeAddress);
				$("#shenfenz").html(data.identityCode);
				$("#riqi").html(data.birthday);
				$("#danwei").html(data.workPlace);
				$("#dydz").html(data.officeAddress);
				$("#gzxz").html(data.workType);
				$("#jycd").html(data.education);
				$("#xfgn").html(data.consumptionConcept);
				jQuery('#Hexinxiangqing').modal('show');
		}
	});

}
//查看核心信息
function selectlpfaohao(id){
	 $.ajax({
			url: "<%=basePath%>/personInfo!selectLpfanghao.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data :{"id":id},
			success: function(data){
				$("#username").html(data.name);
				$("#phone ").html(data.telephone);
				$("#email1 ").html(data.email);
				$("#qq1").html(data.qq);
				$("#wexin1").html(data.weXin);
			}
		});

	}
	
	
	Date.prototype.format = function(format){ 
	var o = { 
	"M+" : this.getMonth()+1, //month 
	"d+" : this.getDate(), //day 
	"h+" : this.getHours(), //hour 
	"m+" : this.getMinutes(), //minute 
	"s+" : this.getSeconds(), //second 
	"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
	"S" : this.getMilliseconds() //millisecond 
	} 

	if(/(y+)/.test(format)) { 
	format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	} 

	for(var k in o) { 
	if(new RegExp("("+ k +")").test(format)) { 
	format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
	} 
	} 
	return format; 
	} 
		</script>
		
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
	language: 'zh-CN'
})
</script>
