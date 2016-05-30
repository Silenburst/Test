var ids = [];
var zuoyous = [];
var total = 0;
//根据下标删除
Array.prototype.baoremove = function(dx) 
{ 
    if(isNaN(dx)||dx>this.length){return false;} 
    this.splice(dx,1); 
} 



Array.prototype.indexOf = function(val) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] == val) return i;
    }
    return -1;
};
Array.prototype.remove = function(val) {
    var index = this.indexOf(val);
    if (index > -1) {
        this.splice(index, 1);
    }
};

function showDlgFp(id,fenpainame)
{
	zuoyous = [];
	zuoyous.push(id);
	$("#lpNamefp").text(fenpainame);
	$("#fhidsfp").val(JSON.stringify(zuoyous));
	
//	$("#dianzufp").parent().find("div a span").eq(0).html("");
//	$("#dianzufp").parent().find("div a span").eq(0).html("请选择店组");
	$("#jinjirenfp").parent().find("div a span").eq(0).html("");
	$("#jinjirenfp").parent().find("div a span").eq(0).html("请选择经纪人");
	
	//queryBM("fp");
	$("#Fenpaifp").click();
}

function showDlgBatch(){
	setNull();
	//queryLpName();
	//queryBM(2);
	$("#PiliangP").click();
};

function setNull()
{
	$("#batchForm")[0].reset();
//	$("#lpid").parent().find("div a span").eq(0).html("");
//	$("#lpid").parent().find("div a span").eq(0).html("请选择楼盘");
//	$("#lpid").append("<option value='0'>请选择楼盘</option>");
	$("#dongid").val(0);
	$("#danyuanid").val(0);
//	$("#dianzu2").parent().find("div a span").eq(0).html("");
//	$("#dianzu2").parent().find("div a span").eq(0).html("请选择店组");
	$("#jinjiren2").parent().find("div a span").eq(0).html("");
	$("#jinjiren2").parent().find("div a span").eq(0).html("请选择经纪人");
	$("#tbodyid1").html("");
	$("#tbodyid2").html("");
	$("#total").text(0);
	$("#total2").text(0);
}
//单左右
function setClass(val,id,value,number)
{
	$(val).css('background-color',"red");
	$(val).parent().parent().remove();  
	var pHtml = '';
	pHtml += '<tr >';
	if(number == 1)
	{
		pHtml += '<td><a href="#" style="background:rgb(221, 236, 228)" onclick="setClass(this,'+id+','+value+',2)" ><input type="hidden" value="'+id+'" id="'+id+'">'+value+'</a></td>';
		pHtml += '</tr>';
		$("#tbodyid2").append(pHtml);
		zuoyous.push(id);
	}
	else
	{
		pHtml += '<td><a href="#" style="background:rgb(221, 236, 228)" onclick="setClass(this,'+id+','+value+',1)" ><input type="hidden" value="'+id+'" id="'+id+'">'+value+'</a></td>';
		pHtml += '</tr>';
		$("#tbodyid1").append(pHtml);
		zuoyous.remove(id);
	}
	$("#total2").text(zuoyous.length);
}

//$("#add").click(function(){
//    var cp = $("table tr:not(:contains('作者'))").clone(true);
//    $("table tbody").append(cp);
//});

//全左右
function setClassAll(number)
{
	//单选中
	//$("input[name='rd']:checked").val();
	if(number == 1)
	{
//		querySource();
//		var pHtml = $("#tbodyid1 tr").clone(true);
//		if(null == pHtml)
//		{
//			alert("数据为空，请重新选择.");
//		}
//		$("#tbodyid2").html(pHtml);
////		 var cp = $("table tr:not(:contains('作者'))").clone(true);
////	    $("#tbodyid2").append(cp);
		$("#tbodyid1").html("");
		querySource("tbodyid2",2);
	}else
	{
//		var pHtml = $("#tbodyid2 tr").clone(true);
//		if(null == pHtml)
//		{
//			alert("数据为空，请重新选择.");
//		}
//		$("#tbodyid1").html(pHtml);
		$("#tbodyid2").html("");
		querySource("tbodyid1",1);
	}
}



function queryLpName()
{
    var url = basepath+"/personInfo!queryLpName.action";
	$.ajax({
		url:url,
		data:{},
		dataType:"json",
		type:"post",
		async:false,
		success:function(result)
		{
			var pHtml = '<option value="0">请选择楼盘</option>';
			$.each(result, function(i,n){
				pHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
			});
			$("#lpid").html(pHtml);
		}
		
	});
}



function queryBM(number)
{
    var url = basepath+"/personInfo!queryBM.action";
	$.ajax({
		url:url,
		data:{},
		dataType:"json",
		type:"post",
		async:true,
		success:function(result)
		{
			var pHtml = '<option value="0">请选择接收店组</option>';
			$.each(result, function(i,n){
				pHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
			});
			$("#dianzu"+number).html(pHtml);
		}
		
	});
}

function changeDisplay(number)
{
	var jinjiren2 =  $("#jinjiren"+number).val();
	if(jinjiren2 == null || jinjiren2 =="0" || jinjiren2 == 0)
	{
		$("#tixing"+number).css("display","block");
	}else
	{
		$("#tixing"+number).css("display","none");

	}
}
function queryBMJL(dzid,number)
{
	var jinjiren2 =  $("#jinjiren"+number).val();
	if(jinjiren2 == null || jinjiren2 =="0" || jinjiren2 == 0)
	{
		$("#tixing"+number).css("display","block");
	}else
	{
		$("#tixing"+number).css("display","none");

	}
	$("#total"+number).val(zuoyous.length);
    var url = basepath+"/personInfo!queryBMJL.action";
	$.ajax({
		url:url,
		data:{"dzid":dzid},
		dataType:"json",
		type:"post",
		async:false,
		success:function(result)
		{
			var pHtml = '<option value="0">请选择接收经纪人</option>';
			$.each(result, function(i,n){
				pHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
			});
			$("#jinjiren"+number).html(pHtml);
		}
		
	});
}

//fenpaisss
function insertBatchFenpai(formName,number)
{
	var dianzu2 =  $("#dianzu"+number).val();
	if(dianzu2 == null || dianzu2 =="0" || dianzu2 == 0)
	{
		alert("请选择想要分派的店组.");
		return false;
	}
	var jinjiren2 =  $("#jinjiren"+number).val();
	if(jinjiren2 == null || jinjiren2 =="0" || jinjiren2 == 0)
	{
		$("#tixing"+number).css("display","block");
	}
	
//	var params = $("#ids").val();
	$("#fhids"+number).val(JSON.stringify(zuoyous));
	 var url = basepath+"/personInfo!insertBatchFenpai.action";
		$.ajax({
			url:url,
			data:$("#"+formName).serialize(),
			dataType:"json",
			type:"post",
			async:false,
			success:function(result)
			{
				if(result == "1")
				{
					alert("分派成功.")
					$("#close"+number).click();
				}else
				{
					alert("分派失败.")
				}
			}
		});
};


function queryDong(id)
{
    var url = basepath+"/personInfo!queryDong.action";
	$.ajax({
		url:url,
		type:"post",
		dataType:"json",
		data:{"id":id},
		async:false,
		success:function(result)
		{
			var pHtml = '<option value="0">请选择</option>';
			$.each(result, function(i,n){
				pHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
			});
			$("#dongid").html(pHtml);
		}
		
	});
}




function queryDanyuan(id)
{
    var url = basepath+"/personInfo!queryDanyuan.action";
	$.ajax({
		url:url,
		type:"post",
		dataType:"json",
		data:{"id":id},
		async:false,
		success:function(result)
		{
			var pHtml = '<option value="0">请选择</option>';
			$.each(result, function(i,n){
				pHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
			});
			$("#danyuanid").html(pHtml);
		}
		
	});
}



