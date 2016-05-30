<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
			UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
	long timeMillis = System.currentTimeMillis();
	String BMSPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/BMS";
%>
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="description" content="Xenon Boostrap Admin Panel" />
		<meta name="author" content="" />
		<title>出租管理</title>
		<link rel="stylesheet" href="../assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="../assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../assets/css/fonts/elusive/css/elusive.css">
		<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/css/xenon-core.css">
		<link rel="stylesheet" href="../assets/css/xenon-forms.css">
		<link rel="stylesheet" href="../assets/css/xenon-components.css">
		<link rel="stylesheet" href="../assets/css/xenon-skins.css">
		<link rel="stylesheet" href="../assets/css/custom.css">
		<script src="./common.js?_t=<%=timeMillis%>"></script>
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		<script src="../js/jquery.loadTemplate-1.4.4.min.js"></script>
		
		<script src="../assets/js/page.js"></script>
		<script src="../assets/js/bootbox/bootbox.min.js"></script>
		<script src="../js/ajaxpage/pagination.js"></script>
		<script src="../js/tools.js"></script>
		
		<style>
		.table-responsive-1150 a {
			text-decoration: none;
		}

		.pageOpen {
			color: #ffffff;
			background-color: #8dc63f !important;
			border-color: #80b636;
		}
		.form-wizard .tab-content { margin-top: 0px; }
		.div_y { max-width: 200px;overflow: hidden; text-overflow:ellipsis; float: left; }
		.div_y1 { max-width: 400px;overflow: hidden; text-overflow:ellipsis; }
		</style>

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

	</head>

	<body class="page-body">
	
		<div class='onsubing' style="display:none; width:100%; height:100%; background:#fff; position:fixed; z-index:99999; opacity:0.8;-moz-opacity:0.8; filter:alpha(opacity=80); ">
			<div class="text-center" style="position:absolute; top:20%; left:50%;">
				<img src="../assets/images/loading.gif" width="176" height="220"/>
				<span> 数据正在加载中....</span>
			</div>
		</div>
	
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
								<a href="verInfo.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<li>
								<a href="#">云发布</a>
							</li>
							<li class="active">
								<strong>出租管理</strong>
							</li>
						</ol>
					</div>
				
				</div>

				<!-- <div class="tsfy-top">
					<i class="el-volume-up"></i> 尊敬的用户，您今日还可推送<a href="#">100</a>套房源，剩余可录入房源<a href="#">100</a>套
				</div> -->
			
				<form role="forl" id="fromlist" class="form-wizard validate">
					<input type="hidden" name="status" value="0"/>
					<input type="hidden" name="qyValue" value=""/>
		
					<ul class="tabs" id="chooseID" style="display: none;">
						<li class="active">
							<a href="javascript:void(0);" id="chooseFang" data-toggle="tab">
							选择房源
							<span>1</span>
						</a>
						</li>
						<li>
							<a href="javascript:void(0);" id="chooseSite" >
							选择网站
							<span>2</span>
						</a>
						</li>
					</ul>

					<div class="progress-indicator" style="display: none;">
						<span></span>
					</div>
					<div class="tab-content">

						<!-- Tabs Content -->
						<div class="tab-pane active" id="fwv-1" style="${param.from == 0 ? 'display:none;':'' }">

							<div class="row">

								<div class="col-md-12">

									<div>
										<!-- <div class="pull-right">
											<div class="pull-left mr10 line32">自动刷新间隔时间为：</div>
											<div class="pull-left">
												<select class="form-control pull-left">
													<option>5秒</option>
													<option>10秒</option>
												</select>
											</div>
										</div> -->

										<ul class="nav nav-tabs pull-left" id="houseType">
											<li class="active">
												<a href="#tab-01" data-toggle="tab" data-val="0" onclick="doShow(this);">
													<span class="visible-xs"><i class="fa-home"></i></span>
													<span class="hidden-xs">住宅</span>
												</a>
											</li>
											<li>
												<a href="#tab-01" data-toggle="tab" data-val="4" onclick="doShow(this);">
													<span class="visible-xs"><i class="fa-user"></i></span>
													<span class="hidden-xs">别墅</span>
												</a>
											</li>
											<li>
												<a href="#tab-01" data-toggle="tab" data-val="2" onclick="doShow(this);">
													<span class="visible-xs"><i class="fa-user"></i></span>
													<span class="hidden-xs">店面</span>
												</a>
											</li>
											<li>
												<a href="#tab-01" data-toggle="tab" data-val="1" onclick="doShow(this);">
													<span class="visible-xs"><i class="fa-user"></i></span>
													<span class="hidden-xs">写字楼</span>
												</a>
											</li>
										</ul>

										<div class="clearfix"></div>
									</div>
									<div class="tab-content bgcolor no-margin">
										<div class="tab-pane active" id="tab-01">
												<!-- 条件  -->
											<div class="panel">
												<div class="table-responsive-1150">
													<table class="table xuanze" style=" min-width: 1050px;">
														<tbody>
															<tr>
																<td>
																	<span><i class="fa-caret-right"></i>状态</span>
																	<a href="#tab-07" data-toggle="tab" class="active" onclick="selectStatus(this);" data-val="0" id="publish">发布中</a>
																	<a href="#tab-08" data-toggle="tab" onclick="selectStatus(this);" data-val="1" id="drafts">草稿箱</a>
																	<a href="#tab-09" data-toggle="tab" onclick="selectStatus(this);" data-val="2">回收站</a>
																</td>
															</tr>
															<tr>
																<td id="qyTd"></td>
															</tr>
															<tr>
																<td style="line-height: 32px;">
																	<div class="pull-left">
																		<div class="input-group" style="width: 150px;" id="sourceId">
																			<span class="input-group-addon">来源</span>
																			<select id="source" class="form-control" style="width: 90px;">
																				<option value="">全部</option>
																				<option value="58同城">58同城</option>
																				<option value="安居客">安居客</option>
																				<option value="赶集">赶集</option>
																				<option value="搜房">搜房</option>
																				<option value="百姓">百姓</option>
																				<option value="新环境">新环境</option>
																				<option value="新增">新增</option>
																				<option value="一键委托">一键委托</option>
																				<option value="400">400</option>
																			</select>
																		</div>
																	</div>
																	<div class="pull-left">
																		<div class="input-group" style="width: 150px;display: none;" id="sjStatusId">
																			<span class="input-group-addon">上架状态</span>
																			<select id="sjstatus" class="form-control" style="width: 90px;">
																				<option value="-1">全部</option>
																				<option value="1">已上架</option>
																				<option value="0">已下架</option>
																			</select>
																		</div>
																	</div>
																	<div class="pull-right">
																		<div class="input-group" style="width: 300px;padding-left:5px;">
																			<input type="text" class="form-control" id="searchKey" placeholder="请输入关键字">
																			<a href="javascript:initShouCang()" class="btn btn-success input-group-addon">搜索</a>
																	    </div>
																	</div>
																</td>
															</tr>
															
														</tbody>
													</table>
												</div>
											</div>
											
											<!-- 发布中 -->
											<div class="tab-content bgcolor no-margin">
												<div class="tab-pane active" id="tab-07">

													<div class="panel">
														<div>
														<span class="input-group-btn pull-left">
															<a id="xinzengfangyuan" href="rentForm.jsp?from=3&hType=0"></a>
															<button class="btn btn-secondary" data-toggle="dropdown" type="button" onclick="$(this).prev()[0].click();">新增房源</button>
														</span>
														</div>
														<div class="panel-body">
														<div class="table-responsive pull-right" data-pattern="priority-columns" data-focus-btn-icon="fa-file-text-o" data-sticky-table-header="true" data-add-display-all-btn="true" data-add-focus-btn="false" id="publishClassId">

																<table class="table table-bordered table-hover table-model-2" id="publishTable">
																	<thead>
																		<tr>
																			<th class="text-center" width="50">
																				<input type="checkbox" onclick="checkAll(this,'rids')" id="cbPublishId">
																			</th>
																			<th class="text-center">房源编号</th>
																			<th class="text-center" width="96px;" rowspan="2"></th>
																			<th class="text-center" data-priority="1">房源基本信息</th>
																			<th data-priority="2" class="text-center">上架数/网站数</th>
																			<th data-priority="3" class="text-center">更新时间</th>
																			<!-- -->
																			<th data-priority="4" class="text-center">推送时间</th> 
																			<th data-priority="5" class="text-center">状态</th>
																			<th data-priority="6" class="text-center">来源</th>
																			<th class="text-center">操作</th>
																		</tr>
																	</thead>
																	<tbody>
																	</tbody>
																</table>

															</div>
															<div class="clearfix"></div>
															<div class="col-sm-12">
																<div class="form-group">
																	<div class="col-sm-1">
																		<a class="btn btn-secondary" data-toggle="dropdown" onclick="javascript:shangjia('0');">上架</a>
																	</div>
																	<div class="col-sm-1">
																		<a class="btn btn-secondary" class="btn btn-secondary" onclick="xiajia()">下架</a>
																	</div>
																	<div class="col-sm-1">
																		<a class="btn btn-secondary" data-toggle="dropdown" onclick="pdelete()">删除</a>
																	</div>
																</div>
															</div>

														</div>

													</div>

												</div>
										
												<div class="tab-pane" id="tab-08">
													<div class="panel">
														<div class="panel-body">
														<div class="table-responsive pull-right" data-pattern="priority-columns" data-focus-btn-icon="fa-file-text-o" data-sticky-table-header="true" data-add-display-all-btn="true" data-add-focus-btn="false" id="draftsClassId">

																<table class="table table-bordered table-hover table-model-2" id="shouCangTable">
																	<thead>
																		<tr>
																			<th class="text-center" width="50">
																				<input type="checkbox" onclick="checkAll(this,'cbDraftsName')" id="cbDraftsId">
																			</th>
																			<th class="text-center">房源编号</th>
																			<th class="text-center" width="96px;" rowspan="2"></th>
																			<th class="text-center" data-priority="1">房源基本信息</th>
																			<th data-priority="2" class="text-center">创建时间</th>
																			<th class="text-center">来源</th>
																			<th class="text-center">操作</th>
																		</tr>
																	</thead>
																	<tbody>
																		<!-- 收藏 -->
																	</tbody>
																</table>
																
															</div>

														</div>

													</div>

												</div>

												<div class="tab-pane" id="tab-09">

													<div class="panel">
														<div class="panel-body">
															<div class="table-responsive pull-right" data-pattern="priority-columns" data-focus-btn-icon="fa-file-text-o" data-sticky-table-header="true" data-add-display-all-btn="true" data-add-focus-btn="false" id="recycleClassId">

																<table class="table table-bordered table-hover table-model-2" id="recyleTable">
																	<thead>
																		<tr>
																			<th class="text-center" width="50">
																				<input type="checkbox" onclick="checkAll(this,'cbRecycleName')" id="cbRecycleId">
																			</th>
																			<th class="text-center">房源编号</th>
																			<th class="text-center" width="96px;" rowspan="2"></th>
																			<th class="text-center" data-priority="1">房源基本信息</th>
																			<th data-priority="2" class="text-center">网站</th>
																			<th data-priority="3" class="text-center">更新时间</th>
																			<th data-priority="4" class="text-center">推送时间</th>
																			<th data-priority="5" class="text-center">下架原因</th>
																			<th class="text-center">操作</th>
																		</tr>
																	</thead>
																	<tbody>
																		<!-- 回收站结果集 -->
																	</tbody>
																</table>

															</div>

															<div class="clearfix"></div>
															<div class="col-sm-12">
																<div class="form-group">
																	<div class="col-sm-6">
																		<a href="javascript:void(0);" class="btn btn-secondary" onclick="multiFunctionBackup(1)">还原</a>
																		<a href="javascript:void(0);" class="btn btn-secondary" onclick="multiFunctionBackup(2)">彻底删除</a>
																		<%--<a href="javascript:void(0);" class="btn btn-secondary" onclick="multiFunctionBackup(3)">清空回收站</a>--%>
																	</div>
																	<div class="col-sm-1">

																	</div>
																	<div class="col-sm-1">

																	</div>
																</div>
															</div>

														</div>

													</div>

												</div>

											</div>

										</div>
										<!-- tab-02 ... tab-05 -->
									</div>

								</div>

							</div>

						</div>

						<div class="tab-pane with-bg" id="fwv-2" style="${param.from == 0 ? '':'display:none;' }">

							<div class="row">
								<div class="wxts">
									<p><i class="el-info-circled"></i> 贴心提示：</p>
									<p>1、如果您未配置账号，您可以马上<a href="<%=basePath%>/crawl/personalSite.jsp">添加账户</a></p>
									<p>2、<font style="color: red;">注意： 一键上架存在一定发布失败率！请根据提示信息修改再次发布！</font></p>
								</div>
								<div class="table-responsive-1150">
									<table class="table table-bordered table-striped text-center" style=" min-width: 1050px;" id="shangjiaTable">
										<thead>
											<tr>
												<th>
													<input type="checkbox" class="cbr cbr-done" onclick="checkAll(this,'uids')" id="cbGroundingId"> 全选</th>
												<th>网站</th>
												<th>帐号</th>
												<%--<th>库存满时发送处理</th>
												<th>房源重复发送处理</th>--%>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
									<div class="clearfix">
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<div class="col-sm-1">
												<a class="btn btn-secondary" data-toggle="dropdown" onclick="javascript:shangjia('1');">上架</a>
											</div>
										</div>
									</div>
								</div>
							</div>

						</div>

						<div class="tab-pane with-bg" id="fwv-3">

							<div class="wxts">
								<p><i class="el-info-circled"></i> 贴心提示：</p>
								<p>1、您的房源发布任务已经开始。</p>
								<p>2、发布过程根据网络情况需要几分钟之内完成</p>
								<p>3、成功发布的信息将会即时出现在发布成功记录中，您可以随时查看。</p>
							</div>
							<div class="fscg text-center">
								您选中了<a href="#">1</a>条房源发布到<a href="#">1</a>个网站，小秘书为您创建了<a href="#">1</a>个发布任务，正在排队发布，点击“发布日志查”看详情。

							</div>
							<div class="pull-right">
								<a href="#" class="btn btn-secondary">发布日志</a>
								<a href="#" class="btn btn-secondary">发布统计</a>
								<a href="#" class="btn btn-secondary">继续发布</a>
							</div>
							<div class="clearfix"></div>
						</div>

						<!-- Tabs Pager -->
						<ul class="pager wizard">
							<li class="previous" style="display: none;">
								<a href="javascript:void();" onclick="initShouCang();"><i class="fa-angle-double-left"></i> 上一步</a>
							</li>

							<li class="next" style="display: none;">
								<a href="#">下一步 <i class="fa-angle-double-right"></i></a>
							</li>
						</ul>
						<div class="clearfix"></div> 
					</div>

				</form>

			</div>
		</div>
		<div class="go-up" style="position: fixed;right: 15px; bottom: 10px; z-index: 9999;">
			<a href="#" rel="go-top" style="font-size: 24px;">
				<i class="fa-angle-up"></i>
			</a>
		</div>

		<!-- Bottom Scripts -->
		<script src="../assets/js/bootstrap.min.js"></script>
		<script src="../assets/js/TweenMax.min.js"></script>
		<script src="../assets/js/resizeable.js"></script>
		<script src="../assets/js/joinable.js"></script>
		<script src="../assets/js/xenon-api.js"></script>
		<script src="../assets/js/xenon-toggles.js"></script>
		<script src="../assets/js/moment.min.js"></script>
		<!-- Imported scripts on this page -->
		<script src="../assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
		<script src="../assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>

		<!-- Imported scripts on this page  xiala-->
		<link rel="stylesheet" href="../assets/js/daterangepicker/daterangepicker-bs3.css">
		<link rel="stylesheet" href="../assets/js/select2/select2.css">
		<link rel="stylesheet" href="../assets/js/select2/select2-bootstrap.css">
		<link rel="stylesheet" href="../assets/js/multiselect/css/multi-select.css">

		<script src="../assets/js/jquery-validate/jquery.validate.js"></script>
		<script src="../assets/js/inputmask/jquery.inputmask.bundle.js"></script>
		<script src="../assets/js/formwizard/jquery.bootstrap.wizard.min.js"></script>
		<script src="../assets/js/datepicker/bootstrap-datepicker.js"></script>
		<script src="../assets/js/multiselect/js/jquery.multi-select.js"></script>

		<script src="../assets/js/rwd-table/js/rwd-table.js"></script>
		<script src="../assets/js/daterangepicker/daterangepicker.js"></script>
		<script src="../assets/js/datepicker/bootstrap-datepicker.js"></script>
		<script src="../assets/js/timepicker/bootstrap-timepicker.min.js"></script>
		<script src="../assets/js/colorpicker/bootstrap-colorpicker.min.js"></script>
		<script src="../assets/js/select2/select2.min.js"></script>

		<link rel="stylesheet" href="../assets/js/datepicker/bootstrap-datetimepicker.min.css">
		<!-- Imported scripts on this page  xiala-->
		<script type="text/javascript" src="../assets/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script>
		<script type="text/javascript" src="../assets/js/datepicker/bootstrap-datetimepicker.zh-CN.js"></script>
		<!-- JavaScripts initializations and stuff -->

		<!-- Imported scripts on this page  xiala-->
		<script src="../assets/js/rwd-table/js/rwd-table.js"></script>
		<script src="../assets/js/jquery-ui/jquery-ui.min.js"></script>
		<script src="../assets/js/selectboxit/jquery.selectBoxIt.min.js"></script>

		<!-- BEGIN PAGE LEVEL SCRIPTS -->
<%--		<script src="../assets/js/app.js"></script>
		<script src="../assets/js/table-advanced.js"></script>--%>

		<script src="../assets/js/xenon-custom.js"></script>

		<script>
			/*jQuery(document).ready(function($) {
				$(".sboxit-2").selectBoxIt({
					showFirstOption: false
				}).on('open', function() {
					// Adding Custom Scrollbar
					$(this).data('selectBoxSelectBoxIt').list.perfectScrollbar();
				});
				//initChooseSite();
				//alert(222)
			});
			jQuery(document).ready(function() {
				App.init();
				TableAdvanced.init();
			});*/
			
			<%-- function initChooseSite(){
				var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/getFangYuanRelease/";
				var requestParameter=new Object();
				requestParameter.userId= <%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>;
				requestParameter.businessType="fangyuan_chuzu";
				requestParameter.houseType=houseType;
				requestParameter.status=status;
				requestParameter.qyValue=qyValue;
				obj.requestParameter=requestParameter;
				var jsonData=JSON.stringify(obj);
				var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
				var resultObj = $.parseJSON(result.responseText);
				$('#shangjiaTable tbody').loadTemplate("#shangjiaTemplate");
			} --%>
		</script>

	</body>

</html>

<!-- 查看-->
<div class="modal fade" id="Chakan" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<table class="table table-bordered table-hover table-model-2" id="chakanTable">
					<thead>
						<tr>
							<th class="text-center" width="50">
								<input type="checkbox" onclick="checkAll(this,'cbUnderCarriage')" id="cbUnderCarriageId">
							</th>
							<th class="text-center">发布网站</th>
							<th class="text-center">发布时间</th>
							<th class="text-center">本地操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="delAllPushlish();">批量下架</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>

<!-- 发布中 下架-->
<div class="modal fade" id="xiajiaModal">
	<input type="hidden" id="scId" value="" />
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">下架</h4>
			</div>
			<div class="modal-body">
				请确定是否下架所选择的房源？
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="multiUnderCarriage()">确认</button>
				<button type="button" class="btn btn-red" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>


<!-- 发布中 批量删除 -->
<div class="modal fade" id="pdeleteModal">
	<input type="hidden" id="scId" value="" />
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">删除</h4>
			</div>
			<div class="modal-body">
				请确定是否从发布列表中删除所选房源？
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="delFromPublish(scId);">确认</button>
				<button type="button" class="btn btn-red" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>

<!-- 草稿箱列表删除  -->
<div class="modal fade" id="shoucangModal">
	<input type="hidden" id="scId" value="" />
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">删除</h4>
			</div>
			<div class="modal-body">
				已选中（1）条记录，是否确定立即删除？
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="updateStatus(1);">确认</button>
				<button type="button" class="btn btn-red" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>


<!-- 从回收站彻底删除 -->
<div class="modal fade" id="recycleModal">
	<input type="hidden" id="deleteType" value="" />
	<input type="hidden" id="scId" value="" />
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">删除</h4>
			</div>
			<div class="modal-body">
				确定是否删除所选房源？
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="deleteD();">确认</button>
				<button type="button" class="btn btn-red" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>


<!-- 还原  -->
<div class="modal fade" id="huanyuanModal">
	<input type="hidden" id="scId" value="" />
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">删除</h4>
			</div>
			<div class="modal-body" id="backUpCount">
				已选中（1）条记录，确定是否还原？
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="updateStatus(2);">确认</button>
				<button type="button" class="btn btn-red" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>


<!-- 清空回收站  -->
<div class="modal fade" id="emptyRecycleModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">删除</h4>
			</div>
			<div class="modal-body">
				确认清空回收站？
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="emptyRecycle();">确认</button>
				<button type="button" class="btn btn-red" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>

<!-- 上架BMS房源之后 确定是否要跳转到BMS  -->
<div class="modal fade" id="jumpModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<input type="hidden" id="jumpHref" value=""/>
			<a href="#" class="jumpUrl" style="display: none;"></a>
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">跳转</h4>
			</div>
			<div class="modal-body" id="errorMsg">
			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="returnModify();">返回修改</button>
				<button type="button" class="btn btn-red" data-dismiss="modal">确认</button>
			</div>
		</div>
	</div>
</div>

<!-- 选择网站模板 -->
<script type="text/html" id="shangjiaTemplate">
<tr>
	<td class="middle-align">
		<input type="checkbox" name="uids" class="cbr cbr-done" data-value="pid">
	</td>
	<td class="middle-align"><img data-src="logo" style="width: 120px;height: 50px;"></td>
	<td class="middle-align">
		<div class="line24"><span data-content="username"></span></div>
	</td>
	<td class="middle-align">
		<%--<select class="form-control pull-left" aria-invalid="false">
			<option>补发送</option>
			<option>删除旧房源再发送</option>
		</select>--%>
	</td>
	<td class="middle-align">
		<%--<select class="form-control pull-left" aria-invalid="false">
			<option>补发送</option>
			<option>强制发送</option>
		</select>--%>
	</td>
</tr>
</script>

											
<!-- 发布中模板 -->
<script type="text/html" id="publishTemplate">
	<tr id ="pubid">
	<td class="middle-align text-center" colspan="1" data-columns="publishTable-col-0">
		<input type="checkbox" class="cbr" data-value="id" name="rids">
	</td>
	<td class="middle-align text-center" colspan="1" data-columns="publishTable-col-1">
        <div class="line24" data-content="housenumber" data-format="houseNumberFormatter"></div>
    </td>
	<td class="middle-align text-center" colspan="1" data-columns="publishTable-col-2">
		<div class="pic-fy" data-content="cover" data-format="imgFormatter"></div>
	</td>
	<td class="middle-align" data-priority="1" colspan="1" data-columns="publishTable-col-3">
		<div class="pull-left">
			<div class="line24"><span class="label label-red pull-left">新</span>
					<span data-content="title" data-format="urlFormatter"></span> 
			</div>
			<div class="line24"><div class="div_y" data-alt="address"><span data-content="address"></span></div>&nbsp;<span data-content="cityId"></span>&nbsp;<span data-content="qyId"></span>&nbsp;<span data-content="sqId"></span></div>
			<div class="line24" data-content="price" data-format="priceFormatter"></div>
			<div class="line24"><span data-content="rooms"></span>&nbsp;<span data-content="area" data-format="areaFormatter"></span>&nbsp;<span data-content="floor"><span></div>
		</div>
		<div class="clearfix"></div>
	</td>
	<td class="middle-align text-center" data-priority="2" colspan="1" data-columns="publishTable-col-4">
		<div class="line24"><spa data-content="yfbCount"></spa>/<spa data-content="sjCount"></spa></div>
		<div><a href="javascript:;" class="btn btn-secondary btn-xs" onclick="lookPushlish(this);jQuery('#Chakan').modal('show', {backdrop: 'fade'});">查看</a></div>
	</td>
	<td class="middle-align text-center" data-priority="3" colspan="1" data-columns="publishTable-col-5">
		<div class="line24" data-content="updatetime" data-format="dateFormatter"></div>
	</td>
	<td class="middle-align text-center" data-priority="4" colspan="1" data-columns="publishTable-col-6">
		<div class="line24" data-content="tsTime" data-format="dateFormatter"></div>
	</td>
	<td class="middle-align text-center" data-priority="5" colspan="1" data-columns="publishTable-col-7">
		<div class="line24" data-content="yfbCount" data-format="yfbCountFormatter"></div>
	</td>
	<td class="middle-align text-center" data-priority="6" colspan="1" data-columns="publishTable-col-8">
		<div class="line24" data-content="source"></div>
	</td>
	<td class="middle-align text-center" colspan="1" data-columns="publishTable-col-9">
		<span data-content="crawlId" data-format="shouFormatter"></span>
	</td>
</tr>
</script>

<!-- 收藏模板 -->
<script type="text/html" id="shouCangTemplate">
<tr>
<td class="middle-align text-center" colspan="1" data-columns="shouCangTable-col-0">
	<input type="checkbox" class="cbr" name="cbDraftsName">
</td>
<td class="middle-align text-center" colspan="1" data-columns="shouCangTable-col-1">
    <div class="line24" data-content="housenumber" data-format="houseNumberFormatter"></div>
</td>
<td class="middle-align text-center" colspan="1" data-columns="shouCangTable-col-2">
	<div class="pic-fy" data-content="cover" data-format="imgFormatter"></div>
</td>
<td class="middle-align" data-priority="1" colspan="1" data-columns="shouCangTable-col-3">
	<div class="pull-left">
		<div class="line24 div_y1"><span class="label label-red pull-left">新</span><a class="f18" target="_blank" data-alt="title" data-content="title"></a></div>
		<div class="line24"><div class="div_y" data-alt="address"><span data-content="address"></span></div>&nbsp;<span data-content="cityId"></span>&nbsp;<span data-content="qyId"></span>&nbsp;<span data-content="sqId"></span></div>
		<div class="line24" data-content="price" data-format="priceFormatter"></div>
		<div class="line24"><span data-content="rooms"></span>&nbsp;<span data-content="area" data-format="areaFormatter"></span>&nbsp;<span data-content="floor"><span></div>
	</div>
	<div class="clearfix"></div>
</td>
<td class="middle-align text-center" data-priority="2" colspan="1" data-columns="shouCangTable-col-4">
	<div class="line24" data-content="createtime" data-format="dateFormatter">2015-11-11</div>
</td>
<td class="middle-align text-center" data-priority="2" colspan="1" data-columns="shouCangTable-col-5"> <!--来源-->
	<div class="line24" data-content="source"></div>
</td>
<td class="middle-align text-center" colspan="1" data-columns="shouCangTable-col-6">
	<span data-content="crawlId" data-format="shouFormatter"></span>
	<br>
	<span data-content="id" data-format="deleteShouFormatter"></span>
	<br>
</td>
</tr>
</script>

<!-- 回收站 -->
<script type="text/html" id="recycleTemplate">
<tr>
<td class="middle-align text-center" colspan="1" data-columns="recyleTable-col-0">
	<input type="checkbox" class="cbr" data-value="id" name="cbRecycleName">
</td>
<td class="middle-align text-center" colspan="1" data-columns="recyleTable-col-1">
    <div class="line24" data-content="housenumber" data-format="houseNumberFormatter"></div>
</td>
<td class="middle-align text-center" colspan="1" data-columns="recyleTable-col-2">
	<div class="pic-fy" data-content="cover" data-format="imgFormatter"></div>
</td>
<td class="middle-align" data-priority="1" colspan="1" data-columns="recyleTable-col-3">
	<div class="pull-left">
		<div class="line24"><span class="label label-red pull-left">新</span><a class="f18" target="_blank" data-content="title"></a></div>
		<div class="line24"><div class="div_y" data-alt="address"><span data-content="address"></span></div>&nbsp;<span data-content="cityId"></span>&nbsp;<span data-content="qyId"></span>&nbsp;<span data-content="sqId"></span></div>
		<div class="line24" data-content="price" data-format="priceFormatter"></div>
		<div class="line24"><span data-content="rooms"></span>&nbsp;<span data-content="area" data-format="areaFormatter"></span>&nbsp;<span data-content="floor"><span></div>
	</div>
	<div class="clearfix"></div>
</td>
<td class="middle-align text-center" data-priority="2" colspan="1" data-columns="recyleTable-col-4"> <!--来源-->
		<div class="line24" data-content="source"></div>
</td>
<td class="middle-align text-center" data-priority="3" colspan="1" data-columns="recyleTable-col-5">
	<div class="line24" data-content="collecttime" data-format="dateFormatter">2015-11-11</div>
</td>
<td class="middle-align text-center" data-priority="4" colspan="1" data-columns="recyleTable-col-6">
	<div class="line24" data-content="createtime" data-format="dateFormatter"></div>
</td>
<td class="middle-align text-center" data-priority="5" colspan="1" data-columns="recyleTable-col-7">
	<div class="line24" data-content="ucCause"></div>
</td>
<td class="middle-align text-center" colspan="1" data-columns="recyleTable-col-8">
	<span data-content="ucCause" data-format="huanyuanFormatter"></span>
	<br>
	<span data-content="id" data-format="deleteRecycleFormatter"></span>
	<br>
</td>
</tr>
</script>

<!-- 查看 -->
<script type="text/html" id="lookTemplate">
<tr>
	<td class="text-center">
		<input type="checkbox" class="cbr" name="cbUnderCarriage" data-value="id">
	</td>
	<td class="text-center" data-content="name">58同城</td>
	<td class="text-center" data-content="createtime" data-format="dateFormatter">2015-11-13 14:34:48</td>
	<td class="text-center">
		<input name="fids" type="hidden" data-value="id"/>
		<a href="javascript:;" class="btn btn-secondary btn-xs" onclick="delRowPushlish(this);">下架</a>
		<a data-href="url" target="_blank" class="btn btn-secondary btn-xs">浏览</a>
	</td>
</tr>
</script>

<script type="text/javascript">
$("#menu0202").addClass("active expanded");
$("#menu0202").parent().show();

var uid = "<%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>";
var username = "<%=SecurityUserHolder.getCurrentUserLogin().getUserLogin().getUsername()%>";
var cityId = "<%=SecurityUserHolder.getCurrentUserLogin().getCityId()%>";
var provinceId = "<%=SecurityUserHolder.getCurrentUserLogin().getProvinceId()%>";
var cityName = "";

$(function(){
	buildPro();
});

function buildPro(){
	$.ajax({ 
		url: "<%=basePath%>/cam/campus!getCity.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"pid" : provinceId},
		success: function(data){
			//var pHtml = '<span>省份/州：</span><a href="javascript:buildCity(0,true)" class="mr10 active" data-id="0">不限</a>';
			$.each(data, function(i,n){
				if(n.id==cityId){
					cityName=n.cityName;
				}
				/*if(i % 8 == 0 && i > 0) {
					pHtml += "<br>";
				}
				pHtml += '<a href="javascript:buildCity(\''+n.id+'\',true)" class="mr10" data-id="'+n.id+'" dataValue="'+n.pname+'">'+n.pname+'</a>';
				*/
			});
			//$("#pro").html(pHtml);
	    }
	});
}

/* 为分页控件绑定事件 */
var historyPageIndex;
function bindPageEvent(){
	var links = $("#macPageWidget li").find("a");
	$.each(links, function(i, link1){
		var link = $(link1);
		var pageNum = link.attr("pageNum");
		link.click(function(){
			jumpPage(pageNum);
		});
	}); 
}
function jumpPage(pageNum){
	historyPageIndex=pageNum;
	initShouCang(pageNum); 
}

var xhjhType='${param.hType}';

function doShow(thiz){
	$("#houseType li").removeClass("active");
	$(thiz).parent().addClass("active");
	$('.onsubing').show();
	//$("#publish").click();
	setTimeout("$('.onsubing').hide();",200);
	initShouCang(); 
	cancelAllCheck();
	initXinzengFangyuan($(thiz).attr('data-val'));
	xhjhType=$(thiz).attr('data-val');
}

//初始化新增房源
function initXinzengFangyuan(hType){
	$('#xinzengfangyuan').attr('href','rentForm.jsp?from=3&hType='+hType);
}

function selectStatus(thiz){
	$("#fromlist input[name='status']").val($(thiz).attr("data-val"));
	selectStyle(thiz);
	filterAll();
	initShouCang(); 
	cancelAllCheck();
}

function queryFangRelease(op){
	initShouCang(null,op); 
}

String.prototype.endsWith = function(str){
	return (this.match(str+"$")==str)
}

function selectQuYu(thiz){
	var qyValue = $(thiz).attr("data-val");
	$("#fromlist input[name='qyValue']").val(qyValue);
	selectStyle(thiz);
	initShouCang(); 
	cancelAllCheck();
}

function selectStyle(thiz){
	$(thiz).parent().find("a.active").toggleClass("active");
	$(thiz).toggleClass("active");
}

function xiajia(){
	var dids = [];
	$("#publishTable input[name='rids']:checked").each(function(){
		var id = $(this).val();
		dids.push(id);
	});
	if(dids.length == 0){
		alert("请选择要下架的房源");
		return ;
	}
	openXiajia(dids);
}

function pdelete(){
	var dids = "";
	$("#publishTable input[name='rids']:checked").each(function(){
		var id = $(this).val() + ",";
		dids += id;
	});
	if(dids == ""){
		alert("请选择要删除的房源");
		return ;
	}else{
		dids = dids.substring(0,dids.length-1);
	}
	openRecycle(dids,1);
//	openPdelete(dids);
}

function initShouCang(pageNum){

	if($("#publish").hasClass("active")){
		$("#sjStatusId").show();
	}else{
		$("#sjStatusId").hide();
	}

	$('.onsubing').show();
	$("#fwv-1").addClass("active");
	$("#fwv-1").show();
	$("#fwv-2").removeClass("active");
	$("#fwv-2").hide();
	$("#chooseFang").parent().addClass("active");
	$("#chooseSite").parent().removeClass("active");
	$(".pager .previous").hide();
	
	var status = $("#fromlist input[name='status']").val();
	var qyValue = $("#fromlist input[name='qyValue']").val();
	
	var obj=new Object();
	if(pageNum==undefined || pageNum==null)
		pageNum=1;
    var pageInfo=new Object();
    pageInfo.page=pageNum;
    obj.pageInfo=pageInfo;
	
    var houseType = $("#houseType .active a").attr("data-val");
    var searchKey = $("#searchKey").val();
	var source = $("#source").val();
	var sjstatus = $("#sjstatus").val();
    
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/getAllFangYuanRelease/";
	var requestParameter=new Object();
	requestParameter.userId= <%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>;
	requestParameter.businessType="fangyuan_chuzu";
	requestParameter.houseType=houseType;
	requestParameter.status=status;
	requestParameter.qyValue=qyValue;
	requestParameter.lpName=searchKey;
	requestParameter.source=source;
	requestParameter.sjstatus=sjstatus;
	requestParameter.cityValue=cityName;
	obj.requestParameter=requestParameter;
	var jsonData=JSON.stringify(obj);
	var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
	var resultObj = $.parseJSON(result.responseText);
	$.addTemplateFormatter({
		dateFormatter : function(value, template) {
			if(value == null){
				return "";
			}
			var newDate = new Date();
			newDate.setTime(value);
			return newDate.format("yyyy-MM-dd hh:mm:ss");
	    },
	    timeFormatter : function(value, template) {
			var newDate = new Date();
			newDate.setTime(value);
			return  newDate.format("yyyy-MM-dd hh:mm:ss");
	    },
	    shouFormatter : function(value, template) {
			var businessType=$("#houseType li.active a").attr("data-val");
			var url = "<%=basePath%>/crawl/rentForm.jsp?type=fangyuan_chuzu&id="+value+"&hType="+businessType;
	    	return '<a href="'+url+'" class="btn btn-secondary btn-xs">修改</a>';
	    },
	    deleteShouFormatter : function(value, template) {
	    	return '<a href="javascript:void(0);" class="btn btn-secondary btn-xs" style="margin-top: 2px;" onclick="openShouCang('+value+');">删除</a>';
	    },
	    deleteRecycleFormatter : function(value, template) {
	    	return '<a href="javascript:void(0);" class="btn btn-secondary btn-xs" style="margin-top: 2px;" onclick="openRecycle('+value+',2);">删除</a>';
	    },
	    huanyuanFormatter : function(value, template) {
			if(value == '个人下架' || value == '' || value == null){
				return '<a href="javascript:void(0);" onclick="openHuanYuanThiz(this);" class="btn btn-secondary btn-xs">还原</a>';
			}
	    },
	    urlFormatter : function(title,  template) {
	    	return '<a  href="#" target="_blank" id="urlid" title="'+title+'" class="btn btn-secondary btn-xs" style="margin-top: 2px;">' + title.substring(0,22) + '...</a>';
	    },
		yfbCountFormatter:function(value,  template) {
			return value != 0 ? "上架":"下架";
		},
		imgFormatter: function(value,template){
			if($.trim(value) == ""){
				return '<img src="../assets/images/user-4.png"/>';
			}else{
				/* var valueSplit = value.split(',');
				if(valueSplit.length > 0){
					var imgURL = "http://imgbms.xhjfw.com/"+valueSplit[0];
					return '<img src="'+imgURL+'"/>';
				}else{
					return '<img src="../assets/images/user-4.png"/>';
				} */
				var imgURL = "http://imgbms.xhjfw.com/"+value;
				return '<img src="'+imgURL+'"/>';
			}
		},
		priceFormatter:function(value,template){
			var valueStr = "";
			if(null != value && $.trim(value) != "" && $.trim(value) != "面议"){
				if(value.indexOf("万")>0 || value.indexOf("元/月")>0){
					valueStr = value;
				}else{
					valueStr = value + "元/月";
				}
			}else{
				valueStr = "价格面议";
			}
			return valueStr;
		},
		areaFormatter:function(value,template){
			var valueStr = "";
			if(null != value && $.trim(value) != ""){
				if(value.indexOf("㎡")>0){
					valueStr = value;
				}else{
					valueStr = value + "㎡";
				}
			}else{
				valueStr = "面积不详";
			}
			return valueStr;
		},
		houseNumberFormatter:function(value,template){
			var valueStr = "";
			if(null != value && value!=""){
				valueStr = value;
			}else{
				valueStr = "无";
			}
			return valueStr;
		}
		
	});
	
	var body ;
	var grid = resultObj.gridModel;
	if(grid == null){
		grid = [];
	}
	
	$("#paginationId").remove();
	var paginationHtml = '<div style="float:right;" id="paginationId">' +
		'<input id="pageNum" name="pageNum" type="hidden" value="10">'+
		'<div id="macPageWidget"></div>' +
		'<div class="clearfix"></div>'+
		'<div class="clear"></div>'+
	 	'</div>';
	if(status == '0'){
		$('#publishTable tbody').loadTemplate("#publishTemplate", grid);
		body = $("#publishTable tbody tr");
		$('#publishClassId').append(paginationHtml);
	}else if(status == '1'){
		$('#shouCangTable tbody').loadTemplate("#shouCangTemplate", grid);
		body = $("#shouCangTable tbody tr");
		$('#draftsClassId').append(paginationHtml);

	}else{//status :2
		//alert(status)
		$('#recyleTable tbody').loadTemplate("#recycleTemplate", grid);
		body = $("#recyleTable tbody tr");
		$('#recycleClassId').append(paginationHtml);

	}
	
	var len = grid.length;
	if(status == '0'){
		for(var i = 0 ; i < len; i++){
			$(body).eq(i).find("a").eq(0).attr('href','javascript:void(0)');
		}
	}else{
		for(var i = 0 ; i < len; i++){
			$(body).eq(i).find("a").eq(0).attr('href',resultObj.gridModel[i].url);
		}
	}
	var businessType=$("#houseType li.active a").attr("data-val");
	if(status == '0'){
		for(var i = 0 ; i < len; i++){
			if(resultObj.gridModel[i].crawlId == '0'){
				var updateBMSUrl = "<%=basePath%>/crawl/rentForm.jsp?type=fangyuan_chuzu&id="+resultObj.gridModel[i].crawlId+"&houseNumber="+resultObj.gridModel[i].housenumber+"&hType="+ businessType;
				updateBMSUrl += "&scId="+ resultObj.gridModel[i].id;
				$(body).eq(i).find("a").eq(2).attr('href',updateBMSUrl);
			}
		}
	}else if(status == '1'){
		for(var i = 0 ; i < len; i++){
			if(resultObj.gridModel[i].crawlId == '0'){
				var updateBMSUrl = "<%=basePath%>/crawl/rentForm.jsp?type=fangyuan_chuzu&id="+resultObj.gridModel[i].crawlId+"&houseNumber="+resultObj.gridModel[i].housenumber+"&hType="+ businessType;
				updateBMSUrl += "&scId="+ resultObj.gridModel[i].id;
				$(body).eq(i).find("a").eq(1).attr('href',updateBMSUrl);
			}
		}
	}
	
		
	
	// 分页.
	$('#macPageWidget').html(pagination(resultObj.page, resultObj.total));
	bindPageEvent();
	
		//	console.log(historyPageIndex);
	// 分页高亮.
	if(historyPageIndex==undefined || historyPageIndex==null){
		historyPageIndex = 1;
	}
	$("#macPageWidget li a[pagenum='"+historyPageIndex+"']").addClass("pageOpen");
	cancelAllCheck();
	filterAll();

	setTimeout("$('.onsubing').hide();",200);
}


function openXiajia(scId){
	$("#xiajiaModal #scId").val(scId);
	$('#xiajiaModal').modal('show', {backdrop: 'fade'});
}

function callXJ(scId){
	$("#xiajiaModal #scId").val(scId);
	$('#xiajiaModal').modal('show', {backdrop: 'fade'});
}

function openPdelete(scId){
	/* $("#huanyuanModal #scId").val(scId);
	$('#huanyuanModal').modal('show', {backdrop: 'fade'}); */
	$("#pdeleteModal #scId").val(scId);
	$('#pdeleteModal').modal('show', {backdrop: 'fade'});
}

function openHuanYuanThiz(thiz){
	var id = $(thiz).parents('tr').find("input[name='cbRecycleName']").val();
	openHuanYuan(id);
}

function openHuanYuan(scId){
	var scIdStr = scId + "";
	var scIdArr = [];
	scIdArr = scIdStr.split(",");
	var scIdCount = scIdArr.length;
	var tips = "已选中（"+scIdCount+"）条记录，确定是否还原？";
	$("#backUpCount").text(tips);
	$("#huanyuanModal #scId").val(scIdStr);
	$('#huanyuanModal').modal('show', {backdrop: 'fade'});
}
function openShouCang(scId){
	$("#shoucangModal #scId").val(scId);
	$('#shoucangModal').modal('show', {backdrop: 'fade'});
}

function openRecycle(scId,type){
	$("#recycleModal #scId").val(scId);
	$("#recycleModal #deleteType").val(type);
	$('#recycleModal').modal('show', {backdrop: 'fade'});
}

function openEmptyRecycle(){
	$('#emptyRecycleModal').modal('show', {backdrop: 'fade'});
}

function deleteD(){
	var requestParameter=new Object();
	var scId = $("#recycleModal #scId").val();
	var type = $("#recycleModal #deleteType").val();
	requestParameter.id = scId;
	requestParameter.businessType="fangyuan_chuzu";
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/deleteFangYuanRelease/";
	if(type == 1){
		requestParameter.status=2;
		requestParameter.pstatus=0;
		requestParameter.stressValue=0;
		url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/updateFangYuanRelease/";
	}
	var obj = new Object();
	obj.requestParameter=requestParameter;
	var jsonData=JSON.stringify(obj);
	var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
	$('#recycleModal').modal("hide");
	if(result.responseText == 1){
		alert("删除成功!");
	}else{
		alert("删除失败!");
	}
	
	initShouCang();
}

function updateStatus(type){//type : 0
	var obj=new Object();
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/updateFangYuanRelease/";
	var requestParameter=new Object();
	if(type == 1){
		var scId = $("#shoucangModal #scId").val();
		requestParameter.id=scId;
		requestParameter.status=2;
		requestParameter.pstatus=1;
		requestParameter.businessType="fangyuan_chuzu";
		obj.requestParameter=requestParameter;
		var jsonData=JSON.stringify(obj);
		var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
		$('#shoucangModal').modal("hide");
		if(result.responseText == 1){
			alert("删除成功!");
		}else{
			alert("删除失败!");
		}
	}else if(type ==2){//huanyuan
		var scId = $("#huanyuanModal #scId").val();
		requestParameter.id=scId;
		/* alert("requestParameter.scId "+requestParameter.id); */
		requestParameter.status=1;
		requestParameter.pstatus=2;
		requestParameter.businessType="fangyuan_chuzu";
		obj.requestParameter=requestParameter;
		var jsonData=JSON.stringify(obj);
		var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
		$('#huanyuanModal').modal("hide");
		if(result.responseText == 1){
			alert("还原成功!");
		}else if(result.responseText == 2){
			alert("存在房源编号的房源不能还原!");
		}else{
			alert("还原失败!");
		}
	}
	initShouCang();
}

function shangjia(status){
	$('.onsubing').show();
	if(status == '0'){
		var rids = [];
		$("#publishTable input[name='rids']:checked").each(function(){
			var id = $(this).val();
			rids.push(id);
		});
		
		if(rids.length != 1){
			setTimeout("$('.onsubing').hide();",200);
			bootbox.alert({title:"提示",message:"必须选择一条房源!"});
			return ;
		}
		$('#chooseID li:eq(0)').removeClass("active");
		$('#chooseID li:eq(1)').addClass("active");
		$("#fwv-1").hide();
		$("#fwv-1").removeClass("active");
		$("#fwv-2").show();
		$("#fwv-2").addClass("active");
		
		$.addTemplateFormatter({
			dateFormatter : function(value, template) {
				var newDate = new Date();
				newDate.setTime(value);
				return newDate.format("yyyy-MM-dd hh:mm:ss");
		    },
		    timeFormatter : function(value, template) {
				var newDate = new Date();
				newDate.setTime(value);
				return newDate.format("yyyy-MM-dd hh:mm:ss");
		    },
		    shouFormatter : function(value, template) {
		    	var url = "<%=basePath%>/crawl/rentForm.jsp?type=fangyuan_chuzu&id="+value;
		    	return '<a href="'+url+'" class="btn btn-secondary btn-xs">修改</a>';
		    },
		    deleteShouFormatter : function(value, template) {
		    	return '<a href="javascript:void(0);" class="btn btn-secondary btn-xs" style="margin-top: 2px;" onclick="openShouCang('+value+');">删除</a>';
		    },
		});
		
		/*$("#chooseFang").parent().addClass("completed");
		$(".progress-indicator").css("width","49.9577%");*/
		$(".pager .previous").removeClass("disabled");
		$(".previous").show();

		var resultObj = onPushlish();
		setTimeout("$('.onsubing').hide();",200);
		
		// 分页.
		$('#macPageWidget').html(pagination(resultObj.page, resultObj.total));
		bindPageEvent();
		
			//	console.log(historyPageIndex);
		// 分页高亮.
		if(historyPageIndex==undefined || historyPageIndex==null){
			historyPageIndex = 1;
		}
		$("#macPageWidget li a[pagenum='"+historyPageIndex+"']").addClass("pageOpen");
	}else{
		var uids = [];
		$("#shangjiaTable input[name='uids']:checked").each(function(){
			var id = $(this).val();
			uids.push(id);
		});
		if(uids.length < 1){
			bootbox.alert({title:"提示",message:"请配置网站账号,再发布!"});
			setTimeout("$('.onsubing').hide();",200);
			return;
		}
		if(uids == 0){
			bootbox.alert({title:"提示",message:"请勾选网站,再发布!"});
			setTimeout("$('.onsubing').hide();",200);
			return;
		}

		var rids = [];
		$("#publishTable input[name='rids']:checked").each(function(){
			var id = $(this).val();
			rids.push(id);
		});
		var url = cloudPlatformUrl+"/services/newenv/cloub/source_58/postservice/";
		var obj=new Object();
		var bean=new Object();
		bean.uids=uids;
		bean.rids=rids;
		bean.businessType = "fangyuan_chuzu";
		obj.bean=bean;
		var jsonData=JSON.stringify(bean);
		var result = $.ajax({
			url : url,
			async : true,
			dataType : "json",
			data:jsonData,
			type : "POST",
			contentType : "application/json; charset=utf-8",
			success : function(resultObj){
				if(resultObj.status == "error"){
					setTimeout("$('.onsubing').hide();",200);
					initShouCang();
					var msg = resultObj.msg;
					var jumpHref = "";
					if(null != resultObj.fangYuanChuZuRelease.houseNumber || "" != resultObj.fangYuanChuZuRelease.houseNumber){
						jumpHref = "rentForm.jsp?type=fangyuan_chuzu&id=0&houseNumber="+resultObj.fangYuanChuZuRelease.houseNumber+"&hType="+resultObj.fangYuanChuZuRelease.type+"&scId="+resultObj.fangYuanChuZuRelease.id;
					}
					if(null != resultObj.fangYuanChuZuRelease.crawlId || "" != resultObj.fangYuanChuZuRelease.crawlId){
						jumpHref = "rentForm.jsp?type=fangyuan_chuzu&id="+resultObj.fangYuanChuZuRelease.crawlId+"&hType="+resultObj.fangYuanChuZuRelease.type;
					}
					if(null != resultObj.fangYuanChuZuRelease.crawlId || "" != resultObj.fangYuanChuZuRelease.crawlId){
						jumpHref = "rentForm.jsp?type=fangyuan_chuzu&id="+resultObj.fangYuanChuZuRelease.crawlId+"&hType="+resultObj.fangYuanChuZuRelease.type+"&scId="+resultObj.fangYuanChuZuRelease.id;
					}
					$("#jumpHref").val(jumpHref);
					$("#errorMsg").html(msg);
					$('#jumpModal').modal('show', {backdrop: 'fade'});
				}else if(resultObj.status == "ok"){
					setTimeout("$('.onsubing').hide();",200);
					initShouCang();
					bootbox.alert({title:"提示",message:resultObj.msg});
				}else if(resultObj.status == "jump"){
					setTimeout("$('.onsubing').hide();",200);
					var msg = resultObj.msg;
					msg = msg.replace(/<b>/ig,"\\\n");
					msg = msg.replace(/<\/b>/ig,"");
					msg = msg.replace(/<\/br>/ig,"");
					msg = msg.replace(/\\/ig,"");
					/* msg = msg.replace(/<.*?>/ig,""); */
					alert(msg);
					golistMyRent();
				}
			},
			error: function(e) {
				setTimeout("$('.onsubing').hide();",200);
			}
		});
	}
	cancelAllCheck();
}

function onPushlish(){
	var result = $.ajax({
		url : cloudPlatformUrl+"/services/newenv/cloub/source_site/list?uid="+uid+"&state=1&status=1",
		async : false,
		dataType : "json",
		type : "GET",
		contentType : "application/json; charset=utf-8",
		success : function(obj){
			$('#shangjiaTable tbody').loadTemplate("#shangjiaTemplate", obj.result);
		}
	});
	var resultObj = $.parseJSON(result.responseText);
	var rids = [];
	$("#publishTable input[name='rids']:checked").each(function(){
		var id = $(this).val();
		rids.push(id);
	});
	var bean=new Object();
	bean.rids=rids;
	bean.businessType = "fangyuan_chuzu";
	var houseNumber = $.ajax({
		url : cloudPlatformUrl+"/services/newenv/lpzd/crawl/queryHouseNumber/",
		async : false,
		dataType : "json",
		type : "POST",
		data : JSON.stringify(bean),
		contentType : "application/json; charset=utf-8",
	});
	var xhjValue = "";
	if(typeof(houseNumber.responseJSON) == "undefined" || houseNumber.responseJSON == null){
		
	}else{
		if(houseNumber.responseJSON.status == true){
			if(typeof(result.responseJSON) == "undefined" || result.responseJSON == null){
				
			}else{
				if(result.responseJSON.result.length > 0){
					for(var i = 0;i < result.responseJSON.result.length;i++){
						if(result.responseJSON.result[i].id == "6"){
							xhjValue = result.responseJSON.result[i].pid;
						}
					}
				}
			}
			//别墅类型不选中
			if(xhjhType!='4'){
				$("#shangjiaTable :checkbox[value='"+xhjValue+"']").prop("checked","checked");
			}
			$("#shangjiaTable :checkbox[value='"+xhjValue+"']").attr("disabled","true");
		}else{
		if(typeof(result.responseJSON) == "undefined" || result.responseJSON == null){
			
		}else{
			if(result.responseJSON.result.length > 0){
				for(var i = 0;i < result.responseJSON.result.length;i++){
					if(result.responseJSON.result[i].id == "6"){
						xhjValue = result.responseJSON.result[i].pid;
					}
				}
			}
		}
			$("#shangjiaTable :checkbox[value='"+xhjValue+"']").attr("disabled","true");
		}
	}
		
	return resultObj;
}

function lookPushlish(thiz){
	var rid = $(thiz).parents("tr").find("input[name='rids']").val();
	$.ajax({
		url : cloudPlatformUrl+"/services/newenv/cloub/source_58/getFangYuanFaBu?employeeId="+uid+"&rid="+rid,
		dataType : "json",
		type : "GET",
		contentType : "application/json; charset=utf-8",
		success : function(obj){
			$('#chakanTable tbody').loadTemplate("#lookTemplate", obj.result);
		}
	});
}

function delRowPushlish(thiz){
	var id = $(thiz).prev().val();
	var fids = [];
	fids.push(id);
	delPushlish(fids);
}

function delAllPushlish(){
	var fids = [];
	var $selectALL = $("#chakanTable input[name='cbUnderCarriage']:checked");
	$.each($selectALL,function(i,n){
		var fid = $(this).val();
		fids.push(fid);
	})
	if(fids.length == 0){
		alert("请选中已发布的房源再批量下架!");
		return;
	}
	delPushlish(fids);
}

function delPushlish(fids){
	var url = cloudPlatformUrl+"/services/newenv/cloub/source_58/delservice/";
	var obj=new Object();
	var bean=new Object();
	bean.fids=fids;
	obj.bean=bean;
	var jsonData=JSON.stringify(bean);
	var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
	var resultObj = $.parseJSON(result.responseText);
	if(resultObj.status == "error"){
		if(resultObj.msg!=null){
			alert(resultObj.msg);
		}else{
			alert('下架出错!');
		}
	}else{
		alert("下架成功!");
		initShouCang();
		$('#Chakan').modal("hide");
	}
}

function multiUnderCarriage(){
	var fids = $("#xiajiaModal #scId").val();
	var fidsBegin = fids.split(",");
	var fidsArr = [];
	$.ajax({
		url : cloudPlatformUrl+"/services/newenv/cloub/source_58/getFangYuanFaBu?employeeId="+uid+"&rid="+fids,
		async : false,
		dataType : "json",
		type : "GET",
		contentType : "application/json; charset=utf-8",
		success : function(obj){
			if(obj.result.length>0){
				for(var i=0;i<obj.result.length;i++){
					var id = obj.result[i].id;
					fidsArr.push(id);
				}
			}
		}
	});

	if(fidsArr.length == 0){
		$('#xiajiaModal').modal("hide");
		alert("发布的房源已经不存在,下架失败");
		return;
	}
	
	if(fidsBegin.length > fidsArr.length){
		$('#xiajiaModal').modal("hide");
		alert("存在已经下架的房源");
	}
	
	var url = cloudPlatformUrl+"/services/newenv/cloub/source_58/delservice/";
	var obj=new Object();
	var bean=new Object();
	bean.fids=fidsArr;
	obj.bean=bean;
	var jsonData=JSON.stringify(bean);
	var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
	var resultObj = $.parseJSON(result.responseText);
	if(resultObj.status == "error"){
		alert(resultObj.msg);
		$('#xiajiaModal').modal("hide");
	}else{
		alert("下架成功!");
		initShouCang();
		$('#xiajiaModal').modal("hide");
	}
}

$(document).ready(function(){
	buildQy(cityId);
	init();
});


function init(){
	var from = "<%=request.getParameter("from") == null ? 0 :request.getParameter("from") %>";
	var id = "<%=request.getParameter("id") == null ? 0 :request.getParameter("id") %>";
	var houseNumber = "${param.houseNumber}";
	if(from == 0 && id != 0){
		$("#houseType a[data-val='${param.hType}']").click();
		initShouCang();
		$("#pubid input[name='rids'][value='"+id+"']").prop("checked",true);
		shangjia('0');
	}else if(from == 1 && id != 0){
		$("#houseType a[data-val='${param.hType}']").click();
		$("#drafts").click();
		initShouCang();
	}else if(from == 1){
		if(houseNumber != ""){
			window.location.href="http://192.168.1.207:8888/BMS/pages/house/listMyRent.action?clickedTopMenuId=32";
		}else{
			$("#drafts").click();
			initShouCang();
		}
	}else{
		initShouCang();
	}
}

function buildQy(val){
	$.ajax({
		url: "<%=basePath%>/cam/campus!getQy.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"cid" : val},
		success: function(data){
			var cHtml = '<span><i class="fa-caret-right"></i>区域</span>';
			cHtml += '<a href="javascript:void(0);" class="active" onclick="selectQuYu(this);" data-val="">全部</a>';
			$.each(data, function(i,n){
				cHtml += '<a href="javascript:void(0);" onclick="selectQuYu(this);" data-id="'+n.id+'" data-val="'+n.qyName+'">'+n.qyName+'</a>';
			});
			$("#qyTd").append(cHtml);
		}
	});
};

function checkAll(thisCheckBox,checkBoxName){
	var checkBoxName = "[name='"+checkBoxName+"']";
	var allCheck = $(checkBoxName);
	if(thisCheckBox.checked == true){
		if(allCheck.length > 0){
			for(var i = 0;i < allCheck.length;i++){
				if(allCheck[i].disabled == true){
					
				}else{
					$(allCheck[i]).prop("checked",true);//全选 
				}
			}
		}
	}else{
		if(allCheck.length > 0){
			for(var i = 0;i < allCheck.length;i++){
				if(allCheck[i].disabled == true){
					
				}else{
					$(allCheck[i]).prop("checked",false);//取消全选 
				}
			}
		}
	}
}

function cancelAllCheck(){
	$("#cbPublishId").removeAttr("checked");
	$("#cbDraftsId").removeAttr("checked");
	$("#cbRecycleId").removeAttr("checked");
	$("#cbGroundingId").removeAttr("checked");
	$("#cbUnderCarriageId").removeAttr("checked");
}


function filterAll(){
	$("#toggle-publishTable-col-3").prop("checked",true);
	$("#toggle-publishTable-col-4").prop("checked",true);
	$("#toggle-publishTable-col-5").prop("checked",true);
	$("#toggle-publishTable-col-6").prop("checked",true);
	$("#toggle-publishTable-col-7").prop("checked",true);
	$("#toggle-publishTable-col-8").prop("checked",true);
	
	$("#toggle-shouCangTable-col-3").prop("checked",true);
	$("#toggle-shouCangTable-col-4").prop("checked",true);
	
	$("#toggle-recyleTable-col-3").prop("checked",true);
	$("#toggle-recyleTable-col-4").prop("checked",true);
	$("#toggle-recyleTable-col-5").prop("checked",true);
	$("#toggle-recyleTable-col-6").prop("checked",true);

	
	$("#publishTable-col-3").css("display","table-cell");
	$("#publishTable-col-4").css("display","table-cell");
	$("#publishTable-col-5").css("display","table-cell");
	$("#publishTable-col-6").css("display","table-cell");
	$("#publishTable-col-7").css("display","table-cell");
	$("#publishTable-col-8").css("display","table-cell");
	
	$("#shouCangTable-col-3").css("display","table-cell");
	$("#shouCangTable-col-4").css("display","table-cell");
	
	$("#recyleTable-col-3").css("display","table-cell");
	$("#recyleTable-col-4").css("display","table-cell");
	$("#recyleTable-col-5").css("display","table-cell");
	$("#recyleTable-col-6").css("display","table-cell");
}

function multiFunctionBackup(functionId){
	var cbRecycleIds = "";
	var tips = "";
	$("#recyleTable input[name='cbRecycleName']:checked").each(function(){
		var cbRecycleId = $(this).val();
		cbRecycleIds += cbRecycleId + ",";
	});
	if(functionId == 1){
		tips = "请选择需要还原的房源！";
		if(cbRecycleIds == ""){
			bootbox.alert({title:"提示",message:tips});
			return;
		}
		cbRecycleIds = cbRecycleIds.substring(0,cbRecycleIds.length-1);
		openHuanYuan(cbRecycleIds);
	}else if(functionId == 2){
		tips = "请选择需要彻底删除的房源！";
		if(cbRecycleIds == ""){
			bootbox.alert({title:"提示",message:tips});
			return;
		}
		cbRecycleIds = cbRecycleIds.substring(0,cbRecycleIds.length-1);
		openRecycle(cbRecycleIds,2);
	}else if(functionId == 3){
		openEmptyRecycle();
	}
}

function emptyRecycle(){
	
	var obj=new Object();
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/emptyFangYuanRelease/";
	var houseType = $("#houseType .active a").attr("data-val");
	var requestParameter=new Object();
	requestParameter.userId= <%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>;
	requestParameter.cityValue=cityName;
	requestParameter.houseType=houseType;
	requestParameter.businessType="fangyuan_chuzu";
	obj.requestParameter=requestParameter;
	var jsonData=JSON.stringify(obj);
	var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
	$('#emptyRecycleModal').modal("hide");
	if(result.responseText == 1){
		alert("删除成功!");
	}else{
		alert("删除失败!");
	}
	
	initShouCang();
}

function golistMyRent(){
	window.location.href = BMSUrl+'/pages/house/listMyRent.action?clickedTopMenuId=32';
}

function returnModify(){
	var jumpHref = $("#jumpHref").val();
	if(jumpHref != ""){
		$("#jumpModal .jumpUrl").attr("href",jumpHref);
		$("#jumpModal .jumpUrl")[0].click();
//		window.location.href = CloudPlatformWeb + jumpHref;
	}
}

</script>     