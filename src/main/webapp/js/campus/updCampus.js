$(document).ready(function(){
	buildCountry(true);
	buildPro($("#country").attr("data-value"),true);
	buildCity($("#pro").attr("data-value"),true);
	buildQy($("#city").attr("data-value"),true);
	buildSq($("#sQy").attr("data-value"),true);
	getSyscsTypeCheck("楼盘用途","yongtu");
	getSyscsTypeCheck("采暖方式","heatingWay");
	getSyscsTypeCheck("建筑类别","buildingType");
	getSyscsTypeCheck("建筑年代","buildingAge");
	getSyscsTypeCheck("建筑类别","lType");
	getSyscsTypeCheck("环线","linkLocAtion");
	getSyscsTypeCheck("供气方式","airSupply");
	getSyscsTypeCheck("供水方式","waterSupply");
	getSyscsTypeCheck("供电方式","powerSupply");
	getSyscsTypeCheck("通讯配置","configuration");
	getSyscsTypeCheck("社区安全设置","communitySafety");
	getSyscsTypeCheck("门窗材料","materials");
	getSyscsTypeCheck("电梯品牌","brand");
	getSyscsTypeCheck("外墙处理方式","facadesProcessing");
	getSyscsTypeCheck("楼盘等级","level");
	getSyscsTypeCheck("建筑结构","buildingStructure");
	//标签
	geSyscsRadioCheck(441, "lptag", "checkbox", "lpxx.lpTag","");
	//内部设施
	geSyscsRadioCheck(445, "supporting", "checkbox", "lpxx.propertySupporting","");
	getSyscsTypeCheck("产权年限","propertyAge");
	getSyscsTypeCheck("权属性质","propertyInfo");
	//获取所有选中房号
	$('.cbALL').change(function(){
		if($('.cbALL').prop("checked")){
			//选中
			$('.fanghaoCB').each(function(i){
				$(this).prop('checked',true);
			});
		}else{
			//未选中
			$('.fanghaoCB').each(function(i){
				$(this).prop('checked',false);
			});
		};
	});
	
	//获取所有选中栋座
	$('.lpdz').change(function(){
		if($('.lpdz').prop("checked")){
			//选中
			$('.lpLdong').each(function(i){
				$(this).prop('checked',true);
			});
		}else{
			//未选中
			$('.lpLdong').each(function(i){
				$(this).prop('checked',false);
			});
		};
	});
	
	//获取所有选中单元
	$('.lpdy').change(function(){
		if($('.lpdy').prop("checked")){
			//选中
			$('.lpdanyuan').each(function(i){
				$(this).prop('checked',true);
			});
		}else{
			//未选中
			$('.lpdanyuan').each(function(i){
				$(this).prop('checked',false);
			});
		};
	});
	//楼盘信息保存
	$('#lpxxForm').submit(function() {
		$('.onsubing').css("display","block");//弹出提示框
		jQuery.ajax({
			url: basepath + "/cam/campus!saveLpxx.action",
			dataType: "json",
			data: $('#lpxxForm').serialize(), 
			type: "POST",
			async :false,
			beforeSend: function(){
				//在异步提交前要做的操作
				return lpxxCheck();
			},
			success: function(result){
				if(result.data == "success") {
					//在异步提交成功后要做的操作
					bootbox.alert({title:"提示",message:"保存成功!"});
					$('.onsubing').css("display","none");//弹出提示框
					//跳到下一步
				} else {
					alert(result.data);
					$('.onsubing').css("display","none");//弹出提示框
					return false;
				}
			}
		});
		return false;
	});
	//图片保存
	$('#lpimageForm').submit(function() {
		jQuery.ajax({
			url: basepath + "/cam/campus!saveLptp.action",
			dataType: "json",
			data: $('#lpimageForm').serialize(), 
			type: "POST",
			async :false,
			beforeSend: function(){
				//在异步提交前要做的操作
				return imgCheck();
			},
			success: function(result){
				if(result.data == "success") {
					//在异步提交成功后要做的操作
					bootbox.alert({title:"提示",message:"保存成功!"});
					$("#tabDz").attr("href","#tab4").attr("data-toggle","tab");
					$("#wuyeid").val(result.id);
					$('.onsubing').css("display","none");//弹出提示框
					//跳到下一步
				} else {
					alert(result.data);
					$('.onsubing').css("display","none");//弹出提示框
					return false;
				}
			}
		});
		return false;
	});
	var selectshi =document.getElementById("selectshi");
	var  fengdiv =document.getElementById("fenggediv");
	$("#houseExclusiveImgType").change(function(){
		var houseExclusiveImgTypeid = $("#houseExclusiveImgType").val();
		
		if(houseExclusiveImgTypeid ==1)
		{
			$("#houseExclusiveImgType1").click();
				selectshi.style.display = "block";
				fengdiv.style.display = "none";
			
		}
		else if(houseExclusiveImgTypeid ==2)
		{
			$("#houseExclusiveImgType2").click();
			selectshi.style.display = "none";
			fengdiv.style.display = "none";
		}else if(houseExclusiveImgTypeid ==3){
			$("#houseExclusiveImgType3").click();
			selectshi.style.display = "none";
			fengdiv.style.display = "none";
		}else if(houseExclusiveImgTypeid ==4){
			$("#houseExclusiveImgType4").click();
			selectshi.style.display = "none";
			fengdiv.style.display = "block";
		}else if(houseExclusiveImgTypeid ==5){
			$("#houseExclusiveImgType5").click();
			selectshi.style.display = "none";
			fengdiv.style.display = "none";
		}
			
	});
	
	$("#houseExclusiveImgType1").click(function(){
		$("#houseExclusiveImgType").val(1);
		selectshi.style.display = "block";
		fengdiv.style.display = "none";
	});
	
	$("#houseExclusiveImgType2").click(function(){
		$("#houseExclusiveImgType").val(2);
		selectshi.style.display = "none";
		fengdiv.style.display = "none";
	});
	$("#houseExclusiveImgType3").click(function(){
		$("#houseExclusiveImgType").val(3);
		selectshi.style.display = "none";
		fengdiv.style.display = "none";
	});
	
	$("#houseExclusiveImgType4").click(function(){
		$("#houseExclusiveImgType").val(4);
		selectshi.style.display = "none";
		fengdiv.style.display = "block";
	});
	$("#houseExclusiveImgType5").click(function(){
		$("#houseExclusiveImgType").val(5);
		selectshi.style.display = "none";
		fengdiv.style.display = "none";
	});

	
});
//楼盘保存校验
function lpxxCheck(){
	var country = $("#country").val();
	if(country == null || country == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请选择楼盘所在国家!"});
		return false;
	}
	var pro = $("#pro").val();
	if(pro == null || pro == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请选择楼盘所在省份!"});
		return false;
	}
	var city = $("#city").val();
	if(city == null || city == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请选择楼盘所在城市!"});
		return false;
	}
	var sQy = $("#sQy").val();
	if(sQy == null || sQy == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请选择楼盘所在区域!"});
		return false;
	}
	var sSq = $("#sSq").val();
	if(sSq == null || sSq == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请选择楼盘所在商圈!"});
		return false;
	}
	var yongtu = $("#yongtu").val();
	if(yongtu == null || yongtu == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请选择楼盘用途!"});
		return false;
	}
	var lpName = $("#lpName").val().replace(/\s+/g,"");
	if(lpName == null || lpName == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入楼盘名称!"});
		return false;
	}
	var bieMing = $("#bieMing").val().replace(/\s+/g,"");
	if(bieMing == null || bieMing == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入楼盘别名!"});
		return false;
	}
	var lType = $("#lType").val();
	if(lType == null || lType == "" || lType==0) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入楼盘类型!"});
		return false;
	}
	
	var xzgx = $("#xzgx").val().replace(/\s+/g,"");
	if(xzgx == null || xzgx == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入行政地址!"});
		return false;
	}
	var lpaddress = $("#address").val().replace(/\s+/g,"");
	if(lpaddress == null || lpaddress == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入楼盘地址!"});
		return false;
	}
	var linkLocAtion = $("#linkLocAtion").val();
	if(linkLocAtion == null || linkLocAtion == "" || linkLocAtion==0) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入环线位置!"});
		return false;
	}
	var lpxxx = $("#xxzbx").val();
	if(lpxxx == null || lpxxx == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请选择楼盘所在位置!"});
		$("#loadXY").click();
		return false;
	}
	var propertyAddress = $("#propertyAddress").val().replace(/\s+/g,"");
	if(propertyAddress == null || propertyAddress == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入楼盘产权地址!"});
		return false;
	}
	
	var beiZ = $("#beiZ").val().replace(/\s+/g,"");
	if(beiZ == null || beiZ == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入楼盘备注!"});
		return false;
	}
	var sumZd = $("#sumZd").val().replace(/\s+/g,"");
	if(sumZd != null && sumZd != "") {
	if(checkNumber(sumZd)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入占地面积的为数字!"});
		return false;
	}
	}
	var sumJz = $("#sumJz").val().replace(/\s+/g,"");
	if(sumJz != null && sumJz != "") {
	if(checkNumber(sumJz)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入建筑面积的为数字!"});
		return false;
	}
	}
	var rjl = $("#rjl").val().replace(/\s+/g,"");
	if(rjl != null && rjl != "") {
	if(checkNumber(rjl)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入容积率的为数字!"});
		return false;
	}
	}
	var lhl = $("#lhl").val().replace(/\s+/g,"");
	if(lhl != null && lhl != "") {
	if(checkNumber(lhl)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入绿化率的为数字!"});
		return false;
	}
	}
	var djs = $("#djs").val().replace(/\s+/g,"");
	if(djs != null && djs != "") {
	if(checkNumber(djs)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入总栋数的为数字!"});
		return false;
	}
	}
	
	var sumZd = $("#sumZd").val().replace(/\s+/g,"");
	if(sumZd != null && sumZd != "") {
	if(checkNumber(sumZd)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入占地面积的为数字!"});
		return false;
	}
	}
	var sumJz = $("#sumJz").val().replace(/\s+/g,"");
	if(sumJz != null && sumJz != "") {
	if(checkNumber(sumJz)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入建筑面积的为数字!"});
		return false;
	}
	}
	var rjl = $("#rjl").val().replace(/\s+/g,"");
	if(rjl != null && rjl != "") {
	if(checkNumber(rjl)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入容积率的为数字!"});
		return false;
	}
	}
	var lhl = $("#lhl").val().replace(/\s+/g,"");
	if(lhl != null && lhl != "") {
	if(checkNumber(lhl)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入绿化率的为数字!"});
		return false;
	}
	}
	var djs = $("#djs").val().replace(/\s+/g,"");
	if(djs != null && djs != "") {
	if(checkNumber(djs)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入总栋数的为数字!"});
		return false;
	}
	}
	var hjs = $("#hjs").val().replace(/\s+/g,"");
	if(hjs != null && hjs != "") {
	if(checkNumber(hjs)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入总户数的为数字!"});
		return false;
	}
	}
	var rzhs = $("#rzhs").val().replace(/\s+/g,"");
	if(rzhs != null && rzhs != "") {
	if(checkNumber(rzhs)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入入住总户数的为数字!"});
		return false;
	}
	}
	var roomRate = $("#roomRate").val().replace(/\s+/g,"");
	if(roomRate != null && roomRate != "") {
	if(checkNumber(roomRate)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入得房率的为数字!"});
		return false;
	}
	}
	var openingPrice = $("#openingPrice").val().replace(/\s+/g,"");
	if(openingPrice != null && openingPrice != "") {
	if(checkNumber(openingPrice)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入开盘起价的为数字!"});
		return false;
	}
	}
	var lpprice = $("#lpprice").val().replace(/\s+/g,"");
	if(lpprice != null && lpprice != "") {
	if(checkNumber(lpprice)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入系统报价单价的为数字!"});
		return false;
	}
	}
	var openingAvgPrice = $("#openingAvgPrice").val().replace(/\s+/g,"");
	if(openingAvgPrice != null && openingAvgPrice != "") {
	if(checkNumber(openingAvgPrice)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入开盘均价的为数字!"});
		return false;
	}
	}
	var avgPrice = $("#avgPrice").val().replace(/\s+/g,"");
	if(avgPrice != null && avgPrice != "") {
	if(checkNumber(avgPrice)) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入当前均价的为数字!"});
		return false;
	}
	}
	var PNum = $("#PNum").val().replace(/\s+/g,"");
	if(PNum != null && PNum != "") {
	if(PNum.length > 200) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"车库说明字数不能大于200!"});
		return false;
	}
	}
	
	$('.onsubing').css("display","block");//弹出提示框
};

//物业保存校验
function wuyeCheck(){
	var wyName = $("#wyName").val().replace(/\s+/g,"");
	if(wyName == null || wyName == "") {
		bootbox.alert({title:"提示",message:"请输入物业公司名称!"});
		return false;
	}
	var wydz = $("#wydz").val().replace(/\s+/g,"");
	if(wydz == null || wydz == "") {
		bootbox.alert({title:"提示",message:"请输入物业公司地址!"});
		return false;
	}
	var telephone = $("#telephone").val().replace(/\s+/g,"");
	if(telephone == null || telephone == "") {
		bootbox.alert({title:"提示",message:"请输入物业公司电话!"});
		$("#telephone").focus();
		return false;
	}
	var telephone1 = $("#telephone1").val().replace(/\s+/g,"");
	if(telephone1 == null || telephone1 == "") {
		bootbox.alert({title:"提示",message:"请输入物业公司电话!"});
		$("#telephone1").focus();
		return false;
	}
	$('.onsubing').css("display","block");//弹出提示框
};

//图片保存校验
function imgCheck(){
	$('.onsubing').css("display","block");//弹出提示框
};
	
function buildCountry(checked){
	$.ajax({
		url: basepath + "/cam/campus!getCountryInfo.action",
		dataType: "json", 
		type: "POST",
		success: function(data){
			var cHtml = '<option value="">请选择</option>';
			$.each(data, function(i,n){
				if(n.id == $("#country").attr("data-value") && checked){
					cHtml += '<option value="'+n.id+'" selected="selected">'+n.cname+'</option>';
				} else {
					cHtml += '<option value="'+n.id+'">'+n.cname+'</option>';
				}
			});
			$("#country").html(cHtml);
	    }
	});
};

function buildPro(val,checked){
	if(val != "") {
		$("#city").html('<option value="">请选择</option>');
		$("#sQy").html('<option value="">请选择</option>');
		$("#sSq").html('<option value="">请选择</option>');
		$.ajax({ 
			url: basepath + "/cam/campus!getPro.action",
			dataType: "json", 
			type: "POST",
			data : {"cid" : val},
			success: function(data){
				var pHtml = '<option value="">请选择</option>';
				$.each(data, function(i,n){
					if(n.id == $("#pro").attr("data-value") && checked){
						pHtml += '<option value="'+n.id+'" selected="selected">'+n.pname+'</option>';
					} else {
						pHtml += '<option value="'+n.id+'">'+n.pname+'</option>';
					}
				});
				$("#pro").html(pHtml);
		    }
		});
	} else {
		$("#pro").html('<option value="">请选择</option>');
		$("#city").html('<option value="">请选择</option>');
		$("#sQy").html('<option value="">请选择</option>');
		$("#sSq").html('<option value="">请选择</option>');
	}
};

function buildCity(val,checked){
	if(val != "") {
		$("#sQy").html('<option value="">请选择</option>');
		$("#sSq").html('<option value="">请选择</option>');
		$.ajax({ 
			url: basepath + "/cam/campus!getCity.action",
			dataType: "json", 
			type: "POST",
			data : {"pid" : val},
			success: function(data){
				var pHtml = '<option value="">请选择</option>';
				$.each(data, function(i,n){
					if(n.id == $("#city").attr("data-value") && checked){
						pHtml += '<option value="'+n.id+'" selected="selected">'+n.cityName+'</option>';
					} else {
						pHtml += '<option value="'+n.id+'">'+n.cityName+'</option>';
					}
				});
				$("#city").html(pHtml);
		    }
		});
	} else {
		$("#city").html('<option value="">请选择</option>');
		$("#sQy").html('<option value="">请选择</option>');
		$("#sSq").html('<option value="">请选择</option>');
	}
};

function buildQy(val,checked){
	if(val != "") {
		$("#sSq").html('<option value="">请选择</option>');
		$.ajax({ 
			url: basepath + "/cam/campus!getQy.action",
			dataType: "json", 
			type: "POST",
			data : {"cid" : val},
			success: function(data){
				var pHtml = '<option value="">请选择</option>';
				$.each(data, function(i,n){
					if(n.id == $("#sQy").attr("data-value") && checked){
						pHtml += '<option value="'+n.id+'" selected="selected">'+n.qyName+'</option>';
					} else {
						pHtml += '<option value="'+n.id+'">'+n.qyName+'</option>';
					}
				});
				$("#sQy").html(pHtml);
		    }
		});
	} else {
		$("#sQy").html('<option value="">请选择</option>');
		$("#sSq").html('<option value="">请选择</option>');
	}
};

function buildSq(val,checked){
	if(val != "") {
		$.ajax({ 
			url: basepath + "/cam/campus!getSq.action",
			dataType: "json", 
			type: "POST",
			data : {"stressId" : val},
			success: function(data){
				var pHtml = '<option value="">请选择</option>';
				$.each(data, function(i,n){
					if(n.id == $("#sSq").attr("data-value") && checked){
						pHtml += '<option value="'+n.id+'" selected="selected">'+n.sqName+'</option>';
					} else {
						pHtml += '<option value="'+n.id+'">'+n.sqName+'</option>';
					}
				});
				$("#sSq").html(pHtml);
		    }
		});
	} else {
		$("#sSq").html('<option value="">请选择</option>');
	}
};

function setXandY(x,y,address,winClose){
	$("#lpxxx").val(x);
	$("#lpxxy").val(y);
	$("#" + winClose).click();
};

function cancel(){
	var from = $("input[name='from']").val();
	if(from=="apply"){	//从楼盘采集过来
		window.location.href = basepath + "/lp/lpxxCollect.action";
	} else if(from=="check"){	//从楼盘审核过来
		window.location.href = basepath + "/lp/check.action?tab="+fromPageTab;
	} else {
		window.location.href = basepath + "/cam/campus.action";
	}
};

//显示所有地铁信息
function showAddMetor(){
	$.ajax({
		url: basepath + "/cam/campus!getMotors.action",
		dataType: "json",
		type: "POST",
		async : false,
		success: function(data){
			var pHtml = '<option value="0">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.xlName+'</option>';
			});
			$("#dtxianlu").html(pHtml);
	    }
	});
};
//加载所有部门
function showDepart(){
	$.ajax({
		url: basepath + "/base/department!queryDepartmentsByName.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"organizationId" : 88},
		success: function(data){
			var pHtml = '<option value="0">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#serviceWD").html(pHtml);
			$("#addZrService").html(pHtml);
			$("#weihaddService").html(pHtml);
			$("#fanwaddService").html(pHtml);
			$("#updFuzhuWd").html(pHtml);
	    }
	});
};
//加载所有学校类型 shchoolType
function showShchoolAllType(){
	$.ajax({
		url: basepath + "/cam/campus!showSchoolAllType.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"sid" : 767},
		success: function(data){
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#schoolType").html(pHtml);
			$("#schoolUpdType").html(pHtml);
	    }
	});
};

//供气方式
function buildAirSupply(){
	$.ajax({
		url: basepath + "/cam/campus!showSyscsParams.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"name" : "供气方式"},
		success: function(data){
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#airSupply").html(pHtml);
//			$("#schoolUpdType").html(pHtml);
	    }
	});
};
//采暖方式
function buildHeatingWay(){
	$.ajax({
		url: basepath + "/cam/campus!showSyscsParams.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"name" : "供气方式"},
		success: function(data){
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#heatingWay").html(pHtml);
//			$("#schoolUpdType").html(pHtml);
	    }
	});
};

//供水方式
function buildWaterSupply(){
	$.ajax({
		url: basepath + "/cam/campus!showSyscsParams.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"name" : "供气方式"},
		success: function(data){
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#waterSupply").html(pHtml);
//			$("#schoolUpdType").html(pHtml);
	    }
	});
};

//供电方式
function buildPowerSupply(){
	$.ajax({
		url: basepath + "/cam/campus!showSyscsParams.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"name" : "供气方式"},
		success: function(data){
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#powerSupply").html(pHtml);
//			$("#schoolUpdType").html(pHtml);
	    }
	});
};

//通讯配置
function buildConfiguration(){
	$.ajax({
		url: basepath + "/cam/campus!showSyscsParams.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"name" : "供气方式"},
		success: function(data){
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#configuration").html(pHtml);
//			$("#schoolUpdType").html(pHtml);
	    }
	});
};

//社区安全设置
function buildCommunitySafety(){
	$.ajax({
		url: basepath + "/cam/campus!showSyscsParams.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"name" : "供气方式"},
		success: function(data){
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#communitySafety").html(pHtml);
//			$("#schoolUpdType").html(pHtml);
	    }
	});
};

//门窗材料
function buildMaterials(){
	$.ajax({
		url: basepath + "/cam/campus!showSyscsParams.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"name" : "供气方式"},
		success: function(data){
			alert(data)
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#materials").html(pHtml);
//			$("#schoolUpdType").html(pHtml);
	    }
	});
};

//电梯品牌
function buildBrand(){
	$.ajax({
		url: basepath + "/cam/campus!showSyscsParams.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"name" : "供气方式"},
		success: function(data){
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#brand").html(pHtml);
//			$("#schoolUpdType").html(pHtml);
	    }
	});
};

//外墙处理方
function buildFacadesProcessing(){
	$.ajax({
		url: basepath + "/cam/campus!showSyscsParams.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"name" : "供气方式"},
		success: function(data){
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#facadesProcessing").html(pHtml);
//			$("#schoolUpdType").html(pHtml);
	    }
	});
};

//建筑类型
function buildBuildingType(){
	$.ajax({
		url: basepath + "/cam/campus!showSyscsParams.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"name" : "供气方式"},
		success: function(data){
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#buildingType").html(pHtml);
//			$("#schoolUpdType").html(pHtml);
	    }
	});
};

//建筑结构
function buildingStructure(){
	$.ajax({
		url: basepath + "/cam/campus!showSyscsParams.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"name" : "供气方式"},
		success: function(data){
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#leixing").html(pHtml);
//			$("#schoolUpdType").html(pHtml);
	    }
	});
};


