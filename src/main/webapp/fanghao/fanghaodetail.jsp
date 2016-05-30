<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%  String basePath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="Xenon Boostrap Admin Panel" />
<meta name="author" content="" />
<title>详情住宅</title>
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/assets/css/fonts/linecons/css/linecons.css">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/assets/css/fonts/fontawesome/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/assets/css/bootstrap.css">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/assets/css/xenon-core.css">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/assets/css/xenon-forms.css">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/assets/css/xenon-components.css">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/assets/css/xenon-skins.css">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/assets/css/custom.css">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/assets/css/xiaoqu.css">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/assets/js/wysihtml5/src/bootstrap-wysihtml5.css">
<script
	src="<%=request.getContextPath() %>/assets/js/jquery-1.11.1.min.js"></script>
<script src="<%=request.getContextPath() %>/js/services.js"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
<script type="text/javascript">
	var fwztStr='${xhjLpfanghao.fwztStr}';
	var isHavingStr='${xhjLpfanghao.isHavingStr}';
	var houselevelStr='${xhjLpfanghao.houselevelStr}'
	var basePath="<%=basePath%>";
	var facility='${xhjLpfanghao.facility}';
	 $(function(){
	 getLpDelegation();
	 getXhjPersoninfo();
	 getxqxx();
	 getzxdt();
	 if(facility!=null&&facility!=''){
	  checkbox(facility);
	 }
	
	$("#weituoxinxi").load("<%=basePath%>/newenv/lpzd/fanghaoweituo.action?houseInfoId=${xhjLpfanghao.id}");
	
	 $.ajax({
			url:"<%=basePath%>/newenv/lpzd/fanghaogetxhjLptp.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"lpid" : ${xhjLpfanghao.lpid}},
			success: function(data){
				var $imgContainer = $("#tab-01 .panel-body ");
		       	var $imgContainer2 = $("#tab-02 .panel-body ");
		       	var $imgContainer3 = $("#tab-03 .panel-body ");
		       	var $imgContainer4 = $("#tab-04 .panel-body ");
		       	var $imgContainer5 = $("#tab-05 .panel-body ");
		       	var imgnum=0;
		       	var imgnum2=0;
		       	var imgnum3=0;
		       	var imgnum4=0;
		       	var imgnum5=0;
				$.each(data, function(i,n){
				var sHtml='';
				
				if(n[3]==3){
				imgnum++;
				 sHtml= ' <div class="col-lg-6 col-xs-12 form-group"><img  src="http://imgbms.xhjfw.com/'+n[2]+'@200w_150h"  width="200" height="150" class="img-thumbnail"></div>';
					$imgContainer.append(sHtml);
					
				}
				$("#imgnum").html(imgnum);
				
				if(n[3]==1){
				imgnum2++;
				 sHtml2= ' <div class="col-lg-6 col-xs-12 form-group"><img  src="http://imgbms.xhjfw.com/'+n[2]+'@200w_150h"  width="200" height="150" class="img-thumbnail"></div>';
				$imgContainer2.append(sHtml2);
				}
				$("#imgnum2").html(imgnum2);
				if(n[3]==2){
				imgnum3++;
				 sHtml3= ' <div class="col-lg-6 col-xs-12 form-group"><img  src="http://imgbms.xhjfw.com/'+n[2]+'@200w_150h"  width="200" height="150" class="img-thumbnail"></div>';
				$imgContainer3.append(sHtml3);
				}
				$("#imgnum3").html(imgnum3);
				if(n[3]==4){
				imgnum4++;
				 sHtml4= ' <div class="col-lg-6 col-xs-12 form-group"><img  src="http://imgbms.xhjfw.com/'+n[2]+'@200w_150h"  width="200" height="150" class="img-thumbnail"></div>';
				$imgContainer4.append(sHtml4);
				}
					$("#imgnum4").html(imgnum4);
				if(n[3]==5){
				imgnum5++;
				 sHtml5= ' <div class="col-lg-6 col-xs-12 form-group"><img  src="http://imgbms.xhjfw.com/'+n[2]+'@200w_150h"  width="200" height="150" class="img-thumbnail"></div>';
				$imgContainer5.append(sHtml5);
				}
				$("#imgnum5").html(imgnum5);
           
		});
	
				
			}
	 });
 });
	function getLpDelegation(){
		$.ajax({
			url:"<%=basePath%>/newenv/lpzd/fanghaogetPtJson.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"id" : ${xhjLpfanghao.id}},
			success: function(data){
			//$("#lpName").html("<option>"+data.lp.lpName+"</option>");
				var shtml='';
				var jhtml='';
				//房屋设施
				$.each(data.lpFacilityofhouse, function(i,n){
					if(n.hometype==1321){
					shtml+='<tr>'
					shtml+='<td><select class="form-control" disabled>'
					shtml+='<option>'+n.facilityIdName+'</option>'
					shtml+='</select></td>'
					shtml+='<td><select class="form-control" disabled>'
					shtml+='<option>'+n.count+'</option>'
					shtml+='</select></td>'
					shtml+='<td colspan="2"><input type="text" class="form-control" readonly="" placeholder="" value="'+n.brand+'">'
					shtml+='</td>'
					shtml+='</tr>'
					}
					if(n.hometype==1320){
					jhtml+='<tr>'
					jhtml+='<td><select class="form-control" disabled>'
					jhtml+='<option>'+n.facilityIdName+'</option>'
					jhtml+='</select></td>'
					jhtml+='<td><select class="form-control" disabled>'
					jhtml+='<option>'+n.count+'</option>'
					jhtml+='</select></td>'
					jhtml+='<td colspan="2"><input type="text" class="form-control" readonly="" placeholder="" value="'+n.brand+'">'
					jhtml+='</td>'
					jhtml+='</tr>'
					}
					
				});
				$("#jiadian").html(shtml)
				$("#jiaju").html(jhtml)
				var cshtml='';
				var czhtml='';
				$.each(data.lpContractRecords, function(i,n){
					if(n.delegateType==1){
					cshtml+='<tr>'
					cshtml+='<td>'+n.hsnumber+'</td>'
					cshtml+='<td>'+n.contractNumber+'</td>'
					cshtml+='<td>'+n.contractDateStr+'</td>'
					cshtml+='<td>'+n.totalPrice+'</td>'
					cshtml+='<td><p>姓名：'+n.fullname+'</p><p>工号：'+n.username+'</p><p>'+n.tel+'</p></td>'
					cshtml+='<td>'+n.yezhu+'</td>'
					cshtml+='<td>'+n.yztel+'</td>'
					cshtml+='<td>'+n.sourceStr+'</td>'
					cshtml+='</tr>'
					}
					if(n.delegateType==2){
					czhtml+='<tr>'
					czhtml+='<td>'+n.hsnumber+'</td>'
					czhtml+='<td>'+n.contractNumber+'</td>'
					czhtml+='<td>'+n.contractDateStr+'</td>'
					czhtml+='<td>'+n.price+'</td>'
					czhtml+='<td><p>姓名：'+n.fullname+'</p><p>工号：'+n.username+'</p><p>'+n.tel+'</p></td>'
					czhtml+='<td>'+n.yezhu+'</td>'
					czhtml+='<td>'+n.yztel+'</td>'
					cshtml+='<td>'+n.sourceStr+'</td>'
					czhtml+='</tr>'
					}
					
				});
				$("#fwcjcs").html(cshtml);
				$("#fwcjcz").html(czhtml);
			}
			
	 	});
	}
	var page=1;
	var row=3;
	//小区成交信息
	function getxqxx(){
	$.ajax({
			url:"<%=basePath%>/newenv/lpzd/fanghaofianByxq.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"lpid" : ${xhjLpfanghao.lpid},"pageInfo.page":page,"pageInfo.rows":row},
			success: function(data){
			var xqcshtml='';
			var xqczhtml='';
				$.each(data.gridModel, function(i,n){
				if(n.delegateType==1){
				
					xqcshtml+='<tr>'
					xqcshtml+='<td width="110">'
					if(n.imagePath!=null&&n.imagePath!=''){
					xqcshtml+='<img src="http://imgbms.xhjfw.com/'+n.imagePath+'" width="50" height="50">'
					}else{
					xqcshtml+='<img src="'+basePath+'/assets/images/hetong.jpg" width="50" height="50">'
					}
					xqcshtml+='</td>'
					xqcshtml+='<td><p><b>'+n.shi+'室'+n.ting+'厅</b></p><p>'+n.buildingTypeName+'/'+n.totalPrice+'层 '+n.chaoxiangStr+'</p><p>'+n.buildingAgeId+'年建</p></td>'
					xqcshtml+='<td>'+n.tnmj+'平米</td>'
					xqcshtml+='<td>'+n.contractDateStr+'</td>'
					xqcshtml+='<td><span class="red">'+n.totalPrice+'万</span></td>'
					xqcshtml+='<td>'+n.price+'元/平米</td>'
					xqcshtml+='<td><p>'+n.fullname+'</p><p>'+n.tel+'</p></td>'
					xqcshtml+='<td>'+n.sourceStr+'</td>'
					xqcshtml+='</tr>'
					}
					if(n.delegateType==2){
					xqczhtml+='<tr>'
					xqczhtml+='<td width="110">'
					if(n.imagePath!=null&&n.imagePath!=''){
					xqczhtml+='<img src="http://imgbms.xhjfw.com/'+n.imagePath+'" width="100" height="130">'
					}else{
					xqczhtml+='<img src="'+basePath+'/assets/images/hetong.jpg" width="100" height="130">'
					}
					
					xqczhtml+='</td>'
					xqczhtml+='<td><p><b>'+n.shi+'室'+n.ting+'厅</b></p><p>'+n.buildingTypeName+'/'+n.totalPrice+'层 '+n.chaoxiangStr+'</p><p>'+n.buildingAgeId+'年建</p></td>'
					xqczhtml+='<td>'+n.tnmj+'平米</td>'
					xqczhtml+='<td>'+n.contractDateStr+'</td>'
					xqczhtml+='<td><span class="red">'+n.decorationStandardStr+'</span></td>'
					xqczhtml+='<td>'+n.price+'元/平米</td>'
					xqczhtml+='<td><p>'+n.fullname+'</p><p>'+n.tel+'</p></td>'
					xqczhtml+='<td>'+n.sourceStr+'</td>'
					xqczhtml+='</tr>'
					}
					
				});
				$("#xqcs").append(xqcshtml);
				$("#xqcz").append(xqczhtml);
			}
		});
		page++;
	}
	//业主信息
	function getXhjPersoninfo(){
	var  yzid='${xhjLpfanghao.yzid}';
	if(yzid!=null&&yzid!=''){
	$.ajax({
			url:"<%=basePath%>/newenv/lpzd/fanghaogetXhjPersoninfo.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"yzid" :yzid},
			success: function(data){
			$("#yzName").val(data.name);
			if(data.gender==false){
			$("#xingbie").html("<option>女士</option>");
			}else if(data.gender==true){
			$("#xingbie").html("<option>先生</option>");
			}
			
			//$("#tel").val(data.mobilePhone);
			$("#email").val(data.email);
			$("#weXin").val(data.weXin);
			var lianxidianhua='';
			$.each(data.xhjCommunicators, function(i,n){
			lianxidianhua+='<label class="col-sm-2 control-label" for="field-3">联系电话</label>'
			lianxidianhua+='<div class="col-sm-4">'
			lianxidianhua+='<input type="text" class="form-control" readonly=""id="field-3" placeholder="" value="'+n.telephone+'"></div>'
			lianxidianhua+='<div class="col-sm-4">'
			lianxidianhua+='<div class="input-group">'
			lianxidianhua+='<select class="form-control" disabled>'
			lianxidianhua+='<option>'+n.relationTypeName+'</option>'
			lianxidianhua+='<option>朋友</option>'
			lianxidianhua+='<option></option> </select>'
			lianxidianhua+='<span class="input-group-addon"> <i class="fa-plus"></i> </span> '
			lianxidianhua+=' <span class="input-group-addon">'
			lianxidianhua+='<i class="fa-close"></i> </span>'
			lianxidianhua+='</div></div>'
			
			});
			$("#lianxidianhua").html(lianxidianhua);
			}
			});
	}
	
	}
	
	var pageinfo=1;
	var rows=3;
	//房屋最新动态信息
	function getzxdt(){
	$.ajax({
			url:"<%=basePath%>/newenv/lpzd/fanghaohouselog.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"houseinfoid" : ${xhjLpfanghao.id},"pageInfo.page":pageinfo,"pageInfo.rows":rows},
			success: function(data){
			var fwdthtml='';
				$.each(data.gridModel, function(i,n){
					fwdthtml+='<tr>'
					fwdthtml+='<td width="110">'
					if(n.imgPath!=null&&n.imgPath!=''){
					fwdthtml+='<img src="http://imgbms.xhjfw.com/'+n.imgPath+'" width="50" height="50">'
					}else{
					fwdthtml+='<img src="'+basePath+'/assets/images/hetong.jpg" width="50" height="50">'
					}
					fwdthtml+='</td>'
					fwdthtml+='<td><div class="pull-left"><h4>'+n.operatorIdStr+'</h4>'+n.departmentIdStr+' '+n.tel+'</div></td>'
					fwdthtml+='<td>'+n.message+'</td>'
					fwdthtml+='<td>'+n.operateDateStr+'</td>'
					fwdthtml+='</tr>'
				});
				$("#zxdt").append(fwdthtml); 
			}
		});
		pageinfo++;
	}
	
	function   checkbox(obj){
		var limitField=obj;
		if(limitField!=""){
		/* 	var obj = eval('(' + limitField + ')'); */
			var checkbox_query=$("#facility :checkbox");
			for(var i=0;i<checkbox_query.length;i++){
				var checkbox=checkbox_query[i];
				if(limitField.indexOf(checkbox.id)>=0){
					checkbox.checked=true;
				}
			}
		}
		
	} 
	

	</script>
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
			<jsp:include page="../include/top.jsp"/> 
			<div class="page-title">
					<div class="breadcrumb-env pull-left">
						<ol class="breadcrumb bc-1">
							<li>
								<a href="<%=basePath%>/console/index.jsp"><i class="fa-home"></i>首页</a>
							</li>
							<li class="active">
								<a href="<%=basePath%>/fanghao/fanghaoindex.jsp?p=house">房产信息</a>
							</li>
							<li class="active">
								<strong>${xhjLpfanghao.leixingStr}详情</strong>
							</li>
						</ol>
					</div>
				</div>
			<div class="row paddinglr">
				<div id="rootwizard" class="form-wizard">

					<ul class="tabs">
						<li class="active"><a href="#tab1" data-toggle="tab">基础信息</a>
						</li>
						<li><a href="#tab2" data-toggle="tab">楼盘图库</a></li>
						<li><a href="#tab3" data-toggle="tab">房屋成交信息</a></li>
						<li><a href="#tab4" data-toggle="tab">小区成交信息</a></li>
						<li><a href="#tab5" data-toggle="tab">配套设施</a></li>
						<li><a href="#tab7" data-toggle="tab">最新动态</a></li>
					</ul>

					<div class="progress-indicator">
						<span></span>
					</div>

					<div class="tab-content">

						<!-- Tabs Content -->
						<div class="tab-pane active" id="tab1">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h3 class="panel-title">
										<h2>小区基本信息</h2>
									</h3>
									<div class="panel-options">
										<a href="#" data-toggle="panel"> <span
											class="collapse-icon">–</span> <span class="expand-icon">+</span>
										</a>
									</div>
								</div>
								<div class="panel-body">

									<div class="panel-body">
										<form role="form" class="form-horizontal">
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">房屋名称</label>

												<div class="col-sm-2">
													<select class="form-control" disabled id="lpName">
														 <option>${xhjLpfanghao.lpName}</option> 
													</select>
												</div>
												<div class="col-sm-2">
													<select class="form-control" disabled id="lpDname">
														<option>${xhjLpfanghao.zdName}</option>
														<option></option>
														<option></option>
													</select>
												</div>
												<div class="col-sm-2">
													<select class="form-control" disabled id="dyName">
														<option>${xhjLpfanghao.dyName}</option>
														<option></option>
														<option></option>
													</select>
												</div>
												<div class="col-sm-2">
													<select class="form-control" disabled>
														<option>${xhjLpfanghao.ceng}</option>
														<option></option>
														<option></option>
													</select>
												</div>
												<div class="col-sm-2">
													<select class="form-control" disabled>
														<option>${xhjLpfanghao.fangHao}</option>
														<option></option>
														<option></option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">户型</label>

												<div class="col-sm-1">
													<input type="text" class="form-control" readonly=""
														id="field-3" value="${xhjLpfanghao.shi}" placeholder="室">
												</div>
												<div class="col-sm-1">
													<input type="text" class="form-control" readonly=""
														id="field-3" value="${xhjLpfanghao.ting}" placeholder="厅">
												</div>
												<div class="col-sm-1">
													<input type="text" class="form-control" readonly=""
														id="chu" value="${xhjLpfanghao.chu}" placeholder="厨">
												</div>
												<div class="col-sm-1">
													<input type="text" class="form-control" readonly=""
														id="wei" value="${xhjLpfanghao.wei}" placeholder="卫">
												</div>
												<div class="col-sm-1">
													<input type="text" class="form-control" readonly=""
														id="yang" value="${xhjLpfanghao.yang}" placeholder="阳台">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">用途</label>

												<div class="col-sm-8">
													<select class="form-control" disabled id="leixingStr">
														<option>${xhjLpfanghao.leixingStr}</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">朝向</label>

												<div class="col-sm-8">
													<select class="form-control" disabled id="chaoXiangName">
														<option>${xhjLpfanghao.chaoXiangName}</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">楼层</label>

												<div class="col-sm-2">
													<input type="text" class="form-control" readonly=""
														id="field-3" placeholder="" value="${xhjLpfanghao.totalFloor}">
												</div>
												<div class="col-sm-2">
													<input type="text" class="form-control" readonly=""
														id="ceng" value="${xhjLpfanghao.ceng}" placeholder="">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">权属性质</label>

												<div class="col-sm-8">
													<select class="form-control" disabled id="propertyInfo">
														<option>${xhjLpfanghao.propertyInfoStr}</option>
														<option></option>
														<option></option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">国土行政</label>

												<div class="col-sm-8">
													<select class="form-control" disabled id="territoryInfo">
														<option>${xhjLpfanghao.territoryInfoStr}</option>
														<option></option>
														<option></option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">产权编码</label>

												<div class="col-sm-8">
													<input type="text" class="form-control" readonly=""
														id="propertyNumber" value="${xhjLpfanghao.propertyNumber}"
														placeholder="">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">市场地址</label>

												<div class="col-sm-8">
													<input type="text" class="form-control" readonly=""
														id="field-3" value="" placeholder="">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">城市</label>

												<div class="col-sm-2">
													<input type="text" class="form-control" readonly=""
														id="cityName" value="${xhjLpfanghao.cityName}"
														placeholder="">
												</div>

												<label class="col-sm-1 control-label" for="field-3">城区</label>

												<div class="col-sm-2">
													<input type="text" class="form-control" readonly=""
														id="qyName" value="${xhjLpfanghao.qyName}" placeholder="">
												</div>
												<label class="col-sm-1 control-label" for="field-3">商圈</label>

												<div class="col-sm-2">
													<input type="text" class="form-control" readonly=""
														value="${xhjLpfanghao.sqName}" id="sqName" placeholder="">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">产权面积</label>

												<div class="col-sm-8">
													<div class="input-group">
														<input type="text" class="form-control"id="cqmj" readonly=""
															value="${xhjLpfanghao.cqmj}"> <span
															class="input-group-addon"> ㎡ </span>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">使用面积</label>

												<div class="col-sm-8">
													<div class="input-group">
														<input type="text" class="form-control"
															value="${xhjLpfanghao.tnmj}" readonly=""> <span
															class="input-group-addon"> ㎡ </span>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">产权年限</label>

												<div class="col-sm-8">
													<select class="form-control" disabled>
														<option>${xhjLpfanghao.propertyAgeStr}</option>
														<option></option>
														<option></option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">备案号</label>

												<div class="col-sm-8">
													<input type="text" class="form-control" readonly=""
														value="${xhjLpfanghao.recordNumber}" id="field-3"
														placeholder="">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">配套设施</label>

												<div class="col-sm-8" id="facility">
													<label class="checkbox-inline"> <input
														type="checkbox" id="1"> 暖气 </label> <label
														class="checkbox-inline"> <input type="checkbox" id="2">
														杂物间 </label> <label class="checkbox-inline"> <input
														type="checkbox" id="3"> 车位 </label> <label
														class="checkbox-inline"> <input type="checkbox" id="4">
														车库 </label>
												</div>
											</div>

											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">产权地址</label>

												<div class="col-sm-8">
													<input type="text" class="form-control" readonly=""
														id="field-3" value="${xhjLpfanghao.propertyAddress}"
														placeholder="">
												</div>
											</div>
										</form>
									</div>

									<div class="panel-heading">
										<ul class="nav nav-tabs">
											<li class="active"><a href="" data-toggle="tab">业主信息</a>
											</li>
										</ul>
									</div>

									<div class="panel-body">
										<form role="form" class="form-horizontal">
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">业主姓名</label>
												<div class="col-sm-4">
													<input type="text" class="form-control" readonly=""
														id="yzName" placeholder="" >
												</div>
												<div class="col-sm-4">
													<select class="form-control" disabled id="xingbie">
														<option></option>
														<option></option>
														<option></option>
													</select>
												</div>

											</div>

<!-- 											<div class="form-group"> -->
<!-- 												<label class="col-sm-2 control-label" for="field-3">联系电话</label> -->

<!-- 												<div class="col-sm-4"> -->
<!-- 													<input type="text" class="form-control" readonly="" -->
<!-- 														id="tel" placeholder=""> -->
<!-- 												</div> -->
<!-- 											</div> -->
											<div class="form-group" id="lianxidianhua">
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">电子邮箱</label>

												<div class="col-sm-8">
													<input type="text" class="form-control" readonly=""
														id="email" placeholder="" id="">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">微信</label>

												<div class="col-sm-8">
													<input type="text" class="form-control" readonly=""
														id="weXin" placeholder="">
												</div>
											</div>
										</form>
									</div>

									<div class="panel panel-default">
										<div id="weituoxinxi"></div>
									</div>

									<div class="panel-heading">
										<ul class="nav nav-tabs">
											<li class="active"><a href="" data-toggle="tab">房屋现状</a>
											</li>
										</ul>
									</div>

									<div class="panel-body">
										<form role="form" class="form-horizontal">
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">装修标准</label>
												<div class="col-sm-8">
													<select class="form-control" disabled>
														<option>${xhjLpfanghao.zxName}</option>
														<option></option>
														<option></option>
													</select>
												</div>

											</div>

											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">装修年限</label>

												<div class="col-sm-8">
													<input type="text" class="form-control" readonly=""
														id="field-3" placeholder=""
														value="${xhjLpfanghao.decoratedYears}">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="field-3">格局是否改变</label>

												<div class="col-sm-8">
													<label class="radio-inline"> <input type="radio"
														name="radio-2" ${xhjLpfanghao.isChangedUnits=='1'?"checked":""}>
														是 </label> <label class="radio-inline"> <input
														type="radio" name="radio-2"
														${xhjLpfanghao.isChangedUnits=='0'?"checked":""}>
														否 </label>
												</div>
											</div>
										</form>
									</div>

									<div class="panel-heading">
										<ul class="nav nav-tabs">
											<li class="active"><a href="" data-toggle="tab">房屋设施</a>
											</li>
										</ul>
									</div>

									<div class="tab-content">
										<div class="panel-body">
											<div class="col-lg-5">
												<div class="table-responsive">
													<table class="table table-bordered table-striped">
														<thead>
															<tr>
																<th class="no-sorting">家电名称</th>
																<th>家电数量</th>
																<th colspan="2">家电品牌</th>
															</tr>
														</thead>
														<tbody class="middle-align" id="jiadian">

														</tbody>
													</table>
												</div>
											</div>
											<div class="col-lg-5">
												<table class="table table-bordered table-striped">
													<thead>
														<tr>
															<th class="no-sorting">家具名称</th>
															<th>家具数量</th>
															<th colspan="2">家具品牌</th>
														</tr>
													</thead>
													<tbody class="middle-align" id="jiaju">
														
													</tbody>
												</table>
											</div>

										</div>
									</div>

<!-- 									<div class="panel-heading"> -->
<!-- 										<ul class="nav nav-tabs"> -->
<!-- 											<li class="active"><a href="" data-toggle="tab">评价信息</a> -->
<!-- 											</li> -->
<!-- 										</ul> -->
<!-- 									</div> -->

<!-- 									<div class="panel-body"> -->
<!-- 										<form role="form" class="form-horizontal"> -->
<!-- 											<div class="form-group"> -->
<!-- 												<label class="col-sm-2 control-label" for="field-3">归属人评价</label> -->

<!-- 												<div class="col-sm-8"> -->
<!-- 													<textarea class="form-control" cols="5" id="field-5"></textarea> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 											<div class="form-group"> -->
<!-- 												<label class="col-sm-2 control-label" for="field-3">业主自述</label> -->

<!-- 												<div class="col-sm-8"> -->
<!-- 													<textarea class="form-control" cols="5" id="field-5"></textarea> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</form> -->
<!-- 									</div> -->

								</div>
							</div>
						</div>

						<div class="tab-pane" id="tab2">
							<div class="panel panel-default">
								<div class="panel-heading">
									<ul class="nav nav-tabs">
										<li class="active"><a href="" data-toggle="tab"><h2>小区图库</h2>
										</a></li>
									</ul>
								</div>

								<div class="panel-body">
									<form role="form" class="form-horizontal">
									<%-- 	<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3"><span
												class="red">图片类型</span>
											</label>

											<div class="col-sm-8">
												<select class="form-control">
													<option>环境图</option>
													<option>户型图</option>
													<option>交通图</option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3"><span
												class="red">图片名称</span>
											</label>

											<div class="col-sm-8">
												<input type="email" class="form-control" id="field-3"
													placeholder="">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3">上传图片</label>

											<div class="col-sm-5">
												<input type="file" class="form-control" id="field-4">
											</div>
											<span class="help-block">(请上传大小在800*640、5M以内的jpg、png、gif格式图片)</span>
										</div> --%>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="field-3">全部图片</label>
											<div class="col-sm-8">
												<div class="panel-heading">
													<ul class="quanbu nav nav-tabs">
														<li class="active"><a href="#tab-01"
															data-toggle="tab">环境图（<span id="imgnum"></span>）</a></li>
														<li><a href="#tab-02" data-toggle="tab">户型图（<span id="imgnum2"></span>）</a></li>
														<li><a href="#tab-03" data-toggle="tab">交通图（<span id="imgnum3"></span>）</a></li>
														<li><a href="#tab-04" data-toggle="tab">样板间（<span id="imgnum4"></span>）</a></li>
														<li><a href="#tab-05" data-toggle="tab">效果图（<span id="imgnum5"></span>）</a></li>
													</ul>
												</div>

												<div class="tab-content">

													<div class="tab-pane active" id="tab-01">
														<div class="panel-body">
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
														</div>

													</div>

													<div class="tab-pane" id="tab-02">
														<div class="panel-body">
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
														</div>

													</div>
													<div class="tab-pane" id="tab-03">
														<div class="panel-body">
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
														</div>

													</div>

													<div class="tab-pane" id="tab-04">
														<div class="panel-body">
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
														</div>

													</div>

													<div class="tab-pane" id="tab-05">
														<div class="panel-body">
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
<!-- 															<div class="col-lg-6 col-xs-12 form-group"> -->
<!-- 																<a href="#"><img -->
<!-- 																	src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg" -->
<!-- 																	class="img-thumbnail"> -->
<!-- 																</a> -->
<!-- 															</div> -->
														</div>

													</div>

												</div>


											</div>
										</div>

									</form>
								</div>



							</div>
						</div>

						<div class="tab-pane " id="tab3">
							<div class="panel panel-default">
								<div class="panel-heading">
									<ul class="nav nav-tabs">
										<li class="active"><a href="" data-toggle="tab"><h2>房屋成交信息</h2>
										</a></li>
									</ul>
								</div>

								<div class="panel panel-default">
									<div class="panel-heading">
										<ul class="nav nav-tabs">
											<li class="active"><a href="#tab-98" data-toggle="tab">买卖</a>
											</li>
											<li><a href="#tab-99" data-toggle="tab">租赁</a></li>
										</ul>
									</div>
									<div class="tab-content">

										<div class="tab-pane active" id="tab-98">

											<div class="table-responsive">
												<table class="table table-bordered table-striped">
													<thead>
														<tr>
															<th>房源编号</th>
															<th>合同编号</th>
															<th>签约日期</th>
															<th>成交价</th>
															<th>经纪人</th>
															<th>业主</th>
															<th>业主电话</th>
															<th>数据来源</th>
														</tr>
													</thead>
													<tbody class="middle-align" id="fwcjcs">
													</tbody>
												</table>
											</div>
										</div>
										<div class="tab-pane" id="tab-99">

											<div class="table-responsive">
												<table class="table table-bordered table-striped">
													<thead>
														<tr>
															<th>房源编号</th>
															<th>合同编号</th>
															<th>签约日期</th>
															<th>成交价</th>
															<th>经纪人</th>
															<th>业主</th>
															<th>业主电话</th>
															<th>数据来源</th>
														</tr>
													</thead>
													<tbody class="middle-align" id="fwcjcz">
														
													</tbody>
												</table>
											</div>
										</div>

									</div>
									<!-- tab-content  -->

								</div>

							</div>
						</div>

						<div class="tab-pane" id="tab4">
							<div class="panel panel-default">
								<div class="panel-heading">
									<ul class="nav nav-tabs">
										<li class="active"><a href="" data-toggle="tab"><h2>小区成交信息</h2>
										</a></li>
									</ul>
								</div>

								<div class="panel panel-default col-md-12">
									<div class="panel-heading">
										<ul class="nav nav-tabs">
											<li class="active"><a href="#ershoufan"
												data-toggle="tab"> <span class="visible-xs"><i
														class="fa-home"></i>
												</span> <span class="hidden-xs">买卖</span> </a></li>
											<li><a href="#zufan" data-toggle="tab"> <span
													class="visible-xs"><i class="fa-user"></i>
												</span> <span class="hidden-xs">租赁</span> </a></li>
										</ul>
									</div>

									<div class="tab-content">
										<div class="tab-pane active" id="ershoufan">
											
											<div class="panel panel-default"></div>
											<div class="row">
												<div class="panel-heading">
													<div class="col-xs-6">
														<strong>小区成交记录</strong>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="row">
														<div class="col-sm-12">
															<div class="panel panel-default">
																<div class="table-responsive">
																	<table class="table table-striped">
																		<thead>
																			<tr>
																				<th colspan="2">房屋户型</th>
																				<th>面积</th>
																				<th>签约日期</th>
																				<th>成交价</th>
																				<th>成交单价</th>
																				<th>经纪人</th>
																				<th>数据来源</th>
																			</tr>
																		</thead>
																		<tbody id="xqcs">
																			
																		</tbody>
																	</table>
																</div>

															</div>
															<div class="text-center" style="color:#0033CC;"><a href="javascript:getxqxx()">查看更多成交记录></a></div>
														</div>
													</div>
												</div>
											</div>

										</div>
										<div class="tab-pane" id="zufan">
											<div class="panel panel-default"></div>
											<div class="row">
												<div class="panel-heading">
													<div class="col-xs-6">
														<strong>小区成交记录</strong>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="row">
														<div class="col-sm-12">
															<div class="panel panel-default">
																<div class="table-responsive">
																	<table class="table table-striped">
																		<thead>
																			<tr>
																				<th colspan="2">房屋户型</th>
																				<th>面积</th>
																				<th>签约日期</th>
																				<th>装修标准</th>
																				<th>成交单价</th>
																				<th>经纪人</th>
																				<th>数据来源</th>
																			</tr>
																		</thead>
																		<tbody id="xqcz">
																			
																		</tbody>
																	</table>
																</div>

															</div>
															<div class="text-center" style="color:#0033CC;"><a href="javascript:viod()">查看更多成交记录></a></div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div style="clear:both;"></div>

							</div>
						</div>

						<div class="tab-pane" id="tab5">
							<div class="panel panel-default">
								<div class="panel-heading">
									<ul class="nav nav-tabs">
										<li class="active"><a href="" data-toggle="tab"><h2>配套设施</h2>
										</a></li>
									</ul>
								</div>

<!-- 								<div class="panel panel-default"> -->
<!-- 									<div class="tab-content"> -->
									<jsp:include page="../include/zhoubiansousuo.jsp?x=${xhjLpfanghao.x}&y=${xhjLpfanghao.y}"></jsp:include>
<!-- 									</div> -->
<!-- 								</div> -->

							</div>
						</div>

						<div class="tab-pane" id="tab6">
							<div class="panel panel-default">
								<div class="panel-heading">
									<ul class="nav nav-tabs">
										<li class="active"><a href="" data-toggle="tab"><h2>成交信息</h2>
										</a></li>
									</ul>
								</div>
								<div class="panel panel-default col-md-8 col-md-offset-2">
									<div class="panel-heading">
										<ul class="nav nav-tabs">
											<li class="active"><a href="#ershoufan"
												data-toggle="tab"> <span class="visible-xs"><i
														class="fa-home"></i>
												</span> <span class="hidden-xs">二手房</span> </a></li>
											<li><a href="#zufan" data-toggle="tab"> <span
													class="visible-xs"><i class="fa-user"></i>
												</span> <span class="hidden-xs">租房</span> </a></li>
										</ul>
									</div>

									<div class="tab-content">
										<div class="tab-pane active" id="ershoufan">
											
											<div class="panel panel-default"></div>
											<div class="row">
												<div class="panel-heading">
													<div class="col-xs-6">
														<strong>小区成交记录</strong>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="row">
														<div class="col-sm-12">
															<div class="panel panel-default">
																<div class="table-responsive">
																	<table class="table table-striped">
																		<thead>
																			<tr>
																				<th colspan="2">操作人</th>
																				<th class="col-md-4">操作记录</th>
																				<th width="200">操作时间</th>
																			</tr>
																		</thead>
																		<tbody>
																		</tbody>
																	</table>
																</div>

															</div>
															<div class="text-center" style="color:#0033CC;"><a href="javascript:viod()">查看更多成交记录></a></div>
														</div>
													</div>
												</div>
											</div>

										</div>
										<div class="tab-pane" id="zufan">
											
											<div class="panel panel-default"></div>
											<div class="row">
												<div class="panel-heading">
													<div class="col-xs-6">
														<strong>小区成交记录</strong>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="row">
														<div class="col-sm-12">
															<div class="panel panel-default">
																<div class="table-responsive">
																	<table class="table table-striped">
																		<thead>
																			<tr>
																				<th colspan="2">操作人</th>
																				<th class="col-md-4">操作记录</th>
																				<th width="200">操作时间</th>
																			</tr>
																		</thead>
																		<tbody>
																		</tbody>
																	</table>
																</div>

															</div>
															<div class="text-center" style="color:#0033CC;"><a href="javascript:viod()">查看更多成交记录></a></div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div style="clear:both;"></div>
							</div>
						</div>

						<div class="tab-pane" id="tab7">
							<div class="panel panel-default">
								<div class="panel-heading">
									<ul class="nav nav-tabs">
										<li class="active"><a href="" data-toggle="tab"><h2>最新动态</h2>
										</a></li>
									</ul>
								</div>
								<div class="table-responsive">
									<table class="table table-striped">
										<thead>
											<tr>
												<th colspan="2">操作人</th>
												<th class="col-md-4">操作记录</th>
												<th width="200">操作时间</th>
											</tr>
										</thead>
										<tbody id="zxdt">
										</tbody>
									</table>
								</div>
							<div class="text-center" style="color:#0033CC;" ><a href="javascript:getzxdt()">查看更多成交记录></a></div>
							</div>
						</div>
					</div>
					<ul class="pager wizard">
						<div class="col-sm-6 col-sm-offset-3">
							<li class="previous"><a href="#"><i
									class="entypo-left-open"></i> 上一步</a></li>
							<li class="next"><a href="#">下一步 <i
									class="entypo-right-open"></i>
							</a></li>
							<li><a href="javascript:void(0)" onclick="back()">取消</a></li>
						</div>
					</ul>

				</div>

			</div>

		</div>
	</div>

	</div>
	<div class="both"></div>
	</div>

	<!-- Main Footer -->
	</div>
	</div>

	<div class="go-up"
		style="position: fixed;right: 15px; bottom: 10px; z-index: 9999;">
		<a href="#" rel="go-top"> <i class="el-up-open"></i> </a>
	</div>
</body>
<div class="modal fade custom-width" id="xinzenhuapian">
	<div class="modal-dialog" style="width: 40%;">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">查看关联房源</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="800">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">学校类型</td>
								<td><label class="radio-inline"> <input
										type="radio" name="radio-2" checked> 住宅 </label> <label
									class="radio-inline"> <input type="radio"
										name="radio-2"> 商铺 </label></td>
							</tr>
							<tr>
								<td width="100">学校名称</td>
								<td><label class="radio-inline"> <input
										type="radio" name="radio-2" checked> 住宅 </label> <label
									class="radio-inline"> <input type="radio"
										name="radio-2"> 商铺 </label></td>
							</tr>
							<tr>
								<td>户型展示</td>
								<td>
									<div class="row">
										<div class="form-block">
											<div class="col-sm-2">
												<label> <input type="checkbox" class="cbr">
													学区 </label>
											</div>
											<div class="col-sm-2 ">
												<label> <input type="checkbox" class="cbr">
													学位 </label>
											</div>
										</div>
									</div></td>
							</tr>
							<tr>
								<td>选择户型</td>
								<td>
									<div class="form-block">
										<div class="row">
											<div class=" col-xs-4">
												<label> <input type="checkbox" class="cbr">
													1栋 </label>
											</div>
											<div class=" col-xs-4">
												<label> <input type="checkbox" class="cbr">
													1栋 </label>
											</div>
											<div class=" col-xs-4">
												<label> <input type="checkbox" class="cbr">
													1栋 </label>
											</div>
										</div>
										<div class="row">
											<div class=" col-xs-4">
												<label> <input type="checkbox" class="cbr">
													1栋 </label>
											</div>
											<div class=" col-xs-4">
												<label> <input type="checkbox" class="cbr">
													1栋 </label>
											</div>
											<div class=" col-xs-4">
												<label> <input type="checkbox" class="cbr">
													1栋 </label>
											</div>
										</div>
										<div class="row">
											<div class=" col-xs-4">
												<label> <input type="checkbox" class="cbr">
													1栋 </label>
											</div>
											<div class=" col-xs-4">
												<label> <input type="checkbox" class="cbr">
													1栋 </label>
											</div>
											<div class=" col-xs-4">
												<label> <input type="checkbox" class="cbr">
													1栋 </label>
											</div>
										</div>
									</div></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" data-dismiss="modal">保存</button>
				<button type="button" class="btn btn-info">关闭</button>
			</div>
		</div>
	</div>
</div>

</html>

<!-- Bottom Scripts -->
<script src="<%=request.getContextPath() %>/assets/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/TweenMax.min.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/resizeable.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/joinable.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/xenon-api.js"></script>
<script src="<%=request.getContextPath() %>/assets/js/xenon-toggles.js"></script>

<!-- Imported scripts on this page -->
<script src="<%=request.getContextPath() %>/assets/js/xenon-widgets.js"></script>
<script
	src="<%=request.getContextPath() %>/assets/js/select2/select2.min.js"></script>
<script
	src="<%=request.getContextPath() %>/assets/js/formwizard/jquery.bootstrap.wizard.min.js"></script>
<script
	src="<%=request.getContextPath() %>/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script
	src="<%=request.getContextPath() %>/assets/js/selectboxit/jquery.selectBoxIt.min.js"></script>
<script
	src="<%=request.getContextPath() %>/assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script
	src="<%=request.getContextPath() %>/assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>
<script
	src="<%=request.getContextPath() %>/assets/js/toastr/toastr.min.js"></script>
<script
	src="<%=request.getContextPath() %>/assets/js/wysihtml5/lib/js/wysihtml5-0.3.0.js"></script>

<!-- Imported scripts on this page -->
<script
	src="<%=request.getContextPath() %>/assets/js/wysihtml5/src/bootstrap-wysihtml5.js"></script>

<!-- Imported scripts on this page -->
<script
	src="<%=request.getContextPath() %>/assets/js/jquery-ui/jquery-ui.min.js"></script>
<script
	src="<%=request.getContextPath() %>/assets/js/tocify/jquery.tocify.min.js"></script>
<!-- JavaScripts initializations and stuff -->
<script src="<%=request.getContextPath() %>/assets/js/xenon-custom.js"></script>
<div class="modal fade" id="Donglou" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增栋座</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td width="90">新增方式</td>
								<td><label class="radio-inline"> <input
										type="radio" name="radio-2" checked> 单个添加 </label> <label
									class="radio-inline"> <input type="radio"
										name="radio-2"> 批量新增 </label></td>
							</tr>
							<tr>
								<td><span class="red">名称前缀</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td><span class="red">批量序号</span>
								</td>
								<td>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div>
									<div class="col-lg-1">
										<span>-</span>
									</div>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div></td>
							</tr>
							<tr>
								<td><span class="red">名称后缀</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td><span class="red">单元名称</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-info">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal 4 (新增单元)-->
<div class="modal fade" id="Danyuan" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增单元</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td width="90">新增方式</td>
								<td><label class="radio-inline"> <input
										type="radio" name="radio-2" checked> 单个添加 </label> <label
									class="radio-inline"> <input type="radio"
										name="radio-2"> 批量新增 </label></td>
							</tr>
							<tr>
								<td><span class="red">名称前缀</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td><span class="red">批量序号</span>
								</td>
								<td>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div>
									<div class="col-lg-1">
										<span>-</span>
									</div>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div></td>
							</tr>
							<tr>
								<td><span class="red">名称后缀</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td><span class="red">单元名称</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td><span class="red">单元户数</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td><span class="red">总楼层</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-info">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal 4 (修改)-->
<div class="modal fade" id="Xiugai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">修改栋座</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="400">
					<table class="table">
						<tbody>
							<tr>
								<td><span class="red">单元名称</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-info">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal 4 (新增房号)-->
<div class="modal fade" id="Fanghao" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增房号</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="800">
					<table class="table">
						<tbody>
							<tr>
								<td width="90">新增方式</td>
								<td><label class="radio-inline"> <input
										type="radio" name="radio-2" checked> 单个添加 </label> <label
									class="radio-inline"> <input type="radio"
										name="radio-2"> 批量新增 </label></td>
							</tr>
							<tr>
								<td width="90">命名规则</td>
								<td><label class="radio-inline"> <input
										type="radio" name="radio-2" checked> 层+编号 </label> <label
									class="radio-inline"> <input type="radio"
										name="radio-2"> 前缀+编号 </label> <label class="radio-inline">
										<input type="radio" name="radio-2"> 编号+后缀 </label> <label
									class="radio-inline"> <input type="radio"
										name="radio-2"> 前缀+层+编号 </label></td>
							</tr>
							<tr>
								<td width="90">房号类型</td>
								<td><label class="radio-inline"> <input
										type="radio" name="radio-2" checked> 住宅 </label> <label
									class="radio-inline"> <input type="radio"
										name="radio-2"> 商铺 </label></td>
							</tr>
							<tr>
								<td><span class="red">名称前缀</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td><span class="red">批量序号</span>
								</td>
								<td>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div>
									<div class="col-lg-1">
										<span>-</span>
									</div>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div></td>
							</tr>
							<tr>
								<td><span class="red">名称后缀</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td><span class="red">总层数</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td><span class="red">起始层数</span>
								</td>
								<td>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div>
									<div class="col-lg-1">
										<span>-</span>
									</div>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div> <label class="radio-inline"> <input type="radio"
										name="radio-2"> 层数加入命名 </label></td>
							</tr>
							<tr>
								<td><span class="red">起始编号</span>
								</td>
								<td>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div>
									<div class="col-lg-1">
										<span>-</span>
									</div>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div></td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<button type="submit" class="btn btn-info">预览放号</button></td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div></td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div>
									<div class="col-lg-4">
										<input type="text" class="form-control" readonly="">
									</div></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-info">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal 4 (查看关联房源)-->
<div class="modal fade custom-width" id="Guanlianfangyuan">
	<div class="modal-dialog" style="width: 80%;">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">查看关联房源</h4>
			</div>

			<div class="tab-content">
				<div class="panel-body">
					<div class="col-lg-12">
						<div class="table-responsive">
							<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>房号</th>
										<th>房源编号</th>
										<th>租售类型</th>
										<th>归属人</th>
										<th>归属人部门</th>
										<th>录入人</th>
										<th>录入人部门</th>
										<th>房源状态</th>
										<th>房东姓名</th>
										<th>房东电话</th>
										<th>创建时间</th>
									</tr>
								</thead>
								<tbody class="middle-align">
									<tr>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-white" data-dismiss="modal">保存</button>
				<button type="button" class="btn btn-info">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal 4 (修改房号)-->
<div class="modal fade" id="Fanghaoxiugai" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">修改房号</h4>
			</div>
			<div class="modal-body">
				<div class="scrollable" data-max-height="800">
					<table class="table">
						<tbody>
							<tr>
								<td width="100">房号类型</td>
								<td><label class="radio-inline"> <input
										type="radio" name="radio-2" checked> 住宅 </label> <label
									class="radio-inline"> <input type="radio"
										name="radio-2"> 商铺 </label></td>
							</tr>
							<tr>
								<td>上传户型图</td>
								<td><input type="file" class="form-control" id="field-4">
								</td>
							</tr>
							<tr>
								<td>户型展示</td>
								<td>
									<div class="col-sm-12">
										<div class="panel-body">
											<div class="col-lg-6 col-xs-12 form-group">
												<a href="#"><img
													src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg"
													class="img-thumbnail">
												</a>
											</div>
											<div class="col-lg-6 col-xs-12 form-group">
												<a href="#"><img
													src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg"
													class="img-thumbnail">
												</a>
											</div>
											<div class="col-lg-6 col-xs-12 form-group">
												<a href="#"><img
													src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg"
													class="img-thumbnail">
												</a>
											</div>
											<div class="col-lg-6 col-xs-12 form-group">
												<a href="#"><img
													src="http://img.xhjfw.com/image/20150414/14164623c775eb30dd5727.jpg"
													class="img-thumbnail">
												</a>
											</div>
										</div>
									</div></td>
							</tr>
							<tr>
								<td>选择户型</td>
								<td><select class="form-control" disabled>
										<option>两室一厅</option>
										<option>两室一厅</option>
										<option>两室一厅</option>
								</select></td>
							</tr>
							<tr>
								<td>门牌名称</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td><span class="red">单元房号</span>
								</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td>产权面积</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td>楼盘朝向</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td>产权性质</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td>套内面积</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
							<tr>
								<td>房号备注</td>
								<td><input type="text" class="form-control" readonly=""
									placeholder=""></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-info">保存</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal 4 (新增划片)-->
<div class="modal fade" id="xinzenwuye" data-backdrop="static">
	<div class="modal-dialog" style="width: 60%;">

		<div class="panel panel-default">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">新增物业</h4>
			</div>
			<div class="panel-body">
				<form role="form" class="form-horizontal">
					<div class="form-group">
						<div class="col-md-12">
							<label class="col-sm-2 control-label">物业公司名称</label>

							<div class="col-sm-5">
								<input type="text" class="form-control" readonly="">
							</div>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<div class="col-md-12">
							<label class="col-sm-2 control-label">物业公司地址</label>

							<div class="col-sm-5">
								<input type="text" class="form-control" readonly="">
							</div>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<div class="col-md-12">
							<label class="col-sm-2 control-label">物业公司电话</label>
							<div class="col-sm-3">
								<input type="text" class="col-xs-5 wenbenkuan1">
								<div class="col-xs-2 text-center magin-top5">一</div>
								<input type="text" class="col-xs-5 wenbenkuan1">
							</div>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<div class="col-md-12">
							<label class="col-sm-2 control-label">物业费</label>
							<div class="col-sm-3">
								<div class="input-group input-group-minimal">
									<input type="text" class="form-control" readonly="">

									<div class="input-group-addon">
										<a href="#">元/㎡/月</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<div class="col-md-12">
							<label class="col-sm-2 control-label" for="field-11">车库说明</label>
							<div class="col-sm-10">
								<textarea class="form-control"></textarea>
							</div>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<div class="col-md-12">
							<label class="col-sm-2 control-label" for="field-3">停车费</label>
							<div class="col-sm-3">
								<div class="input-group input-group-minimal">
									<input type="text" class="form-control" readonly="">

									<div class="input-group-addon">
										<a href="#">㎡</a>
									</div>
								</div>
							</div>
							<label class="col-sm-1 control-label" for="field-3">门禁系统</label>
							<div class="col-sm-3">
								<div class="input-group input-group-minimal">
									<div class="radio col-sm-6">
										<label> <input type="radio" name="radio-1" checked>
											是 </label>
									</div>
									<div class="radio col-sm-6">
										<label> <input type="radio" name="radio-1"> 否
										</label>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<div class="col-md-12">
							<label class="col-sm-2 control-label" for="field-3">监控系统</label>
							<div class="col-sm-3">
								<div class="input-group input-group-minimal">
									<div class="radio col-sm-6">
										<label> <input type="radio" name="radio-2" checked>
											是 </label>
									</div>
									<div class="radio col-sm-6">
										<label> <input type="radio" name="radio-2"> 否
										</label>
									</div>
								</div>
							</div>
							<label class="col-sm-1 control-label" for="field-3">物业租赁</label>
							<div class="col-sm-6">
								<div class="radio col-xs-2">
									<label> <input type="radio" name="radio-3" checked>
										出租 </label>
								</div>
								<div class="radio col-xs-2">
									<label> <input type="radio" name="radio-3"> 出售
									</label>
								</div>
								<div class="radio col-xs-3">
									<label> <input type="radio" name="radio-3">
										租售均可 </label>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<div class="col-md-5 col-md-offset-5">
							<button type="submit" class="btn btn-success">保存</button>
							<button type="reset" class="btn btn-white">取消</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
