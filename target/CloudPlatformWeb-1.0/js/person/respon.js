var IMAGE_PATH = "http://imgbms.xhjfw.com/";
$(document).ready(function() {
	queryData();
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
	
});
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
    var url = basepath+"/personInfo!queryForZR.action";
	$('.onsubing').css("display","block");//弹出提示框
    $("#macPageWidget").asynPage(url, "#tbodyData", buildDataHtml, true, true, {
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
	    $.each(list, function (i, info) { 
	    	var newTime = new Date(info[5]); 
	    	var nowStr = newTime.format("yyyy-MM-dd hh:mm:ss"); 
			var bianma = (info[2]=='null'||info[2]==''||info[2]==null)?('CS'+info[0]):info[2];

	        var sHtml = '<tr>';
			sHtml += '<td class="text-center">';
			sHtml += '<input type="checkbox" name="subcheck" onclick="setSelectAll(this.id);"  class="cbr" id="ck_'+info.id+'" value="'+info.id+'" />';
			sHtml += '</td>';
			sHtml += '<td class="text-center">';
				if(info[1] !=null && info[1] !=""){
					sHtml += '<a href="#"><img src="'+IMAGE_PATH+info[1]+'" width="50" height="50"></a>';
				} else {
					sHtml += '<a href="#"><img src="../assets/images/20150519191526.png" width="50" height="50"></a>';
				}
			sHtml += '</td>';
			sHtml += '<td class="text-center">'+bianma+'</td>';
			sHtml += '<td class="text-center">'+info[3]+'</td>';
			sHtml += '<td class="text-center">'+info[4]+'</td>';
			sHtml += '<td class="text-center">'+nowStr+'</td>';
			if(info[6]==1){sHtml += '<td class="text-center">内网系统</td>';}else{sHtml += '<td class="text-center">外网系统</td>';}
			if(info[7]==1){sHtml += '<td class="text-center">已委托</td>';}else{sHtml += '<td class="text-center">未委托</td>';}
			if(info[8]==1){sHtml += '<td class="text-center">在售</td>';}else if(info[7]==2){sHtml += '<td class="text-center">在租</td>';}
			else if(info[7]==3){sHtml += '<td class="text-center">租售</td>';}else{sHtml += '<td class="text-center">空置</td>';}
			sHtml += '<td class="text-center">'+info[8]==1?'有效':'无效'+'</td>';
			sHtml += '<td class="text-center">'+info[9]+'</td>';
			sHtml += '<td class="text-center">';
			sHtml += '<a href="#" class="pr10" data-toggle="modal" onclick="genjin('+info[0]+')" style="display:none"><i class="fa-pencil"></i> 跟进 </a>';
			sHtml += '<a href="personInfo!queryByLFId.action?lfid='+info[0]+'" class="pr10" onclick="selctLPxx("'+info[0]+'")"><i class="fa-file-text"></i> 详情 </a>';
			//<a href="'+basepath+'/base/school!detail.action?id='+n.id+'" style="font-size:14px; padding-bottom:5px;">'+n.schoolName+'</a><br />
			sHtml += '<a href="#"  class="pr10" onclick="showDlgFp('+info[0]+',\''+info[10]+'\')"><i class="linecons-key"></i>分派</a>';
			sHtml += '<a  style="display:none"  href="#" class="pr10" data-toggle="modal" id="Fenpaifp" data-target="#Fenpai"></a>';
			sHtml += '</td>';
			sHtml += '</tr>';
	        $("#tbodyData").append(sHtml);
	    });
	  

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
	
	
