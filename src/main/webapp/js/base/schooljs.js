//function setXandY(x,y,address,winClose){
//	$("#xxzbx").val(x);
//	$("#xxzby").val(y);
//	$("#address").val(address);
//	$("#windowClose").click();
//};

//jQuery(document).ready(function(){
//	$(document).on("click","#checkboxAll",function(){
//		$(":checkbox[name='id']").prop("checked", $(this).prop("checked"));
//	});
//});

$(document).ready(function(){
	buildCountry();
	buildSTy();
	
	$("#houseExclusiveImgType").change(function(){
		var houseExclusiveImgTypeid = $("#houseExclusiveImgType").val();
		if(houseExclusiveImgTypeid ==1)
		{
			$("#houseExclusiveImgType1").click();
		}
		else
		{
			$("#houseExclusiveImgType2").click();
		}
	});
	
	$("#houseExclusiveImgType1").click(function(){
		$("#houseExclusiveImgType").val(1);
	});
	
	$("#houseExclusiveImgType2").click(function(){
		$("#houseExclusiveImgType").val(2);
	});
});

function cance()
{
	window.location.href= basepath+"/base/school.action"; 
}
//单独添加类型
function addSchool()
{
	if(schoolCheck()&&validForm()&&numberCheck()){
		//禁用按钮
	//	$("#btnSaveWebImageofhouse").attr("disabled",true);
		//$('.onsubing').css("display","block");//弹出提示框
		$.ajax({
			url: basepath+"/base/school!addSchool.action",
			dataType: "json", 
			type: "POST",
			async : true,
			data : $("#formWebImageofhouse").serialize(),
			success: function(data){
				if(data>0)
				{
					bootbox.alert({title:"提示",message:"添加成功！"});
					$("#schoolid").val(data);
					$("#id").val(data);
				}else
				{
				//	$('.onsubing').css("display","none");//弹出提示框
					alert("添加失败！");
				//	$("#btnSaveWebImageofhouse").attr("disabled",false);
					return false;
				}
		    },error:function(xmlHttpRequest,textStatus,errorThrown){
				//$("#btnSaveWebImageofhouse").attr("disabled",false);
                bootbox.alert({title:"提示",message:"Sorry：保存出错，"+errorThrown+"！"});  
                return false;
            } 
		});
		return true;
	}else
	{
		return false;
	}
}


//单独添加类型
function updateSchool()
{
	if(schoolCheck()&&validForm()&&numberCheck()){
		//禁用按钮
	//	$("#btnSaveWebImageofhouse").attr("disabled",true);
		//$('.onsubing').css("display","block");//弹出提示框
		$.ajax({ 
			url: basepath+"/base/school!updateSchool.action",
			dataType: "json", 
			type: "POST",
			async : true,
			data : $("#formWebImageofhouse").serialize(),
			success: function(data){
				if(data>0)
				{
					bootbox.confirm({title:"确认",message:"修改成功！"});
				//	$("#btnSaveWebImageofhouse").attr("disabled",false);
				//	$("#bnCloseUpdateRecordDlg").trigger("click");
					//$("#lei-gai").modal("hide");
				}else
				{
				//	$('.onsubing').css("display","none");//弹出提示框
					bootbox.confirm({title:"确认",message:"修改失败"});
				//	$("#btnSaveWebImageofhouse").attr("disabled",false);
					return false;
				}
		    }
		});
		return true;
	}else
	{
		return false;
	}
}
function numberCheck()
{
		var teachernum = $("#teachernum").val().replace(/\s+/g,"");
		if(teachernum!=null && teachernum != "")
		{
			if(!/^-?([1-9][0-9]{0,10})$/.test(teachernum)) {
				alert("教师数量请输入小于11位的正整数");
				return false;
			}
		}
		var studentnum = $("#studentnum").val().replace(/\s+/g,"");
		if(studentnum!=null && studentnum != "")
		{
			if(!/^-?([1-9][0-9]{0,10})$/.test(studentnum)) {
				bootbox.alert({title:"提示",message:"学生数量请输入小于11位的正整数"});
				return false;
			}
		}
		var classnum = $("#classnum").val().replace(/\s+/g,"");
		if(classnum!=null && classnum != "")
		{
			if(!/^-?([1-9][0-9]{0,10})$/.test(classnum)) {
				bootbox.alert({title:"提示",message:"班级数量请输入小于11位的正整数"});
				return false;
			}
		}
		return true;
}
//楼盘保存校验
function schoolCheck(){
	///alert($("#xiayibu").attr("display")=="none");
	//$("#btnSaveWebImageofhouse").attr("disabled",true);
	var country = $("#country").val();
	if(country == null || country == "") {
		alert("请填写基础信息-楼盘所在国家!\n\n红色*内容为必填项，否则信息将无法进行保存.");
		$("tabFwv1");
		return false;
	}
	var pro = $("#pro").val();
	if(pro == null || pro == "") {
		alert("请填写基础信息-楼盘所在省份!\n\n红色*内容为必填项，否则信息将无法进行保存.");
		return false;
	}
	var city = $("#city").val();
	if(city == null || city == "") {
		alert("请填写基础信息-楼盘所在城市!\n\n红色*内容为必填项，否则信息将无法进行保存.");
		return false;
	}
	var sQy = $("#sQy").val();
	if(sQy == null || sQy == "") {
		alert("请填写基础信息-楼盘所在区域!\n\n红色*内容为必填项，否则信息将无法进行保存.");
		return false;
	}
	var sSq = $("#sSq").val();
	if(sSq == null || sSq == "") {
		alert("请填写基础信息-楼盘所在商圈!\n\n红色*内容为必填项，否则信息将无法进行保存.");
		return false;
	}
	var xxlx = $("#xxlx").val();
	if(xxlx == null || xxlx == "") {
		alert("请填写基础信息-学校类型!\n\n红色*内容为必填项，否则信息将无法进行保存.");
		return false;
	}
	var xxxz = $("#xxxz").val();
	if(xxxz == null || xxxz == "") {
		alert("请填写基础信息-学校性质!\n\n红色*内容为必填项，否则信息将无法进行保存.");
		return false;
	}
	
	var xxdj = $("#xxdj").val();
	if(xxdj == null || xxdj == "") {
		alert("请填写基础信息-学校等级!\n\n红色*内容为必填项，否则信息将无法进行保存.");
		return false;
	}
	
	var schoolName = $("#schoolName").val();
	if(schoolName == null || schoolName == "") {
		alert("请填写学校名称!\n\n红色*内容为必填项，否则信息将无法进行保存.");
		return false;
	}
	
//	var schoolName = $("#schoolName").val();
//	if(schoolName == null || schoolName == "") {
//		alert("请填写学校名称!\n\n红色*内容为必填项，否则信息将无法进行保存.");
//		return false;
//	}
	
	var address = $("#address").val().replace(/\s+/g,"");
	if(address == null || address == "") {
		alert("请填写基础信息-楼盘所在位置!\n\n红色*内容为必填项，否则信息将无法进行保存.");
		$("#loadXY").click();
		return false;
	}
	
	var xxzbx = $("#xxzbx").val();
	if(xxzbx == null || xxzbx == "") {
		alert("请填写基础信息-楼盘坐标!\n\n红色*内容为必填项，否则信息将无法进行保存.");
		$("#loadXY").click();
		return false;
	}
	var xxzby = $("#xxzby").val();
	if(xxzby == null || xxzby == "") {
		alert("请填写基础信息-楼盘坐标!\n\n红色*内容为必填项，否则信息将无法进行保存.");
		$("#loadXY").click();
		return false;
	}
//	$("#btnSaveWebImageofhouse").attr("disabled",false);
	return true;
};



function buildCountry(){
	$.ajax({ 
		url: basepath + "/cam/campus!getCountryInfo.action",
		dataType: "json", 
		type: "POST",
		async : false,
		success: function(data){
			var cHtml = '<option value="">请选择</option>';
			$.each(data, function(i,n){
				cHtml += '<option value="'+n.id+'">'+n.cname+'</option>';
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
					pHtml += '<option value="'+n.id+'">'+n.pname+'</option>';
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
					pHtml += '<option value="'+n.id+'">'+n.cityName+'</option>';
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

//建立类型展示条件
function buildSTy(){
	var url = basepath + "/base/school!findBySType.action";
		$.ajax({
			url: url,
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"name" : "学校类别"},
			success: function(data){
				var pHtml = '<option value="">请选择</option>';
				$.each(data, function(i,n){
					pHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
				});
				$("#xxlx").html(pHtml);
		    }
		});
		
		$.ajax({
			url:url ,
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"name" : "学校性质"},
			success: function(data){
				var pHtml = '<option value="">请选择</option>';
				$.each(data, function(i,n){
					pHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
				});
				$("#xxxz").html(pHtml);
		    }
		});
		
		
		$.ajax({
			url: url,
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"name" : "学校等级"},
			success: function(data){
				var pHtml = '<option value="">请选择</option>';
				$.each(data, function(i,n){
					pHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
				});
				$("#xxdj").html(pHtml);
		    }
		});
};