//城市ID暂时写死
$(document).ready(function() {
			buildCountry(false);
			buildPro(countryId,false);
			buildCity(provinceId,false);
			buildQy(cityId,false);
			buildSq(0,false);
			buildSTy(true);
				
			//全选或不选
			$('#table_ckall').change(function(){
				
				if($('#table_ckall').prop("checked")){
					//选中
					$('input[id*=ck_]').each(function(i){
						$(this).prop('checked',true);
					});
				}else{
					//未选中
					$('input[id*=ck_]').each(function(i){
						$(this).prop('checked',false);
					});
				};
			});
			
		//	
		//	//根据类型加载图片
		//	$('#houseExclusiveImgType').change(function(){
		//		//先隐藏已经显示的图片
		//		$("[id*='ulHouseExclusiveFiles']").each(function(){
		//			$(this).css("display","none");
		//		});
		//		
		//		$("#ulHouseExclusiveFiles"+$(this).val()).css("display","block");
		//	})
});
			
//子复选框的事件  
function setSelectAll(id){  
//    当没有选中某个子复选框时，SelectAll取消选中  
if (!$('#'+id).prop("checked") ){  
    $("#table_ckall").prop("checked",false);
}  
var chsub = $("input[type='checkbox'][name='subcheck']").length; //获取subcheck的个数  
var checkedsub = $("input[type='checkbox'][name='subcheck']:checked").length; //获取选中的subcheck的个数  
if (checkedsub == chsub) {  
    $("#table_ckall").prop("checked",true);  
    }  
}  
		

		
function queryData(){
	var couId = $("#country a.active").attr("data-id") == null ? 0 : $("#country a.active").attr("data-id");
    var proId = $("#pro a.active").attr("data-id") == null ? 0 : $("#pro a.active").attr("data-id");
    var cityId = $("#city a.active").attr("data-id") == null ? 0 : $("#city a.active").attr("data-id");
    var qyId = $("#sQy a.active").attr("data-id") == null ? 0 : $("#sQy a.active").attr("data-id");
    var sqId = $("#sSq a.active").attr("data-id") == null ? 0 : $("#sSq a.active").attr("data-id");
    var schoolType = $("#xxlx a.active").attr("data-id") == null ? 0 : $("#xxlx a.active").attr("data-id");
    var xuequName = $("#xuequName").val();
    var url = basepath+"/base/school!queryData.action";
    $("#macPageWidget").asynPage(url, "#tbodyData", buildDataHtml, true, true, {
        'condition.xhjLpschool.countryid': couId,
        'condition.xhjLpschool.provinceid': proId,
        'condition.xhjLpschool.CityID': cityId,
        'condition.xhjLpschool.QyID': qyId,
        'condition.xhjLpschool.sqid': sqId,
        'condition.xhjLpschool.schoolType': schoolType ,
        'condition.xuequName':xuequName
    });
};

function buildDataHtml(list) {
	$("#tbodyData").html("");
	if(list.length>0)
	{
		$.each(list, function(i,n){
				var sHtml = '<tr>';
				sHtml += '<td><input type="checkbox" name="subcheck" onclick="setSelectAll(this.id);"  class="cbr" id="ck_'+n.id+'" value="'+n.id+'" /></td>';
				sHtml += '<td width="60">';
				sHtml += '<a href="#">';
				sHtml += '<img src="../assets/images/hetong.jpg" width="50" height="50">';
				sHtml += '</a>';
				sHtml += '</td>';
				sHtml += '<td>';
				sHtml += '<a href="'+basepath+'/base/school!detail.action?id='+n.id+'" style="font-size:14px; padding-bottom:5px;">'+n.schoolName+'</a><br />';
				sHtml += '地址：'+n.address;
				sHtml += '</td>';
				sHtml += '<td>'+n.lpcount+'个小区</td>';
				sHtml += '<td>'+n.recruitStudentsInfo+'</td>';
				sHtml += '<td>';
				sHtml += '<a href="'+basepath+'/base/school!detail.action?id='+n.id+'&k=base&p=xq" class="pr10"><i class="fa-file-text"></i> 查看 <a>';
				sHtml += '<a href="'+basepath+'/base/school!updateDetail.action?schoolid='+n.id+'&k=base&p=xq" class="pr10"><i class="fa-pencil"></i> 修改 </a>';
				sHtml += '	<a class="pr10" onclick="delSchool($(\'#ck_'+n.id+'\'))"><i class="fa-trash-o"></i> 删除 </button>';
				sHtml += '</td>';
				sHtml += '</tr>';
				$("#tbodyData").append(sHtml);
		});
	}
};
					
//国家
function buildCountry(flag){
	$.ajax({ 
		url: basepath+"/cam/campus!getCountryInfo.action",
		dataType: "json", 
		type: "POST",
		async : false,
		success: function(data){
			var cHtml = '<span>国家：</span><a href="javascript:buildPro(0,true)" class="mr10 active" data-id="0">不限</a>';
			$.each(data, function(i,n){
				if(i % 8 == 0 && i > 0) {
					cHtml += "<br>";
				}
				cHtml += '<a href="javascript:buildPro(\''+n.id+'\',true)" class="mr10" data-id="'+n.id+'">'+n.cname+'</a>';
			});
			$("#country").html(cHtml);
	    },error : function(XMLHttpRequest, textStatus, errorThrown) {
	    	bootbox.alert({title:"提示",message:"查询出错：" + errorThrown});
		}
	});
	if(flag){
		queryData();
	}
};

function buildPro(val,flag){
	$("#country a").removeClass("active");
	$("#country a[data-id='"+val+"']").addClass("active");
//	$("#city").html("");
//	$("#sQy").html("");
//	$("#sSq").html("");
	buildCity(0,false);
	buildQy(0,false);
	buildSq(0,false);
	$.ajax({
		url: basepath+"/cam/campus!getPro.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"cid" : val},
		success: function(data){
			var pHtml = '<span>省份/州：</span><a href="javascript:buildCity(0,true)" class="mr10 active" data-id="0">不限</a>';
			$.each(data, function(i,n){
				if(i % 8 == 0 && i > 0) {
					pHtml += "<br>";
				}
				pHtml += '<a href="javascript:buildCity(\''+n.id+'\',true)" class="mr10" data-id="'+n.id+'">'+n.pname+'</a>';
			});
			$("#pro").html(pHtml);
	    }
	});
	if(flag){
		queryData();
	}
};

function buildCity(val,flag){
	$("#pro a").removeClass("active");
	$("#pro a[data-id='"+val+"']").addClass("active");
//	$("#sQy").html("");
//	$("#sSq").html("");
	buildQy(0,false);
	buildSq(0,false);
	$.ajax({ 
		url: basepath+"/cam/campus!getCity.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"pid" : val},
		success: function(data){
			var cHtml = '<span>城市：</span><a href="javascript:buildQy(0,true)" class="mr10 active" data-id="0">不限</a>';
			$.each(data, function(i,n){
				if(i % 8 == 0 && i > 0) {
					cHtml += "<br>";
				}
				cHtml += '<a href="javascript:buildQy(\''+n.id+'\',true)" class="mr10" data-id="'+n.id+'">'+n.cityName+'</a>';
			});
			$("#city").html(cHtml);
	    }
	});
	if(flag){
		queryData();
	}
};

function buildQy(val,flag){
	$("#city a").removeClass("active");
	$("#city a[data-id='"+val+"']").addClass("active");
//	$("#sSq").html("");
	buildSq(0,false);
	$.ajax({ 
		url: basepath+"/cam/campus!getQy.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"cid" : val},
		success: function(data){
			var cHtml = '<span>区域：</span><a href="javascript:buildSq(0,true)" class="mr10 active" data-id="0">不限</a>';
			$.each(data, function(i,n){
				cHtml += '<a href="javascript:buildSq(\''+n.id+'\',true)" class="mr10" data-id="'+n.id+'">'+n.qyName+'</a>';
			});
			$("#sQy").html(cHtml);
	    }
	});
	if(flag){
		queryData();
	}
};

function buildSq(val,flag){
	$("#sQy a").removeClass("active");
	$("#sQy a[data-id='"+val+"']").addClass("active");
	$.ajax({ 
		url: basepath+"/cam/campus!getSq.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"stressId" : val},
		success: function(data){
			var cHtml = '<span>商圈：</span><a href="javascript:queryData()" class="mr10 active" data-id="0">不限</a>';
			$.each(data, function(i,n){
				if(i ==9) {
					cHtml += "<br><a style='margin-left:30px'>";
					}
					if((i-9) % 10 == 0 && i > 10) {
						cHtml += "<br><a style='margin-left:30px'>";
					}
				cHtml += '<a href="javascript:queryData()" class="mr10" data-id="'+n.id+'">'+n.sqName+'</a>';
			});
			$("#sSq").html(cHtml);
			$("#sSq a").click(function(){
				$("#sSq a").removeClass("active");
				$(this).addClass("active");
			});
	    }
	});
	if(flag){
		queryData();
	}
};
//建立类型展示条件
function buildSTy(flag){
// 		$("#sSq a").removeClass("active");
// 		$("#sSq a[data-id='"+val+"']").addClass("active");
	$.ajax({ 
		url: basepath+"/base/school!findBySType.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"name" : "学校类别"},
		success: function(data){
			var cHtml = '<span>类型：</span><a href="javascript:queryData()" class="mr10 active" data-id="0">不限</a>';
			$.each(data, function(i,n){
				if(i % 9 == 0 && i > 0) {
					cHtml += "<br>";
				}
				cHtml += '<a href="javascript:queryData()" class="mr10" data-id="'+n[0]+'">'+n[1]+'</a>';
			});
			$("#xxlx").html(cHtml);
			$("#xxlx a").click(function(){
				$("#xxlx a").removeClass("active");
				$(this).addClass("active");
			});
	    }
	});
	if(flag){
		queryData();
	}
};
//单独添加类型
function addType()
{
	var rows = $("#addButton div");
	var typeNames = "";
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		var name = $(row).find("input[name='typeName']").val().replace(/\s+/g,"");
		if(name != null && name != "") {
			typeNames += "," + name;
		}
	}
	if(typeNames.length > 0) {
		typeNames = typeNames.substring(1);
	}
	$.ajax({ 
		url : basepath+"/base/school!addType.action", 
		dataType : "json", 
		type : "POST",
		data : {"typeNames": typeNames},
		success : function(result){
			if(result>0)
			{
				//bootbox.alert({title:"提示",message:"操作成功!"});
				bootbox.alert({title:"提示",message:"操作成功!"});
				$("#lei-zeng").modal("hide");
				buildSTy(false);
			}else
			{
				bootbox.alert({title:"提示",message:"操作失败!"});
			}
    	}
	});
	queryData();
}
//删除单S
function delSchool(value)
{
	if(confirm("是否确认删除？"))
	{
		//获取当前列ID
		var id = value.val();
			$.ajax({
				url : basepath+"/base/school!delSchool.action", 
				dataType : "json", 
				type : "POST",
				data : {"id" : id},
				success : function(result){
					if(result>0)
					{
						bootbox.alert({title:"提示",message:"删除成功!"});
						queryData();
					}else
					{
						bootbox.alert({title:"提示",message:"删除失败!"});
					}
		    	}
			});	
	}
}


//删除AllSS
function deleteAllSchool(value)
{
	if(confirm("是否确认批量删除？"))
	{
		//所有选中的行
		var ids="";
		$('input[id*=ck_]').each(function(i){
			if($(this).prop('checked')){
				ids+=","+$(this).val();
			}
		});
		
		if(ids==""){
			bootbox.alert({title:"提示",message:"请选择要操作的记录"});
			return false;
		}
		//var jsonData="{\"ids\":\""+ids.substring(1)+"\"}";
		
		//alert(ids.substring(1));
		//获取当前列ID
		$.ajax({
			url : basepath+"/base/school!deleteAllSchool.action", 
			dataType : "json", 
			type : "POST",
			data : {"ids" : ids.substring(1)},
			success : function(result){
				if(result>0)
				{
					bootbox.alert({title:"提示",message:"删除成功!"});
					queryData();
				}else
				{
					bootbox.alert({title:"提示",message:"删除失败!"});
				}
			}
		});
	}
}


function delInput(obj,val)
{
// 		var sid = $(obj).parent().find("input[name='typeName']").val();
//	if(sid == "add") {
		$(obj).parent().remove();
		var str = $("#hidderDelete").val();
		str+=","+val;
		$("#hidderDelete").val(str);
	//}
}
function addInput()
{
	var aHtml = '<div class="input-group input-group-minimal" >';
	aHtml+='<input type="text" class="form-control" name="typeName"/>';
	aHtml+='<a href="#" class="input-group-addon" onclick="delInput(this)"><i class="fa-trash-o" ></i></a>';
	aHtml+='</div>';
	$("#addButton").append(aHtml);
}

// 	编辑框
function editType()
{
	$("#hidderDelete").val("");
	$.ajax({ 
		url: basepath+"/base/school!findBySType.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"name" : "学校类别"},
		success: function(data){
			var tHtml="";
			$.each(data, function(i,n){
					tHtml += '<div class="form-group" id="editDel">';
					tHtml += '<div class="input-group input-group-minimal">';
					tHtml += '<input type="hidden" class="form-control" name="condition.names['+i+'].id" id="edit'+n[0]+'" value="'+n[0]+'">';
					tHtml += '<input type="text" class="form-control" name="condition.names['+i+'].name" id="'+n[0]+'" value="'+n[1]+'">';
					if(n[1]==768 || n[1] == 769 || n[1] == 777 || n[1] == 776 || n[1] == "小学" || n[1] == "幼儿园" || n[1] == "高中" || n[1] == "初中" )
					{
						tHtml += 	'<a href="#" class="input-group-addon"  title="点击删除"  onclick="javascript:alert(\'此类型不可删除,仅可编辑\')">';
						tHtml += 		'<i class="fa-trash-o" style="disable:disable"></i>';
						tHtml += 	'</a>';
					}else
					{
						tHtml += 	'<a href="#" class="input-group-addon" title="点击删除" onclick="delInput(this,'+n[0]+')">';
						tHtml += 		'<i class="fa-trash-o"></i>';
						tHtml += 	'</a>';
					}
					tHtml += '</div>';
					tHtml += '</div>';
			});
			$("#editType").html(tHtml);
	    }
	});
}

function saveType()
{
	var delParams = $("#hidderDelete").val();
	$.ajax({ 
		url: basepath+"/base/school!updateType.action?ids="+delParams,
		dataType: "json", 
		type: "POST",
		async : false,
		data : $("#form").serialize(),
		success: function(data){
			if(data>0)
			{
				alert("修改成功!");
				$("#lei-gai").modal("hide");
				$("#hidderDelete").val("");
			}else
			{
				alert("修改失败!");
				$("#hidderDelete").val("");
			}
	    }
	});
}