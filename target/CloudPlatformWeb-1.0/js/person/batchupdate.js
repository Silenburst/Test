var zuoyous = [];
//$(function(){
////	queryLpName();
//})
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

function querySource(sourceNumber,targetNumber)
{
	$("#table1").html("");
	var lpid = $("#lpid").val();
	var dongid = $("#dongid").val();
	var danyuanid = $("#danyuanid").val();
	if(lpid == null || lpid =="0" || lpid == 0)
	{
		alert("请选择楼盘.");
		return false;
	}
	if(dongid == null || dongid =="0" || dongid == 0)
	{
		alert("请选择栋座.");
		return false;
	}
	if(danyuanid == null || danyuanid =="0" || danyuanid == 0)
	{
		alert("请选择单元.");
		return false;
	}
	
	var huxingid = $("#huxingid").val();
	if(huxingid == null || huxingid =="0" || huxingid == 0)
	{
		alert("请选择户型.");
		return false;
	}

	var url = basepath+"/personInfo!querySource.action";
	$.ajax({
		url:url,
		data:{"condition.lpxx.id":lpid,"condition.dong.id":dongid,"condition.danyuan.id":danyuanid,"condition.fanghao.fangHao":huxingid},
		dataType:"json",
		type:"post",
		async:false,
		success:function(result)
		{
			if(null!=result && result.getGridModel.length >0)
			{
				zuoyous =[];
				var pHtml = '';
				var j = 0;
				if(sourceNumber != 0)
				{
					$("#total").text(result.getGridModel.length);
				}
				$("#table"+targetNumber).html("");
				$.each(result.getGridModel, function(i,n){
					pHtml += '<tr id="c'+i+'" >';
					if(sourceNumber == 0)
					{
						zuoyous.push(n[0]);
						pHtml += '<td style="background:rgb(221, 236, 228)">'+  $('#dongid  option:selected').text()+'&nbsp;&nbsp;'+$('#danyuanid  option:selected').text()+'&nbsp;&nbsp;'+$('#huxingid  option:selected').text()+'&nbsp;&nbsp;'+n[2]+'</td>';
						pHtml += '<td><a href="#"  onclick="setClass(this,'+n[0]+',\''+n[2]+'\','+sourceNumber+','+targetNumber+')"  ><input type="hidden" value="'+n[0]+'" id="'+n[0]+'"><i class="fa-trash-o"></i> 删除</a></td>';
					}else
					{
						zuoyous=[];
						pHtml += '<tr id="c'+i+'" >';
						pHtml += '<td><a href="#" style="background:rgb(221, 236, 228)" onclick="setClass(this,'+n[0]+',\''+n[2]+'\','+sourceNumber+','+targetNumber+')" ><input type="hidden" value="'+n[0]+'" id="'+n[0]+'">'+n[2]+'</a></td>';
					}
					pHtml += '</tr>';
				});
				$("#total1").text(zuoyous.length);
				$("#fhids").val(JSON.stringify(zuoyous));
				$("#table"+sourceNumber).html(pHtml);
			}
			else
			{
				$("#table"+sourceNumber).html("无数据，请重新选择！");
			}
		}
	});
}

//单左右
function setClass(val,id,value,sourceNumber,targetNumber)
{
	$(val).css('background-color',"red");
	$(val).parent().parent().remove();  
	var pHtml = '';
	pHtml += '<tr >';
	if(targetNumber == 0)
	{
		pHtml += '<td style="background:rgb(221, 236, 228)">'+  $('#dongid  option:selected').text()+'&nbsp;&nbsp;'+$('#danyuanid  option:selected').text()+'&nbsp;&nbsp;'+$('#huxingid  option:selected').text()+'&nbsp;&nbsp;'+value+'</td>';
		pHtml += '<td><a href="#"  onclick="setClass(this,'+id+',\''+value+'\','+targetNumber+','+sourceNumber+')" ><input type="hidden" value="'+id+'" id="'+id+'"><i class="fa-trash-o"></i> 删除</a></td>';
		pHtml += '</tr>';
		$("#table"+targetNumber).append(pHtml);
		zuoyous.push(id);
	}
	else
	{
		pHtml += '<td><a href="#" style="background:rgb(221, 236, 228)" onclick="setClass(this,'+id+',\''+value+'\','+targetNumber+','+sourceNumber+')" ><input type="hidden" value="'+id+'" id="'+id+'">'+value+'</a></td>';
		pHtml += '</tr>';
		$("#table"+targetNumber).append(pHtml);
		zuoyous.remove(id);
	}
	$("#fhids").val(JSON.stringify(zuoyous));
	$("#total1").text(zuoyous.length);
}

//$("#add").click(function(){
//    var cp = $("table tr:not(:contains('作者'))").clone(true);
//    $("table tbody").append(cp);
//});

//全左右
function setClassAll(sourceNumber,targetNumber)
{
	$("#table"+targetNumber).html("");
	querySource(sourceNumber,targetNumber);
}



function queryLpName()
{
    var url = basepath+"/personInfo!queryLpName.action";
	$.ajax({
		url:url,
		dataType:"json",
		type:"post",
		async:false,
		success:function(result)
		{
			var pHtml = '<option value="0">请输入搜索楼盘</option>';
			$.each(result, function(i,n){
				pHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
			});
			$("#lpid").html(pHtml);
		}
		
	});
}

//$("#tixing").css("display","none");


function batchUP()
{
	var lpid = $("#lpid").val();
	var dongid = $("#dongid").val();
	var danyuanid = $("#danyuanid").val();
	if(lpid == null || lpid =="0" || lpid == 0)
	{
		alert("请选择楼盘.");
		return false;
	}
	if(dongid == null || dongid =="0" || dongid == 0)
	{
		alert("请选择栋座.");
		return false;
	}
	if(danyuanid == null || danyuanid =="0" || danyuanid == 0)
	{
		alert("请选择单元.");
		return false;
	}
	
	var huxingid = $("#huxingid").val();
	if(huxingid == null || huxingid =="0" || huxingid == 0)
	{
		alert("请选择户型.");
		return false;
	}
	var ceng =  $("#ceng").val();
	if(ceng == null || ceng =="0" || ceng == 0)
	{
		alert("请选择户型.");
		return false;
	}
	var jsons= {"zuoyous":JSON.stringify(zuoyous),"ceng":ceng,"lpid":lpid,"buildingId":dongid,"dyId":danyuanid,"fangHao":huxingid};
	var fhs = JSON.stringify(jsons);
	window.location.href= basepath+"/personInfo!queryFanghao.action?fhs="+fhs;
}

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
			var pHtml = '<option value="0">请选择栋座</option>';
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
			var pHtml = '<option value="0">请选择单元</option>';
			$.each(result, function(i,n){
				pHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
			});
			$("#danyuanid").html(pHtml);
		}
		
	});
}

function queryHuxing()
{
//	$("#table1").html("");
//	var lpid = $("#lpid").val();
//	var dongid = $("#dongid").val();
//	var danyuanid = $("#danyuanid").val();
//	if(lpid == null || lpid =="0" || lpid == 0)
//	{
//		alert("请选择楼盘.");
//		return false;
//	}
//	if(dongid == null || dongid =="0" || dongid == 0)
//	{
//		alert("请选择栋座.");
//		return false;
//	}
//	if(danyuanid == null || danyuanid =="0" || danyuanid == 0)
//	{
//		alert("请选择单元.");
//		return false;
//	}
	
	   var url = basepath+"/personInfo!queryHuxing.action";
		$.ajax({
			url:url,
			type:"post",
			dataType:"json",
			data:{"lpid":$("#lpid").val(),"dongid":$("#dongid").val(),"danyuanid":$("#danyuanid").val()},
			async : false,
			success:function(result)
			{
				var pHtml = '<option value="0">请选择户型</option>';
				$.each(result, function(i,n){
					$("#ceng").val(n[2]);
					pHtml += '<option value="'+n[1]+'">'+n[1]+'号户型</option>';
				});
				$("#huxingid").html(pHtml);
			}
		});
}
