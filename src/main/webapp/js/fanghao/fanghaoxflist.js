$(function(){
		$(document).on("click", "div.fysearch-rightxf a", function(){
		var container = $(this).closest(".fysearch-rightxf");
		var conditionName = container.attr("data-conditionName");
		if(typeof(conditionName)!="undefined"){
			container.find("a").removeClass("active");
			$(this).addClass("active");
			pagerFormxf[conditionName].value = $(this).attr("data-conditionValue");
			if(conditionName=='xfsQy'&&$(this).attr("data-conditionValue")==0){
				pagerFormxf['xfsSq'].value = "0";
			 	$("#xfsSq a").addClass("active");
			 	$("#xfsSq a[data-conditionValue='0']").addClass("active");
			 	buildSqxf($(this).attr("data-conditionValue"))
	}
			showShaiXuanTianJianxf();
			queryDataxf(0,2);
		}
	});
	
	$("div.tiaojianxf").on("click", ".removeCondition", function(){
		var conditionName = $(this).closest("a").attr("data-conditionName");
		pagerFormxf[conditionName].value = "0";
		var container = $("div.fysearch-rightxf[data-conditionName='"+conditionName+"']");
		if(conditionName=='xfsQy'){
			 var sqId = $("#xfsSq a.active").attr("data-conditionValue") == null ? 0 : $("#xfsSq a.active").attr("data-conditionValue");
			 if(sqId>0){
				 pagerFormxf['xfsSq'].value = "0";
				 	$("#xfsSq a").addClass("active");
				 	$("#xfsSq a[data-conditionValue='0']").addClass("active");
				 	buildSqxf(0)
			 }
			       
		}
		container.find("a").removeClass("active");
		container.find("a[data-conditionValue='0']").addClass("active");
		showShaiXuanTianJianxf();
		queryDataxf(0,2);
	});
	});
	
	function submitSearchxf(typeName) {
	if (typeName == 'dtsHx') {
		if(pagerFormxf.sHxS.value=="" && pagerFormxf.sHxT.value=="" && pagerFormxf.sHxW.value==""){
			alert("请输入户型！");
			return;
		}
		resetConditionItemdt(typeName);
		
	}
	if (typeName == 'dtsMj') {
		if (parseInt(pagerFormxf.sMjX.value) > parseInt(pagerFormxf.sMjD.value)) {
			alert("面积最小值不能大于最大值！");
			pagerFormxf.sMjX.value = "";
			pagerFormxf.sMjD.value = "";
			return;
		}
		resetConditionItemdt(typeName);
	}
	if (typeName == 'dtsZj') {
		if (parseInt(pagerFormxf.sZjX.value) > parseInt(pagerFormxf.sZjD.value)) {
			alert("总价最小值不能大于最大值！");
			pagerFormxf.sZjX.value = "";
			pagerFormxf.sZjD.value = "";
			return;
		}
		resetConditionItemdt(typeName);
	}
	if (typeName == 'sFjRESET') {
		pagerFormxf.reset();
		resetConditionItemdt("dtsFw");
		resetConditionItemdt("dtsQy");
		resetConditionItemdt("dtsSq");
		resetConditionItemdt("dtsHx");
		resetConditionItemdt("dtsMj");
		resetConditionItemdt("dtsZj");
		
		showShaiXuanTianJianxf();
	}
	queryDataxf(0,2);
	
}

//将某个条件设成 "不限"
function resetConditionItemxf(conditionName){
	pagerFormxf[conditionName].value = "0";
	var container = $("div.fysearch-rightxf[data-conditionName='"+conditionName+"']");
	container.find("a").removeClass("active");
	container.find("a[data-conditionValue='0']").addClass("active");
}

//筛选条件
function showShaiXuanTianJianxf(){
	var sHtml = '<a  class="btn btn-red btn-icon btn-icon-standalone bg2" title=""><i class="fa-trash-o"></i><span>清空筛选选项</span></a>';
	
	if(pagerFormxf.xfsQy.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition" data-conditionName="xfsQy"><i class="fa-remove"></i><span>区域:' + $("div.fysearch-rightxf[data-conditionName='xfsQy'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	
	if(pagerFormxf.xfsJg.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition" data-conditionName="xfsJg"><i class="fa-remove"></i><span>价格:' + $("div.fysearch-rightxf[data-conditionName='xfsJg'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(pagerFormxf.xfsSq.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition" data-conditionName="xfsSq"><i class="fa-remove"></i><span>商圈:' + $("div.fysearch-rightxf[data-conditionName='xfsSq'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(sHtml == '<a  class="btn btn-red btn-icon btn-icon-standalone bg2" title=""><i class="fa-trash-o"></i><span>清空筛选选项</span></a>') {
		$("div.tiaojianxf").html("");
	} else {
		$("div.tiaojianxf").html(sHtml);
	}
	buildRemovexf();
}

function buildRemovexf() {
	
	$("#tiaojianxf span.removeCondition").click(function() {
		
		var conditionName = $(this).closest("a").attr("data-conditionName");
		pagerFormxf[conditionName].value = "0";
		var container = $("div.fysearch-rightxf[data-conditionName='"
				+ conditionName + "']");
		container.find("a").removeClass("active");
		container.find("a[data-conditionValue='0']").addClass("active");
		showShaiXuanTianJianxf();
		queryDataxf(0,2);
	});
	$("#tiaojianxf i.fa-trash-o").click(function() {
		var build = $(this).parent().find(".removeCondition");
		for(var i = 0 ; i < build.length ; i++) {
			var conditionName = $(build[i]).closest("a").attr("data-conditionName");
			pagerFormxf[conditionName].value = "0";
			var container = $("div.fl[data-conditionName='" + conditionName + "']");
			container.find("a").removeClass("active");
			container.find("a[data-conditionValue='0']").addClass("active");
		}
		showShaiXuanTianJianxf();
		queryDataxf(0,2);
	});
}


function buildQyxf(val){
	$.ajax({ 
		url: basePath+"/cam/campus!getQy.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"cid" : val},
		success: function(data){
			var cHtml = '<a href="javascript:buildSqxf(0)" class="mr10 active" data-conditionValue="0">不限</a>';
			$.each(data, function(i,n){
				cHtml += '<a href="javascript:buildSqxf('+n.id+')" class="mr10" data-conditionValue="'+n.id+'">'+n.qyName+'</a>';
			});
			$("#xfsQy").html(cHtml);
	    }
	});
	
};
function buildSqxf(val){
	$("#xfsQy a").removeClass("active");
	$("#xfsQy a[data-conditionValue='"+val+"']").addClass("active");
	if(val==0){
		$("#sQqxf").html("");
		}else{
			$.ajax({ 
				url: basePath+"/cam/campus!getSq.action",
				dataType: "json", 
				type: "POST",
				async : false,
				data : {"stressId" : val},
				success: function(data){
					var cHtml = '<td class="text-right"><div class="line32">商圈：</div></td><td><div class="fysearch-rightxf pull-left Color line32" data-conditionName="xfsSq" id="xfsSq"><a href="javascript:void(0)" class="mr10 active" data-conditionValue="0">不限</a>';
					$.each(data, function(i,n){
						if(i % 12 == 0 && i > 0) {
							cHtml += "<br>";
						}
						cHtml += '<a href="javascript:void(0)" class="mr10" data-conditionValue="'+n.id+'">'+n.sqName+'</a>';
					});
					$("#sQqxf").html(cHtml);
					$("#xfsSq a").click(function(){
						$("#xfsSq a").removeClass("active");
						$(this).addClass("active");
					});
			    }
			});
		}
	
	
};

function getSyscsOPTIONxf(sid ,buildDIV){
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
				cHtml += '<a href="javascript:queryDataxf(0)" class="mr10" data-conditionValue="'+n[0]+'">'+n[1]+'</a>';
			});
			$("#" + buildDIV).html(cHtml);
	    }
	});
};



function queryDataxf(schoolidxf,ltype){
	 var schoolid=0;//学校ID
	 var lTyexf=-1;
	 if(schoolidxf!=null&&schoolidxf!=0){
		 $("#schoolidxf").val(schoolidxf);
	 	}
	 if($("#schoolidxf").val()!=null&&$("#schoolidxf").val()!=0){
		 schoolid=$("#schoolidxf").val();
		}
    var stressId = $("#xfsQy a.active").attr("data-conditionValue") == null ? 0 : $("#xfsQy a.active").attr("data-conditionValue");
    var xfsJg = $("#xfsJg a.active").attr("data-conditionValue") == null ? 0 : $("#xfsJg a.active").attr("data-conditionValue");
    var sqId = $("#xfsSq a.active").attr("data-conditionValue") == null ? 0 : $("#xfsSq a.active").attr("data-conditionValue");
    var lpName = $("#lpNamexf").val();
    var url = basePath+"/newenv/lpzd/fanghaoXhjLpfanghaoxf.action";
    $("#xfmacPageWidget").asynPage(url, "#xftbodyData", buildDataHtmlxf, true, true, {
        'xhjNewhouseinfo.stressId': stressId,
        'xhjNewhouseinfo.schoolid': schoolid,
        'xhjNewhouseinfo.sqId': sqId,
        'xhjNewhouseinfo.lpName': lpName,
        'ltype': ltype,
        'avgprice':xfsJg
    });
};

function buildDataHtmlxf(list,records) {
	$("#fwtsxf").html("共 "+records+"套")
	$("#xftbodyData").html("");
	var cHtml='';
    $.each(list, function (i, info) {
     
    	cHtml+='<tr>'
    	cHtml+='<td class="text-center"><input type="checkbox" onclick="setSelectAll(this)" class="cbr" value="'+info.id+'" /></td>'
    	cHtml+='<td width="110" class="middle-top"><a href="'+basePath+'/newenv/lpzd/fanghaogetByIdXf.action?id='+info.id+'">'
    	if(info.img!=null&&info.img!=''){
    		cHtml+='<img src="http://imgbms.xhjfw.com/'+info.img+'" width="80" height="80">'
    	}else{
    		cHtml+='<img src="'+basePath+'/assets/images/hetong.jpg" width="80" height="80">'
    	}
    	cHtml+='</a></td>'
    	cHtml+='<td><h3><a href="'+basePath+'/newenv/lpzd/fanghaogetByIdXf.action?id='+info.id+'">'+info.lpName+'</a> <span style="color:#666;font-size:14px;font-weight: bold; padding-top: 5px;">'+info.usagesStr+'</span></h3>'
    	cHtml+='<h6>'+info.address+'</h6><h6>开发商：'+info.developers+'</h6>'
    	cHtml+='<div>';
    		var j = 0;
    	   	if(info.schoolName!=null&&info.schoolName!=''){
       		 $.each(info.schoolName.split(","), function (i, info) { 
       			 if(j!= 0 && j % 3 == 0) {
       				 cHtml += '<br><div style="height:3px;"></div>';
       			 }
       			 cHtml+='<button class="btn btn-bqcolor1 btn-icon-standalone btn-xs"><i class="fa-magic"></i><span>'+info+'</span></button>'
       			 j++;
       		 });
       	}
       	if(info.zdName!=null&&info.zdName!=''){
      		 $.each(info.zdName.split(","), function (i, info) { 
      			if((j!= 0 && j % 3 == 0) ||( i != 0 && i % 3 == 0)) {
      				 cHtml += '<br><div style="height:3px;"></div>';
      			 }
      			cHtml+='<button class="btn btn-bqcolor3 btn-info btn-icon btn-icon-standalone btn-xs"><i class="fa-eyedropper"></i><span>'+info+'</span></button>'
      			j ++;
      		 });
      	}
    	cHtml+='</div></td>'
    	cHtml+='<td>'+info.avgPrice+' 元/m2</td>'
    	cHtml+='<td>内部系统</td>'
    	cHtml+='<td><a href="'+basePath+'/newenv/lpzd/fanghaogetByIdXf.action?id='+info.id+'" class="btn btn-blue"><i class="fa-file-text"></i> 查看详情 </a></td>'
    	cHtml+='</tr>'
        
    });
    $("#xftbodyData").html(cHtml);
    
};
