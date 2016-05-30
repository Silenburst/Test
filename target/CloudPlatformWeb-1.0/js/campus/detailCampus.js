$(document).ready(function(){
	//内部设施
	geSyscsRadioDisabled(445, "supporting", "checkbox", "lpxx.propertySupporting","");
	
});

function setValue(val,div){
	if(val==null||val==''||val=='null'||val==undefined){
		val=0;
	}
		if(div=='quxiancj'){
			$("#"+div).load(basepath+"/cam/campus!lpcjquxian.action?lpid="+$("#tuplpid").val()+"&shi="+val);
		}else if(div=='quxiancjcz'){
			$("#"+div).load(basepath+"/cam/campus!lpczcjquxian.action?lpid="+$("#tuplpid").val()+"&shi="+val);
		}else if(div=='quxianld'){
			$("#"+div).load(basepath+"/cam/campus!fangwquxian.action?zt="+val+"&lpid="+$("#tuplpid").val());
		}
	
	
	
}

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
