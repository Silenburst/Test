var ids = [];
var zuoyous = [];
var total = 0;
$(function() {
			//queryData();
//			$('.onsubing').css("display","none");//弹出提示框
			//全选或不选
			/**$('#table_ckall').change(function(){
				
				if($('#table_ckall').prop("checked")){
					//选中
					$('input[id*=ck_]').each(function(i){
						$(this).prop('checked',true);
//						ids.push($(this).val());
					});
				}else{
					//未选中
					$('input[id*=ck_]').each(function(i){
						$(this).prop('checked',false);
//						ids=[];
					});
				};
//				$("#ids").val(JSON.stringify(ids));
			});*/
});

jQuery(document).ready(function($)
		{
			$("#dianzufp").select2({
				minimumInputLength: 1,
				placeholder: '请输入店组搜索',
				ajax: {
					url: basepath+"/personInfo!queryBM.action",
					type: "POST",
					dataType: 'json',
					quietMillis: 100,
					data: function(term, page) {
						return {
							limit: -1,
							"condition.dianzuName": term
						};
					},
					results: function(data, page ) {
						return { results: data };
					}
				},
				formatResult: function(student) { 
					return "<div class='select2-user-result'>" + student[1] + "</div>"; 
				},
				formatSelection: function(student) { 
					return  student[1]; 
				}
				
			}).on("change",function(e){
				queryBMJL(e.val,'fp');
				if($('#select2-chosen-1').html()!=''&&$('#select2-chosen-1').html()!=null)       
				 	{
				 	$(".select2-search-choice-close").addClass("dis");
				 	}
				 	else
				 	{
				 		$(".select2-search-choice-close").removeClass("dis");
				 	}
			});
			$(".select2-search-choice-close").click(function(){
				$(".select2-search-choice-close").removeClass("dis");
			});
		});
/**
//子复选框的事件  
function setSelectAll(index,id,value){  
//    当没有选中某个子复选框时，SelectAll取消选中  
if ($('#'+id).prop("checked") ){  
//	ids.push(value);
	var chsub = $("input[type='checkbox'][name='subcheck']").length; //获取subcheck的个数  
	var checkedsub = $("input[type='checkbox'][name='subcheck']:checked").length; //获取选中的subcheck的个数  
	if (checkedsub == chsub) {  
		$("#table_ckall").prop("checked",true);  
	}  
	}else
	{
		$("#table_ckall").prop("checked",false);
//		ids.remove(value);
	}
//	$("#ids").val(JSON.stringify(ids));
}  */

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

		
function queryData(){
	
		var lpName = $("#lpName").val() == null ? "" : $("#lpName").val();
		var dyName = $("#dyName").val() == null ? "" : $("#dyName").val();
		var lpdName = $("#lpdName").val() == null ? 0 : $("#lpdName").val();
		var fhName = $("#fhName").val() == null ? 0 : $("#fhName").val();
		var smj = $("#smj").val() == null ? 0 : $("#smj").val();
		var emj = $("#emj").val() == null ? 0 : $("#emj").val();
		var sc = $("#sc").val() == null ? 0 : $("#sc").val();
	    var ec = $("#ec").val() == null ? 0 : $("#ec").val();
	    var sh = $("#sh").val() == null ? 0 : $("#sh").val();
	    var eh = $("#eh").val() == null ? 0 : $("#eh").val();
	    var sd = $("#sd").val() == null ? "" : $("#sd").val();
	    var ed = $("#ed").val() == null ? "" : $("#ed").val();
	    var url = basepath+"/personInfo!queryForAssign.action";
		$('.onsubing').css("display","block");//弹出提示框
	    $("#macPageWidget").asynPage(url,"#tbodyData",buildDataHtml, true, true, {
	       'condition.lpxx.lpName': lpName,
	       'condition.danyuan.dyName': dyName,
	       'condition.dong.lpdName': lpdName,
	       'condition.fanghao.fhName': fhName,
           'condition.smj': smj,
           'condition.emj': emj,
           'condition.sc': sc,
           'condition.ec': ec,
           'condition.sh': sh,
           'condition.eh': eh,
           'condition.sd': sd,
           'condition.ed': ed
	    });
	};

function buildDataHtml(list) {
	$('.onsubing').css("display","none");//弹出提示框
	$("#tbodyData").html("");
	if(list.length>0)
	{
		$.each(list, function(i,n){
			var newTime = new Date(n[5]); 
	    	var nowStr = newTime.format("yyyy-MM-dd hh:mm:ss"); 
			var image = '<img src="'+IMAGE_PATH+n[1]+'" onerror="this.src=\'../assets/images/20150519191526.png\'" width="50" height="50" alt="'+[3]+'">';
			var bianma = (n[2]=='null'||n[2]==''||n[2]==null)?('CS'+n[0]):n[2];
			var sHtml = '<tr>';
		/**	sHtml += '<td class="text-center"  style="display:none">';
			sHtml += '<input type="checkbox" name="subcheck" onclick="setSelectAll(this.index,this.id,this.value);" index="'+i+'" class="cbr" id="ck_'+i+'" value="'+n[0]+'" />';
			sHtml += '</td>';*/
			sHtml += '<td class="text-center">';
			sHtml += '<a href="#">'+image+'</a>';
			sHtml += '</td>';
			sHtml += '<td class="text-center">'+bianma+'</td>';
			sHtml += '<td class="text-center">'+n[3]+'</td>';
			sHtml += '<td class="text-center">'+n[4]+'</td>';
			sHtml += '<td class="text-center">'+nowStr+'</td>';
			if(n[6]==1){sHtml += '<td class="text-center">内网系统</td>';}else{sHtml += '<td class="text-center">外网系统</td>';}
			if(n[7]==1){sHtml += '<td class="text-center">已委托</td>';}else{sHtml += '<td class="text-center">未委托</td>';}
			if(n[8]==1){sHtml += '<td class="text-center">在售</td>';}else if(n[7]==2){sHtml += '<td class="text-center">在租</td>';}
			else if(n[7]==3){sHtml += '<td class="text-center">租售</td>';}else{sHtml += '<td class="text-center">空置</td>';}

			sHtml += '<td class="text-center">'+n[8]==1?'有效':'无效'+'</td>';
			sHtml += '<td class="text-center">'+n[9]+'次</td>';
			sHtml += '<td class="text-center">';
			sHtml += '<a  href="personInfo!queryByLFId.action?lfid='+n[0]+'" class="pr10" onclick="selctLPxx("'+n[0]+'")"><i class="fa-file-text"></i>详情</a>';
			sHtml += '<a href="#"  class="pr10" onclick="showDlgFp('+n[0]+',\''+n[10]+'\')" style="margin-left:3px"><i class="linecons-key"></i>分派</a>';
			sHtml += '<a  style="display:none"  href="#" class="pr10" data-toggle="modal" id="Fenpaifp" data-target="#Fenpai"></a>';
			sHtml += '</td>';
			sHtml += '</tr>';
			$("#tbodyData").append(sHtml);
		});
	}
};
Date.prototype.format = function(format){ 
	var o = { 
	"M+" : this.getMonth()+1, //month 
	"d+" : this.getDate(), //day 
	"h+" : this.getHours(), //hour 
	"m+" : this.getMinutes(), //minute 
	"s+" : this.getSeconds(), //second 
	"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
	"S" : this.getMilliseconds() //millisecond 
	} 

	if(/(y+)/.test(format)) { 
	format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	} 

	for(var k in o) { 
	if(new RegExp("("+ k +")").test(format)) { 
	format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
	} 
	} 
	return format; 
	} 

function showDlgFp(id,fenpainame)
{
	zuoyous = [];
	zuoyous.push(id);
	$("#lpNamefp").text(fenpainame);
	$("#fhidsfp").val(JSON.stringify(zuoyous));
	$("#dianzufp").parent().find("div a span").eq(0).html("");
	$("#dianzufp").parent().find("div a span").eq(0).html("请选择店组");
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

function querySource(val,number)
{
	$("#tbodyid1").html("");
	$("#tbodyid2").html("");
	
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
	 var url = basepath+"/personInfo!querySource.action";
		$.ajax({
			url:url,
			data:{"condition.ids":JSON.stringify(ids),"condition.lpxx.id":lpid,"condition.dong.id":dongid,"condition.danyuan.id":danyuanid},
			dataType:"json",
			type:"post",
			async:false,
			success:function(result)
			{
				if(null!=result)
				{
					var pHtml = '';
					zuoyous =[];
					$.each(result.getGridModel, function(i,n){
						if(number == 2)
						{
							zuoyous.push(n[0]);
						}else
						{
							zuoyous=[];
						}
						pHtml += '<tr id="c'+i+'" >';
						pHtml += '<td><a href="#" style="background:rgb(221, 236, 228)" onclick="setClass(this,'+n[0]+',\''+n[2]+'\','+number+')" ><input type="hidden" value="'+n[0]+'" id="'+n[0]+'">'+n[2]+'</a></td>';
						pHtml += '</tr>';
					});
					$("#total").text(result.getRecords);
					$("#"+val).html(pHtml);
					if(number == 2)
					{
						$("#total2").text(zuoyous.length);
					}
				}
				else
				{
					$("#total").text(0);
					$("#"+val).html("无数据，请重新选择！");
				}
			}
		});
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
		pHtml += '<td><a href="#" style="background:rgb(221, 236, 228)" onclick="setClass(this,'+id+',\''+value+'\',2)" ><input type="hidden" value="'+id+'" id="'+id+'">'+value+'</a></td>';
		pHtml += '</tr>';
		$("#tbodyid2").append(pHtml);
		zuoyous.push(id);
	}
	else
	{
		pHtml += '<td><a href="#" style="background:rgb(221, 236, 228)" onclick="setClass(this,'+id+',\''+value+'\',1)" ><input type="hidden" value="'+id+'" id="'+id+'">'+value+'</a></td>';
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
					alert("分派成功.");
					$("#close"+number).click();
				}else
				{
					alert("分派失败.")
				}
			}
		});
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

