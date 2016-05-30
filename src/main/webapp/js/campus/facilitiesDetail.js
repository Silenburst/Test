//显示楼盘地铁信息
function metorInfo(){
	$.ajax({
		url: basepath + "/cam/campus!showLpZhan.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"lpid" : $("#tuplpid").val()},
		success: function(result){
			var sHtml = '';
			$.each(result, function(i,n){
				sHtml += '<tr>' 
						+ '<td>'+(i+1)+'</td>' 
						+ '<td>'+n.xName+'</td>' 
						+ '<td>'+n.zdName+'</td>'
						'</tr>';
			});
			$("#metorInfo").html(sHtml);
	    }
	});
};
//加载所有划片学校信息
function loadLpSchoolInfo(){
	$.ajax({
		url: basepath + "/cam/campus!loadLpSchoolInfo.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"lpid" : $("#tuplpid").val()},
		success: function(data){
			var sHtml = '';
			$.each(data, function(i,n){
				var type = n.type;
				if(type == "1") {
					type = "学区";
				} else {
					type = "学位";
				};
				sHtml += '<tr>' 
						+ '<td>'+n.schoolType+'</td>' 
						+ '<td>'+n.schoolName+'</td>' 
						+ '<td>'+n.names+'</td>'
						+ '<td>'+type+'</td>'
						+ '</tr>';
			});
			$("#lpSchoolInfo").html(sHtml);
	    }
	});
};
/***************************************
 * 服务网点	
 * *************************************/
//加载责任盘,范围盘,维护盘
function loadLpFuzh(){
	var findsta = $("#serFindFw").val();
	var bmid = $("#serviceWD").val();
    
    var url = basepath + "/cam/campus!loadLpFuzh.action";
    $("#macPageWidgetWd").asynPage(url, "#showLpHuaPanInfo", buildLpfuzhuHtml, true, true, {
        'lpid': $("#tuplpid").val(),
        'findsta': findsta,
        'bmid': bmid
    });
};

function buildLpfuzhuHtml(data){
	var pHtml = '';
	$.each(data, function(i,n){
		var sta = n[1];
		if(sta == "1"){
			sta = "责任盘";
		} else if(sta == "2") {
			sta = "维护盘";
		} else {
			sta = "范围盘";
		}
		var source = n[2];
		if(source == "1") {
			source = "公司内部";
		} else if(source == "2") {
			source = "外部加盟";
		} else {
			source = "其他";
		}
		pHtml += '<tr>'
			+'<td>'+sta+'</td>'
			+'<td>'+source+'</td><td>'+n[3]+'</td><td>'+n[4]+'</td><td>'+n[5]+'</td>'
			+'</tr>';
	});
	$("#showLpHuaPanInfo").html(pHtml);
};

var sPage = 1;
var zPage = 1;
var rows = 3;
//小区成交信息
function getChengjiaoInfo(type){
	var page = 0;
	if(type == 1) {
		page = sPage;
	} else {
		page = zPage;
	}
	$.ajax({
		url: basepath + "/cam/campus!findByLpChengjiao.action",
		dataType: "json",
		type: "POST",
		data : {
			"lpid" : $("#tuplpid").val(),
			"type" : type,
			"pageInfo.page" : page,
			"pageInfo.rows" : rows
		},
		success: function(result){
			var sHtml = '';
			var rHtml = '';
			$.each(result.gridModel, function(i,n){
				var shi = "";
				if(n[0] != null && n[0] != "" && n[0] != "") {
					shi = n[0] + "室";
				}
				var ting = "";
				if(n[1] != null && n[1] != "" && n[1] != "") {
					ting = n[1] + "厅";
				}
				var wei = "";
				if(n[2] != null && n[2] != "" && n[2] != "") {
					wei = n[2] + "卫";
				}
				var source = "";
				if(n[11] == '1') {
					source = "公司内部";
				} else if(n[11] == '2') {
					source = "外部加盟";
				} else {
					source = "其他";
				}
				var  nowStrData =  new Date(n[7]).format("yyyy-MM-dd hh:mm:ss");
				var zxbz='';
				if(n[12]!=null&&n[12]!=''){
					zxbz=n[12];
				}
				if(type == 1) {
					sHtml += '<tr><td>';
					sHtml += shi + ting + wei;
					sHtml += '</td><td>'+n[3]+'</td><td>'+n[4]+'</td><td>'+n[5]+'</td>'
							+ '<td>'+n[6]+'</td><td>'+nowStrData+'</td><td>'+n[8]+'</td><td>'+n[9]+'</td>'
							+ '<td>'+n[10]+'</td><td>'+source+'</td></tr>';
				} else {
					rHtml += '<tr><td>';
					rHtml += shi + ting + wei;
					rHtml += '</td><td>'+n[3]+'</td><td>'+n[4]+'</td><td>'+n[5]+'</td>'
							+ '<td>'+n[6]+'</td><td>'+nowStrData+'</td><td>'+zxbz+'</td><td>'+n[9]+'</td>'
							+ '<td>'+n[10]+'</td><td>'+source+'</td></tr>';
				}
			});
			if(type == 1) {
				$(".ershoufan").append(sHtml);
				sPage ++;
			}
			if(type == 2) {
				$(".zufan").append(rHtml);
				zPage ++;
			}
	    }
	});
};

var dtPage = 1;
var dtRow = 5;
function dirLog(){
	$.ajax({
		url: basepath + "/cam/campus!findByLpLog.action",
		dataType: "json",
		type: "POST",
		data : {
			"lpid" : $("#tuplpid").val(),
			"pageInfo.page" : dtPage,
			"pageInfo.rows" : dtRow
		},
		success: function(result){
			var rHtml = '';
			$.each(result.gridModel, function(i,n){
				rHtml += '<tr><td width="110"><img src="../assets/images/20150519191526.png" width="100" height="130"></td><td><div class="pull-left"><h4>' + n[0] + '</h4>' + n[1] + n[2] +'</div></td>'
						+ '<td>' + n[3] + '</td>'
						+ '<td>' + n[4] + '</td></tr>';
			});
			if(rHtml != "") {
				$(".dirLog").append(rHtml);
				dtPage ++;
			}
	    }
	});
};
//维护单位
var maintainPage = 1;
var maintainRow = 5;
function maintain(){
	$.ajax({
		url: basepath + "/cam/campus!queryLpMaintenanceUnit.action",
		type:'POST',
		dataType:'json',
		data : {
			"lpid" : $("#tuplpid").val(),
			"pageInfo.page" : maintainPage,
			"pageInfo.rows" : maintainRow
		},
		success:function(data){
			var maintainHtml='';
			$.each(data.gridModel,function(index,info){
				maintainHtml +='<tr>'
				maintainHtml +='<td><a href="#">'+info[0]+'</a></td>'
				maintainHtml +='<td><a href="#">'+info[1]+'</a></td>'
				maintainHtml +='<td>'+info[2]+'</td>'
				maintainHtml +='<td>'+info[3]+'</td>'
				maintainHtml +='<td>'+info[4]+'</td>'
				maintainHtml +='</tr>'
			});
			if(maintainHtml!=''){
				$("#maintainHtml").append(maintainHtml);
				maintainHtml++;
			}
			
		}
		
	});
}
//居住
var costsPage=1;
var costsRow=5;
function livingcosts(){
	$.ajax({
		url: basepath + "/cam/campus!queryLpCostLiving.action",
		type:'POST',
		dataType:'json',
		data:{"lpid" : $("#tuplpid").val(),
			"pageInfo.page" : costsPage,
			"pageInfo.rows" : costsRow},
		success:function(data){
				var costsHtml='';
			$.each(data.gridModel,function(index,info){
					costsHtml +='<tr>'
					costsHtml +='<td><a href="#">'+info[0]+'</a></td>'
					costsHtml +='<td><a href="#">'+info[1]+'</a></td>'
					costsHtml +='<td>'+info[2]+'</td>'
					costsHtml +='<td>'+info[3]+'</td>'
					costsHtml +='<td>'+info[4]+'</td>'
					costsHtml +='</tr>'
			});
			if(costsHtml!=''){
				$("#costsHtml").append(costsHtml);
				costsPage++;
			}
			
		}
		
	});
}
//点评
var dpPage = 1;
var dpRow = 5;
function dpLpReview(){
	$.ajax({
		url: basepath + "/cam/campus!queryLpReview.action",
		dataType: "json",
		type: "POST",
		data : {
			"lpid" : $("#tuplpid").val(),
			"pageInfo.page" : dpPage,
			"pageInfo.rows" : dpRow
		},
		success: function(result){
			
			var rHtml = '';
			$.each(result.gridModel, function(i,n){
		    	var  nowStrData =  new Date(n[3]).format("yyyy-MM-dd hh:mm:ss");
				rHtml += '<tr><td class="col-lg-1">'+n[0]+'</td>'
						+ '<td>'+n[1]+'</td>'
						+ '<td>'+n[2]+'</td><td>'+nowStrData+'</td></tr>';
			});
			if(rHtml != "") {
				if(dpPage==1){
					$("#LpReview").html(rHtml);
				}else{
					$("#LpReview").append(rHtml);
				}
				dpPage ++;
			}
	    }
	});
};
//查询楼盘专家的 信息
function queryLpzj(){
	var url= basepath + "/cam/campus!queryLpzj.action";
	$("#macPagequeryLpzj").asynPage(url, "#tbodyDataqueryLpzj", buildDataqueryLpzj, true, true, {
		"lpid" : $("#tuplpid").val(),
	 });
	};
	
	
	function buildDataqueryLpzj(list) {
		$("#tbodyDataqueryLpzj").html("");
	    $.each(list, function (i, info) {
	        var tr = [
	            '<tr>',
	            '<td class="text-center">',info[0],'</td>',
	            '<td class="text-center">',info[1],'</td>',
	            '<td class="text-center">',info[2],'</td>',
	            '<td class="text-center">',info[3],'</td>',
	            '<td class="text-center">',info[4],'</td>',
	            '<td class="text-center">',info[5],'</td>',
	            '</tr>'].join('');
	        $("#tbodyDataqueryLpzj").append(tr);
	    });
	}
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
