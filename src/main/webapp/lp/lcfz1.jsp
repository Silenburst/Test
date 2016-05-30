<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="description" content="Xenon Boostrap Admin Panel" />
		<meta name="author" content="" />
		<title>维护盘、范围盘维护</title>
		<link rel="stylesheet" href="../assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="../assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/css/xenon-core.css">
		<link rel="stylesheet" href="../assets/css/xenon-forms.css">
		<link rel="stylesheet" href="../assets/css/xenon-components.css">
		<link rel="stylesheet" href="../assets/css/xenon-skins.css">
		<link rel="stylesheet" href="../assets/css/custom.css">
		<link rel="stylesheet" href="../assets/css/xiaoqu.css">
		<link rel="stylesheet" href="../assets/js/select2/select2.css">
		<link rel="stylesheet" href="../assets/js/select2/select2-bootstrap.css">
		<link rel="stylesheet" href="../assets/js/multiselect/css/multi-select.css">
		<link rel="stylesheet" href="../assets/js/bootbox/bootbox.css">
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		<script src="../assets/js/bootbox/bootbox.min.js"></script>
		<script src="../js/services.js"></script>
		<script src="../js/lp/lcfz1.js"></script>

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
<style type="text/css">
	#accordion-test1 .form-group{  padding: 10px; padding-left: 30px;}
	#accordion-test1 .form-group span{ margin-left: 10px;}
	#accordion-test1 .form-group {position: relative;}
	#accordion-test1 .form-group font{position: absolute;  right: 10px;
  top: 10px;}
  	#accordion-test1 .form-group{ margin-bottom: 5px;}
  	#accordion-test1 .form-group:hover{ background: #E9E9E9;}
</style>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>

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
								<a href="javascript:void(0)"><i class="fa-home"></i>首页</a>
							</li>
							<li class="active">
								<strong>维护盘、范围盘管理</strong>
							</li>
						</ol>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-12">		
						<ul class="nav nav-tabs">
							<li class="active">
								<a href="#home" data-toggle="tab">
									<span class="visible-xs"><i class="fa-home"></i></span>
									<span class="hidden-xs">单个搜索方式</span>
								</a>
							</li>
							<li>
								<a href="#profile" data-toggle="tab">
									<span class="visible-xs"><i class="fa-user"></i></span>
									<span class="hidden-xs">复制店组方式</span>
								</a>
							</li>
							<li>
								<a href="#messages" data-toggle="tab">
									<span class="visible-xs"><i class="fa-envelope-o"></i></span>
									<span class="hidden-xs">商圈方式</span>
								</a>
							</li>
						</ul>	
						<div class="tab-content">
							<div class="tab-pane active" id="home">
												<div class="col-lg-4 margin15">
													<select class="form-control" id="selectQy4">
														<option value="">区域（不限）</option>
														<s:iterator value="stressList">
									                		<option  value="<s:property value="id"/>"><s:property value="qyName"/></option>
									                	</s:iterator>
													</select>									
												</div>
												<div class="col-lg-4 margin15">
													<select class="form-control" id="selectSq4">
														<option value="">商圈（不限）</option>
													</select>			
												</div>
												<div class="col-lg-2 margin15">	
													<input type="text" class="form-control" id="keyword4" placeholder="请输入关键字">								
												</div>
												<div class="col-lg-2 margin15">
													<button class="btn btn-secondary" id="bnSearch4">搜&nbsp;索</button>
												</div>
								<div style="clear:both;"></div>
							</div>
							<div class="tab-pane" id="profile">
											<div class="col-lg-4 margin15">
													<input type="hidden" class="form-control" id="selectCopyGroupDz" value="" />										
												</div>
												<div class="col-lg-2 col-sm-6 margin15">
													<input type="radio" name="copyGroup2" value="2" checked >维护盘
												</div>
												<div class="col-lg-2 col-sm-6 margin15">
													<input type="radio" name="copyGroup2" value="3">范围盘
												</div>
												<div class="col-lg-2 margin15">
													<button class="btn btn-secondary" id="bnSearch1">搜&nbsp;索</button>
												</div>
												<div style="clear:both;"></div>
							</div>
							<div class="tab-pane" id="messages">
												<div class="col-lg-4 margin15">
													<select class="form-control" id="selectQy1">
														<option value="">请选择区域</option>
														<s:iterator value="stressList">
									                		<option  value="<s:property value="id"/>"><s:property value="qyName"/></option>
									                	</s:iterator>
													</select>
												</div>
												<div class="col-lg-2 margin15">
													<button class="btn btn-secondary" id="bnSearch2">搜&nbsp;索</button>
												</div>
												<div class="row">
													<div class="col-lg-12" id="tblSq1">
														
													</div>
												</div>
												
												<div style="clear:both;"></div>
							</div>							
						</div>			
					</div>
				</div>
				<div class="row">
					
					<div class="col-md-12 panel">
						<div class="tocify-content">
							<div class="col-lg-3">
								<div class="panel-group height20 " style="border:0px;">
									<input type="checkbox" id="allChoose"><font>全选</font>
									<div class="fr width100 line-height20">搜索共<span id="lpxxCount">0</span>个楼盘</div>
								</div>
								<div class="panel-group panel-group-joined" id="accordion-test1">
									
								</div>	
								<div class="col-lg-12 text-right">
                                                            <ul class="pagination">                                                               
                                                                <li><a href="javascript:void(0)" id="llxxPagerPre"><i class="fa-angle-left"></i></a></li>
                                                                <li><a href="javascript:void(0)" id="llxxPager">1/1</a></li>                                                               
                                                                <li><a href="javascript:void(0)" id="llxxPagerNext"><i class="fa-angle-right"></i></a></li>
                                                            </ul>

                                 </div>
							</div>	
							<div class="col-lg-1" style=" padding-top: 8%">
								<div class="panel-group">
								<button class="btn btn-secondary btn-icon btn-xs" id="bnAddtoWhp">
									<span>划为维护盘</span>
									<i class="fa-angle-double-right"></i>
								</button>
								</div>
								<div class="panel-group">
								<button class="btn btn-secondary btn-icon btn-xs" id="bnAddToFwp">
									<span>划为范围盘</span>
									<i class="fa-angle-double-right"></i>
								</button>
								</div>
								<div class="panel-group divCopyAll" style="display:none">
								<button class="btn btn-info btn-icon btn-xs" id="bnAddAlltoWhp">
									<span>全部划为维护盘</span>
									<i class="fa-angle-double-right"></i>
								</button>
								</div>
								<div class="panel-group divCopyAll" style="display:none">
								<button class="btn btn-info btn-icon btn-xs" id="bnAddAllToFwp">
									<span>全部划为范围盘</span>
									<i class="fa-angle-double-right"></i>
								</button>
								</div>
							</div>
							<div class="col-lg-7">
								<div class="form-group col-md-5">
												
									<input type="hidden" class="form-control" id="selectMainDz" value="" />	
								</div>
								<div class="panel panel-default col-md-12">
									<div class="panel-heading">										
											<ul class="nav nav-tabs">
												<li id="panel1" class="active">
													<a href="#tab-68" data-toggle="tab">维护盘</a>
												</li>
												<li id="panel2">
													<a href="#tab-68" data-toggle="tab">范围盘</a>
												</li>
											</ul>							
										
									</div>
									<div class="tab-content">	
										<div class="tab-pane active" id="tab-68">
											<div class="panel-body">
												<a href="javascript:void(0)" class="btn btn-success " id="allDel">批量删除</a>
												<div class="fr">
													<input type="text" id="txtLpName" class="soushuo">
													<a href="javascript:void(0)" class="btn btn-success" id="bnSearchDzLp">搜索</a>
												</div>
											</div>
											<div class="panel-body">									
												<div class="table-responsive">
													<table class="table table-bordered">
														<thead>
															<tr>
																<th width="50" class="text-center"><input type="checkbox" id="allCho"></th>
																<th class="text-center">楼盘</th>
																<th class="text-center">操作</th>
															</tr>
														</thead>
														<tbody id="tblLcfz1">
															
														</tbody>
													</table>
																			
												</div>

												<div style="clear:both"></div>			
											</div>
										</div>
											<div class="col-lg-12">
												<div class="col-lg-6 text-left">
													<div class="dataTables_info" id="example-4_info" role="status" aria-live="polite">共<span id="dzLpxxCount" style="color:#ff5400;">0</span>个楼盘</div>
												</div>
												<div class="col-lg-6">
	                                               <ul class="pagination">                                                               
	                                                   <li><a href="javascript:void(0);" id="lcfzPagerPre"><i class="fa-angle-left"></i></a></li>
	                                                   <li><a href="javascript:void(0);" id="lcfzPager">1/1</a></li>
	                                                   <li><a href="javascript:void(0);" id="lcfzPagerNext"><i class="fa-angle-right"></i></a></li>                                                               
	                                               </ul>
	                                           </div>
											</div>					
											<div style=" height:20px;"></div>
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

<!-- Bottom Scripts -->
<script src="../assets/js/bootstrap.min.js"></script>
<script src="../assets/js/TweenMax.min.js"></script>
<script src="../assets/js/resizeable.js"></script>
<script src="../assets/js/joinable.js"></script>
<script src="../assets/js/xenon-api.js"></script>
<script src="../assets/js/xenon-toggles.js"></script>

<!-- Imported scripts on this page -->
<script src="../assets/js/xenon-widgets.js"></script>
<script src="../assets/js/select2/select2.min.js"></script>
<script src="../assets/js/select2/select2_locale_zh-CN.js"></script>
<script src="../assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="../assets/js/selectboxit/jquery.selectBoxIt.min.js"></script>
<script src="../assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script src="../assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>
<script src="../assets/js/toastr/toastr.min.js"></script>

<!-- Imported scripts on this page -->
<script src="../assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="../assets/js/tocify/jquery.tocify.min.js"></script>
<!-- JavaScripts initializations and stuff -->
<script src="../assets/js/xenon-custom.js"></script>

<div class="modal fade" id="modal-6">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"id="viewTitle"><span id="viewDlgLpName">中原大厦</span>的<span id="viewDlgStaName"></span>店组列表</h4>
			</div>
			
			<div class="modal-body">
				<div class="table-responsive" id="viewDlgCon">
												
				</div>
			</div>
			
			<div class="modal-footer">
				<button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>