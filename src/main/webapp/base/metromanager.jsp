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
		<title>地铁管理</title>
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/bootstrap.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-core.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-forms.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-components.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/xenon-skins.css">
		<link rel="stylesheet" href="<%=basePath%>/assets/css/custom.css">
		<script src="<%=basePath%>/assets/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=cwWUeu7m6ZIclzyUBhqMrA05"></script>
		<script type="text/javascript" src="<%=basePath%>/js/ext/exttab/js/ext-base.js" ></script> 
		<script type="text/javascript" src="<%=basePath%>/js/ext/exttab/js/ext-all.js" ></script> 
		<script src="<%=basePath%>/js/base/LpMetroManager.js"></script>
		<script src="<%=basePath%>/assets/js/page.js"></script>
		<script src="<%=basePath%>/js/services.js"></script>
	<%-- 	<script src="<%=basePath%>/assets/js/base/base.js"></script> --%>
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
								<strong><a href="<%=basePath%>/base/lpMetroManager.action?k=base&p=dt">地铁管理</a></strong>
							</li>
						</ol>
					</div>
				</div>
						<div class="panel panel-default">
							<div class="row">
								<div class="col-md-12" style="display:none">
									<div class="Color pull-left h5" id="country">
									</div>
								</div>
								<div class="col-md-12">
									<div class="Color pull-left h5" id="pro">
									</div>
								</div>
								<div class="col-md-12">
									<div class="Color pull-left h5" id = "city">
									</div>
								</div>
								<div class="col-md-12">
									
									<div class="Color pull-left h5" id = "leiBie">
									</div>
								</div>
								<div class="col-md-12">
									<div class="Color pull-left h5" id = "xianlu" >
									</div>
								</div>
							</div>
						</div>
		
						<div class="panel panel-default">
							<div class="input-group col-lg-3" style="padding-bottom: 10px;" >
								<input type="text" class="form-control no-right-border form-focus-purple"  placeholder="请输入站点名称" id="zdUserName">
								<span class="input-group-btn">
									<a href="#" class="btn btn-success" onclick="queryData()">搜索</a>
								</span>
							</div>
							<div>
								<button class="btn btn-secondary" data-toggle="modal" type="button" onclick="jQuery('#shangquan').modal('show');selectCountryData();selectProvinceData(<%=countryId%>);city(<%=provinceId%>);selectLeiBei(<%=cityId%>)"><i class="fa-plus"></i> 新增 </button>
								<button class="btn btn-danger"  type="button" onclick="batchRemoveData();"><i class="fa-trash-o"></i> 批量删除 </button>
							</div>
					<div class="table-responsive">
						<table class="table table-bordered table-striped table-condensed">
							<thead>
								<tr>
									<th data-priority="3"class="text-center hidden-480" width="9%"><input type="checkbox" onclick="checkAll(this)"/></th>
									<th data-priority="3"class="text-center hidden-480" width="19%">城市</th>
		                            <th data-priority="3"class="text-center hidden-480" width="19%">线路</th>
		                            <th data-priority="3" class="text-center hidden-480" width="19%">站点</th>
		                            <th data-priority="3"class="text-center hidden-480" width="19%">操作</th>
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
<script src="<%=basePath%>/assets/js/bootstrap.min.js"></script>
<script src="<%=basePath%>/assets/js/TweenMax.min.js"></script>
<script src="<%=basePath%>/assets/js/resizeable.js"></script>
<script src="<%=basePath%>/assets/js/joinable.js"></script>
<script src="<%=basePath%>/assets/js/xenon-api.js"></script>
<script src="<%=basePath%>/assets/js/xenon-toggles.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/xenon-widgets.js"></script>
<script src="<%=basePath%>/assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script src="<%=basePath%>/assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>
<script src="<%=basePath%>/assets/js/toastr/toastr.min.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=basePath%>/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script src="<%=basePath%>/assets/js/tocify/jquery.tocify.min.js"></script>
<!-- JavaScripts initializations and stuff -->
<script src="<%=basePath%>/assets/js/xenon-custom.js"></script>

<!--交通-->
<div class="modal fade" id="jiao-zeng" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">新增</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
					<form role="form" class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-3 control-label">交通名称：</label>
							<div class="col-sm-8">
									<input type="text" class="form-control"  onblur="selectDataLeiBei()" id = "leibeiName"/>
								</div>
							</div>
					</form>

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="addLeiBei()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="jiao-gai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">编辑</h4>
				</div>
					<div class="modal-body">
						<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
<!-- 							<form role="form" class="form-horizontal"> -->
<!-- 									<div class="form-group"> -->
<!-- 										<div class="input-group input-group-minimal"> -->
<!-- 											<input type="hidden" id="leibeiDataID"> -->
<!-- 											<input type="email" class="form-control" id = "leibeiDataName"> -->
<!-- 												<a href="#" class="input-group-addon" title="清空" onclick="Empty()"></a> -->
<!-- 												<a href="#" class="input-group-addon" title="点击删除" onclick="updateDataLeiBei()"> -->
<!-- 												<i class="fa-trash-o"></i> -->
<!-- 											</a> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 							</form> -->
								<table class="table">
					           	  <tbody>
					              <tr>
					              	<td width="120px">交通名称：</td>
					                <td>
					              		<div class="input-group input-group-minimal">
					              		<input type="hidden" id="leibeiDataID">
						            	<input type="email" class="form-control" id = "leibeiDataName">
										<a href="#" class="input-group-addon" title="点击删除" onclick="updateDataLeiBei()">
										<i class="fa-trash-o"></i>
										</a>
										</div>
									</td>
					              </tr>
					            </tbody>
		          			</table>
						</div>
					</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info" onclick="updateLeiBei()">保存</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
				</div>
		</div>
	</div>
</div>

<!--线路-->
<div class="modal fade" id="xian-zeng" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">新增</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
					<form role="form" class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-3 control-label">线路名称：</label>
							<div class="col-sm-8">
										<input type="hidden" id="xianluDataID">
									<input type="text" class="form-control" id = "xianluDateName"  onblur="selectXianluData()"/>
							</div>
						</div>
					</form>

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="addXianLu()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="xian-gai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">编辑</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
<!-- 					<form role="form" class="form-horizontal"> -->
<!-- 						<div class="form-group"> -->
<!-- 							<div class="input-group input-group-minimal"> -->
<!-- 								<input type="email" class="form-control" id ="xianluDataName"> -->
<!-- 								<a href="#" class="input-group-addon" title="清空" onclick="xianluEmpty()"></a> -->
<!-- 								<a href="#" class="input-group-addon" title="点击删除" onclick="updateXianLuData()"> -->
<!-- 									<i class="fa-trash-o"></i> -->
<!-- 								</a> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</form> -->
						<table class="table">
			            <tbody>
			              <tr>
			              	<td width="120px">线路名称：</td>
			                <td>
			              		<div class="input-group input-group-minimal">
				            	<input type="email" class="form-control" id ="xianluDataName">
								<a href="#" class="input-group-addon" title="点击删除" onclick="updateXianLuData()">
								<i class="fa-trash-o"></i>
								</a>
								</div>
							</td>
			              </tr>
			            </tbody>
		          </table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="updatexianlu()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!--交通线路-->
<div class="modal fade" id="shangquan" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">新增交通线路</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
					<form role="form" class="form-horizontal" name="pageForm" id="pageForm">
						<h4><b>基本信息</b></h4>
						<div class="form-group-separator"></div>
						<div class="form-group">
						<label class="col-sm-3 control-label">国家：</label>
						<div class="col-sm-8">
							<select class="form-control" id = "countrydataId" onchange="selectProvinceData(this)">
							</select>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-3 control-label">省份：</label>
						<div class="col-sm-8">
							<select class="form-control" id = "pdataid" onchange="city(this)">
							</select>
						</div>
					</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">城市：</label>
							<div class="col-sm-8">
								<select class="form-control" id ="polis" onchange="selectLeiBei(this)" name="cityID">
								</select>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">站点类别：</label>
							<div class="col-sm-8">
								<select class="form-control" id = "zdLeiBei" onchange="selectXianLu(this)" name="leibeiID">
								</select>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">新增站点名称：</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id = "zdName" name="zdName" onblur="selectDataZD()">
							</div>
						</div>
						<div class="form-group">
									<div class="col-md-12">
										
										<label class="col-sm-3 control-label" for="field-1"><span style="color:red">坐标地址</span></label>
										<div class="col-md-4">
											<input type="text" class="col-xs-6 wenbenkuan1" id="xxzbx" name="x" readonly>
											<input type="text" class="col-xs-6 wenbenkuan1" id="xxzby" name="y" readonly>
										</div>
<!-- 										<a href="javascript:void(0)" class="btn btn-success" id="loadXY">获取位置</a> -->
										<input type="hidden" class="form-control" id="address" name="condition.xhjLpschool.address" >
										<a class="btn btn-secondary" id="loadXY"  data-toggle="modal" data-target="#map-info-windom">获取位置</a>
									</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">站点线路选择：</label>
							<div class="col-sm-8">
								<input type="hidden" id ="zdXianLuDAata" >
								<div class="form-block" id = "zdXianLu">
								</div>
							</div>
						</div>
						<div class="form-group-separator"></div>
					</form>

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="insertDataZD()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="zdEmpty()">关闭</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="shangquan-gai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">修改交通线路</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable ps-container" data-max-height="400" style="max-height: 400px;">
					<form role="form" class="form-horizontal">
						<h4><b>基本信息</b></h4>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">城市：</label>
							<div class="col-sm-8">
									<input type="text" class="form-control" id ="cityName" readonly="readonly">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">站点类别：</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id ="zhandiaLeiBei" readonly="readonly">
							</div>
						</div>
						
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">站点名称：</label>
							<div class="col-sm-8">
							<input type="hidden" id="ciD">
							<input type="hidden" id="ZiD">
								<input type="text" class="form-control" id = "jtzName" name = "jtzName" >
							</div>
						</div>
						<div class="form-group">
									<div class="col-md-12">
										
										<label class="col-sm-3 control-label" for="field-1"><span style="color:red">坐标地址</span></label>
										<div class="col-md-4">
											<input type="text" class="col-xs-6 wenbenkuan1" id="xxzbx1" name="x" readonly>
											<input type="text" class="col-xs-6 wenbenkuan1" id="xxzby1" name="y" readonly>
										</div>
<!-- 										<a href="javascript:void(0)" class="btn btn-success" id="loadXY">获取位置</a> -->
										<input type="hidden" class="form-control" id="address1" name="condition.xhjLpschool.address" >
										<a class="btn btn-secondary" id="loadXY1"  data-toggle="modal" data-target="#map-info-windom">获取位置</a>
									</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label">站点线路选择：</label>
							<div class="col-sm-8">
								<div class="form-block" >
									<div class="form-block" id = "xianLu_Name" >
								</div>
								</div>
							</div>
						</div>
						<div class="form-group-separator"></div>
						
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" onclick="updateDataXianLu()">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="$('#shangquan-gai').hide();"id = "closeEdit">关闭</button>
			</div>
			</div>
		</div>
	</div>
</div>

<!--线路图片-->
<div class="modal fade" id="xianlutu">
	<div class="modal-dialog">
		<div class="col-md-3 col-sm-4 col-xs-12">
			<div class="album-image">
				<a href="#" class="thumb" data-action="edit">
					<img src="<%=basePath%>/assets/images/tupian.jpg">
				</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var cityId="<%=cityId%>";
	var countryId="<%=countryId%>";
	var provinceId="<%=provinceId%>";
function xianName(){  //jquery获取复选框值  
	var chk_value ="";  
	$('input[name="zdXian"]:checked').each(function(){  

	 chk_value=chk_value+$(this).val()+",";  
	
	}); 
	chk_value=chk_value.substring(0,chk_value.length-1);
	return chk_value

}
var basePath="<%=basePath%>";
$(function(){
buildCountry();
buildPro(countryId);
buildCity(provinceId);
leiBie(cityId);
xianlu(362);
});
var cityID;
var fian = false;
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
			$("#country").html(cHtml);
	    }
	});
	queryData();
};

function buildPro(val){
	var countryIdData =val;
	$("#country a").removeClass("active");
	$("#country a[data-id='"+countryIdData+"']").addClass("active");
	$("#city").html("");
	$("#leiBie").html("");
	$("#xianlu").html("");
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
			$("#pro").html(pHtml);
	    }
	});
	queryData();
};

function buildCity(val){
	var provinceIdData=val;
	$("#pro a").removeClass("active");
	$("#pro a[data-id='"+provinceIdData+"']").addClass("active");
	$("#city").html("");
	$("#leiBie").html("");
	$("#xianlu").html("");
	$.ajax({ 
		url: "<%=basePath%>/cam/campus!getCity.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"pid" : provinceIdData},
		success: function(data){
			var cHtml = '<span>城市：</span><a href="javascript:leiBie(0)" class="mr10 active" data-id="0">不限</a>';
			$.each(data, function(i,n){
				if(i % 8 == 0 && i > 0) {
					cHtml += "<br>";
				}
				cHtml += '<a href="javascript:leiBie('+n.id+')" class="mr10" data-id="'+n.id+'">'+n.cityName+'</a>';
			});
			$("#city").html(cHtml);
	    }
	});
	queryData();
};

function leiBie(val){
var cityIDData = val;
$("#city a").removeClass("active");
$("#city a[data-id='"+cityIDData+"']").addClass("active");
$("#xianlu").html("");
$.ajax({ 
	url: "<%=basePath%>/base/lpMetroManager!getJiaoTong.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"cityID" : cityIDData},
		success: function(data){
			var cHtml = '<span>交通：</span><a href="javascript:void(0)" class="mr10 active" data-id="0">不限</a>';
			if(cityID!=0){
			$.each(data, function(i,n){
				cHtml += '<a href="javascript:xianlu(\''+n.id+'\')" class="mr10" data-id="'+n.id+'">'+n.name+'</a>';
			});
			}
			var dHtml = '<div class="pull-right">';
			dHtml += '<button class="btn btn-secondary  btn-xs" data-toggle="modal" type="button" onclick="leibeibiaji()"><i class="fa-pencil"></i> 编辑</button>';
			dHtml += '<button class="btn btn-success  btn-xs" data-toggle="modal" data-target="#jiao-zeng" type ="button"><i class="fa-plus"></i> 新增</button>';
			dHtml += '</div>';
			$("#leiBie").html(cHtml);
			$("#leiBie").parent().find("div").eq(1).remove();
			$("#leiBie").parent().append(dHtml);
			$("#leiBie a").click(function(){
			$("#leiBie a").removeClass("active");
			$(this).addClass("active");
			queryData();
			});
	    }
	});
	queryData();
};

function xianlu(val){
$("#leiBie a").removeClass("active");
$("#leiBie a[data-id='"+val+"']").addClass("active");
	$.ajax({ 
		url: "<%=basePath%>/base/lpMetroManager!getXianLu.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"cityID" : cityID,"leiBeiID":val},
			success: function(data){
				var cHtml = '<span>线路：</span><a href="javascript:void(0)" class="mr10 active" data-id="0">不限</a>';
				$.each(data, function(i,n){
					if(i % 11 == 0 && i > 0) {
						cHtml += "<br><a style='margin-left:50px'>";
					}
					cHtml += '<a href="javascript:void(0)" class="mr10" data-id="'+n.xianID+'">'+n.xianLuName+'</a>';
				});
				var dHtml = '<div class="pull-right">';
				dHtml += '<button class="btn btn-secondary  btn-xs" data-toggle="modal" type="button" onclick="xianlubiaji()"><i class="fa-pencil"></i> 编辑</button>';
				dHtml += '<button class="btn btn-success  btn-xs" data-toggle="modal"  type ="button"  onclick="addDataXianLu()"><i class="fa-plus"></i> 新增</button>';
				dHtml += '</div>';
				$("#xianlu").html(cHtml);
				$("#xianlu").parent().find("div").eq(1).remove();
				$("#xianlu").parent().append(dHtml);
				$("#xianlu a").click(function(){
				$("#xianlu a").removeClass("active");
				$(this).addClass("active");
				queryData();
				});
		    }
		});
		queryData();
	};
	
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
//获取所有城市
function city(obj){
var provinceDataID;
if(obj.value!=null&&obj.value!=''){
provinceDataID=obj.value;
}else{
provinceDataID=obj;
}
		$.ajax({ 
			url: "<%=basePath%>/base/lpMetroManager!selectCity.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"pid":provinceDataID},
		success: function(data){
			var cHtml = '<option>请选择城市</option>';
			$.each(data, function(i,n){
				cHtml += '<option href="javascript:selectLeiBei(\''+n.id+'\')"  class="mr10" data-id="'+n.cityID+'" value="'+n.cityID+'">'+n.cityName+'</option>';
			});
			$("#polis").html(cHtml);
	    }
	});
	$("#polis option[value='"+cityId+"']").attr("selected", true); 
};

//获取所有类别
function selectLeiBei(obj){
var cityDataID;
if(obj.value!=null&&obj.value!=''){
cityDataID=obj.value;
}else{
cityDataID=obj;
}

	$.ajax({ 
		url: "<%=basePath%>/base/lpMetroManager!selectLeiBei.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data:{"CityID":cityDataID},
		success: function(data){
			var cHtml = '<option>请选择类别</option>';
			$.each(data, function(i,n){
				cHtml += '<option href="javascript:selectXianLu(\''+n.id+'\')" class="mr10" data-id="'+n.id+'" value="'+n.id+'-'+cityDataID+'">'+n.name+'</option>';
			});
			$("#zdLeiBei").html(cHtml);
	    }
	});
};
//查询所有线路
function updateXianLu(obj,val){
	$.ajax({ 
		url: "<%=basePath%>/base/lpMetroManager!selectXianLu.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data:{"LeiBei_ID":obj,"cityID":val},
		success: function(data){
			var cHtml = '';
			$.each(data, function(i,n){
				cHtml += '<input type="checkbox" name="zdXian" id="'+n.xianID+'" value="'+n.xianID+'"/><lable href="" class="mr10" data-id="'+n.xianID+'">'+n.xianLuName+'</lable>';
			});
			$("#xianLu_Name").html(cHtml);
	    }
	});
};


function selectXianLu(obj){
vai = obj.value.substring(0,obj.value.indexOf("-"));
val = obj.value.substring(obj.value.indexOf("-")+1,obj.value.length);
var xianluID;
if(vai.value!=null&&vai.value!=''){
xianluID=vai.value;
}else{
xianluID=vai;
}
$.ajax({ 
	url: "<%=basePath%>/base/lpMetroManager!selectXianLu.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data:{"LeiBei_ID":xianluID,"cityID":val},
		success: function(data){
			var cHtml = '';
			$.each(data, function(i,n){
				cHtml += '<input type="checkbox" name="zdXian" value="'+n.xianID+'"/><lable href="" class="mr10" data-id="'+n.xianID+'">'+n.xianLuName+'</lable>';
			});
			$("#zdXianLu").html(cHtml);
	    }
	});
};

function selectDataZD(){
	$.ajax({
		url: "<%=basePath%>/base/lpMetroManager!selectDataZD.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"zdName":$("#zdName").val()},
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

//添加商圈
function insertDataZD(){
	var res = $("#polis").val();
	var reszd = $("#zdLeiBei").val();
	var resu = $("#zdName").val();
	var str = xianName();
	if(str == ''){
	alert('请选择正确的线路名称');
	}
	if(null != $("#xxzbx").val() && '' !=  $("#xxzbx").val()){
	 var x = $("#xxzbx").val();
	}
	if(null != $("#xxzby").val() && '' !=  $("#xxzby").val()) {
		var y = $("#xxzby").val();
	}
if(fian){
$.ajax({ 
		url: "<%=basePath%>/base/lpMetroManager!insertDataZD.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"cityID":res,"leiBeiID":reszd,"zdName":resu,"xianID":str,"x":x,"y":y},
		success: function(data){
			if(data != null){
				alert('添加成功!');
				window.location.reload();
			} else {
				alert('添加失败!');
			}
	    }
	});
   }
};
		
		
		
//批量删除
function batchRemoveData(val){

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
	url: "<%=basePath%>/base/lpMetroManager!batchRemoveData.action",
	dataType: "json", 
	type: "POST",
	async : false,
	data :{"zhanID":ids},
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
};
//单个删除
function deldata(value){
if(confirm("确认要删除?")) {
	$.ajax({
		url : "<%=basePath%>/base/lpMetroManager!batchRemoveData.action", 
		dataType : "json", 
		type : "POST",
		data : {"zhanID" : value},
		success : function(result){
			if(result>0){
				alert('删除成功!');
				queryData();
			} else {
				alert('删除失败!');
			}
    	}
	});
	}
}	
var fian=false;


//新增类别进行判断
function selectDataLeiBei(){
	$.ajax({
		url: "<%=basePath%>/base/lpMetroManager!selectDataLeiBei.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"leiBeiName": $("#leibeiName").val()},
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

//新增线路进行判断
function selectXianluData(){
	$.ajax({
		url: "<%=basePath%>/base/lpMetroManager!selectXianluData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"xianLuName":$("#xianluDateName").val()},
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
//新增交通类别
function addLeiBei(){
var leibeiName = $("#leibeiName").val();
if(fian){
$.ajax({
		url: "<%=basePath%>/base/lpMetroManager!addLeiBei.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"leiBeiName":leibeiName},
		success: function(data){
		
		var cHtml = '';
		if(data != null){
				alert('添加成功!');
				cHtml = '<a href="" class="mr10" data-id="'+data.id+'">'+data.name+'</a>';
				jQuery('#jiao-zeng').modal('hide');
				window.location.reload();
			} else {
				alert('添加失败!');
			}
				$("#leiBie").html(cHtml);
		}
	});	
  }
}
function leibeibiaji(){
 var leiBieId = $("#leiBie a.active").attr("data-id") == null ? 0 : $("#leiBie a.active").attr("data-id");
  if(leiBieId == 0 ){
 alert('请选择正确的类别名称!');
 } else {
 jQuery('#jiao-gai').modal('show');
 }
$.ajax({ 
		url: "<%=basePath%>/base/lpMetroManager!selectLeiBeiData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"leiBeiID":leiBieId},
		success: function(data){
			var cHtml = '';
			$.each(data, function(i,n){
				$("#leibeiDataID").val(n.leibeiID);
				$("#leibeiDataName").val(n.leibeiName);
			});
		}
	});
}
//修改类别
function updateLeiBei(){
var leibeiDataName = $("#leibeiDataName").val();
 var leiBieId = $("#leiBie a.active").attr("data-id") == null ? 0 : $("#leiBie a.active").attr("data-id");
$.ajax({
		url: "<%=basePath%>/base/lpMetroManager!updateLeiBei.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"leiBeiName":leibeiDataName,"leiBeiID":leiBieId},
		success: function(data){
		if(data>0){
				alert('修改成功!');
				jQuery('#jiao-gai').modal('hide')
				window.location.reload();
			} else {
				alert('修改失败!');
			}
		}
	});
}
//新增线路进行判断
function selectXianluData(){
	$.ajax({
		url: "<%=basePath%>/base/lpMetroManager!selectXianluData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"xianLuName":$("#xianluDateName").val()},
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
function addDataXianLu(){
var leiBieId = $("#leiBie a.active").attr("data-id") == null ? 0 : $("#leiBie a.active").attr("data-id");
 if(leiBieId == 0 ){
 alert('请选择正确的类别名称!');
 } else {
 jQuery('#xian-zeng').modal('show');
 }
 }
//新增线路
function addXianLu(){
var xianluName = $("#xianluDateName").val();
 var leiBieId = $("#leiBie a.active").attr("data-id") == null ? 0 : $("#leiBie a.active").attr("data-id");
 var cityid = $("#city a.active").attr("data-id") == null ? 0 : $("#city a.active").attr("data-id");
 if(fian){
$.ajax({
		url: "<%=basePath%>/base/lpMetroManager!addXianLu.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"xianLuName":xianluName,"leiBeiID":leiBieId,"cityID":cityid},
		success: function(data){
		var cHtml = '';
		if(data != null){
				alert('添加成功!');
				cHtml += '<a href="" class="mr10" data-id="'+data.id+'">'+data.xianLuName+'</a>';
				jQuery('#xian-zeng').modal('hide');
				window.location.reload();
			} else {
				alert('添加失败!');
			}
				$("#xianlu").html(cHtml);
		}
	});
}
}

function xianlubiaji(){
 var xianluId = $("#xianlu a.active").attr("data-id") == null ? 0 : $("#xianlu a.active").attr("data-id");
 if(xianluId == 0 ){
 alert('请选择正确的线路名称!');
 } else {
 jQuery('#xian-gai').modal('show');
 }
$.ajax({ 
		url: "<%=basePath%>/base/lpMetroManager!selectDateXianlu.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"xianID":xianluId},
		success: function(data){
			var cHtml = '';
			$.each(data, function(i,n){
				$("#xianluDataID").val(n.xianID);
				$("#xianluDataName").val(n.xianLuName);
			});
		}
	});
}
//修改线路
function updatexianlu(){
var xianluDataName = $("#xianluDataName").val();
 var xianluId = $("#xianlu a.active").attr("data-id") == null ? 0 : $("#xianlu a.active").attr("data-id");
$.ajax({
		url: "<%=basePath%>/base/lpMetroManager!updateXianLu.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"xianLuName":xianluDataName,"xianID":xianluId},
		success: function(data){
		if(data>0){
				alert('修改成功!');
				jQuery('#xian-gai').modal('hide')
				window.location.reload();
			} else {
				alert('修改失败!');
			}
		}
	});
}

/**
 * 修改页面的数据根据ID查询
 * @return
 */
function selectData(cityName,zdName,val,obj,ciD,x,y){
$.ajax({
		url: "<%=basePath%>/base/lpMetroManager!selectData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"zhanID":val,"leiBeiID":obj},
		success: function(data){
			var cHtml = '';
			$.each(data, function(i,n){
				$("#cityName").val(cityName);
				$("#zhandiaLeiBei").val(n.leibeiName);
				$("#jtzName").val(zdName);
					$("#ZiD").val(val);
					$("#ciD").val(ciD);
					if(x != '' && x != null)
					{
						$("#xxzbx1").val(x);
					} else {
						$("#xxzbx1").val('');
					}
					if(y != '' && y != null)
					{
						$("#xxzby1").val(y);
					} else {
						$("#xxzby1").val('');
					}
					
				checkbox(n.xianID);
			});
		}
	});
}

	function   checkbox(obj){
		var limitField=obj;
		if(limitField!=""){
		/* 	var obj = eval('(' + limitField + ')'); */
			var checkbox_query=$("#xianLu_Name :checkbox");
			for(var i=0;i<checkbox_query.length;i++){
				var checkbox=checkbox_query[i];
				if(limitField.indexOf(checkbox.id)>=0){
					checkbox.checked=true;
				}
			}
		}
		
	} 

//修改数据
function updateDataXianLu(){
var xianNameData = xianName();
var jtzName =  $("#jtzName").val();
if(null != $("#xxzbx1").val() && '' !=  $("#xxzbx1").val()){
 var x = $("#xxzbx1").val();
}
if(null != $("#xxzby1").val() && '' !=  $("#xxzby1").val()) {
	var y = $("#xxzby1").val();
}
$.ajax({
		url: "<%=basePath%>/base/lpMetroManager!updateDataXianLu.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"xianID":xianNameData,"zdName":jtzName,"cityID":$("#ciD").val(),"zhanID":$("#ZiD").val(),"x":x,"y":y},
		success: function(data){
		if(data>0){
				alert('修改成功!');
				jQuery('#shangquan-gai').modal('hide');
				$("#closeEdit").click();
				queryData();
			} else {
				alert('修改失败!');
			}
		}
	});
}



function Empty(){
$("#leibeiDataName").val('');
}
function xianluEmpty(){
$("#xianluDataName").val('');
}
function zdEmpty(){
$("#countrydataId").val('');
$("#pdataid").val('');
$("#polis").val('');
$("#zdLeiBei").val('');
$("#zdName").val('');
$("#xxzbx").val('');
$("#xxzby").val('');
$("#zdXianLu").val('');
}


//删除类别
function updateDataLeiBei(){
 var leiBieId = $("#leiBie a.active").attr("data-id") == null ? 0 : $("#leiBie a.active").attr("data-id");
 var shtml  = $("#xianlu").text();
if(shtml == "" || shtml == "undefined" || shtml== "线路：不限"){
if(confirm("确认要删除?")) {
$.ajax({
		url: "<%=basePath%>/base/lpMetroManager!updateDataLeiBei.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"leiBeiID":leiBieId},
		success: function(data){
		if(data>0){
				alert('删除成功!');
				jQuery('#jiao-gai').modal('hide')
				window.location.reload();
			} else {
				alert('删除失败!');
			}
		}
	});
	}
} else {
    alert('该类别下面有线路不能进行删除！');
  }
}
//删除线路
function updateXianLuData(){
 var xianluId = $("#xianlu a.active").attr("data-id") == null ? 0 : $("#xianlu a.active").attr("data-id");
  var shtml  = $("#tbodyData").text();
 if(shtml == "" || shtml == "undefined"){
 if(confirm("确认要删除?")) {
$.ajax({
		url: "<%=basePath%>/base/lpMetroManager!updateXianLuData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"xianID":xianluId},
		success: function(data){
		if(data>0){
				alert('删除成功!');
				jQuery('#xian-gai').modal('hide')
			window.location.reload();
			} else {
				alert('删除失败!');
			}
		}
	});
	}
   }else {
   		alert('该线路下有地铁站不能删除该线路！');
   }
}

$("#loadXY1").click(function(){
		$("#up").val("1");
// 		$(this).attr("data-toggle","modal").attr("data-url",basePath + "/campus/seekCoord.jsp?sqaddress="+encodeURI(encodeURI($("#jtzName").val()))).attr("href","#infoModal");
// 		$("#infoModal").load($(this).attr("data-url"));
	});
// function setXandY(x,y,address,winClose){
// 	if(!isUpdate){
// 		$("#lpxxx").val(x);
// 		$("#lpxxy").val(y);
// 	} else {
// 		$("#lpxx").val(x);
// 		$("#lpxy").val(y);
// 	}
// 	$("#" + winClose).click();
// };
// function setXandY(x,y,address,winClose){
// 	parent.document.getElementById("lpxx").value = x;
// 	parent.document.getElementById("lpxy").value = y;
// 	parent.document.getElementById("address").value = address;
// 	parent.document.getElementById("windowClose").click();
// };
</script>
<div class="modal fade" id="infoModal" data-backdrop="static"></div>

<div class="modal fade" id="map-info-windom">
	<input type="text" id="up" value="0">
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