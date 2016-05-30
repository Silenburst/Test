//单个添加栋数
var curDongId = "";
var curDanyuanId = "";
var curCeng = "";
var curFanghaoId = "";
function dongAddTypeClicked(theRdo){
	var theTable = $("#tblAddDong");
	theTable.find("tr:gt(0)").hide();
	theTable.find(".dong"+$(theRdo).val()).show();
};
//显示栋信息
function showDongInfo(val){
	$.ajax({
		url: basepath + "/cam/campus!showDongLp.action",
		dataType: "json", 
		type: "POST",
		data: {"lpid":val},
		success: function(result){
			var pHtml = '<option value="0">请选择</option>';
			$.each(result, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.lpdName+'</option>';
			});
			$("#dQuery").html(pHtml);
		}
	});
};
 
//================单元操作===================================================================
	//显示某一栋的单元信息
function showDanyuanOfDong(dongId){
	$("#cQuery").html("<option value='0'>请选择</option>");
	  $.ajax({
	  	url: basepath + "/cam/campus!showLpDanyuan.action",
		dataType: "json",
		type: "POST",
		data: {"dongId":dongId},
		success: function(dyList){
			var pHtml = '<option value="0">请选择</option>';
			$.each(dyList, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.dyName+'</option>';
			});
			$("#dyQuery").html(pHtml);
    	}
	});
}

//============层信息维护============================================
function showCengsOfDy(dyId){
	  $.ajax({
		url: basepath + "/cam/campus!showCeng.action",
		dataType: "json",
		type: "POST",
		async:false,
		data: {"dyId":dyId},
		success: function(cengList){
			var pHtml = "<option value='0'>请选择</option>";
			$.each(cengList, function(i,n){
				pHtml += '<option value="'+n.ceng+'">'+n.ceng+'</option>';
			});
			$("#cQuery").html(pHtml);
    	}
	});
};

//function queryFanghaoInfo(lpid){
//    var url = basepath + "/newenv/lpzd/fanghaoqueryFanghaoInfo.action";
//    $("#macPageWidget").asynPage(url, "#fangHInfo", buildDataHtml, true, true, {
//        'lpid': lpid,
//        'dzid': $("#dQuery").val(),
//        'dyid': $("#dyQuery").val(),
//        'ceng': $("#cQuery").val(),
//        'fwzt': $("#ztQuery").val(),
//        "source" : $("#soQuery").val()
//    });
//};


function queryFanghaoInfo(lpid){
    var url = basepath + "/newenv/lpzd/fanghaoqueryLpdongInfo.action";
    $("#macPageWidget").asynPage(url, "#fangHInfo", buildDataHtml, true, true, {
        'lpid': lpid
    });
};

//function buildDataHtml(list) {
//	$("#fangHInfo").html("");
//    $.each(list, function (i, info) {
//    	var fwzt = info[0];
//    	if(fwzt == 1) {
//    		fwzt = "在售";
//    	} else if(fwzt == 2) {
//    		fwzt= "在租";
//    	} else if(fwzt == 3) {
//    		fwzt = "即售又租";
//    	} else if(fwzt == 0) {
//    		fwzt = "空置";
//    	}
//    	var shi = "";
//    	var ting = "";
//    	var wei = "";
//    	if(info[2] != "" && info[2] != "0" && info[2] != "null" && info[2] != null) {
//    		shi = info[2] + "室";
//    	}
//    	if(info[3] != "" && info[3] != "0" && info[2] != "null" && info[2] != null) {
//    		ting = info[3] + "厅";
//    	}
//    	if(info[4] != "" && info[4] != "0" && info[2] != "null" && info[2] != null) {
//    		wei = info[4] + "卫";
//    	}
//    	var source = info[9];
//    	if(source == 1) {
//    		source = "公司内部";
//    	} else if(source == 2) {
//    		source = "外部加盟";
//    	} else {
//    		source = "其他";
//    	}
//    	
//        var tr = [
//            '<tr>',
//            '<td class="text-center">', fwzt, '</td>',
//            '<td class="text-center">', info[1], '</td>',
//            '<td class="text-center">', shi + ting + wei, '</td>',
//            '<td class="text-center">', info[5], '</td>',
//            '<td class="text-center">', info[6], '</td>',
//            '<td class="text-center">', info[7], '</td>',
//            '<td class="text-center">', info[8], '</td>',
//            '<td class="text-center">', source, '</td>',
//            '<td class="text-center">', info[10], '</td>',
//            '<td class="text-center">', '<button class="btn btn-secondary" onclick="showCorHouseInit('+info[11]+')">查看关联房源 </button>', '</td>',
//            '</tr>'].join('');
//        $("#fangHInfo").append(tr);
//    });
//};


function buildDataHtml(list) {
	$("#fangHInfo").html("");
    $.each(list, function (i, info) {
        var tr = [
            '<tr>',
            '<td class="text-center">', i+1, '</td>',
            '<td class="text-center">', info[0], '</td>',
            '<td class="text-center">', info[1], '</td>',
            '<td class="text-center">', info[2], '</td>',
            '<td class="text-center">', info[3], '</td>',
            '<td class="text-center">', info[4], '</td>',
            '</tr>'].join('');
        $("#fangHInfo").append(tr);
    });
};

//查询关联房源
function showCorHouseInit(val){
	 $.ajax({
	  	url: basepath + "/cam/campus!showCorHouseInit.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data: {"fhid" : val},
		success: function(data){
			var sHtml = "";
			if(data != null) {
				$.each(data,function(i, n) {
					var fwzt = n[7];
					if(fwzt == "0") {
						fwzt = "无效";
					} else if(fwzt == "1"){
						fwzt = "有效";
					} else if(fwzt == "2"){
						fwzt = "定金";
					} else if(fwzt == "3"){
						fwzt = "签约未审核";
					} else if(fwzt == "4"){
						fwzt = "锁定";
					} else if(fwzt == "5"){
						fwzt = "签约已审核";
					} else {
						fwzt = "待审核";
					}
					sHtml += '<tr>'
						+ '<td>'+n[0]+'</td><td>'+n[1]+'</td><td>'+n[2]+'</td><td>'+n[3]+'</td><td>'+n[4]+'</td><td>'+n[5]+'</td>'
						+ '<td>'+n[6]+'</td><td>'+fwzt+'</td><td>'+n[8]+'</td><td>'+(n[9] == "null" || n[9] == null ? "" : n[9])+'</td><td>'+(n[10] == "null" || n[10] == null ? "" : n[10])+'</td>'
						+ '</tr>';
				});
			}
			$("#crrHouse").html(sHtml);
			$("#showCrrHouseModal").click();
	    }
	 });
};