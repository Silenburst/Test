$(function(){
		$(document).on("click", "div.fysearch-rightxq a", function(){
		var container = $(this).closest(".fysearch-rightxq");
		var conditionName = container.attr("data-conditionName");
		if(typeof(conditionName)!="undefined"){
			container.find("a").removeClass("active");
			$(this).addClass("active");
			pagerFormxq[conditionName].value = $(this).attr("data-conditionValue");
			if(conditionName=='xqsQy'&&$(this).attr("data-conditionValue")==0){
				pagerFormxq['xqsSq'].value = "0";
			 	$("#xqsSq a").addClass("active");
			 	$("#xqsSq a[data-conditionValue='0']").addClass("active");
			 	buildSqxq($(this).attr("data-conditionValue"))
			}
			showShaiXuanTianJianxq();
			queryDataxq();

		}
	});
	
	$("div.tiaojianxq").on("click", ".removeCondition", function(){
		var conditionName = $(this).closest("a").attr("data-conditionName");
		pagerFormxq[conditionName].value = "0";
		var container = $("div.fysearch-rightxq[data-conditionName='"+conditionName+"']");
		if(conditionName=='xqsQy'){
			 var sqId = $("#xqsSq a.active").attr("data-conditionValue") == null ? 0 : $("#xqsSq a.active").attr("data-conditionValue");
			 if(sqId>0){
				 pagerFormxq['xqsSq'].value = "0";
				 	$("#xqsSq a").addClass("active");
				 	$("#xqsSq a[data-conditionValue='0']").addClass("active");
				 	buildSqxq(0)
			 }
			     
		}
		container.find("a").removeClass("active");
		container.find("a[data-conditionValue='0']").addClass("active");
		showShaiXuanTianJianxq();
		queryDataxq();
	});
	
	$("div.tiaojianxq").on("click", ".bg2", function(){
		
		var build = $(this).parent().find(".removeCondition");
		for(var i = 0 ; i < build.length ; i++) {
			var conditionName = $(build[i]).closest("a").attr("data-conditionName");
			pagerFormxq[conditionName].value = "0";
			var container = $("div.fysearch-rightxq[data-conditionName='" + conditionName + "']");
			container.find("a").removeClass("active");
			container.find("a[data-conditionValue='0']").addClass("active");
		}
		showShaiXuanTianJianxq();
		queryDataxq();
	});
	});
	
	function submitSearchxq(typeName) {
	if (typeName == 'dtsHx') {
		if(pagerFormxq.sHxS.value=="" && pagerFormxq.sHxT.value=="" && pagerFormxq.sHxW.value==""){
			alert("请输入户型！");
			return;
		}
		resetConditionItemdt(typeName);
		
	}
	if (typeName == 'dtsMj') {
		if (parseInt(pagerFormxq.sMjX.value) > parseInt(pagerFormxq.sMjD.value)) {
			alert("面积最小值不能大于最大值！");
			pagerFormxq.sMjX.value = "";
			pagerFormxq.sMjD.value = "";
			return;
		}
		resetConditionItemdt(typeName);
	}
	if (typeName == 'dtsZj') {
		if (parseInt(pagerFormxq.sZjX.value) > parseInt(pagerFormxq.sZjD.value)) {
			alert("总价最小值不能大于最大值！");
			pagerFormxq.sZjX.value = "";
			pagerFormxq.sZjD.value = "";
			return;
		}
		resetConditionItemdt(typeName);
	}
	if (typeName == 'sFjRESET') {
		pagerFormxq.reset();
		resetConditionItemdt("dtsFw");
		resetConditionItemdt("dtsQy");
		resetConditionItemdt("dtsSq");
		resetConditionItemdt("dtsHx");
		resetConditionItemdt("dtsMj");
		resetConditionItemdt("dtsZj");
		
		showShaiXuanTianJianxq();
	}
	showShaiXuanTianJianxq();
	queryDataxq();
	
}

//将某个条件设成 "不限"
function resetConditionItemxq(conditionName){
	pagerFormxq[conditionName].value = "0";
	var container = $("div.fysearch-rightxq[data-conditionName='"+conditionName+"']");
	container.find("a").removeClass("active");
	container.find("a[data-conditionValue='0']").addClass("active");
}

//筛选条件
function showShaiXuanTianJianxq(){
	var sHtml = '<a  class="btn btn-red btn-icon btn-icon-standalone bg2" title=""><i class="fa-trash-o"></i><span>清空筛选选项</span></a>';
	
	if(pagerFormxq.xqsQy.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition" data-conditionName="xqsQy"><i class="fa-remove"></i><span>区域:' + $("div.fysearch-rightxq[data-conditionName='xqsQy'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	
	if(pagerFormxq.xqType.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition" data-conditionName="xqType"><i class="fa-remove"></i><span>类型:' + $("div.fysearch-rightxq[data-conditionName='xqType'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(pagerFormxq.xqsSq.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition" data-conditionName="xqsSq"><i class="fa-remove"></i><span>商圈:' + $("div.fysearch-rightxq[data-conditionName='xqsSq'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(sHtml == '<a  class="btn btn-red btn-icon btn-icon-standalone bg2" title=""><i class="fa-trash-o"></i><span>清空筛选选项</span></a>') {
		$("div.tiaojianxq").html("");
	} else {
		$("div.tiaojianxq").html(sHtml);
	}
	buildRemovexq();
}

function buildRemovexq() {
	
	$("#tiaojianxq span.removeCondition").click(function() {
		
		var conditionName = $(this).closest("a").attr("data-conditionName");
		pagerFormxq[conditionName].value = "0";
		var container = $("div.fysearch-rightxq[data-conditionName='"
				+ conditionName + "']");
		container.find("a").removeClass("active");
		container.find("a[data-conditionValue='0']").addClass("active");
		showShaiXuanTianJianxq();
		queryDataxq();
	});
	$("#tiaojianxq i.fa-trash-o").click(function() {
		var build = $(this).parent().find(".removeCondition");
		for(var i = 0 ; i < build.length ; i++) {
			var conditionName = $(build[i]).closest("a").attr("data-conditionName");
			pagerFormxq[conditionName].value = "0";
			var container = $("div.fl[data-conditionName='" + conditionName + "']");
			container.find("a").removeClass("active");
			container.find("a[data-conditionValue='0']").addClass("active");
		}
		showShaiXuanTianJianxq();
		queryDataxq();
	});
}


function buildQyxq(val){
	$.ajax({ 
		url: basePath+"/cam/campus!getQy.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"cid" : val},
		success: function(data){
			var cHtml = '<a href="javascript:buildSqxq(0)" class="mr10 active" data-conditionValue="0">不限</a>';
			$.each(data, function(i,n){
				cHtml += '<a href="javascript:buildSqxq('+n.id+')" class="mr10" data-conditionValue="'+n.id+'">'+n.qyName+'</a>';
			});
			$("#xqsQy").html(cHtml);
	    }
	});
};
function buildSqxq(val){
	$("#xqsQy a").removeClass("active");
	$("#xqsQy a[data-conditionValue='"+val+"']").addClass("active");
	if(val==0){
		$("#sQqxq").html("");
		}else{
			$.ajax({ 
				url: basePath+"/cam/campus!getSq.action",
				dataType: "json", 
				type: "POST",
				async : false,
				data : {"stressId" : val},
				success: function(data){
					var cHtml = '<td class="text-right"><div class="line32">商圈：</div></td><td><div class="fysearch-rightxq pull-left Color line32" data-conditionName="xqsSq" id="xqsSq"><a href="javascript:void(0)" class="mr10 active" data-conditionValue="0">不限</a>';
					$.each(data, function(i,n){
						if(i % 12 == 0 && i > 0) {
							cHtml += "<br>";
						}
						cHtml += '<a href="javascript:void(0)" class="mr10" data-conditionValue="'+n.id+'">'+n.sqName+'</a>';
					});
					$("#sQqxq").html(cHtml);
					$("#xqsSq a").click(function(){
						$("#xqsSq a").removeClass("active");
						$(this).addClass("active");
					});
			    }
			});
			
		}
	
};

function getSyscsOPTIONxq(sid ,buildDIV){
	var url = basePath + "/base/school!findBySType.action";
	$.ajax({
		url: url,
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"name" : sid},
		success: function(data){
			var cHtml = '<a href="javascript:void(0)" class="mr10 active" data-conditionValue="0">不限</a>';
			$.each(data, function(i,n){
				cHtml += '<a href="javascript:void(0)" class="mr10" data-conditionValue="'+n[0]+'">'+n[1]+'</a>';
			});
			$("#" + buildDIV).html(cHtml);
	    }
	});
};

function queryDataxq(){
	var fanghaoxq = document.getElementById("fanghaoxq");
	var fanghaoxqcs = document.getElementById("fanghaoxqcs");
	fanghaoxq.style.display = "block";
	fanghaoxqcs.style.display = "none";
    var stressId = $("#xqsQy a.active").attr("data-conditionValue") == null ? 0 : $("#xqsQy a.active").attr("data-conditionValue");
    var xqType = $("#xqType a.active").attr("data-conditionValue") == null ? 0 : $("#xqType a.active").attr("data-conditionValue");
    var sqId = $("#xqsSq a.active").attr("data-conditionValue") == null ? 0 : $("#xqsSq a.active").attr("data-conditionValue");
    var schoolName=$("#schoolName").val();
    var url = basePath+"/newenv/lpzd/fanghaoXhjLpfanghaxq.action";
    $("#xqmacPageWidget").asynPage(url, "#xqtbodyData", buildDataHtmlxq, true, true, {
        'xhjLpschool.QyID': stressId,
        'xhjLpschool.sqid': sqId,
        'xhjLpschool.schoolName': schoolName,
        'xhjLpschool.schoolType':xqType
    });
};

function buildDataHtmlxq(list) {
	$("#xqtbodyData").html("");
	var cHtml='';
    $.each(list, function (i, info) {
            cHtml += '<tr>'
            cHtml +='<td class="text-center"><input type="checkbox" class="cbr" onclick="setSelectAll(this)"  value="1" /></td>'
            cHtml +='<td width="110" class="middle-top"><a href="'+basePath+'/base/school!detail.action?id='+info.id+'">'
            if(info.imgPath!=null&&info.imgPath!=''){
            	cHtml +='<img src="http://imgbms.xhjfw.com/'+info.imgPath+'" width="80" height="80">'
            }else{
            	cHtml +='<img src="'+basePath+'/assets/images/hetong.jpg" width="80" height="80">'
            }
            cHtml +='</td>'
            cHtml +='<td><h3><a href="'+basePath+'/base/school!detail.action?id='+info.id+'">'+info.schoolName+'</a></h3><p style="color:#666;font-size:14px;font-weight: bold; padding-top: 2px;">地址：'+info.address+'</p><p style="color:#999;">更新时间：'+info.createDateStr+'</p></td>'
            cHtml +='<td>'+info.xqnum+'</td>'
            cHtml +='<td><p><a href="javascript:showTab(\'tab-1\'),empty(),queryData('+info.id+',1)">出售房屋：'+info.csnum+'</a></p><p><a href="javascript:showTab(\'tab-1\'),empty(),queryData('+info.id+',2)">出租房屋：'+info.cznum+'</a></p><p><a href="javascript:showTab(\'tab-1\'),empty(),queryData('+info.id+',0)">空置房屋：'+info.kznum+'</a></p><p><a href="javascript:showTab(\'tab-4\'),emptyxf(),fanghaoxf('+info.id+',2)">新房项目：'+info.xfnum+'</a></p></td>'
            cHtml +=  '</tr>'
       
    });
    $("#xqtbodyData").append(cHtml);
    
};



function fanghaoxfType(obj,type,ltype){
	var fanghaoxq = document.getElementById("fanghaoxq");
	var fanghaoxqcs = document.getElementById("fanghaoxqcs");
	fanghaoxq.style.display = "none";
	fanghaoxqcs.style.display = "block";
	$("#fanghaoxqcs").html("加载中...").load(basePath+"/newenv/lpzd/fanghaoxfType.action?schoolid="+obj+"&type="+type+"&ltype="+ltype); 
	
}

