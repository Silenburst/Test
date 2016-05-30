<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
			UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
			
	String BMSPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/BMS";
	String id = request.getParameter("id");
	String type = request.getParameter("type");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>房源采集管理</title>
<link rel="stylesheet" href="../assets/css/bootstrap.css">
		<link rel="stylesheet" href="../assets/css/fonts/linecons/css/linecons.css">
		<link rel="stylesheet" href="../assets/css/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="../assets/css/xenon-core.css">
		<link rel="stylesheet" href="../assets/css/xenon-forms.css">
		<link rel="stylesheet" href="../assets/css/xenon-components.css">
		<link rel="stylesheet" href="../assets/css/xenon-skins.css">
		<link rel="stylesheet" href="../assets/css/custom.css">
		<link rel="stylesheet" href="../assets/css/xiaoqu.css">
		<link rel="stylesheet" href="../assets/js/bootbox/bootbox.css">
		<link rel="stylesheet" href="../assets/js/select2/select2.css">
		<link rel="stylesheet" href="../assets/js/select2/select2-bootstrap.css">
		<link rel="stylesheet" href="../assets/js/multiselect/css/multi-select.css">
		
		<script src="./common.js"></script>
		<script src="../assets/js/jquery-1.11.1.min.js"></script>
		<script src="./jquery.timers-1.2.js"></script>
		
		<script src="../assets/js/page.js"></script>
		<script src="../assets/js/bootbox/bootbox.min.js"></script>
		<script src="../js/ajaxpage/pagination.js"></script>
		<script src="../assets/js/select2/select2.min.js"></script>
		<script src="../assets/js/select2/select2_locale_zh-CN.js"></script>
		<script src="../assets/js/xenon-custom.js"></script>
		<script src="../js/jquery.form.js"></script>
		<script type="text/javascript" src="../js/plupload/plupload.full.min.js"></script>
		<script type="text/javascript" src="../js/plupload/i18n/zh_CN.js"></script>

		<style>
			.radioLabel { padding-right: 20px; }
			.btnMultiselect { padding: 0px;font-size: 12px; }
			.errorLabel { padding: 4px;margin: 0px; display: none; }
		</style>
</head>
<body class="page-body">

<div class="page-container">
	<div class="sidebar-menu toggle-others fixed">
		<jsp:include page="../include/left.jsp"/>
	</div>
	<div class="main-content">
		<%-- <jsp:include page="../include/top.jsp"/> --%>

		<div class="page-title">
			<div class="breadcrumb-env pull-left">
				<ol class="breadcrumb bc-1">
					<li>
						<a href="../index.html"><i class="fa-home"></i>首页</a>
					</li>
					<li>
						<span>房源采集</span>
					</li>
					<li class="active">
						<strong>秒发</strong>
					</li>
				</ol>
			</div>
		</div>
		
		<div class="panel">

				<form role="form" class="form-horizontal" id="postform" method="post" enctype="multipart/form-data">
				<div class="row">

					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">住宅信息</h3>
								<div class="panel-options">
									<a href="#" data-toggle="panel"> <span class="collapse-icon">&ndash;</span> <span class="expand-icon">+</span> </a> <a href="#" data-toggle="remove"> &times; </a> </div>
							</div>

							<div class="panel-body">
									<br>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 小区：</label>
											<div class="col-sm-4">
												<input type="hidden" id="selectXiaoQu" />
											</div>
											<div class="col-sm-2 alert alert-danger errorLabel" role="alert" id="selectXiaoQuLabel">
												<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>请选择一个小区
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 区域：</label>
											<div class="col-sm-2" style="display: none;">
												<select class="form-control sboxit-2" id="cityId">
												</select>
											</div>
											<div class="col-sm-2">
												<select class="form-control sboxit-2" id="qyId" onchange="onQyChange();">
												</select>
											</div>
											<div class="col-sm-2">
												<select class="form-control sboxit-2" id="sqId">
												</select>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 地址：</label>
											<div class="col-sm-6">
												<input type="text" class="form-control"  name="address" id="address" placeholder="">
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 面积：</label>
											<div class="col-sm-3">
												<input type="number" name="area" id="area" class="form-control">
											</div>
											<div class="line32 text-center" style="float: left;">平方米</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 户型：</label>
											<div class="col-sm-1">
												<select class="form-control" name="hx_s" id="hx_s">
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="5">6</option>
													<option value="5">7</option>
													<option value="5">8</option>
													<option value="5">9</option>
												</select>
											</div>
											<div class="line32 text-center" style="width: 20px;float: left;">室</div>
											<div class="col-sm-1">
												<select class="form-control" name="hx_t" id="hx_t">
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
												</select>
											</div>
											<div class="line32 text-center" style="width: 20px;float: left;">厅</div>
											<div class="col-sm-1">
												<select class="form-control" name="hx_c" id="hx_c">
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
												</select>
											</div>
											<div class="line32 text-center" style="width: 20px;float: left;">厨</div>
											<div class="col-sm-1">
												<select class="form-control" name="hx_w" id="hx_w">
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
												</select>
											</div>
											<div class="line32 text-center" style="width: 20px;float: left;">卫</div>
											<div class="col-sm-1">
												<select class="form-control" name="hx_y" id="hx_y">
													<option value="0">0</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
												</select>
											</div>
											<div class="line32 text-center" style="width: 30px;float: left;">阳台</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 楼层：</label>
											<div class="col-sm-1">
												<input type="number" name="lc_d" id="floor_c" class="form-control" placeholder="">
											</div>
											<div class="line32 text-center" style="width: 40px;float: left;">楼&nbsp;,&nbsp;共</div>
											<div class="col-sm-1">
												<input type="number" name="lc_z" id="floor_z" class="form-control" placeholder="">
											</div>
											<div class="line32 text-center" style="width: 20px;float: left;">楼</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 价位：</label>
											<div class="col-sm-4">
												<div class=" pull-left">
													<input type="text" class="form-control pull-left"  name="price" id="price">
												</div>
												<div class=" pull-left">
													<select class="form-control" id="price_unit" disabled="disabled">
														<option>万</option>
														<option>元/月</option>
													</select>
												</div>

											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" >朝向：</label>
											<div class="col-sm-2">
													<select class="form-control sboxit-2" name="direction" id="direction">
														<option value="1">东</option>
														<option value="2">南</option>
														<option value="3">西</option>
														<option value="4">北</option>
														<option value="5">东南</option>
														<option value="6">东西</option>
														<option value="7">西南</option>
														<option value="8">西北</option>
														<option value="9">东北</option>
														<option value="10">南北</option>
													</select>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label left" >装修：</label>
											<div class="col-sm-8">
												<label class="radio-inline">
													<input type="radio" name="fitment" value="5"><label class="radioLabel">豪华装修</label>
													<input type="radio" name="fitment" value="4"><label class="radioLabel">精装修</label>
													<input type="radio" name="fitment" checked="true" value="3"><label class="radioLabel">中等装修</label>
													<input type="radio" name="fitment" value="2"><label class="radioLabel">简装修</label>
													<input type="radio" name="fitment" value="1"><label class="radioLabel">毛坯</label>
												</label>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 房源标签：</label>
											<div class="col-sm-6">
												<input type="text" class="form-control" id="label" placeholder="">
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 58配套设施：</label>
											<div class="col-sm-6">
												<input type="text" class="form-control" id="wubalabel" placeholder="">
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 一句话广告：</label>
											<div class="col-sm-6">
												<input type="text" class="form-control" id="yijuhuaguanggao" placeholder="">
											</div>
										</div>
									</div>


								<div class="clearfix"></div>
							</div>

						</div>

						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">基本信息</h3>
								<div class="panel-options">
									<a href="#" data-toggle="panel"> <span class="collapse-icon">&ndash;</span> <span class="expand-icon">+</span> </a> <a href="#" data-toggle="remove"> &times; </a> </div>
							</div>

							<div class="panel-body">

								<form role="form" class="form-horizontal">

									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" >房屋类别：</label>
											<div class="col-sm-8">
												<label class="radio-inline">
													<input type="radio" name="houseType" value="2" ><label class="radioLabel">公寓</label>
													<input type="radio" name="houseType" value="4" ><label class="radioLabel">平房</label>
													<input type="radio" name="houseType" value="3" ><label class="radioLabel">别墅</label>
													<input type="radio" name="houseType" value="5" ><label class="radioLabel">其它</label>
													<input type="radio" name="houseType" value="1" checked="checked"><label class="radioLabel">普通住宅</label>
												</label>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 房屋产权：</label>
											<div class="col-sm-8">
												<label class="radio-inline">
													<input type="radio" name="propertyAge" value="70" checked="checked"><label class="radioLabel">70年</label>
													<input type="radio" name="propertyAge" value="50" ><label class="radioLabel">50年</label>
													<input type="radio" name="propertyAge" value="40" ><label class="radioLabel">40年</label>
												</label>
											</div>
										</div>
									</div>
									<%--<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" >基础设施：</label>
											<div class="col-sm-8">
												<label class="checkbox-inline">
													<input type="checkbox"><label class="radioLabel">水</label>
													<input type="checkbox"><label class="radioLabel">电</label>
													<input type="checkbox"><label class="radioLabel">煤气/天然气</label>
													<input type="checkbox"><label class="radioLabel">有线电视</label>
													<input type="checkbox"><label class="radioLabel">暖气</label>
													<input type="checkbox"><label class="radioLabel">电梯</label>
													<input type="checkbox"><label class="radioLabel">车位</label>
													<input type="checkbox"><label class="radioLabel">露台</label>
													<input type="checkbox"><label class="radioLabel">阁楼</label>
													<input type="checkbox"><label class="radioLabel">储藏室/地下室</label>
													<button type="button" class="btnMultiselect">全选</button>
													<button type="button" class="btnMultiselect">取消</button>
												</label>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" >配套设施：</label>
											<div class="col-sm-8" >
												<label class="checkbox-inline">
													<input type="checkbox"><label class="radioLabel">电话</label>
													<input type="checkbox"><label class="radioLabel">热水器</label>
													<input type="checkbox"><label class="radioLabel">彩电</label>
													<input type="checkbox"><label class="radioLabel">空调</label>
													<input type="checkbox"><label class="radioLabel">冰箱</label>
													<input type="checkbox"><label class="radioLabel">洗衣机</label>
													<input type="checkbox"><label class="radioLabel">家具</label>
													<input type="checkbox"><label class="radioLabel">床</label>
													<input type="checkbox"><label class="radioLabel">宽带网</label>
													<input type="checkbox"><label class="radioLabel">微波炉</label>
													<input type="checkbox"><label class="radioLabel">衣柜</label>
													<button type="button" class="btnMultiselect">全选</button>
													<button type="button" class="btnMultiselect">取消</button>
												</label>
											</div>
										</div>
									</div>--%>

								<div class="clearfix"></div>
							</div>

						</div>

						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">房源介绍</h3>
								<div class="panel-options">
									<a href="#" data-toggle="panel"> <span class="collapse-icon">&ndash;</span> <span class="expand-icon">+</span> </a> <a href="#" data-toggle="remove"> &times; </a> </div>
							</div>

							<div class="panel-body">

								<form role="form" class="form-horizontal">

									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 信息标题：</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" name="title" id="title" placeholder="">
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label" ><span class="red">*</span> 信息描述：</label>
											<div class="col-sm-8">
												<textarea class="form-control" placeholder="输入文本..." id="summary" rows="15"></textarea>
											</div>
										</div>
									</div>

								<div class="clearfix"></div>
							</div>

						</div>

						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">图片信息</h3>
								<div class="panel-options">
									<a href="#" data-toggle="panel"> <span class="collapse-icon">&ndash;</span> <span class="expand-icon">+</span> </a> <a href="#" data-toggle="remove"> &times; </a> </div>
							</div>

							<div class="panel-body">
								<form role="form" class="form-horizontal">
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label red" >室内照片：</label>
											<div class="col-sm-8">
												<div class="col-sm-1" id="fkContainer">
													<input type="button" class="btn btn-success" id="fkPickfiles"  value="上传">
												</div>
											</div>
										</div>
									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label red" ></label>
											<div class="col-sm-8">
												最多10张图片，您可以从我的图库选择，客厅/卧室/厨房等3张以上照片可帮助您获得较好的效果！
											</div>
										</div>

									</div>

									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label red" >房型图：</label>
											<div class="col-sm-8">
												<div class="col-sm-1" id="fkContainer1">
													<input type="button" class="btn btn-success" id="fkPickfiles1"  value="上传">
												</div>
											</div>
										</div>

									</div>
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label red" ></label>
											<div class="col-sm-8">
												最多5张图片，您可以从我的图库选择，或者房型图库选择
											</div>
										</div>

									</div>

									
									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label red" >小区照片：</label>
											<div class="col-sm-8">
												<div class="col-sm-1" id="fkContainer2">
													<input type="button" class="btn btn-success" id="fkPickfiles2"  value="上传">
												</div>
											</div>
										</div>
									</div>

									<div class="col-sm-12">
										<div class="form-group">
											<label class="col-sm-2 control-label red" ></label>
											<div class="col-sm-8">
												最多10张图片，您可以从我的图库选择，或者小区图库选择
											</div>
										</div>

									</div>

							</div>
						</div>

						<div class="text-center">
							<button type="button" class="btn btn-secondary" onclick="save(0);">下一步</button>
							<button type="button" class="btn btn-secondary" onclick="save(1);">保存草稿</button>
						</div>


					</div>
		</div>
			</form>
	</div>
		
</div>

</body>
</html>





<script type="text/javascript">

var uid = "<%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>";
var basepath = "<%=basePath%>";

function initMiaoLu(){
	var url = cloudPlatformUrl+"/services/newenv/cloub/houseparse/get?type=<%=type%>&id=<%=id%>";
	var result = $.ajax({url:url,async:false});
	var obj = $.parseJSON(result.responseText);
	$("#postform input[name='address']").val(obj.address);
	$("#postform input[name='area']").val(parseInt(obj.area));
	var hx = obj.rooms;
	var hx_s = hx.match(/[\d]室/g);
	hx_s = hx_s == null ? 0 : parseInt(hx_s);
	var hx_t = hx.match(/[\d]厅/g);
	hx_t = hx_t == null ? 0 : parseInt(hx_t);
	var hx_c = hx.match(/[\d]厨/g);
	hx_c = hx_c == null ? 0 : parseInt(hx_c);
	var hx_w = hx.match(/[\d]卫/g);
	hx_w = hx_w == null ? 0 : parseInt(hx_w);
	var hx_y = hx.match(/[\d]阳台/g);
	hx_y = hx_y == null ? 0 : parseInt(hx_y);
	$("#hx_s").find("option[value='"+hx_s+"']").attr("selected",true);
	$("#hx_t").find("option[value='"+hx_t+"']").attr("selected",true);
	$("#hx_c").find("option[value='"+hx_c+"']").attr("selected",true);
	$("#hx_w").find("option[value='"+hx_w+"']").attr("selected",true);
	$("#hx_y").find("option[value='"+hx_y+"']").attr("selected",true);
	var floor = obj.floor;
	var floor_split = floor.split("/");
	var lc_d = parseInt(floor_split[0])
	var lc_z = parseInt(floor_split[1])
	$("#postform input[name='lc_d']").val(lc_d);
	$("#postform input[name='lc_z']").val(lc_z);
	var price = parseInt(obj.price);
	$("#postform input[name='price']").val(price);
	$("#price_unit").get(0).selectedIndex= "<%=type%>" == "fangyuan_chushou" ?  0 : 1;
	var direction = obj.direction;
	$("#direction").find("option[value='"+direction+"']").attr("selected",true);
	$("#summary").val(obj.summary);
	var fitment = obj.fitment;
	if(fitment == "简单装修"){
		fitment = "简装修";
	}
	$("#postform input[name='fitment']").filter(function () { return $(this).val() == fitment; }).attr("checked", true);
	$("#postform input[name='title']").val(obj.title);
	lpName = obj.lpName;
	if(lpName == ""){
		lpName = obj.sqId;
	}
	return lpName;
}

function initShouCangMiaoLu(obj){
	$("#postform input[name='address']").val(obj.address);
	$("#postform input[name='area']").val(parseInt(obj.area));
	$("#hx_s").find("option[value='"+obj.hx_s+"']").attr("selected",true);
	$("#hx_t").find("option[value='"+obj.hx_t+"']").attr("selected",true);
	$("#hx_c").find("option[value='"+obj.hx_c+"']").attr("selected",true);
	$("#hx_w").find("option[value='"+obj.hx_w+"']").attr("selected",true);
	$("#hx_y").find("option[value='"+obj.hx_y+"']").attr("selected",true);
	$("#direction").find("option[value='"+obj.directionType+"']").attr("selected",true);
	$("#postform input[name='fitment']").filter(function () { return $(this).val() == obj.fitmentType; }).attr("checked", true);
	$("#postform input[name='title']").val(obj.title);
	$("#postform input[name='houseType'][value='"+obj.houseType+"']").attr("checked","checked");
	$("#postform input[name='propertyAge'][value='"+obj.propertyAge+"']").attr("checked","checked");
	$("#floor_c").val(obj.floor_c);
	$("#floor_z").val(obj.floor_z);
	$("#price").val(obj.price);
	$("#summary").val(obj.summary);
	$("#label").val(obj.label);
	$("#wubalabel").val(obj.wubalabel);
	$("#yijuhuaguanggao").val(obj.yijuhuaguanggao);

	var s_picture_array =  obj.s_picture.split(",");
	var s_picture_tag = "";
	var s_picture_imgtag = "";
	$.each(s_picture_array,function(i,pic){
		if($.trim(pic) != ""){
			s_picture_tag += "<input type='hidden' name='s_picture' value='"+pic+"'/>";
			var img = "http://imgbms.xhjfw.com/"+pic;
			s_picture_imgtag += '<div class="album-image col-lg-3"><img width="200" height="150" class="img-thumbnail" src="'+img+'"/>';
			s_picture_imgtag += '<div class="text-center"><a href="javascript:void(0)" onclick="removeExclusiveImg(0,\''+pic+'\',this);">删除</a></div></div>';
		}
	})
	$("#fkContainer").after(s_picture_imgtag);
	$("#postform").append(s_picture_tag);

	var f_picture_array =  obj.f_picture.split(",");
	var f_picture_tag = "";
	var f_picture_imgtag = "";
	$.each(f_picture_array,function(i,pic){
		if($.trim(pic) != ""){
			f_picture_tag += "<input type='hidden' name='f_picture' value='"+pic+"'/>";
			var img = "http://imgbms.xhjfw.com/"+pic;
			f_picture_imgtag += '<div class="album-image col-lg-3"><img width="200" height="150" class="img-thumbnail" src="'+img+'"/>';
			f_picture_imgtag += '<div class="text-center"><a href="javascript:void(0)" onclick="removeExclusiveImg(0,\''+pic+'\',this);">删除</a></div></div>';
		}
	})
	$("#fkContainer1").after(f_picture_imgtag);
	$("#postform").append(f_picture_tag);

	var x_picture_array =  obj.x_picture.split(",");
	var x_picture_tag = "";
	var x_picture_imgtag = "";
	$.each(x_picture_array,function(i,pic){
		if($.trim(pic) != ""){
			x_picture_tag += "<input type='hidden' name='x_picture' value='"+pic+"'/>";
			var img = "http://imgbms.xhjfw.com/"+pic;
			x_picture_imgtag += '<div class="album-image col-lg-3"><img width="200" height="150" class="img-thumbnail" src="'+img+'"/>';
			x_picture_imgtag += '<div class="text-center"><a href="javascript:void(0)" onclick="removeExclusiveImg(0,\''+pic+'\',this);">删除</a></div></div>';
		}
	})
	$("#fkContainer2").after(x_picture_imgtag);
	$("#postform").append(x_picture_tag);

	return obj.lpName;
}


function onQyChange(){
	$("#sqId").empty();
	var qyId = $("#qyId").val();
	initShangQuan();
}

function getLpName(){
	$("#selectXiaoQu").select2({
		minimumInputLength: 1,
		placeholder: '请输入小区名称搜索',
		ajax: {
			url: cloudPlatformUrl+"/services/newenv/lpzd/crawl/getLouPan/",
			type: "GET",
			dataType: 'json',
			quietMillis: 100,
			data: function(term, page) {
				return {
					"keyword": term
				};
			},
			results: function(data, page ) {
				return { results: data.result }
			}
		},
		formatResult: function(obj) { 
			return "<div class='select2-user-result'>" + obj.name + "</div>";
		},
		formatSelection: function(obj) {
			$("#select2-chosen-1").css("color","#444");
			$("#qyId").find("option[value='"+obj.areaid+"']").attr("selected",true);
			onQyChange();
			$("#sqId").find("option[value='"+obj.wubapid+"']").attr("selected",true);
			$("#postform input[name='address']").val(obj.address);
			$("#selectXiaoQuLabel").hide();
			return obj.name; 
		}
	}).on("change",function(e){
		
	});;
}

function checkLpName(lpName){
	if(lpName != ""){
		var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/getLouPan?keyword="+lpName;
		var result = $.ajax({url:url,async:false});
		var resObj = $.parseJSON(result.responseText);
		var obj = resObj.result;
		if(obj.length == 0 || obj[0].name != lpName){
			alert("因为不同站点对小区的命名有所差别，请在列表中选择对应的小区并核实信息再发布!");
			$("#selectXiaoQuLabel").show();
		}else{
			$("#select2-chosen-1").css("color","#444");
			$("#qyId").find("option[value='"+obj[0].areaid+"']").attr("selected",true);
			onQyChange();
			$("#sqId").find("option[value='"+obj[0].wubapid+"']").attr("selected",true);
		}
		$("#select2-chosen-1").text(lpName);
		$("#selectXiaoQu").val(obj[0].id);
	}else{
		alert("因为不同站点对小区的命名有所差别，请在列表中选择对应的小区并核实信息再发布!");
	}
}

function initArea(){
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/getArea?cityName=长沙";
	var result = $.ajax({url:url,async:false});
	var resObj = $.parseJSON(result.responseText);
	var cityIds = resObj.result;
	$.each(cityIds,function (idx){
		var areaName = cityIds[idx].areaName;
		var areaId = cityIds[idx].areaId;
		$("#qyId").append("<option value='"+areaId+"'>"+areaName+"</option>");
	})
}

function initShangQuan(){
	var qyId = $("#qyId").val();
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/getShangQuan?id="+qyId;
	var result = $.ajax({url:url,async:false});
	var resObj = $.parseJSON(result.responseText);
	var cityIds = resObj.result;
	$.each(cityIds,function (idx){
		var sqName = cityIds[idx].sqName;
		var sqId = cityIds[idx].sqId;
		$("#sqId").append("<option value='"+sqId+"'>"+sqName+"</option>");
	})
}

function save(id){

	//验证
	var lpName = $("#select2-chosen-1").text();
	if(lpName == "请输入小区名称搜索" || !$("#selectXiaoQuLabel").is(":hidden")){
		errorAnchor("selectXiaoQuLabel");
		return;
	}

	var fangYuanChuShouRelease=new Object();
	fangYuanChuShouRelease.businessType="fangyuan_chushou";
	fangYuanChuShouRelease.status=id;
	fangYuanChuShouRelease.employeeId=uid;
	fangYuanChuShouRelease.crawlId="<%=id%>";
	fangYuanChuShouRelease.lpName=lpName;
	fangYuanChuShouRelease.title=$("#title").val();
	fangYuanChuShouRelease.address=$("#address").val();
	fangYuanChuShouRelease.area=$("#area").val();
	fangYuanChuShouRelease.price=$("#price").val();
	fangYuanChuShouRelease.directionType=$("#direction").val();
	fangYuanChuShouRelease.fitmentType=$("#postform input[name='fitment']").val();
	fangYuanChuShouRelease.xqid=$("#selectXiaoQu").val();
	fangYuanChuShouRelease.hx_s=$("#hx_s").val();
	fangYuanChuShouRelease.hx_t=$("#hx_t").val();
	fangYuanChuShouRelease.hx_c=$("#hx_c").val();
	fangYuanChuShouRelease.hx_w=$("#hx_w").val();
	fangYuanChuShouRelease.hx_y=$("#hx_y").val();
	fangYuanChuShouRelease.floor_c=$("#floor_c").val();
	fangYuanChuShouRelease.floor_z=$("#floor_z").val();
	fangYuanChuShouRelease.label=$("#label").val();
	fangYuanChuShouRelease.wubalabel=$("#wubalabel").val();
	fangYuanChuShouRelease.houseType=$("#postform input[name='houseType']:checked").val();
	fangYuanChuShouRelease.propertyAge=$("#postform input[name='propertyAge']:checked").val();
	fangYuanChuShouRelease.summary=$("#summary").val();
	fangYuanChuShouRelease.pstatus = id;
	fangYuanChuShouRelease.label = $("#label").val();
	fangYuanChuShouRelease.wubalabel = $("#wubalabel").val();
	fangYuanChuShouRelease.yijuhuaguanggao = $("#yijuhuaguanggao").val();
	var array = [];
	$.each($("input[name='s_picture']"),function(i,n){
		array.push($(this).val());
	})
	var array1 = [];
	$.each($("input[name='f_picture']"),function(i,n){
		array1.push($(this).val());
	})
	var array2 = [];
	$.each($("input[name='x_picture']"),function(i,n){
		array2.push($(this).val());
	})
	fangYuanChuShouRelease.s_picture = array.join(",");
	fangYuanChuShouRelease.f_picture = array1.join(",");
	fangYuanChuShouRelease.x_picture = array2.join(",");
	var jsonData=JSON.stringify(fangYuanChuShouRelease);
	$.ajax({
		url: cloudPlatformUrl+"/services/newenv/lpzd/crawl/saveFangYuanRelease/", 
		dataType: "json", 
		type: "POST", 
		contentType : "application/json; charset=utf-8",
		data : jsonData,
		success : function(result){
			if(result == 1){
				if(id == 0){
					window.location.href = "<%=basePath%>/crawl/postpage.jsp?from="+id;
				}else{
					var tip = bootbox.alert({title:"提示",message:"录入成功!"});
				}
			}else{
				bootbox.alert({title:"提示",message:"录入失败 !"});
			}
    	}
	});
}

function errorAnchor(id){
	$("#"+id).show();
	$('html,body').animate({scrollTop: $("#"+id).offset().top - 50}, 500);
}

$(document).ready(function(){
	var lpName = "";
	var url = cloudPlatformUrl+"/services/newenv/lpzd/crawl/getFangYuanRelease/";
	var obj=new Object();
	var requestParameter=new Object();
	requestParameter.userId=<%=SecurityUserHolder.getCurrentUserLogin().getUserProfile().getId()%>;
	requestParameter.businessType="fangyuan_chushou";
	requestParameter.id=<%=id%>;
	obj.requestParameter=requestParameter;
	var jsonData=JSON.stringify(obj);
	var result = $.ajax({url:url,type:"POST",data:jsonData,contentType:"application/json; charset=utf-8",async:false});
	var obj = $.parseJSON(result.responseText);
	if(obj != null){
		lpName = initShouCangMiaoLu(obj);
	}else{
		lpName = initMiaoLu();
	}
	initArea();
	initShangQuan();
	getLpName();
	checkLpName(lpName);


	/*var uploader = new plupload.Uploader({
		browse_button : 'fkPickfiles',
		url : 'upload.html',
		flash_swf_url : 'js/Moxie.swf',
		silverlight_xap_url : 'js/Moxie.xap',
		init : {
			alert(1);
		}
	});*/
//	uploader.init();
});

</script>

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
<script src="../assets/js/jquery-ui/jquery-ui.js"></script>
<script src="../assets/js/tocify/jquery.tocify.min.js"></script>
<!-- JavaScripts initializations and stuff -->
<script src="../assets/js/xenon-custom.js"></script>

<script type="text/javascript" src="../js/campus/pluploadfile.js"></script>
