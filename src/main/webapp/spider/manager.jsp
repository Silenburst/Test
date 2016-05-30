<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page isErrorPage="false" %>
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
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta name="description" content="Xenon Boostrap Admin Panel" />
		<meta name="author" content="" />
		<title>采集管理</title>
		<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="../assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../assets/css/xenon-core.css">
		<link rel="stylesheet" href="../assets/css/xenon-forms.css">
		<link rel="stylesheet" href="../assets/css/xenon-components.css">
		<link rel="stylesheet" href="../assets/css/xenon-skins.css">
		<link rel="stylesheet" href="../assets/css/custom.css">
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		
		<script src="<%=basePath%>/assets/js/page.js"></script>
		<script src="<%=basePath%>/js/services.js"></script>
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
							<li class="active">
								<strong><a href="<%=basePath%>/spider/manager.jsp">采集管理</a></strong>
							</li>
						</ol>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="row">
								<div class="col-md-12" style="display:none">
										<div class="Color pull-left h4" id="country">
										</div>
								</div>
								<div class="col-md-12">
										<div class="Color pull-left h4" id="pro">
										</div>
								</div>
								
								<div class="col-md-12">
										<div class="Color pull-left h4" id="city">
										</div>
								</div>
								<div class="col-md-12">
										<div class="Color pull-left h4" id="sQy">
										</div>
								</div>
								
								<div class="col-md-3">
									
									<div class="input-group">
										<input type="text" id="sqValue" class="form-control no-right-border form-focus-secondary" placeholder="请输入商圏名称">
										<span class="input-group-btn">
											<button id="search1" class="btn btn-secondary" type="button">搜索</button>
										</span>										
									</div>
								</div>
					</div>
				</div>
				<div class="panel panel-default">
					<div>
						<button class="btn btn-secondary" data-toggle="modal" data-target="#shangquan" onclick="selectCountryData();selectProvinceData(<%=countryId%>);selectCity(<%=provinceId%>);selectShuangQuan(<%=cityId%>);" tybe ="button"><i class="fa-plus"></i> 新增 </button>
						<button class="btn btn-danger" tybe = "button" onclick="batchBatchRemove()"><i class="fa-trash-o" ></i> 批量删除 </button>	
					</div>
					<div class="table-responsive">
						<table class="table table-bordered table-striped table-condensed">
							<thead>
								<tr>
									<th data-priority="3"class="text-center hidden-480" width="50"><input type="checkbox" onclick="checkAll(this)"/></th>
									<th data-priority="3"class="text-center hidden-480" width="19%">区域</th>
									<th data-priority="3"class="text-center hidden-480" width="19%">商圈</th>
									<th data-priority="3"class="text-center hidden-480" width="19%">创建时间</th>
									<th data-priority="3"class="text-center hidden-480" width="19%">更新时间</th>
									<th data-priority="3"class="text-center hidden-480" width="19%">操作</th>
								</tr>
							</thead>
							<tbody class="middle-align" id="tbodyData">
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
</script>

<!-- Imported scripts on this page -->
<script src="../assets/js/xenon-widgets.js"></script>
<script src="../assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script src="../assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>
<script src="../assets/js/toastr/toastr.min.js"></script>

<!-- Imported scripts on this page -->
<script src="../assets/js/jquery-ui/jquery-ui.js"></script>
<script src="../assets/js/tocify/jquery.tocify.min.js"></script>
<!-- JavaScripts initializations and stuff -->
<script src="../assets/js/xenon-custom.js"></script>

<!--国家-->
<div class="modal fade" id="guojia-zeng" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">新增</h4>
			</div>
			<div class="modal-body">
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
				<form role="form" class="form-horizontal" >
					<div class="form-group">
						<label class="col-sm-3 control-label">国家名称：</label>
						<div class="col-sm-8">
								<input type="text" class="form-control" id = "cName" name = "cName" onblur="selectStateData()"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">国家编码：</label>
						<div class="col-sm-8">
								<input type="text" class="form-control" id = "cNameCoding" name = "cNameCoding"/>
						</div>
					</div>
				</form>

			</div>	
			</div>	
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="addState();">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="coutnridEmpty()">关闭</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="guojia-gai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">编辑</h4>
			</div>
			<div class="modal-body">
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
<!-- 				<form role="form" class="form-horizontal"> -->
<!-- 					<div class="form-group"> -->
<!-- 						<div class="input-group input-group-minimal"> -->
<!-- 							<label class="col-sm-3 control-label">国家名称：</label> -->
<!-- 							<input type="hidden" id="countryId"> -->
<!-- 							<input type="text" class="form-control col-sm-3" id = "countryName" > -->
<!-- 							<a href="#" class="input-group-addon" title="点击删除" onclick="updateDataState()"> -->
<!-- 								<i class="fa-trash-o"></i> -->
<!-- 							</a> -->
<!-- 						</div> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label class="col-sm-3 control-label">国家编码：</label> -->
<!-- 							<input type="text" class="form-control" id = "cNameCodingdata"/> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</form> -->
					<table class="table">
			            <tbody>
			              <tr>
			              	<td width = "120px">国家名称：</td>
			                <td>
			                	<div class="input-group input-group-minimal">
			                	<input type="hidden" id="countryId">
								<input type="text" class="form-control col-sm-3" id = "countryName" >
									<a href="#" class="input-group-addon" title="点击删除" onclick="updateDataState()">
								<i class="fa-trash-o"></i>
								</a>
								</div>
			              </td>
			              </tr>
			              <tr>
			              	<td  width="120px">国家编码：</td>
			                <td>
								<input type="text" class="form-control" id = "cNameCodingdata"/>
			              	</td>
			              </tr>
			            </tbody>
		          </table>
			</div>	
			</div>	
			<div class="modal-footer">
				<button type="submit" class="btn btn-info" onclick="updateState()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!--省份/州-->
<div class="modal fade" id="sheng-zeng" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">新增</h4>
			</div>
			<div class="modal-body">
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
				<form role="form" class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-3 control-label">省份/州名称：</label>
						<div class="col-sm-8">
								<input type="text" class="form-control" id ="pname" name ="pname" onblur="selectDataProvince()">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">省份/州编码：</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id ="pnamedata" name ="pnamedata">
							</div>
						</div>
				</form>
			</div>	
			</div>	
			<div class="modal-footer">
				<button type="submit" class="btn btn-info" onclick="addProvince()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="provinceEmpty()">关闭</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="sheng-gai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">编辑</h4>
			</div>
			<div class="modal-body">
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
<!-- 				<form role="form" class="form-horizontal" > -->
<!-- 					<div class="form-group"> -->
<!-- 						<div class="input-group input-group-minimal"> -->
<!-- 							<input type="hidden" id="pid"> -->
<!-- 							<input type="email" class="form-control" id ="pName"> -->
<!-- 							<a href="#" class="input-group-addon" title="清空" onclick="pEmpty()"></a>  -->
<!-- 							<a href="#" class="input-group-addon" title="点击删除" onclick="updateDataProvince()"> -->
<!-- 								<i class="fa-trash-o"></i> -->
<!-- 							</a> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 						<div class="form-group"> -->
<!-- 							<input type="email" class="form-control" id ="provinceNameData"/> -->
<!-- 						</div> -->
<!-- 				</form> -->
						<table class="table">
			            <tbody>
			              <tr>
			              	<td width="120px">省份/州名称：</td>
			                <td>
			              		<div class="input-group input-group-minimal">
			                	<input type="hidden" id="pid">
				            	<input type="email" class="form-control" id ="pName">
									<a href="#" class="input-group-addon" title="点击删除" onclick="updateDataProvince()">
								<i class="fa-trash-o"></i>
								</a>
								</div>
							</td>
			              </tr>
			              <tr>
			              	<td  width="120px">省份/州编码：</td>
			                <td>
								<input type="email" class="form-control" id ="provinceNameData"/>
			              	</td>
			              </tr>
			            </tbody>
		          </table>
			</div>	
			</div>	
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="updateProvince()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>


<!--城市-->
<div class="modal fade" id="cheng-zeng" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">新增</h4>
			</div>
			<div class="modal-body">
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
				<form role="form" class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-3 control-label">城市名称：</label>
						<div class="col-sm-8">
								<input type="text" class="form-control" id = "cityname1" name ="cityname" onblur="selectCityData()">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">城市编码：</label>
						<div class="col-sm-8">
								<input type="text" class="form-control" id = "citynamedata" name ="citynamedata">
						</div>
					</div>
					<div class="form-group-separator"></div>
				</form>

			</div>	
			</div>	
			<div class="modal-footer">
				<button type="submit" class="btn btn-info" onclick="addCity()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="cityEmpty()">关闭</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="cheng-gai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">编辑</h4>
			</div>
			<div class="modal-body">
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
<!-- 				<form role="form" class="form-horizontal"> -->
<!-- 					<div class="form-group"> -->
<!-- 						<div class="input-group input-group-minimal"> -->
<!-- 							<input type="hidden" id="cityid"> -->
<!-- 							<input type="email" class="form-control" id ="cityName"> -->
<!-- 							<a href="#" class="input-group-addon" title="清空" onclick="Empty()"></a>  -->
<!-- 							<a href="#" class="input-group-addon" title="点击删除" onclick="updateDataCity()"> -->
<!-- 								<i class="fa-trash-o"></i> -->
<!-- 							</a> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="form-group"> -->
<!-- 							<input type="email" class="form-control" id ="citydataName"/> -->
<!-- 						</div> -->
<!-- 				</form> -->
					<table class="table">
			            <tbody>
			              <tr>
			              	<td width="120px">城市名称：</td>
			                <td>
			                	<div class="input-group input-group-minimal"> 
									<input type="hidden" id="cityid">
									<input type="email" class="form-control" id ="cityName">
									<a href="#" class="input-group-addon" title="点击删除" onclick="updateDataCity()">
										<i class="fa-trash-o"></i>
									</a>
								</div> 
			              </td>
			              </tr>
			              <tr>
			              	<td  width="120px">城市编码：</td>
			                <td>
								<input type="email" class="form-control" id ="citydataName"/>
			              	</td>
			              </tr>
			          </tbody>
			       </table>
			</div>	
			</div>	
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="updateCity()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<!--区域-->
<div class="modal fade" id="qu-zeng" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">新增</h4>
			</div>
			<div class="modal-body">
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
				<form role="form" class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-3 control-label">区域名称：</label>
						<div class="col-sm-8">
								<input type="text" class="form-control" id = "qyName" name ="qyName" onblur="selectDataArea()">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">区域编码：</label>
						<div class="col-sm-8">
								<input type="text" class="form-control" id = "qyNameData" name ="qyNameData">
							</div>
					</div>
				</form>

			</div>	
			</div>	
			<div class="modal-footer">
				<button type="submit" class="btn btn-info" onclick="addArea()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="coutnridEmpty()">关闭</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="qu-gai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">编辑</h4>
			</div>
			<div class="modal-body">
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
<!-- 				<form role="form" class="form-horizontal"> -->
<!-- 					<div class="form-group"> -->
<!-- 						<div class="input-group input-group-minimal"> -->
<!-- 							<input type="hidden" id="qId"> -->
<!-- 							<input type="email" class="form-control" id = "qName"> -->
<!-- 							<a href="#" class="input-group-addon" title="清空" onclick="qEmpty()"></a> -->
<!-- 							<a href="#" class="input-group-addon" title="点击删除" onclick="updateDataArea();"> -->
<!-- 								<i class="fa-trash-o"></i> -->
<!-- 							</a> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 						<div class="form-group"> -->
<!-- 							<input type="email" class="form-control" id = "qyDataName"/> -->
<!-- 						</div> -->
<!-- 				</form> -->
					<table class="table">
			            <tbody>
			              <tr>
			              	<td width="120px">区域名称：</td>
			                <td>
			                	<div class="input-group input-group-minimal"> 
									<input type="hidden" id="qId">
									<input type="email" class="form-control" id = "qName">
									<a href="#" class="input-group-addon" title="点击删除" onclick="updateDataArea();">
										<i class="fa-trash-o"></i>
									</a>
								</div>
			              </td>
			              </tr>
			              <tr>
			              	<td  width="120px">区域编码：</td>
			                <td>
								<input type="email" class="form-control" id = "qyDataName"/>
			              	</td>
			              </tr>
			          </tbody>
			       </table>
			</div>	
			</div>	
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="updateArea()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>


<!--新增商圈-->
<div class="modal fade" id="shangquan" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">新增商圈</h4>
			</div>
			<div class="modal-body">
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
				<form role="form" class="form-horizontal" name="pageForm" id="pageForm">
					<h4><b>站点基本信息</b></h4>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">国家：</label>
						<div class="col-sm-9">
							<select class="form-control" id = "countrydataId" onchange="selectProvinceData(this)">
							</select>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">省份：</label>
						<div class="col-sm-9">
							<select class="form-control" id = "pdataid" onchange="selectCity(this)">
							</select>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">城市：</label>
						<div class="col-sm-9">
							<select class="form-control" id = "polis" onchange="selectShuangQuan(this)">
							</select>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">区域选择：</label>
						<div class="col-sm-9">
							<select class="form-control" id="quyuId">
							</select>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<h4><b>商圈</b></h4>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">新增商圈：</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id = "shangQuanId" onblur="selectShangQuanData()">
						</div>
					</div>
					<div class="form-group-separator"></div>
				</form>

			</div>	
			</div>	
			<div class="modal-footer">
				<button class="btn btn-info" type="button" onclick="addData()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="diquEmpty()">关闭</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="shangquan-gai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">修改商圈</h4>
			</div>
			<div class="modal-body">
			<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
				<form role="form" class="form-horizontal">
					<h4><b>站点基本信息</b></h4>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">城市：</label>
						<div class="col-sm-9 control-label" style="text-align: left;" >
							<input type="text" class="form-control" id= "citydataid" readonly="readonly">
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">区域选择：</label>
						<div class="col-sm-9 control-label">
							<input type="text" class="form-control" id= "quyudataId" readonly="readonly">
						</div>
					</div>
					<div class="form-group-separator"></div>
					<h4><b>商圈</b></h4>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">新增商圈：</label>
						<div class="col-sm-9">
							<input type="hidden" id="shangquanDataId">
							<input type="text" class="form-control" id= "shangquanName">
						</div>
					</div>
					<div class="form-group-separator"></div>
				</form>

			</div>	
			</div>	
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="updateData()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" id="closeEdit">关闭</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var cityId="<%=cityId%>";
	var countryId="<%=countryId%>";
	var provinceId="<%=provinceId%>";
	$(document).ready(function()
	{
		buildCountry();
		buildPro(countryId);
		buildCity(provinceId);
		buildQy(cityId);
	});
	
	var basePath="<%=basePath%>";

	$("#search1").click(function()
	{
		queryData();
	});
	
	function queryData()
	{
		var couId = $("#country a.active").attr("data-id") == null ? 0 : $("#country a.active").attr("data-id");
	    var proId = $("#pro a.active").attr("data-id") == null ? 0 : $("#pro a.active").attr("data-id");
	    var cityId = $("#city a.active").attr("data-id") == null ? 0 : $("#city a.active").attr("data-id");
	    var qyId = $("#sQy a.active").attr("data-id") == null ? 0 : $("#sQy a.active").attr("data-id");
	    var sqName = $("#sqValue").val() == null ? "" : $("#sqValue").val();
	    
	    var url = basePath+"/base/regionManager!pageInFo.action";
	    $("#macPageWidget").asynPage(url, "#tbodyData", buildDataHtml, true, true, 
	    {
	        'metro.countryId': couId,
	        'metro.pid': proId,
	        'metro.cityID': cityId,
	        'metro.qyID': qyId,
	        'metro.sqName': sqName
	    });
	};

	function buildDataHtml(list) 
	{
		$("#tbodyData").html("");
	    $.each(list, function (i, info) 
	    {
	    	var newTime = new Date(info[3]); 
	    	var nowStr = newTime.format("yyyy-MM-dd hh:mm:ss"); 
	    	var newDateTime;
	    	var nowStrData;
	    	if(null != info[4]&& info[4]!='')
	    	{
	    		 newDateTime = new Date(info[4]);
		    	 nowStrData = newDateTime.format("yyyy-MM-dd hh:mm:ss");
	    	}
	    	else
	    	{
	    		nowStrData='';
	    	}
	    	
	        var tr = [
	            '<tr>',
	            '<td class="text-center">', '<input type="checkbox" class="cbr" name="id" value="'+info[7]+'"  onclick="setSelectAll(this)" />', '</td>',
	            '<td class="text-center">', info[0]=="null" ||info[0]=="" || info[0]==null?"":info[0], '</td>',
	            '<td class="text-center">', info[2]=="null" ||info[2]=="" || info[2]==null?"":info[2], '</td>',
	            '<td class="text-center">', nowStr, '</td>',
	            '<td class="text-center">',nowStrData, '</td>',
	            '<td><button class="btn btn-secondary" data-toggle="modal" type="button" onclick="jumpToDetail('+info[7]+')"><i class="fa-pencil"></i> 详情</button></td>',
	            '</tr>'].join('');
	        $("#tbodyData").append(tr);
	    });
	};
	
	function jumpToDetail(parameter)
	{
		var tt=parameter;
		alert(parameter);
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


//国家
function buildCountry(){
	$.ajax({ 
		url: "<%=basePath%>/cam/campus!getCountryInfo.action",
		dataType: "json", 
		type: "POST",
		async : false,
		success: function(data){
			var cHtml = '<span>国家：</span><a href="javascript:buildPro(0)" class="mr10 active" data-id="0">不限</a>';
			$.each(data, function(i,n){
				if(i % 8 == 0 && i > 0) {
					cHtml += "<br>";
				}
				cHtml += '<a href="javascript:buildPro(\''+n.id+'\')" class="mr10" data-id="'+n.id+'">'+n.cname+'</a>';
			});
			var dHtml = '<div class="pull-right">';
			dHtml += '<button class="btn btn-secondary" data-toggle="modal"   type="button" onclick="bainji()"><i class="fa-pencil"></i> 编辑</button>';
			dHtml += '<button class="btn btn-success" data-toggle="modal" data-target="#guojia-zeng"><i class="fa-plus"></i> 新增</button>';
			dHtml += '</div>';
			$("#country").html(cHtml);
			$("#country").parent().find("div").eq(1).remove();
			$("#country").parent().append(dHtml);
	    }
	});
	queryData();
	
};
function buildPro(val){
	var countryIdData = val;
	$("#country a").removeClass("active");
	$("#country a[data-id='"+countryIdData+"']").addClass("active");
	$("#city").html("");
	$("#sQy").html("");
	$("#sSq").html("");
	$.ajax({ 
		url: "<%=basePath%>/cam/campus!getPro.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"cid" : countryIdData},
		success: function(data){
			var pHtml = '<span>省份/州：</span><a href="javascript:buildCity(0)" class="mr10 active" data-id="0">不限</a>';
			$.each(data, function(i,n){
				if(i % 8 == 0 && i > 0) {
					pHtml += "<br>";
				}
				pHtml += '<a href="javascript:buildCity(\''+n.id+'\')" class="mr10" data-id="'+n.id+'">'+n.pname+'</a>';
			});
			var dHtml = '<div class="pull-right">';
			dHtml += '<button class="btn btn-secondary" data-toggle="modal"tybe ="button" onclick="provincebiaji()"><i class="fa-pencil"></i> 编辑</button>';
			dHtml += '<button class="btn btn-success" data-toggle="modal" data-target="#sheng-zeng"><i class="fa-plus"></i> 新增</button>';
			dHtml += '</div>';
			$("#pro").html(pHtml);
			$("#pro").parent().find("div").eq(1).remove();
			$("#pro").parent().append(dHtml);
	    }
	});
	queryData();
	
};

function buildCity(val){
	var provinceIdData = val;
	$("#pro a").removeClass("active");
	$("#pro a[data-id='"+provinceIdData+"']").addClass("active");
	$("#sQy").html("");
	$("#sSq").html("");
	$.ajax({ 
		url: "<%=basePath%>/cam/campus!getCity.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"pid" : provinceIdData},
		success: function(data){
			var cHtml = '<span>城市：</span><a href="javascript:buildQy(0)" class="mr10 active" data-id="0">不限</a>';
			$.each(data, function(i,n){
				if(i % 8 == 0 && i > 0) {
					cHtml += "<br>";
				}
				cHtml += '<a href="javascript:buildQy(\''+n.id+'\')" class="mr10" data-id="'+n.id+'">'+n.cityName+'</a>';
			});
			var dHtml = '<div class="pull-right">';
			dHtml += '<button class="btn btn-secondary" data-toggle="modal" tybe="button" onclick="citybiaji()"><i class="fa-pencil"></i> 编辑</button>';
			dHtml += '<button class="btn btn-success" data-toggle="modal" data-target="#cheng-zeng"><i class="fa-plus"></i> 新增</button>';
			dHtml += '</div>';
			$("#city").html(cHtml);
			$("#city").parent().find("div").eq(1).remove();
			$("#city").parent().append(dHtml);
	    }
	});
	queryData();
	
};

function buildQy(val){
var cityIdData = val;
$("#city a").removeClass("active");
$("#city a[data-id='"+cityIdData+"']").addClass("active");
$("#sSq").html("");
$.ajax({ 
url: "<%=basePath%>/cam/campus!getQy.action",
dataType: "json", 
type: "POST",
async : false,
data : {"cid" : cityIdData},
success: function(data){
			var cHtml = '<span>区域：</span><a href="javascript:void(0)" class="mr10 active" data-id="0">不限</a>';
			$.each(data, function(i,n){
				if(i % 9 == 0 && i > 0) {
						cHtml += "<br><a style='margin-left:50px'>";
					}
				cHtml += '<a href="javascript:void(0)" class="mr10" data-id="'+n.id+'">'+n.qyName+'</a>';
			});
			var dHtml = '<div class="pull-right">';
			dHtml += '<button class="btn btn-secondary" data-toggle="modal"tybe="button" onclick="biajiArea()"><i class="fa-pencil"></i> 编辑</button>';
			dHtml += '<button class="btn btn-success" data-toggle="modal" data-target="#qu-zeng"><i class="fa-plus"></i> 新增</button>';
			dHtml += '</div>';
			$("#sQy").html(cHtml);
			$("#sQy").parent().find("div").eq(1).remove();
			$("#sQy").parent().append(dHtml);
			$("#sQy a").click(function(){
				$("#sQy a").removeClass("active");
				$(this).addClass("active");
				queryData();
			});
	    }
	});
	queryData();
	
};
var fian=false;
function selectStateData(){
	$.ajax({
		url: "<%=basePath%>/base/regionManager!selectStateData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cname":$("#cName").val()},
		success: function(data){
		if(data>0){
			alert('名称已重复,请重新输入!');
			return fian;
			}else{
			fian=true;
			return fian;
			}
		}
	});
}
//新增国家
function addState(){
var countryName = $("#cName").val();
var countryNameCoding = $("#cNameCoding").val();
if(countryName !=  null && countryName !='' && 'null' != countryName){
if(fian){
$.ajax({
		url: "<%=basePath%>/base/regionManager!addState.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cname":countryName,"cnameCoding":countryNameCoding},
		success: function(data){
		var cHtml = '';
		if(data!=null){
		alert('添加成功!');
		cHtml = '<a href="javascript:buildPro(\''+data.id+'\')" class="mr10" data-id="'+data.id+'">'+data.cname+'</a>';
			jQuery('#guojia-zeng').modal('hide');
			window.location.reload();
		} else {
			alert('添加失败!');
		}
			$("#country").append(cHtml);
		}
	});
	}else {
	alert('请输入国家名称!');
	}
 }
}

//修改国家
function updateState(val){
var countryName = $("#countryName").val();
var cid = $("#countryId").val();
if(null != $("#cNameCodingdata").val()  && '' != $("#cNameCodingdata").val()){
	var countryNameCoding = $("#cNameCodingdata").val();
}
$.ajax({
		url: "<%=basePath%>/base/regionManager!updateState.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cname":countryName,"cid":cid,"cnameCoding":countryNameCoding},
		success: function(data){
		if(data>0){
				alert('修改成功!');
				jQuery('#guojia-gai').modal('hide')
				window.location.reload();
			} else {
				alert('修改失败!');
			}
		}
	});
}
var fian=false;
function selectDataProvince(){
	$.ajax({
		url: "<%=basePath%>/base/regionManager!selectProvinceData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"pname":$("#pname").val(),"cid":countryId},
		success: function(data){
		if(data>0){
			alert('名称已重复,请重新输入!');
			return fian;
			}else{
			fian=true;
			return fian;
			}
		}
	});
}
//添加省份	
function addProvince(){
 var countryid = $("#country a.active").attr("data-id") == null ? 0 : $("#country a.active").attr("data-id");
var provinceName = $("#pname").val();
var provinceNameCoding = $("#pnamedata").val();
if(provinceName !=  null && provinceName !='' && 'null' != provinceName){
if(fian){
$.ajax({
		url: "<%=basePath%>/base/regionManager!addProvince.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"pname":provinceName,"cid":countryid,"cnameCoding":provinceNameCoding},
		success: function(data){
		var cHtml = '';
		if(data != null){
				alert('添加成功!');
				pHtml = '<a href="javascript:buildCity(\''+data.id+'\')" class="mr10" data-id="'+data.id+'">'+data.pname+'</a>';
				jQuery('#sheng-zeng').modal('hide');
				window.location.reload();
			} else {
				alert('添加失败!');
			}
				$("#pro").html(pHtml);
		}
	});	
  } else {
  alert('请输入省份名称!');
  }
 }
}

//修改省份
function updateProvince(){
 var proid = $("#pro a.active").attr("data-id") == null ? 0 : $("#pro a.active").attr("data-id");
var provinceName = $("#pName").val();
var countryId = $("#countryId").val();
$.ajax({
		url: "<%=basePath%>/base/regionManager!updateProvince.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"pname":provinceName,"pid":proid,"cnameCoding":$("#provinceNameData").val()},
		success: function(data){
		if(data>0){
				alert('修改成功!');
				jQuery('#sheng-gai').modal('hide');
				window.location.reload();
			} else {
				alert('修改失败!');
			}
		}
	});
}
var fian=false;
function selectCityData(){
	$.ajax({
		url: "<%=basePath%>/base/regionManager!selectCityData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cityname":$("#cityname1").val(),"pid":provinceId},
		success: function(data){
		if(data>0){
			alert('名称已重复,请重新输入!');
			return fian;
			}else{
			fian=true;
			return fian;
			}
		}
	});
}
//添加城市	
function addCity(){
 var proid = $("#pro a.active").attr("data-id") == null ? 0 : $("#pro a.active").attr("data-id");
var cityName = $("#cityname1").val();
if(cityName !=  null && cityName !='' && 'null' != cityName){
if (fian){
$.ajax({
		url: "<%=basePath%>/base/regionManager!addCity.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cityname":cityName,"pid":proid,"cnameCoding":$("#citynamedata").val()},
		success: function(data){
		var cHtml = '';
		if(data != null){
			alert('添加成功!');
			cHtml = '<a href="javascript:buildQy(\''+data.id+'\')" class="mr10" data-id="'+data.id+'">'+data.cityName+'</a>';
			jQuery('#cheng-zeng').modal('hide');
			window.location.reload();
			} else {
			alert('添加失败!');
			}
			$("#city").html(cHtml);
		}
	});	
  }
} else {
	alert('请输入城市名称!');
}
}
//修改城市
function updateCity(){
var cityid = $("#city a.active").attr("data-id") == null ? 0 : $("#city a.active").attr("data-id");
var cityName = $("#cityName").val();
$.ajax({
		url: "<%=basePath%>/base/regionManager!updateCity.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cityname":cityName,"cityID":cityid,"cnameCoding":$("#citydataName").val()},
		success: function(data){
		if(data>0){
				alert('修改成功!');
				jQuery('#cheng-gai').modal('hide');
				window.location.reload();
			} else {
				alert('修改失败!');
			}
		}
	});
}
var fian=false;
function selectDataArea(){
	$.ajax({
		url: "<%=basePath%>/base/regionManager!selectDataArea.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"qyName":$("#qyName").val(),"cityID":cityId,"cnameCoding":$("#citydataName").val()},
		success: function(data){
		if(data>0){
			alert('名称已重复,请重新输入!');
			return fian;
			}else{
			fian=true;
			return fian;
			}
		}
	});
}
//添加区域	
function addArea(){
var cityid = $("#city a.active").attr("data-id") == null ? 0 : $("#city a.active").attr("data-id");
var qyid = $("#qyName").val();
if(qyid !=  null && qyid !='' && 'null' != qyid){
if(fian){
$.ajax({
	url: "<%=basePath%>/base/regionManager!addArea.action",
	dataType: "json", 
	type: "POST",
	async : false,
	data :{"qyName":qyid,"cityID":cityid,"cnameCoding":$("#qyNameData").val()},
	success: function(data){
	var cHtml = '';
	if(data != null){
		alert('添加成功!');
		cHtml += '<a href="" class="mr10" data-id="'+data.id+'">'+data.qyName+'</a>';
		jQuery('#qu-zeng').modal('hide');
			window.location.reload();
		} else {
		alert('添加失败!');
		}
		$("#sQy").html(cHtml);
	}
	});	
  } else {
  	alert('请输入区域名称!');
  }
 }
}
//修改区域
function updateArea(val){
var qyName = $("#qName").val();
 var qyId = $("#sQy a.active").attr("data-id") == null ? 0 : $("#sQy a.active").attr("data-id");
$.ajax({
		url: "<%=basePath%>/base/regionManager!updateArea.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"qyName":qyName,"qyID":qyId,"cnameCoding":$("#qyDataName").val()},
		success: function(data){
		if(data>0){
				alert('修改成功!');
				jQuery('#qu-gai').modal('hide');
				window.location.reload();
			} else {
				alert('修改失败!');
			}
		}
	});
}
//删除
function updateBatchRemove(val){
if(confirm("确认要删除?")) {
$.ajax({
		url: "<%=basePath%>/base/regionManager!updateBatchRemove.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"sqID":val},
		success: function(data){
		if(data>0){
				alert('删除成功!');
				queryData();
			} else {
				alert('删除失败!');
			}
		}
	});
	}
}
//批量删除
function batchBatchRemove(){
var ids = "";
		$("input[name='id']").each(function(i){
			if(this.checked && this.value != ""){
				ids = (ids != "") ?  (ids + "," + this.value) : this.value;
			}
		});
		if(ids == ""){
			alert("请选择数据后操作！");
			return;
		}
if(confirm("确认要删除?")) {
$.ajax({
		url: "<%=basePath%>/base/regionManager!updateBatchRemove.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"sqID":ids},
		success: function(data){
		if(data>0){
				alert('删除成功!');
				queryData();
			} else {
				alert('删除失败!');
			}
		}
	});
	}
}
/**
 * 修改页面的数据根据ID查询
 * @return
 */
function selectData(cityName,qyName,sqName,sqid){
	$("#citydataid").val(cityName);
	if(qyName == null){
		$("#quyudataId").val();
	} else {
		$("#quyudataId").val(qyName);
	}
	
	$("#shangquanName").val(sqName);
	$("#shangquanDataId").val(sqid);
}
//修改数据
function updateData(){
var shangquanName = $("#shangquanName").val();
var shangquanID = $("#shangquanDataId").val();
$.ajax({
url: "<%=basePath%>/base/regionManager!updateData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"sqname":shangquanName,"sqID":shangquanID},
		success: function(data){
			var cHtml = '';
			if(data>0){
				alert('修改成功!');
				$("#closeEdit").click();
				queryData();
			} else {
				alert('修改失败!');
			}
		}
	});
}
//获取国家
function selectCountryData(){
$.ajax({
		url: "<%=basePath%>/base/regionManager!selectCountryData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		success: function(data){
		var cHtml = '<option>请选择国家</option>';
			$.each(data, function(i,n){
				cHtml += '<option  class="mr10" data-id="'+n.countryId+'" value="'+n.countryId+'">'+n.cname+'</option>';
			});
			$("#countrydataId").html(cHtml);
		}
	});
		$("#countrydataId option[value='"+countryId+"']").attr("selected", true); 
}
//根据国家ID查询出省份名称
function selectProvinceData(obj){
var countrydataId;
if(obj.value!=null&&obj.value!=''){
countrydataId=obj.value;
}else{
countrydataId=obj;
}
$.ajax({
		url: "<%=basePath%>/base/regionManager!selectDataProvince.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cid":countrydataId},
		success: function(data){
		var cHtml = '<option>请选择省份</option>';
			$.each(data, function(i,n){
				cHtml += '<option class="mr10" data-id="'+n.pid+'" value="'+n.pid+'">'+n.pname+'</option>';
			});
			$("#pdataid").html(cHtml);
		}
	});
	$("#pdataid option[value='"+provinceId+"']").attr("selected", true); 
}

//获取城市
function selectCity(obj){
var provinceDataID;
if(obj.value!=null&&obj.value!=''){
provinceDataID=obj.value;
}else{
provinceDataID=obj;
}
$.ajax({
		url: "<%=basePath%>/base/regionManager!selectCity.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"pid":provinceDataID},
		success: function(data){
		var cHtml = '<option>请选择城市</option>';
			$.each(data, function(i,n){
				cHtml += '<option  class="mr10" data-id="'+n.cityID+'" value="'+n.cityID+'">'+n.cityName+'</option>';
			});
			$("#polis").html(cHtml);
		}
	});
	$("#polis option[value='"+cityId+"']").attr("selected", true); 
}
//获取所有商圈
function selectShuangQuan(obj){
var cityIDdata;
if(obj.value!=null&&obj.value!=''){
cityIDdata=obj.value;
}else{
cityIDdata=obj;
}
$.ajax({
		url: "<%=basePath%>/base/regionManager!selectShuangQuan.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cityID":cityIDdata},
		success: function(data){
		var cHtml = '<option>请选择区域</option>';
			$.each(data, function(i,n){
				cHtml += '<option href="" class="mr10" data-id="'+n.id+'" value="'+n.id+'">'+n.qyName+'</option>';
			});
			$("#quyuId").html(cHtml);
		}
	});
}

function selectShangQuanData(){
	$.ajax({
		url: "<%=basePath%>/base/regionManager!selectShangQuanData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"sqname":$("#shangQuanId").val()},
		success: function(data){
		if(data>0){
				alert('名称已重复,请重新输入!');
				return fian;
			}else{
				fian=true;
				return fian;
		}
	  }
	});
}
//新增商圈
function addData(){
var quyuid = $("#quyuId").val();
var shangQuanName = $("#shangQuanId").val();
if(fian){
$.ajax({
		url: "<%=basePath%>/base/regionManager!addData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"qyID":quyuid,"sqname":shangQuanName},
		success: function(data){
			if(data != null){
				alert('添加成功!');
				jQuery('#country').modal('hide');
				window.location.reload();
			} else {
				alert('添加失败!');
			}
		}
	});

 }
}
function bainji(){
 var countryid = $("#country a.active").attr("data-id") == null ? 0 : $("#country a.active").attr("data-id");
if(countryid==0){
 alert('请选择正确的国家名称!');
} else {
jQuery('#guojia-gai').modal('show');
}
$.ajax({ 
		url: "<%=basePath%>/base/regionManager!selectState.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cid":countryid},
		success: function(data){
			var cHtml = '';
			$.each(data, function(i,n){
				$("#countryId").val(n.countryId);
				$("#countryName").val(n.cityName);
				if( null != n.coding && '' != n.coding){
					$("#cNameCodingdata").val(n.coding);
				} else {
					$("#cNameCodingdata").val('');
				}
			});
			
	    }
	});
	
}


function provincebiaji(){
 var proid = $("#pro a.active").attr("data-id") == null ? 0 : $("#pro a.active").attr("data-id");
 if(proid == 0 ){
 alert('请选择正确的省份名称!');
 } else {
 jQuery('#sheng-gai').modal('show');
 }
$.ajax({ 
		url: "<%=basePath%>/base/regionManager!selectProvince.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"pid":proid},
		success: function(data){
			var cHtml = '';
			$.each(data, function(i,n){
				$("#pid").val(n.Pid);
				$("#pName").val(n.cityName);
				if(n.coding != null && '' != n.coding){
					$("#provinceNameData").val(n.coding);
				} else {
					$("#provinceNameData").val('');
				}
			});
		}
	});
}
function citybiaji(){
var cityid = $("#city a.active").attr("data-id") == null ? 0 : $("#city a.active").attr("data-id");
 if(cityid == 0 ){
 alert('请选择正确的城市名称!');
 } else {
 jQuery('#cheng-gai').modal('show');
 }
$.ajax({ 
		url: "<%=basePath%>/base/regionManager!selectCityName.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cityID":cityid},
		success: function(data){
			var cHtml = '';
			$.each(data, function(i,n){
				$("#cityid").val(n.Pid);
				$("#cityName").val(n.cityName);
				if(n.coding != null && '' != n.coding){
					$("#citydataName").val(n.coding);
				} else {
					$("#citydataName").val('');
				}
			});
		}
	});
}

function biajiArea(){
 var qyId = $("#sQy a.active").attr("data-id") == null ? 0 : $("#sQy a.active").attr("data-id");
  if(qyId == 0 ){
 alert('请选择正确的区域名称!');
 } else {
 jQuery('#qu-gai').modal('show');
 }
$.ajax({
		url: "<%=basePath%>/base/regionManager!selectAreaData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"qyID":qyId},
		success: function(data){
		var cHtml = '';
			$.each(data, function(i,n){
			$("#qId").val(n.qyID);
			$("#qName").val(n.qyName);
			if(n.coding != null && '' != n.coding){
				$("#qyDataName").val(n.coding);
			} else {
				$("#qyDataName").val('');
			}
			});
		}
	});
}

function Empty(){
$("#cityName").val('');
$("#citydataName").val('');
}
function cEmpty(){
$("#countryName").val('');
$("#cNameCodingdata").val('');
}
function pEmpty(){
$("#pName").val('');
$("#provinceNameData").val('');
}
function qEmpty(){
$("#qName").val('');
$("#qyDataName").val('');
}

function coutnridEmpty(){
$("#cName").val('');
$("#cNameCoding").val('');
}
function provinceEmpty(){
$("#pname").val('');
$("#pnamedata").val('');
}
function cityEmpty(){
$("#cityname1").val('');
$("#citynamedata").val('');
}
function coutnridEmpty(){
$("#qyName").val('');
$("#qyNameData").val('');
}


function diquEmpty(){
$("#countrydataId").val('');
$("#pdataid").val('');
$("#polis").val('');
$("#quyuId").val('');
$("#shangQuanId").val('');
}


//删除国家
function updateDataState(){
var countryid = $("#country a.active").attr("data-id") == null ? 0 : $("#country a.active").attr("data-id");
if(confirm("确认要删除?")) {
$.ajax({
		url: "<%=basePath%>/base/regionManager!updateDataState.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cid":countryid},
		success: function(data){
		if(data>0){
				alert('删除成功!');
				jQuery('#guojia-gai').modal('hide');
				window.location.reload();
			} else {
				alert('删除失败!');
			}
		}
	});
	}
   }
//删除省份
function updateDataProvince(){
var proid = $("#pro a.active").attr("data-id") == null ? 0 : $("#pro a.active").attr("data-id");
var shtml  = $("#city").text();
if(shtml == "" || shtml == "undefined" || shtml== "城市：不限"){
if(confirm("确认要删除?")) {
$.ajax({
		url: "<%=basePath%>/base/regionManager!updateDataProvince.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"pid":proid},
		success: function(data){
		if(data>0){
				alert('删除成功!');
				jQuery('#sheng-gai').modal('hide');
				window.location.reload();
			} else {
				alert('删除失败!');
			}
		}
	});
	}
} else {
	alert('该省份下有城市不能进行删除!');
   }
}
//删除城市
function updateDataCity(){
var cityid = $("#city a.active").attr("data-id") == null ? 0 : $("#city a.active").attr("data-id");
var shtml  = $("#sQy").text();
if(shtml == "" || shtml == "undefined" || shtml== "区域：不限"){
if(confirm("确认要删除?")) {
$.ajax({
		url: "<%=basePath%>/base/regionManager!updateDataCity.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cityID":cityid},
		success: function(data){
		if(data>0){
				alert('删除成功!');
				jQuery('#cheng-gai').modal('hide');
				window.location.reload();
			} else {
				alert('删除失败!');
			}
		}
	});
	}
	} else {
		alert("该城市下有区域不能进行删除!");
	}
}
//删除区域
function updateDataArea(){
 var qyId = $("#sQy a.active").attr("data-id") == null ? 0 : $("#sQy a.active").attr("data-id");
 var shtml  = $("#tbodyData").text();
 if(shtml == "" || shtml == "undefined"){
  if(confirm("确认要删除?")) {
 		$.ajax({
		url: "<%=basePath%>/base/regionManager!updateDataArea.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"qyID":qyId},
		success: function(data){
		if(data>0){
				alert('删除成功!');
				jQuery('#qu-gai').modal('hide');
				window.location.reload();
			} else {
				alert('删除失败!');
			}
		}
	});
	}
 } else {
 		alert('该区域下有商圈不能删除该区域！');
 	}
}
</script>
