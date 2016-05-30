$(document).ready(function(){
	var coun = $("#usCountry").val();
	buildCountry(coun);
	if(coun != null) {
		buildPro(coun);
		buildCity($("#usPro").val());
		buildQy($("#usCity").val());
	}
	getSyscsTypeCheck("楼盘用途","yongtu");
	//标签
	geSyscsRadio(441, "lptag", "checkbox", "lpxx.lpTag","");
	//获取所有选中
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
	//内部设施
	geSyscsRadio(445, "supporting", "checkbox", "lpxx.propertySupporting","");
	//楼盘信息保存
	$('#lpxxForm').submit(function() {
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
					$("#tabWy").attr("href","#tab2").attr("data-toggle","tab");
					$("#tabTk").attr("href","#tab3").attr("data-toggle","tab");
					$("#tabDz").attr("href","#tab4").attr("data-toggle","tab");
					$("#tabSs").attr("href","#tab5").attr("data-toggle","tab");
					$("#lpxxid").val(result.id);
					$("#wuyelpid").val(result.id);	//物业
					$("#tuplpid").val(result.id);	//图片
					$("#dyuplpid").val(result.id); //修改单元
					$("#xhjLpdonglpId").val(result.id); //修改栋座
					$("#dylpid").val(result.id); //新增单元
					$("#dzlpid").val(result.id); //新增栋座
					$("#fanghaoUplpid").val(result.id);//修改房号
					$("#fanghaolpid").val(result.id);//新增房号
					$('.onsubing').css("display","none");//弹出提示框
					$("#tabWy").click();
					//跳到下一步
				} else {
					alert(result.data);
					$('.onsubing').css("display","none");//弹出提示框
					return false;
				}
			}
		});
		$('.onsubing').css("display","none");//弹出提示框
		return false;
	});
	//物业信息保存
	$('#wyForm').submit(function() {
		jQuery.ajax({
			url: basepath + "/cam/campus!saveLpwy.action",
			dataType: "json",
			data: $('#wyForm').serialize(), 
			type: "POST",
			async :false,
			beforeSend: function(){
				//在异步提交前要做的操作
				return wuyeCheck();
			},
			success: function(result){
				if(result.data == "success") {
					//在异步提交成功后要做的操作
					bootbox.alert({title:"提示",message:"保存成功!"});
					$("#wuyeid").val(result.id);
					$('.onsubing').css("display","none");//弹出提示框
					$("#tabTk").click();
					//跳到下一步
				} else {
					alert(result.data);
					$('.onsubing').css("display","none");//弹出提示框
					return false;
				}
			}
		});
		$('.onsubing').css("display","none");//弹出提示框
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
					$("#tabDz").click();
					//跳到下一步
				} else {
					alert(result.data);
					$('.onsubing').css("display","none");//弹出提示框
					return false;
				}
			}
		});
		$('.onsubing').css("display","none");//弹出提示框
		return false;
	});
	//加载地铁线路
	showAddMetor();
	//加载部门
	showDepart();
	//加载学校类型
	showShchoolAllType();
	//加载维护单位数据
//	queryData();
	//加载维护居住成本
//	queryData1();
	getSyscsTypeCheck("建筑类别","buildingType");
	getSyscsTypeCheck("建筑年代","buildingAge");
	getSyscsTypeCheck("供气方式","airSupply");
	getSyscsTypeCheck("采暖方式","heatingWay");
	getSyscsTypeCheck("供水方式","waterSupply");
	getSyscsTypeCheck("供电方式","powerSupply");
	getSyscsTypeCheck("通讯配置","configuration");
	getSyscsTypeCheck("社区安全设置","communitySafety");
	getSyscsTypeCheck("门窗材料","materials");
	getSyscsTypeCheck("电梯品牌","brand");
	getSyscsTypeCheck("外墙处理方式","facadesProcessing");
	getSyscsTypeCheck("建筑类别","ltype");
	getSyscsTypeCheck("环线","linkLocAtion");
	getSyscsTypeCheck("建筑结构","buildingStructure");
	getSyscsTypeCheck("维护单位","mType");
	getSyscsTypeCheck("居住成本","ctype");
	getSyscsTypeCheck("房屋朝向","chaoXiang");
	getSyscsTypeCheck("房屋用途","leibei2");
	getSyscsTypeCheck("装修情况","decorationStandard");
	getSyscsTypeCheck("租赁支付方式","payingWay");
	getSyscsTypeCheck("产权年限","propertyAge");
	getSyscsTypeCheck("权属性质","propertyInfo");
	getSyscsTypeCheck("房屋朝向","chaoXiangup");
	getSyscsTypeCheck("装修情况","decorationStandardup");
	getSyscsTypeCheck("楼盘等级","level");
	
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
//	var country = $("#country").val();
//	if(country == null || country == "") {
//		bootbox.alert({title:"提示",message:"请选择楼盘所在国家!"});
//		return false;
//	}
	var pro = $("#pro").val();
	if(pro == null || pro == ""  || pro == "0") {
		bootbox.alert({title:"提示",message:"请选择楼盘所在省份!"});
		return false;
	}
	var city = $("#city").val();
	if(city == null || city == "" || city == "0") {
		bootbox.alert({title:"提示",message:"请选择楼盘所在城市!"});
		return false;
	}
	var sQy = $("#sQy").val();
	if(sQy == null || sQy == "" || sQy == "0") {
		bootbox.alert({title:"提示",message:"请选择楼盘所在区域!"});
		return false;
	}
	var sSq = $("#sSq").val();
	if(sSq == null || sSq == "" || sSq =="0") {
		bootbox.alert({title:"提示",message:"请选择楼盘所在商圈!"});
		return false;
	}
	var yongtu = $("#yongtu").val();
	if(yongtu == null || yongtu == "" || yongtu == "0") {
		bootbox.alert({title:"提示",message:"请选择楼盘用途!"});
		return false;
	}
	var ltype = $("#ltype").val();
	if(ltype == null || ltype == "0") {
		bootbox.alert({title:"提示",message:"请选择楼盘类型!"});
		return false;
	}
	var lpName = $("#lpName").val().replace(/\s+/g,"");
	if(lpName == null || lpName == "") {
		bootbox.alert({title:"提示",message:"请输入楼盘名称!"});
		return false;
	}
	
	var bieMing = $("#bieMing").val().replace(/\s+/g,"");
	if(bieMing == null || bieMing == "") {
		bootbox.alert({title:"提示",message:"请输入别名!"});
		return false;
	}
	var xzgx = $("#xzgx").val().replace(/\s+/g,"");
	if(xzgx == null || xzgx == "") {
		bootbox.alert({title:"提示",message:"请输入行政地址!"});
		return false;
	}
	var lpaddress = $("#address").val().replace(/\s+/g,"");
	if(lpaddress == null || lpaddress == "") {
		bootbox.alert({title:"提示",message:"请输入楼盘地址!"});
		return false;
	}
	var lpxxx = $("#xxzbx").val();
	if(lpxxx == null || lpxxx == "") {
		bootbox.alert({title:"提示",message:"请选择楼盘所在位置!"});
		$("#loadXY").click();
		return false;
	}
	
	var linkLocAtion = $("#linkLocAtion").val();
	if(linkLocAtion == null || linkLocAtion == "0") {
		bootbox.alert({title:"提示",message:"请选择环线位置!"});
		return false;
	}
	
	var propertyAddress = $("#propertyAddress").val().replace(/\s+/g,"");
	if(propertyAddress == null || propertyAddress == "") {
		bootbox.alert({title:"提示",message:"请输入楼盘产权地址!"});
		return false;
	}
	var beiZ = $("#beiZ").val().replace(/\s+/g,"");
	if(beiZ == null || beiZ == "") {
		bootbox.alert({title:"提示",message:"请输入备注!"});
		return false;
	}
	var sumZd = $("#sumZd").val().replace(/\s+/g,"");
	if(sumZd != null && sumZd != "") {
	if(checkNumber(sumZd)) {
		bootbox.alert({title:"提示",message:"请输入占地面积的为数字!"});
		return false;
	}
	}
	var sumJz = $("#sumJz").val().replace(/\s+/g,"");
	if(sumJz != null && sumJz != "") {
	if(checkNumber(sumJz)) {
		bootbox.alert({title:"提示",message:"请输入建筑面积的为数字!"});
		return false;
	}
	}
	var rjl = $("#rjl").val().replace(/\s+/g,"");
	if(rjl != null && rjl != "") {
	if(checkNumber(rjl)) {
		bootbox.alert({title:"提示",message:"请输入容积率的为数字!"});
		return false;
	}
	}
	var lhl = $("#lhl").val().replace(/\s+/g,"");
	if(lhl != null && lhl != "") {
	if(checkNumber(lhl)) {
		bootbox.alert({title:"提示",message:"请输入绿化率的为数字!"});
		return false;
	}
	}
	var djs = $("#djs").val().replace(/\s+/g,"");
	if(djs != null && djs != "") {
	if(checkNumber(djs)) {
		bootbox.alert({title:"提示",message:"请输入总栋数的为数字!"});
		return false;
	}
	}
	var hjs = $("#hjs").val().replace(/\s+/g,"");
	if(hjs != null && hjs != "") {
	if(checkNumber(hjs)) {
		bootbox.alert({title:"提示",message:"请输入总户数的为数字!"});
		return false;
	}
	}
	var rzhs = $("#rzhs").val().replace(/\s+/g,"");
	if(rzhs != null && rzhs != "") {
	if(checkNumber(rzhs)) {
		bootbox.alert({title:"提示",message:"请输入入住总户数的为数字!"});
		return false;
	}
	}
	var roomRate = $("#roomRate").val().replace(/\s+/g,"");
	if(roomRate != null && roomRate != "") {
	if(checkNumber(roomRate)) {
		bootbox.alert({title:"提示",message:"请输入得房率的为数字!"});
		return false;
	}
	}
	var openingPrice = $("#openingPrice").val().replace(/\s+/g,"");
	if(openingPrice != null && openingPrice != "") {
	if(checkNumber(openingPrice)) {
		bootbox.alert({title:"提示",message:"请输入系统报价单价的为数字!"});
		return false;
	}
	}
	var lpprice = $("#lpprice").val().replace(/\s+/g,"");
	if(lpprice != null && lpprice != "") {
	if(checkNumber(lpprice)) {
		bootbox.alert({title:"提示",message:"请输入开盘起价的为数字!"});
		return false;
	}
	}
	var openingAvgPrice = $("#openingAvgPrice").val().replace(/\s+/g,"");
	if(openingAvgPrice != null && openingAvgPrice != "") {
	if(checkNumber(openingAvgPrice)) {
		bootbox.alert({title:"提示",message:"请输入开盘均价的为数字!"});
		return false;
	}
	}
	var avgPrice = $("#avgPrice").val().replace(/\s+/g,"");
	if(avgPrice != null && avgPrice != "") {
	if(checkNumber(avgPrice)) {
		bootbox.alert({title:"提示",message:"请输入当前均价的为数字!"});
		return false;
	}
	}
	var level = $("#level").val();
	if(level == null || level == "0") {
		bootbox.alert({title:"提示",message:"请选择房源等级!"});
		return false;
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
//	var imgNameAll = $("#imgNameAll").val().replace(/\s+/g,"");
//	if(imgNameAll == null || imgNameAll == "") {
//		bootbox.alert({title:"提示",message:"请输入图片名称!"});
//		$("#imgNameAll").focus();
//		return false;
//	}
	$('.onsubing').css("display","block");//弹出提示框
};
	
function buildCountry(oval){
	$.ajax({ 
		url: basepath + "/cam/campus!getCountryInfo.action",
		dataType: "json",
		type: "POST",
		async : false,
		success: function(data){
			var cHtml = '<option value="">请选择</option>';
			$.each(data, function(i,n){
				if(n.id == oval) {
					cHtml += '<option value="'+n.id+'" selected="selected">'+n.cname+'</option>';
				} else {
					cHtml += '<option value="'+n.id+'">'+n.cname+'</option>';
				}
			});
			$("#country").html(cHtml);
	    }
	});
};

function buildPro(val){
	if(val != "") {
		$("#city").html('<option value="">请选择</option>');
		$("#sQy").html('<option value="">请选择</option>');
		$("#sSq").html('<option value="">请选择</option>');
		$.ajax({ 
			url: basepath + "/cam/campus!getPro.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"cid" : val},
			success: function(data){
				var pHtml = '<option value="">请选择</option>';
				$.each(data, function(i,n){
					if(n.id == $("#usPro").val()) {
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

function buildCity(val){
	if(val.value!=null&&val.value!=''){
		pid=val.value;
	}else{
		pid=val;
	}
		$("#sQy").html('<option value="">请选择</option>');
		$("#sSq").html('<option value="">请选择</option>');
		$.ajax({ 
			url: basepath + "/cam/campus!getCity.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"pid" : pid},
			success: function(data){
				var pHtml = '<option value="">请选择</option>';
				$.each(data, function(i,n){
						pHtml += '<option value="'+n.id+'">'+n.cityName+'</option>';
				});
				$("#city").html(pHtml);
		    }
		});
		if(val.value==null||val.value==''){
			$("#city option[value='"+$("#usCity").val()+"']").attr("selected", true);
	} 
};

function buildQy(val){
	if(val != "") {
		$("#sSq").html('<option value="">请选择</option>');
		$.ajax({ 
			url: basepath + "/cam/campus!getQy.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"cid" : val},
			success: function(data){
				var pHtml = '<option value="">请选择</option>';
				$.each(data, function(i,n){
					pHtml += '<option value="'+n.id+'">'+n.qyName+'</option>';
				});
				$("#sQy").html(pHtml);
		    }
		});
	} else {
		$("#sQy").html('<option value="">请选择</option>');
		$("#sSq").html('<option value="">请选择</option>');
	}
};

function buildSq(val){
	if(val != "") {
		$.ajax({ 
			url: basepath + "/cam/campus!getSq.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"stressId" : val},
			success: function(data){
				var pHtml = '<option value="">请选择</option>';
				$.each(data, function(i,n){
					pHtml += '<option value="'+n.id+'">'+n.sqName+'</option>';
				});
				$("#sSq").html(pHtml);
		    }
		});
	} else {
		$("#sSq").html('<option value="">请选择</option>');
	}
};


function cancel(){
	var from = $("input[name='from']").val();
	if(from=="apply"){	//从楼盘采集过来
		window.location.href = basepath + "/lp/lpxxCollect.action";
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
