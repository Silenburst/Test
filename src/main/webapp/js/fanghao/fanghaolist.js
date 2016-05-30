
$(function(){
	buildCountry();
	buildProfw(countryId);
	buildCity(provinceId);
	buildQy(cityId);
	getshi(804,"shi");
	gettnmj(806,"mianji");
	getSyscsOPTION("房屋朝向","CsCx","朝向不限");
	getSyscsOPTION("房屋用途","YsYt","用途不限");
	getSyscsOPTION("装修标准","ZsZx","装修不限");
	getSyscsOPTION("建筑类别","sFwjg","结构不限");
	//getxhjLpxx();
		$(document).on("click", "div.fysearch-right a", function(){
		var container = $(this).closest(".fysearch-right");
		var conditionName = container.attr("data-conditionName");
		if(typeof(conditionName)!="undefined"){
			container.find("a").removeClass("active");
			$(this).addClass("active");
			pagerForm[conditionName].value = $(this).attr("data-conditionValue");
			if(conditionName=='sQy'&&$(this).attr("data-conditionValue")==0){
					 	pagerForm['sSq'].value = "0";
					 	$("#sSq a").addClass("active");
					 	$("#sSq a[data-conditionValue='0']").addClass("active");
					 	buildSq($(this).attr("data-conditionValue"))
			}
			showShaiXuanTianJian();
			queryData(0,-1);
		}
	});
		
		$("div.tiaojian").on("click", ".removeCondition", function(){
		var conditionName = $(this).closest("a").attr("data-conditionName");
		pagerForm[conditionName].value = "0";
		var container = $("div.fysearch-right[data-conditionName='"+conditionName+"']");
		if(conditionName=='sQy'){
			 var sqId = $("#sQq a.active").attr("data-conditionValue") == null ? 0 : $("#sQq a.active").attr("data-conditionValue");
			 if(sqId>0){
				 	pagerForm['sSq'].value = "0";
				 	$("#sSq a").addClass("active");
				 	$("#sSq a[data-conditionValue='0']").addClass("active");
				 	buildSq(0)
			 }
			
		}
		container.find("a").removeClass("active");
		container.find("a[data-conditionValue='0']").addClass("active");
		showShaiXuanTianJian();
		queryData(0,-1);
	});
	$("div.tiaojian").on("click", ".bg2", function(){
		
		var build = $(this).parent().find(".removeCondition");
		for(var i = 0 ; i < build.length ; i++) {
			var conditionName = $(build[i]).closest("a").attr("data-conditionName");
			pagerForm[conditionName].value = "0";
			var container = $("div.fysearch-right[data-conditionName='" + conditionName + "']");
			container.find("a").removeClass("active");
			container.find("a[data-conditionValue='0']").addClass("active");
		}
		showShaiXuanTianJian();
		queryData(0,-1);
	});
	
	});
	
	function submitSearch(typeName) {
	if (typeName == 'sHx') {
		if(pagerForm.sHxS.value=="" && pagerForm.sHxT.value=="" && pagerForm.sHxW.value==""){
			alert("请输入户型！");
			return;
		}
		resetConditionItem(typeName);
		
	}
	if (typeName == 'sMj') {
		if (parseInt(pagerForm.startmj.value) > parseInt(pagerForm.endmj.value)) {
			alert("面积最小值不能大于最大值！");
			pagerForm.startmj.value = "";
			pagerForm.endmj.value = "";
			return;
		}
		resetConditionItem(typeName);
	}
	if (typeName == 'sZj') {
		if (parseInt(pagerForm.sZjX.value) > parseInt(pagerForm.sZjD.value)) {
			alert("总价最小值不能大于最大值！");
			pagerForm.sZjX.value = "";
			pagerForm.sZjD.value = "";
			return;
		}
		resetConditionItem(typeName);
	}
	if (typeName == 'sFjRESET') {
		pagerForm.reset();
		resetConditionItem("sFw");
		resetConditionItem("sQy");
		resetConditionItem("sSq");
		resetConditionItem("sHx");
		resetConditionItem("sMj");
		resetConditionItem("sZj");
		
		showShaiXuanTianJian();
	}
	queryData(0,-1);
	
}

//将某个条件设成 "不限"
function resetConditionItem(conditionName){
	pagerForm[conditionName].value = "0";
	var container = $("div.fysearch-right[data-conditionName='"+conditionName+"']");
	container.find("a").removeClass("active");
	container.find("a[data-conditionValue='0']").addClass("active");
	showShaiXuanTianJian();
}

//筛选条件
function showShaiXuanTianJian(){
	var sHtml = '<a  class="btn btn-red btn-icon btn-icon-standalone bg2" title=""><i class="fa-trash-o"></i><span>清空筛选选项</span></a>';
	if(pagerForm.sQy.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition" data-conditionName="sQy"><i class="fa-remove"></i><span>区域:' + $("div.fysearch-right[data-conditionName='sQy'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(pagerForm.sHx.value!="0"){
		pagerForm.sHxS.value=""
		pagerForm.sHxT.value=""
		pagerForm.sHxW.value=""
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition " data-conditionName="sHx"><i class="fa-remove"></i><span>户型:' + $("div.fysearch-right[data-conditionName='sHx'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(pagerForm.sMj.value!="0"){
		pagerForm.startmj.value = "";
		pagerForm.endmj.value = "";
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition " data-conditionName="sMj"><i class="fa-remove"></i><span>面积:' + $("div.fysearch-right[data-conditionName='sMj'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(pagerForm.sZj.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition" data-conditionName="sZj"><i class="fa-remove"></i><span>价格:' + $("div.fysearch-right[data-conditionName='sZj'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(pagerForm.sSq.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition" data-conditionName="sSq"><i class="fa-remove"></i><span>商圈:' + $("div.fysearch-right[data-conditionName='sSq'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(sHtml == '<a  class="btn btn-red btn-icon btn-icon-standalone bg2" title=""><i class="fa-trash-o"></i><span>清空筛选选项</span></a>') {
		$("div.tiaojian").html("");
	} else {
		$("div.tiaojian").html(sHtml);
	}
	buildRemove();
}

function buildRemove() {
	$("#tiaojian .removeCondition").click(function() {
		var conditionName = $(this).closest("a").attr("data-conditionName");
		pagerForm[conditionName].value = "0";
		var container = $("div.fysearch-right[data-conditionName='"
				+ conditionName + "']");
		container.find("a").removeClass("active");
		container.find("a[data-conditionValue='0']").addClass("active");
		showShaiXuanTianJian();
		queryData(0,-1);
	});
	$("#tiaojian a.bg2").click(function() {
		var build = $(this).parent().find(".removeCondition");
		for(var i = 0 ; i < build.length ; i++) {
			var conditionName = $(build[i]).closest("a").attr("data-conditionName");
			pagerForm[conditionName].value = "0";
			var container = $("div.fl[data-conditionName='" + conditionName + "']");
			container.find("a").removeClass("active");
			container.find("a[data-conditionValue='0']").addClass("active");
		}
		showShaiXuanTianJian();
		queryData(0,-1);
	});
}
function country(){
var sHtml="";
	$.ajax({
 			url: SERVICES_BASE_PATH + "/country/all",
			dataType: "json",
			type: "GET",	
			contentType: "application/json; charset=utf-8",
			success: function(data){
			$.each(data, function(i,info){
						sHtml += '<option  value="'+info.id+'">'+info.cname+'</option>';
					});
					$("#country").html(sHtml);
			}

});

}

function getshi(sid ,buildDIV){
	$.ajax({
		url:  basePath+"/newenv/lpzd/fanghaogetshi.action",
			dataType: "json",
			type: "GET",	
			contentType: "application/json; charset=utf-8",
			data : {"sid" : sid},
			success: function(data){
				var sHtml ='<a href="javascript:void(0)" class="mr10 active" data-conditionValue="0">不限</a>';
			$.each(data, function(i,info){
			
						i=i+1;
						sHtml += '<a href="javascript:void(0)" class="mr10" data-conditionValue="'+i+'">'+info.name+'</a> ';
					});
					$("#"+buildDIV).html(sHtml);
			}

});

}

function getxhjLpxx(){
	$.ajax({
 			url: basePath+"/newenv/lpzd/fanghaogetxhjLpxx.action",
			dataType: "json",
			type: "GET",	
			contentType: "application/json; charset=utf-8",
			success: function(data){
				var sHtml ='<option></option>';
			$.each(data, function(i,info){
						sHtml += '<option  value="'+info[0]+'">'+info[1]+'</option>';
					});
					$("#lp").html(sHtml);
			}

});

}

function gettnmj(sid,buildDIV){

	$.ajax({
		url:  basePath+"/newenv/lpzd/fanghaogetmianji.action",
			dataType: "json",
			type: "GET",	
			contentType: "application/json; charset=utf-8",
			data : {"sid" : sid},
			success: function(data){
				var sHtml ='<a href="javascript:void(0)" class="active mr10" data-conditionValue="0">不限</a>';
			$.each(data, function(i,info){
					
						sHtml += '<a href="javascript:void(0)"   class="mr10" data-conditionValue="'+info.value+'-'+info.maxValue+'">'+info.name+'</a> ';
					});
					$("#"+buildDIV).html(sHtml);
			}

});

}



//国家
function buildCountry(){
	$.ajax({ 
		url: basePath+"/cam/campus!getCountryInfo.action",
		dataType: "json", 
		type: "POST",
		async : false,
		success: function(data){
			var cHtml = '<option value="0"><a href="javascript:void(0)" class="mr10 active" data-id="0">不限</a></option>';
			$.each(data, function(i,n){
				if(i % 8 == 0 && i > 0) {
					cHtml += "<br>";
				}
				cHtml += '<option value="'+n.id+'" >'+n.cname+'</option>';
			});
			$("#country").html(cHtml);
			
	    }
	});
	$("#country option[value='"+countryId+"']").attr("selected", true); 
	queryData(0,-1);
};

function buildProfw(val){
	if(val.value!=null&&val.value!=''){
		countryId=val.value;
	}else{
		countryId=val;
	}
	$("#cityId").html("<option value=''>城市</option>");
	$("#tdsQy").html("");
	$("#sQq").html("");
	$.ajax({ 
		url: basePath+"/cam/campus!getPro.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"cid" :countryId},
		success: function(data){
			var pHtml = '<option value="0">不限</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.pname+'</option>';
			});
			$("#pro").html(pHtml);
	    }
	});
	if(val.value!=null&&val.value!=''){
		queryData(0,-1);
		pagerForm['sQy'].value = "0";
	 	//$("#sQy a").addClass("active");
	 	$("#sQy a[data-conditionValue='0']").addClass("active");
		pagerForm['sSq'].value = "0";
	 	//$("#sSq a").addClass("active");
	 	$("#sSq a[data-conditionValue='0']").addClass("active");
	 	showShaiXuanTianJian();
	}else{
		$("#pro option[value='"+provinceId+"']").attr("selected", true); 
	}
	
	
};
//栋座
function getBYLpId(lpid){
	if(lpid!=null&&lpid!=''){
		$.ajax({
			url: basePath+"/newenv/lpzd/fanghaogetBYLpId.action",
		dataType: "json",
		type: "GET",	
		contentType: "application/json; charset=utf-8",
		data:{"lpid":lpid},
		success: function(data){
			var sHtml ='<option  value="0">请选择</option>';
		$.each(data, function(i,info){
					sHtml += '<option   value="'+info[0]+'">'+info[1]+'</option>';
				});
				$("#ld").html(sHtml);
		}

});
	}else{
		
		$("#ld").html("");
		$("#dyId").html("");
		$("#ceng").html("");
		$("#fangHao").html("");
	}
	queryData('')
}

//单元
function getBYdzId(dzId){
	if(dzId.value!=null&&dzId.value!=''&&dzId.value!='0'){
		$.ajax({
			url: basePath+"/newenv/lpzd/fanghaogetBYdzId.action",
		dataType: "json",
		type: "GET",	
		contentType: "application/json; charset=utf-8",
		data:{"dzId":dzId.value},
		success: function(data){
			var sHtml ='<option  value="0">请选择</option>';
		$.each(data, function(i,info){
					sHtml += '<option   value="'+info[0]+'">'+info[1]+'</option>';
				});
				$("#dyId").html(sHtml);
		}

});
		
	}else{
		$("#dyId").html("");
		$("#ceng").html("");
		$("#fangHao").html("");
	}
	
	queryData('')
}


//层
function getBYceng(dyId){
	if(dyId.value!=null&&dyId.value!=''&&dyId.value!='0'){
		$.ajax({
			url: basepath + "/cam/campus!showCeng.action",
			dataType: "json", 
			type: "POST",
			async:false,
			data: {"dyId":dyId.value},
			success: function(data){
			var sHtml ='<option  value="0">请选择</option>';
			$.each(data, function(i,info){
					sHtml += '<option   value="'+info.ceng+'">'+info.ceng+'</option>';
				});
				$("#ceng").html(sHtml);
		}

});
		
	}else{
		$("#ceng").html("");
		$("#fangHao").html("");
	}
	
	queryData('')
}

//房号
function getBYfangHao(ceng){
	var dyId=$("#dyId").val();
	if(ceng.value!=null&&ceng.value!=''&&ceng.value!='0'){
		$.ajax({
			url : basepath + "/cam/campus!showFanghaoOfDanyuan.action",
			dataType: "json", 
			type: "POST",
			async:false,
			data : {
				"dyId" : dyId,
				"ceng" : ceng.value
			},
			success: function(data){
			var sHtml ='<option  value="">请选择</option>';
			$.each(data, function(i,info){
					sHtml += '<option   value="'+info.fhName+'">'+info.fhName+'</option>';
				});
				$("#fangHao").html(sHtml);
		}

});
		
	}else{
		$("#fangHao").html("");
	}
	
	queryData('')
}


function buildCity(val){
	if(val.value!=null&&val.value!=''){
		provinceId=val.value;
	}else{
		provinceId=val;
	}
	
	$.ajax({ 
		url: basePath+"/cam/campus!getCity.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"pid" :provinceId},
		success: function(data){
			var cHtml = '<option value="0"><a href="javascript:void(0)" class="mr10 active" data-id="0">不限</a></option>';
			$.each(data, function(i,n){
				cHtml += '<option value="'+n.id+'"><a href="void(0)" class="mr10" data-id="'+n.id+'">'+n.cityName+'</a></option>';
			});
			$("#cityId").html(cHtml);
	    }
	});
	
		$("#tdsQy").html("");
		$("#sQq").html("");
	if(val.value!=null&&val.value!=''){
		queryData(0,-1);
		pagerForm['sQy'].value = "0";
	 	//$("#sQy a").addClass("active");
	 	$("#sQy a[data-conditionValue='0']").addClass("active");
		pagerForm['sSq'].value = "0";
	 	//$("#sSq a").addClass("active");
	 	$("#sSq a[data-conditionValue='0']").addClass("active");
	 	showShaiXuanTianJian();
	}else{
	$("#cityId option[value='"+cityId+"']").attr("selected", true);
	}
};

function buildQy(val){
	if(val.value!=null&&val.value!=''){
		cityId=val.value
	}else{
		cityId=val;
	}
	$.ajax({ 
		url: basePath+"/cam/campus!getQy.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"cid" : cityId},
		success: function(data){
			var cHtml = '<td class="text-right"><div class="line32">区域：</div></td><td><div class="fysearch-right pull-left Color line32" data-conditionName="sQy" id="sQy"><a href="javascript:buildSq(0)" class="mr10 active" data-conditionValue="0">不限</a>';
			$.each(data, function(i,n){
				cHtml += '<a href="javascript:buildSq('+n.id+')" class="mr10" data-conditionValue="'+n.id+'">'+n.qyName+'</a>';
			});
			cHtml +='</div></td>'
			$("#tdsQy").html(cHtml);
	    }
	});
	$("#sQq").html("");
	if(val.value!=null&&val.value!=''){
		queryData(0,-1);
		pagerForm['sQy'].value = "0";
	 	//$("#sQy a").addClass("active");
	 	$("#sQy a[data-conditionValue='0']").addClass("active");
		pagerForm['sSq'].value = "0";
	 	//$("#sSq a").addClass("active");
	 	$("#sSq a[data-conditionValue='0']").addClass("active");
	 	showShaiXuanTianJian();
	}

};

function buildSq(val){
	$("#sQy a").removeClass("active");
	$("#sQy a[data-conditionValue='"+val+"']").addClass("active");
	if(val==0){
		$("#sQq").html("");
	}else{
		$.ajax({ 
			url: basePath+"/cam/campus!getSq.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"stressId" : val},
			success: function(data){
				var cHtml = '<td class="text-right"><div class="line32">商圈：</div></td><td colspan="2"><div class="fysearch-right pull-left Color line32" data-conditionName="sSq" id="sSq"><a href="javascript:void(0)" class="mr10 active" data-conditionValue="0">不限</a>';
				$.each(data, function(i,n){
					if(i % 12 == 0 && i > 0) {
						cHtml += "<br>";
					}
					cHtml += '<a href="javascript:void(0)" class="mr10" data-conditionValue="'+n.id+'">'+n.sqName+'</a>';
				});
				$("#sQq").html(cHtml);
				$("#sSq a").click(function(){
					$("#sSq a").removeClass("active");
					$(this).addClass("active");
				});
		    }
		});
	}
	
	
	
};
function getSyscsOPTION(sid ,buildDIV,typeName){
	var url = basePath + "/base/school!findBySType.action";
	$.ajax({
		url: url,
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"name" : sid},
		success: function(data){
			var cHtml = '<option value="">'+typeName+'</option>';
			$.each(data, function(i,n){
				cHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
			});
			$("#" + buildDIV).html(cHtml);
	    }
	});
};

function queryData(obj,fwzx){
	var shi;//户型
	 var mianji ;//面积
	 var yongtou=0;//用途
	 var dzId=0;//楼栋ID
	 var dyid=0;//单元ID
	 var ceng=0;//层
	 var fangHao='';//房号
	 var fwzt=-1;//房屋现状
	 var couId=0;//国家
	 var proId=0;//省
	 var city=0;//城市
	 var schoolid=0;//学校ID
	 var stressId = $("#sQy a.active").attr("data-conditionValue") == null ? 0 : $("#sQy a.active").attr("data-conditionValue");
	 var sqId = $("#sQq a.active").attr("data-conditionValue") == null ? 0 : $("#sQq a.active").attr("data-conditionValue");
	 var chaoxiang=$("#CsCx").val()
	 var lpid=$("#lp").val();
	 var zxcd=$("#ZsZx").val()== null ? 0 :$("#ZsZx").val();
	 var fwjg=$("#sFwjg").val()== null ? 0 :$("#sFwjg").val();
	 var startmj =$("#startmj").val();
	 var endmj =$("#endmj").val();
	 var number=$("#number").val();
	 var sHxS  =$("#sHxS").val();
	 var sHxT  =$("#sHxT").val();
	 var sHxW  =$("#sHxW").val();
	 if(fwzx!=null&&fwzx!=-1){
		 $("#fwztId").val(fwzx);
	 	}
	 if($("#fwxz").val()!=null&&$("#fwxz").val()!=''){
			fwzt=$("#fwxz").val();
			
		}else if($("#fwztId").val()!=null&&$("#fwztId").val()!=-1){
			fwzt=$("#fwztId").val();
		}
	 if(obj!=null&&obj!=0){
		 $("#schoolid").val(obj);
	 	}
	 if($("#schoolid").val()!=null&&$("#schoolid").val()!=0){
		 schoolid=$("#schoolid").val();
		}
	 if($("#sHxS").val()!=null&&$("#sHxS").val()!=''){
		shi=$("#sHxS").val();
	 	}else{
		shi = $("#shi a.active").attr("data-conditionValue") == null ? 0 : $("#shi a.active").attr("data-conditionValue");
	 	}
	if(startmj!=null&&startmj!=''||endmj!=null&&endmj!=''){
		mianji=startmj+"-"+endmj;
	}else{
		mianji = $("#mianji a.active").attr("data-conditionValue") == null || $("#mianji a.active").attr("data-conditionValue")==0 ? -1 : $("#mianji a.active").attr("data-conditionValue");
	}
	if($("#YsYt").val()!=null&&$("#YsYt").val()!=''){
		yongtou=$("#YsYt").val()
	}
	if($("#country").val()!=null&&$("#country").val()!=''){
		couId=$("#country").val()
	}else{
		couId=countryId;
	}
	if($("#pro").val()!=null&&$("#pro").val()!=''){
		proId=$("#pro").val();
	}else{
		proId=provinceId;
	}
	if($("#cityId").val()!=null&&$("#cityId").val()!=''){
		city=$("#cityId").val();
	}else{
		city=cityId;
	}
	if($("#ld").val()!=null&&$("#ld").val()!=''){
	dzId=$("#ld").val() != null&&$("#ld").val() !=''&&$("#ld").val()!='null'?$("#ld").val():0;
	ceng=$("#ceng").val() != null&&$("#ceng").val()!=''&&$("#ceng").val()!='null'?$("#ceng").val():0;
	dyid=$("#dyId").val()!= null&&$("#dyId").val()!=''&&$("#dyId").val()!='null'?$("#dyId").val():0;
	fangHao=$("#fangHao").val()!= null&&$("#fangHao").val()!=''&&$("#fangHao").val()!='null' ? $("#fangHao").val():'';
	}
    var url = basePath+"/newenv/lpzd/fanghaoXhjLpfanghaoPage.action";
    $("#macPageWidget").asynPage(url, "#tbodyData", buildDataHtml, true, true, {
	    'xhjLpfanghao.countryid': couId,
	    'xhjLpfanghao.provinceid': proId,
        'xhjLpfanghao.cityId': city,
        'xhjLpfanghao.stressId': stressId,
        'xhjLpfanghao.chaoXiang':chaoxiang,
        'xhjLpfanghao.leixing':yongtou,
        'xhjLpfanghao.DecorationStandard':zxcd,
        'xhjLpfanghao.shi': shi,
        'xhjLpfanghao.fangHao':fangHao,
        'xhjLpfanghao.ceng':ceng,
        'xhjLpfanghao.dzId':dzId,
        'xhjLpfanghao.number': number,
        'xhjLpfanghao.lpid': lpid,
        'xhjLpfanghao.ting':sHxT,
        'xhjLpfanghao.wei': sHxW,
        'xhjLpfanghao.buildingType':fwjg,
        'xhjLpfanghao.dyId':dyid,
        'startmj':mianji,
        'xhjLpfanghao.fwzt':fwzt,
        'xhjLpfanghao.schoolid':schoolid,
        'xhjLpfanghao.sqId':sqId
//	        'xhjLpfanghao.fwjg':fwjg
    });
};

function buildDataHtml(list,records) {
	$("#fwts").html("共 "+records+" 套");
	$("#tbodyData").html("");
	var cHtml='';
    $.each(list, function (i, info) {
    	cHtml+='<tr>'
    	cHtml+='<td class="text-center"><input type="checkbox" onclick="setSelectAll(this)"  class="cbr" value="'+info.id+'" /></td>'
    	cHtml+='<td width="110" class="middle-top"><p><a href="'+basePath+'/newenv/lpzd/fanghaogetById.action?id='+info.id+'" >'
    	if(info.imagePath!=null&&info.imagePath!=''){
    		cHtml+='<img src="http://imgbms.xhjfw.com/'+info.imagePath+'" width="80" height="80">'
    	}else{
    		cHtml+='<img src="'+basePath+'/assets/images/hetong.jpg" width="80" height="80">'
    	}
    	
    	cHtml+='</a></p><p>'+ info.number+ '</p></td>'
    	cHtml+='<td><h3><a href="'+basePath+'/newenv/lpzd/fanghaogetById.action?id='+info.id+'" >'+ info.lpName+  '</a> <span style="color:#666;font-size:14px;font-weight: bold; padding-top: 2px;">'+ info.leixingStr+ '</span></h3> <h6>'+info.lpdName+'&nbsp;&nbsp;&nbsp;&nbsp;'+info.dyName+'&nbsp;&nbsp;&nbsp;&nbsp;'+info.ceng+'层 '+info.fangHao+'&nbsp;&nbsp;&nbsp;&nbsp;</h6><h6>'+ info.shi+ '室'+'&nbsp;&nbsp;&nbsp;'+ info.ting+ '厅 '+'&nbsp;&nbsp;&nbsp;'+ info.tnmj+ '平米 '+ info.chaoXiangName+ '</h6><div>'
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
   			cHtml+='<button class="btn btn-bqcolor2 btn-icon btn-icon-standalone btn-xs"><i class="fa-eyedropper"></i><span>'+info+'</span></button>'
   			j++;
   		 });
   	}
    	if(info.isHaving!=null&&info.isHaving!=''&&info.isHaving==886){
    		if((j!= 0 && j % 3 == 0) ||( i != 0 && i % 3 == 0)) {
    			 cHtml += '<br><div style="height:3px;"></div>';
			 }
    			cHtml+='<button class="btn btn-bqcolor3 btn-info btn-icon btn-icon-standalone btn-xs"><i class="fa-ticket"></i><span>'+info.isHavingStr+'</span></button>'
    			j++;
    		}
    	cHtml+='</div>';
    	cHtml+='<h6 style="color:#999;">更新时间：'+info.updateDateStr+ '</h6></td>'
    	cHtml+='<td>'+info.fwztStr+ '</td>'
    	cHtml+='<td>'+info.sourceStr+'</td>'
    	cHtml+='<td class="text-center"><a href="'+basePath+'/newenv/lpzd/fanghaogetById.action?id='+info.id+'" class="btn btn-blue"><i class="fa-file-text"></i> 查看详情 <a></td>'
    	cHtml+='</tr>'
       
    });
    $("#tbodyData").html(cHtml);
};


function fanghaoxf(schoolidxf,ltype){
	 if(schoolidxf!=null&&schoolidxf!=0){
		 $("#schoolidxf").val(schoolidxf);
	 	}
	 if(ltype!=null&&ltype!=0){
		 $("#ltypexf").val(ltype);
	 	}
	 tabStatustable('tab-4')
	$("#fanghaoxf").html("加载中...").load(basePath+"/newenv/lpzd/fanghaoxf.action"); 
	
}

