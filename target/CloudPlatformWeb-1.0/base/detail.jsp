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
		<link rel="stylesheet" href="../assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="../assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/css/xenon-core.css">
		<link rel="stylesheet" href="../assets/css/xenon-forms.css">
		<link rel="stylesheet" href="../assets/css/xenon-components.css">
		<link rel="stylesheet" href="../assets/css/xenon-skins.css">
		<link rel="stylesheet" href="../assets/css/custom.css">
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="../js/jquery.params.js"></script>
		<script src="../js/services.js"></script>
		
		<script type="text/javascript">
			var basepath = "<%=basePath%>";
			
		</script>
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

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
								<a href="<%=basePath%>/console/index.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<li>
								<a href="<%=basePath%>/base/school.action?k=base&p=xq">学区管理</a>
							</li>
							<li class="active">
								<strong>学校详情</strong>
							</li>
						</ol>

					</div>

				</div>
				<div class="row">
					<div class="col-md-12">

						<div id="toc" style="z-index: 99999;"></div>
					</div>
					<div class="col-md-12">

						<div class="panel panel-default panel-tabs">
							<!-- Add class "collapsed" to minimize the panel -->
							<div class="panel-heading">

								<div class="panel-options pull-left">

									<ul class="nav nav-tabs">
										<li class="active">
											<a href="#tab-01" data-toggle="tab">基础信息</a>
										</li>
										<li class="">
											<a href="#tab-02" data-toggle="tab">学校简介</a>
										</li>
										<li>
											<a href="#tab-03" data-toggle="tab">招生简章</a>
										</li>
										<li>
											<a href="#tab-04" data-toggle="tab">学校图库</a>
										</li>
										<li>
											<a href="#tab-05" data-toggle="tab">划片小区</a>
										</li>
<!-- 										<li> -->
<!-- 											<a href="#tab-06" data-toggle="tab">学校点评</a> -->
<!-- 										</li> -->
										<li>
											<a href="#tab-07" data-toggle="tab">最新动态</a>
										</li>
									</ul>

								</div>
							</div>

							<div class="panel-body">

								<div class="tab-content">

									<div class="tab-pane active" id="tab-01">
										<div class="panel panel-default">
											<h2 class="no-top-margin">基础信息</h2>
											<div class="col-md-12">
												<h3 class="h4">学校基本信息</h3>
												<div class="col-md-3">
													<div class="form-group">
														国家：${condition.guojia}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														省份/州：${condition.shengfen}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														城市：${condition.chengshi}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														区域：${condition.quyu}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														商圈：${condition.shangquan}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														学校名称：${condition.xhjLpschool.schoolName}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														学校类别：${condition.schoolType}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														学校性质：${condition.schoolxingzhi}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														学校等级：${condition.schooldengji}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														学校地址：${condition.xhjLpschool.address}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														坐标地址：${condition.xhjLpschool.mapXy}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														联系方式：${condition.xhjLpschool.phone}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														电子信箱：${condition.xhjLpschool.email}
													</div>
												</div>
											</div>
											<div style="height: 30px;"></div>
											<div class="col-lg-12">
												<h3 class="h4">教学规模</h3>
												<div class="col-md-3">
													<div class="form-group">
														学校网址：${condition.xhjLpschool.schoolWebsite}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														教师人数：${condition.xhjLpschool.teacherNum}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														学生人数：${condition.xhjLpschool.studentNum}
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
														班级数：${condition.xhjLpschool.classNum}
													</div>
												</div>
											</div>
											<div class="clearfix"></div>
											<div style="height: 30px;"></div>
										</div>
									</div>

									<div class="tab-pane " id="tab-02">

										<div class="panel panel-default">
											<h2>学校简介</h2>
											<div class="form-group">
											<p>简介：
											<textarea cols="50" rows="30"  class="form-control" style="height:auto;" id="zhaoshengjz">
${condition.xhjLpschool.schoolRemark}
											</textarea>
											</div>
											<div class="clearfix"></div>
											<div style="height: 30px;"></div>
										</div>

									</div>

									<div class="tab-pane" id="tab-03">
										<div class="panel panel-default">
											<h2>招生简章</h2>
											<div class="form-group">
											<textarea cols="50" rows="30"  class="form-control" style="height:auto;" id="zhaoshengjz">
${condition.xhjLpschool.recruitStudentsInfo}
											</textarea>
											</div>
											<div class="clearfix"></div>
											<div style="height: 30px;"></div>
										</div>
									</div>

									<div class="tab-pane" id="tab-04">
										<div class="panel panel-default">
											<h2>学校图库</h2>
											<div class="col-lg-12">
												<h3 class="h4">环境图</h3>
												<section class="gallery-env">

													<div class="row">

														<!-- Gallery Album Optipns and Images -->
														<div class="">

															<!-- Album Images -->
															<div class="album-images row">
				
<!-- 													<div class="clearfix"></div> -->
										<s:iterator value="condition.imageUrl" var="item">
										<s:if test="#item.type==1">
													<!-- Album Image -->
													<div class="col-lg-6 col-xs-12 form-group">
													<a href="#" class="thumb" data-action="edit">
														<img src="http://imgbms.xhjfw.com/${item.img}" width="150" height="100"/>
													</a>
<!-- 													<a href="#" class="name"> -->
<!-- 																<span>IMG_007.jpg</span> -->
<!-- 													</a> -->
													</div>
										</s:if>
										</s:iterator>
														</div>

														<!-- Gallery Sidebar -->
													</div>

												</section>
												<div class="clearfix"></div>
												<div style="height: 30px;"></div>
												<h3 class="h4">简章图</h3>
												<section class="gallery-env">

													<div class="row">

														<!-- Gallery Album Optipns and Images -->
														<div class="">

															<!-- Album Images -->
															<div class="album-images row">

															<s:iterator value="condition.imageUrl" var="item">
																	<s:if test="#item.type==2">
																		<!-- Album Image -->
																		<div class="col-lg-6 col-xs-12 form-group">
																		<a href="#" class="thumb" data-action="edit">
																			<img src="http://imgbms.xhjfw.com/${item.img}" width="150" height="100" class="img-thumbnail"/>
																		</a>
					<!-- 													<a href="#" class="name"> -->
					<!-- 														<span>IMG_007.jpg</span> -->
					<!-- 													</a> -->
																		</div>
																	</s:if>
																</s:iterator>

															</div>

														</div>

														<!-- Gallery Sidebar -->
													</div>

												</section>
											</div>
											<div class="clearfix"></div>
											<div style="height: 30px;"></div>
										</div>
									</div>

									<div class="tab-pane" id="tab-05">
							<div class="panel panel-default">
								<h2>划片小区</h2>
								<div class="col-lg-12">
									<h3 class="h4">房屋信息</h3>
										<s:iterator value="condition.schoolAreas" var="xqf">
													<s:if test="#xqf.type==1">
															<div class="col-lg-12">
																<h4 class="h5">${xqf.lpname}&nbsp;&nbsp;学区房</h4>
																<div class="col-lg-10">
																<s:iterator value="#xqf.dnames" var="dd">
																	<span class="mr10">${dd}</span>&nbsp;
																</s:iterator>
																</div>
																<div class="col-lg-2">
																	出售房屋：${xqf.count1}<br />出租房屋：${xqf.count2}<br />空置房屋：${xqf.count0}
																</div>
															</div>
													</s:if>
												</s:iterator>
									<s:iterator value="condition.schoolAreas" var="xwf">
										<s:if test="#xwf.type==2">
												<div class="col-lg-12">
													<h4 class="h5">${xwf.lpname}&nbsp;&nbsp;学位房</h4>
													<div class="col-lg-10">
														<s:iterator value="#xwf.dnames" var="ll">
														<span class="mr10">${ll}</span>
														</s:iterator>
													</div>
													<div class="col-lg-2">
														新房项目：${xwf.countNew}
													</div>
												</div>
										</s:if>
									</s:iterator>
								</div>
							<div class="clearfix"></div>
							<div style="height: 30px;"></div>
					</div>
									</div>

									<div class="tab-pane" id="tab-06">
										<div class="panel panel-default">
											<h2>学校点评</h2>
											<section class="profile-env">
												<section class="user-timeline-stories">
													<article class="timeline-story">
														<i class="fa-paper-plane-empty block-icon"></i>
														<!-- 用户信息 -->
														<header>
															<a href="#" class="user-img">
																<img src="../assets/images/user-4.png" alt="user-img" class="img-responsive img-circle">
															</a>
															<div class="user-details">
																<a href="#">达尼</a> 发布更新.
																<time>12 小时 前</time>
															</div>

														</header>

														<div class="story-content">
															<!-- 里面的故事段包裹内容 -->
															<p>还算认真米德尔顿极不信任，她现在的孩子没有。添加并准备提供亲切如何的许诺。大大谁贴上假设，但来电咨询紧凑准备全部投入。加入第四首席树木，房间认为可能。</p>

															<!-- 故事的选项链接 -->
															<div class="story-options-links">
																<a href="#">
																	<i class="linecons-heart"></i> 赞
																	<span>(3)</span>
																</a>

																<a href="#">
																	<i class="linecons-comment"></i> 评论
																	<span>(5)</span>
																</a>
															</div>

															<!-- Story Comments -->
															<ul class="list-unstyled story-comments">
																<li>

																	<div class="story-comment">
																		<a href="#" class="comment-user-img">
																			<img src="../assets/images/user-2.png" alt="user-img" class="img-circle img-responsive">
																		</a>

																		<div class="story-comment-content">
																			<a href="#" class="story-comment-user-name">
																	怒狮
																	<time>2015-8-7 10:17:44</time>
																</a>

																			<p>他这些都是参观前端七墙壁。吃钱现在规模问法学习。</p>
																		</div>
																	</div>

																</li>
																<li>

																	<div class="story-comment">
																		<a href="#" class="comment-user-img">
																			<img src="../assets/images/user-2.png" alt="user-img" class="img-circle img-responsive">
																		</a>

																		<div class="story-comment-content">
																			<a href="#" class="story-comment-user-name">
																	怒狮
																	<time>2015-8-7 10:17:44</time>
																</a>

																			<p>他这些都是参观前端七墙壁。吃钱现在规模问法学习。</p>
																		</div>
																	</div>

																</li>
															</ul>

															<form method="post" action="" class="profile-post-form">
																<textarea class="form-control input-unstyled input-lg autogrow" placeholder="回复..." style="overflow: hidden; word-wrap: break-word; height: 66px;"></textarea>
																<ul class="list-unstyled list-inline form-action-buttons">
																	<li>
																		<button type="button" class="btn btn-unstyled">
																			<i class="el-camera"></i>
																		</button>
																	</li>
																	<li>
																		<button type="button" class="btn btn-unstyled">
																			<i class="el-attach"></i>
																		</button>
																	</li>
																	<li>
																		<button type="button" class="btn btn-unstyled">
																			<i class="el-mic"></i>
																		</button>
																	</li>
																	<li>
																		<button type="button" class="btn btn-unstyled">
																			<i class="el-music"></i>
																		</button>
																	</li>
																</ul>
																<button type="submit" class="btn btn-single btn-xs btn-success post-story-button">确定</button>
															</form>
														</div>

													</article>
												</section>

											</section>
										</div>
									</div>

									<div class="tab-pane" id="tab-07">
											<div class="panel panel-default">
							<h2>最新动态</h2>
							<div class="table-responsive">
								<table class="table table-striped">
					                <thead>
					                  <tr>
<!--							  <th colspan="2">操作人</th> -->
					                    <th colspan="1">操作人</th>
					                    <th class="col-md-4">操作记录</th>
					                    <th width="200">操作时间</th>
					                  </tr>
					                </thead>
					                <tbody>
					               <s:iterator value="condition.lpSchoolLogs" var="lpSchoolLog">
					                  <tr>
<!-- 					                  	<td width="110"><img src="../assets/images/20150519191526.png" width="100" height="100"></td> -->
					                    <td width="110">
					                    	<div class="pull-left">
					                        <h4>${lpSchoolLog.operatorName}</h4>
				                       		联系电话：${lpSchoolLog.phone}<br>
			                       			ip:${lpSchoolLog.ipAddress}<br>
					                        </div>
					                    </td>
					                    <td>${lpSchoolLog.message}</td>
					                    <td>${lpSchoolLog.operateDate}</td>
					                  </tr>
					       			 </s:iterator>
					                </tbody>
					              </table>
								</div>

							</div>
									</div>

								</div>

							</div>
						</div>

						<div class="tocify-content">

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

<!-- Bottom Scripts -->
<script src="../assets/js/bootstrap.min.js"></script>
<script src="../assets/js/TweenMax.min.js"></script>
<script src="../assets/js/resizeable.js"></script>
<script src="../assets/js/joinable.js"></script>
<script src="../assets/js/xenon-api.js"></script>
<script src="../assets/js/xenon-toggles.js"></script>

<!-- Imported scripts on this page -->
<script src="../assets/js/xenon-widgets.js"></script>
<script src="../assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script src="../assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>
<script src="../assets/js/toastr/toastr.min.js"></script>

<!-- Imported scripts on this page -->
<script src="../assets/js/jquery-ui/jquery-ui.min.js"></script>
<!--<script src="../assets/js/tocify/jquery.tocify.min.js"></script>-->
<!-- JavaScripts initializations and stuff -->
<script src="../assets/js/xenon-custom.js"></script>
<script type="text/javascript">
	// Sample Javascript code for this page
	jQuery(document).ready(function($) {
		// Edit Modal
// 			<a href="#" class="thumb" data-action="edit">
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