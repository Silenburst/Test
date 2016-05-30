$(document).ready(function()
{
	var coun = $("#usCountry").val();
	buildCountry(coun);
	
	if(coun != null) 
	{
		buildPro(coun);
		buildCity($("#usPro").val());
		//buildQy($("#usCity").val());
		//buildSq($("#usQyId").val());
	}
	
	//标签
	geSyscsRadio(441, "lptag", "checkbox", "lpxx.lpTag","");
	//内部设施
	geSyscsRadio(445, "supporting", "checkbox", "lpxx.propertySupporting","");
	
	//楼盘信息保存
	$('#lpxxForm').submit(function() 
	{
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
				if(result.data == "success") 
				{
					updateId(result.id);
					
					//在异步提交成功后要做的操作
					bootbox.alert({title:"提示",message:"保存成功!"});
					$("#tabWy").attr("href","#tab2").attr("data-toggle","tab");
					$("#tabTk").attr("href","#tab3").attr("data-toggle","tab");
					$("#tabDz").attr("href","#tab4").attr("data-toggle","tab");
					$("#tabSs").attr("href","#tab5").attr("data-toggle","tab");
					$("#lpxxid").val(result.id);
					$("#wuyelpid").val(result.id);	//物业
					$("#tuplpid").val(result.id);	//图片
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
	$('#lpimageForm').submit(function() 
	{
		var jsonData=$('#lpimageForm').serialize();
		jQuery.ajax({
			url: basepath + "/cam/campus!saveLptp.action",
			dataType: "json",
			data: jsonData, 
			type: "POST",
			async :false,
			beforeSend: function(){
				//在异步提交前要做的操作
				//return imgCheck();
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
	queryData();
	//加载维护居住成本
	queryData1();
});


//楼盘保存校验
function lpxxCheck(){
	var country = $("#country").val();
	if(country == null || country == "") {
		bootbox.alert({title:"提示",message:"请选择楼盘所在国家!"});
		return false;
	}
	var pro = $("#pro").val();
	if(pro == null || pro == "") {
		bootbox.alert({title:"提示",message:"请选择楼盘所在省份!"});
		return false;
	}
	var city = $("#city").val();
	if(city == null || city == "") {
		bootbox.alert({title:"提示",message:"请选择楼盘所在城市!"});
		return false;
	}
	var sQy = $("#sQy").val();
	if(sQy == null || sQy == "") {
		bootbox.alert({title:"提示",message:"请选择楼盘所在区域!"});
		return false;
	}
	var sSq = $("#sSq").val();
	if(sSq == null || sSq == "") {
		bootbox.alert({title:"提示",message:"请选择楼盘所在商圈!"});
		return false;
	}
	var yongtu = $("#yongtu").val();
	if(yongtu == null || yongtu == "" || yongtu < 1) {
		bootbox.alert({title:"提示",message:"请选择楼盘用途!"});
		return false;
	}
	var lpName = $("#lpName").val();
	if(lpName == null || lpName == "") 
	{
		lpName=lpName.replace(/\s+/g,"");
		bootbox.alert({title:"提示",message:"请输入楼盘名称!"});
		return false;
	}
	var l_bieMing = $("#bieMing").val();
	if(l_bieMing == null || l_bieMing == "") 
	{
		l_bieMing=l_bieMing.replace(/\s+/g,"");
		bootbox.alert({title:"提示",message:"请输入楼盘别名!"});
		return false;
	}
	var lpaddress = $("#address").val().replace(/\s+/g,"");
	if(lpaddress == null || lpaddress == "") {
		bootbox.alert({title:"提示",message:"请输入楼盘地址!"});
		return false;
	}
	/**
	var lpxxx = $("#xxzbx").val();
	if(lpxxx == null || lpxxx == "") {
		bootbox.alert({title:"提示",message:"请选择楼盘所在位置!"});
		$("#loadXY").click();
		return false;
	}
	var propertyAddress = $("#propertyAddress").val().replace(/\s+/g,"");
	if(propertyAddress == null || propertyAddress == "") {
		bootbox.alert({title:"提示",message:"请输入楼盘产权地址!"});
		return false;
	}
	**/
	$('.onsubing').css("display","block");//弹出提示框
};

//物业保存校验
function wuyeCheck()
{
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
	var imgNameAll = $("#imgNameAll").val().replace(/\s+/g,"");
	if(imgNameAll == null || imgNameAll == "") {
		bootbox.alert({title:"提示",message:"请输入图片名称!"});
		$("#imgNameAll").focus();
		return false;
	}
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
	if(val != "") {
		$("#sQy").html('<option value="">请选择</option>');
		$("#sSq").html('<option value="">请选择</option>');
		$.ajax({ 
			url: basepath + "/cam/campus!getCity.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"pid" : val},
			success: function(data){
				var pHtml = '<option value="">请选择</option>';
				$.each(data, function(i,n){
					if(n.id == $("#usCity").val()) {
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
				$.each(data, function(i,n)
				{
					if(n.id == $("#usQyId").val())
						pHtml += '<option value="'+n.id+'" selected="selected">'+n.qyName+'</option>';
					else
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
				$.each(data, function(i,n)
				{
					if(n.id == $("#usSqId").val())
						pHtml += '<option value="'+n.id+'" selected="selected">'+n.sqName+'</option>';
					else
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

function queryData(){
var lpid = $("#lpxxid").val();
var url = basepath+"/add/maintenanceAction!findByPageInFo.action";
$("#macPageWidget").asynPage(url, "#tbodyData", buildDataHtml, true, true, {
	'enetiy.lpid': lpid,
 });
};
function buildDataHtml(list) {
	$("#tbodyData").html("");
    $.each(list, function (i, info) {
        var tr = [
            '<tr>',
            '<td class="text-center">', '<input type="checkbox" class="cbr" ame="id"/>', '</td>',
            '<td class="text-center">', info[2]=="null" ||info[2]=="" || info[2]==null?"":info[2], '</td>',
            '<td class="text-center">', info[3]=="null" ||info[3]=="" || info[3]==null?"":info[3], '</td>',
            '<td class="text-center">', info[4]=="null" ||info[4]=="" || info[4]==null?"":info[4], '</td>',
            '<td class="text-center">', info[5]=="null" ||info[5]=="" || info[5]==null?"":info[5], '</td>',
            '<td class="text-center">', info[6]=="null" ||info[6]=="" || info[6]==null?"":info[6], '</td>',
            '</tr>'].join('');
        $("#tbodyData").append(tr);
    });
	
};

var fian=false;
function update(){
var companyName = $("#enterprise").val();
alert(companyName);
	$.ajax({
		url: basepath+"/add/maintenanceAction!update.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"companyName":companyName},
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
function addData(){
var lpid = $("#lpxxid").val();
var cityID = $("#city").val();
var companyName = $("#enterprise").val();
var iphone = $("#phone").val();
var dizhi = $("#dizhi").val();
var remark = $("#remark").val();
if(fian){
$.ajax({
		url: basepath+"/add/maintenanceAction!addData.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"lpid":lpid,"mtype":cityID,"companyName":companyName,"tel":iphone,"address":dizhi,"remark":remark},
		success: function(data){
			if(data!=null){
				alert('添加成功!');
				jQuery('#weihudanwei').modal('hide');
				window.location.reload();
			} else {
				alert('添加失败!');
			}
		}
	});
	} 
}
function buttong(){
	$("#city").val('');
	$("#enterprise").val('');
	$("#phone").val('');
	$("#dizhi").val('');
	$("#remark").val('');
}


function queryData1(){
var lpid = $("#lpxxid").val();
var url1 = basepath+"/add/housingCostAction!pageinfo.action";
	$("#macPageWidget").asynPage(url1, "#tbodyData1", buildDataHtml1, true, true, {
		'enetiy.lpid': lpid,
	});
};
	function buildDataHtml1(list) {
		$("#tbodyData1").html("");
	    $.each(list, function (i, info) {
	        var tr = [
	            '<tr>',
	            '<td class="text-center">', '<input type="checkbox" class="cbr" ame="id"/>', '</td>',
	            '<td class="text-center">', info[2]=="null" ||info[2]=="" || info[2]==null?"":info[2], '</td>',
	            '<td class="text-center">', info[3]=="null" ||info[3]=="" || info[3]==null?"":info[3], '</td>',
	            '<td class="text-center">', info[4]=="null" ||info[4]=="" || info[4]==null?"":info[4], '</td>',
	            '<td class="text-center">', info[5]=="null" ||info[5]=="" || info[5]==null?"":info[5], '</td>',
	            '<td class="text-center">', info[6]=="null" ||info[6]=="" || info[6]==null?"":info[6], '</td>',
	            '</tr>'].join('');
	        $("#tbodyData1").append(tr);
	    });
		
	};
	
	
function addData1(){
var lpid = $("#lpxxid").val();
var cityid = $("#cityid").val();
var billing = $("#billing").val();
var univalence = $("#univalence").val();
var charge = $("#charge").val();
var remarks = $("#remarks").val();
alert(lpid);
alert(cityid);
alert(billing);
alert(univalence);
alert(charge);
alert(remarks);
$.ajax({
		url: basepath+"/add/housingCostAction!addDwell.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data :{"lpid":lpid,"ctype":cityid,"payingWay":billing,"price":univalence,"unit":charge,"remark":remarks},
		success: function(data){
		var cHtml = '';
		if(data!=null){
			alert('添加成功!');
			jQuery('#juzhuchengben').modal('hide');
			window.location.reload();
		} else {
			alert('添加失败!');
		}
			$("#country").append(cHtml);
		}
	});
} 
function uopdayt(){
$("#cityid").val('');
$("#billing").val('');
$("#univalence").val('');
$("#charge").val('');
$("#remarks").val('');
}