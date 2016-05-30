 
$(function(){
		$(document).on("click", "div.fysearch-rightdt a", function(){
		var container = $(this).closest(".fysearch-rightdt");
		var conditionName = container.attr("data-conditionName");
		if(typeof(conditionName)!="undefined"){
			container.find("a").removeClass("active");
			$(this).addClass("active");
			pagerFormdt[conditionName].value = $(this).attr("data-conditionValue");
			if(conditionName=='dtsQy'&&$(this).attr("data-conditionValue")==0){
				pagerFormdt['dtsSq'].value = "0";
			 	$("#dtsSq a").addClass("active");
			 	$("#dtsSq a[data-conditionValue='0']").addClass("active");
			 	buildSqdt($(this).attr("data-conditionValue"))
			}
			showShaiXuanTianJiandt();
			queryDatadt('');
		}
	});
	
	$("div.tiaojiandt").on("click", ".removeCondition", function(){
		var conditionName = $(this).closest("a").attr("data-conditionName");
		pagerFormdt[conditionName].value = "0";
		var container = $("div.fysearch-rightdt[data-conditionName='"+conditionName+"']");
		if(conditionName=='dtsQy'){
			 var sqId = $("#dtsSq a.active").attr("data-conditionValue") == null ? 0 : $("#dtsSq a.active").attr("data-conditionValue");
			 if(sqId>0){
				 pagerFormdt['dtsSq'].value = "0";
				 	$("#dtsSq a").addClass("active");
				 	$("#dtsSq a[data-conditionValue='0']").addClass("active");
				 	buildSqdt(0)
			 }
			   
		}
		container.find("a").removeClass("active");
		container.find("a[data-conditionValue='0']").addClass("active");
		showShaiXuanTianJiandt();
		queryDatadt('');
	});
	$("div.tiaojiandt").on("click", ".bg2", function(){
		
		var build = $(this).parent().find(".removeCondition");
		for(var i = 0 ; i < build.length ; i++) {
			var conditionName = $(build[i]).closest("a").attr("data-conditionName");
			pagerFormdt[conditionName].value = "0";
			var container = $("div.fysearch-rightdt[data-conditionName='" + conditionName + "']");
			container.find("a").removeClass("active");
			container.find("a[data-conditionValue='0']").addClass("active");
		}
		showShaiXuanTianJiandt();
		queryDatadt('');
	});
	});
	
	function submitSearchdt(typeName) {
	if (typeName == 'dtsHx') {
		if(pagerFormdt.dtsHxS.value=="" && pagerFormdt.dtsHxT.value=="" && pagerFormdt.dtsHxW.value==""){
			alert("请输入户型！");
			return;
		}
		resetConditionItemdt(typeName);
		
	}
	if (typeName == 'dtsMj') {
		if (parseInt(pagerFormdt.startmjdt.value) > parseInt(pagerFormdt.endmjdt.value)) {
			alert("面积最小值不能大于最大值！");
			pagerFormdt.startmjdt.value = "";
			pagerFormdt.endmjdt.value = "";
			return;
		}
		resetConditionItemdt(typeName);
	}
	if (typeName == 'dtsZj') {
		if (parseInt(pagerFormdt.sZjX.value) > parseInt(pagerFormdt.sZjD.value)) {
			alert("总价最小值不能大于最大值！");
			pagerFormdt.sZjX.value = "";
			pagerFormdt.sZjD.value = "";
			return;
		}
		resetConditionItemdt(typeName);
	}
	if (typeName == 'sFjRESET') {
		pagerFormdt.reset();
		resetConditionItemdt("dtsFw");
		resetConditionItemdt("dtsQy");
		resetConditionItemdt("dtsSq");
		resetConditionItemdt("dtsHx");
		resetConditionItemdt("dtsMj");
		resetConditionItemdt("dtsZj");
		resetConditionItemdt("dtxianLu");
		
		showShaiXuanTianJiandt();
	}
	queryDatadt('');
	
}

//将某个条件设成 "不限"
function resetConditionItemdt(conditionName){
	pagerFormdt[conditionName].value = "0";
	var container = $("div.fysearch-rightdt[data-conditionName='"+conditionName+"']");
	container.find("a").removeClass("active");
	container.find("a[data-conditionValue='0']").addClass("active");
	showShaiXuanTianJiandt();
}

//筛选条件
function showShaiXuanTianJiandt(){
	var sHtml = '<a class="btn btn-red btn-icon btn-icon-standalone bg2" ><i class="fa-trash-o"></i><span>清空筛选选项</span></a>';
	
	if(pagerFormdt.dtsQy.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition " data-conditionName="dtsQy"><i class="fa-remove"></i><span>区域:' + $("div.fysearch-rightdt[data-conditionName='dtsQy'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(pagerFormdt.dtsHx.value!="0"){
			pagerFormdt.dtsHxS.value=""
			pagerFormdt.dtsHxT.value=""
			pagerFormdt.dtsHxW.value=""
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition " data-conditionName="dtsHx"><i class="fa-remove"></i><span>户型:' + $("div.fysearch-rightdt[data-conditionName='dtsHx'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(pagerFormdt.dtsMj.value!="0"){
		pagerFormdt.startmjdt.value = "";
		pagerFormdt.endmjdt.value = "";
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition " data-conditionName="dtsMj"><i class="fa-remove"></i><span>面积:' + $("div.fysearch-rightdt[data-conditionName='dtsMj'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(pagerFormdt.dtsZj.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition " data-conditionName="dtsZj"><i class="fa-remove"></i><span>价格:' + $("div.fysearch-rightdt[data-conditionName='dtsZj'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(pagerFormdt.dtxianLu.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition " data-conditionName="dtxianLu"><i class="fa-remove"></i><span>线路:' + $("div.fysearch-rightdt[data-conditionName='dtxianLu'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(pagerFormdt.dtsjl.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition " data-conditionName="dtsjl"><i class="fa-remove"></i><span>距离:' + $("div.fysearch-rightdt[data-conditionName='dtsjl'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(pagerFormdt.dtsSq.value!="0"){
		sHtml += '<a class="btn btn-white btn-icon btn-icon-standalone btn-icon-standalone-right removeCondition " data-conditionName="dtsSq"><i class="fa-remove"></i><span>商圈:' + $("div.fysearch-rightdt[data-conditionName='dtsSq'] a[class='mr10 active']").text()
				+ '</span></a> ';
	}
	if(sHtml == '<a class="btn btn-red btn-icon btn-icon-standalone bg2" ><i class="fa-trash-o"></i><span>清空筛选选项</span></a>') {
		$("div.tiaojiandt").html("");
	} else {
		$("div.tiaojiandt").html(sHtml);
	}
	buildRemovedt();
}

function buildRemovedt() {
	
	$("#tiaojiandt span.removeCondition").click(function() {
		
		var conditionName = $(this).closest("a").attr("data-conditionName");
		pagerFormdt[conditionName].value = "0";
		var container = $("div.fysearch-rightdt[data-conditionName='"
				+ conditionName + "']");
		container.find("a").removeClass("active");
		container.find("a[data-conditionValue='0']").addClass("active");
		showShaiXuanTianJiandt();
		queryDatadt('');
	});
	$("#tiaojiandt i.fa-trash-o").click(function() {
		var build = $(this).parent().find(".removeCondition");
		for(var i = 0 ; i < build.length ; i++) {
			var conditionName = $(build[i]).closest("a").attr("data-conditionName");
			pagerFormdt[conditionName].value = "0";
			var container = $("div.fl[data-conditionName='" + conditionName + "']");
			container.find("a").removeClass("active");
			container.find("a[data-conditionValue='0']").addClass("active");
		}
		showShaiXuanTianJiandt();
	});
}

function buildQydt(val){
	$.ajax({ 
		url: basePath+"/cam/campus!getQy.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"cid" : val},
		success: function(data){
			var cHtml = '<a href="javascript:buildSqdt(0)" class="mr10 active" data-conditionValue="0">不限</a>';
			$.each(data, function(i,n){
				cHtml += '<a href="javascript:buildSqdt('+n.id+')" class="mr10" data-conditionValue="'+n.id+'">'+n.qyName+'</a>';
			});
			$("#dtsQy").html(cHtml);
	    }
	});
	
};
function buildSqdt(val){
	$("#sQydt a").removeClass("active");
	$("#sQydt a[data-conditionValue='"+val+"']").addClass("active");
	if(val==0){
		$("#sQqdt").html("");
	}else{
		$.ajax({ 
			url: basePath+"/cam/campus!getSq.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data : {"stressId" : val},
			success: function(data){
				var cHtml = '<td class="text-right"><div class="line32">商圈：</div></td><td><div class="fysearch-rightdt pull-left Color line32" data-conditionName="dtsSq" id="dtsSq"><a href="javascript:void(0)" class="mr10 active" data-conditionValue="0">不限</a>';
				$.each(data, function(i,n){
					if(i % 12 == 0 && i > 0) {
						cHtml += "<br>";
					}
					cHtml += '<a href="javascript:void(0)" class="mr10" data-conditionValue="'+n.id+'">'+n.sqName+'</a>';
				});
				$("#sQqdt").html(cHtml);
					$("#dtsSq a").click(function(){
					$("#dtsSq a").removeClass("active");
					$(this).addClass("active");
				});
		    }
		});
		
	}
	
};
function getSyscsOPTIONdt(sid ,buildDIV,typeName){
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

function getXianLu(){
	$.ajax({ 
		url: basePath+"/newenv/lpzd/fanghaogetXianLu.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"cid" : cityId,"sid":362},
		success: function(data){
			var cHtml = '<a href="javascript:void(0)" class="mr10 active" data-conditionValue="0">不限</a>';
			$.each(data, function(i,n){
				cHtml += '<a href="javascript:void(0)" class="mr10" data-conditionValue="'+n.xianID+'">'+n.xianLuName+'</a>';
			});
			$("#dtxianLu").html(cHtml);
	    }
	});
	
}


function queryDatadt(obj){
	var shi;
	var mainji;
	var yongtou=0;
	 var fwzt=-1;//房屋现状
	var xianluid = $("#dtxianLu a.active").attr("data-conditionValue") == null ? 0 : $("#dtxianLu a.active").attr("data-conditionValue");
	var dtsjl = $("#dtsjl a.active").attr("data-conditionValue") == null ? 0 : $("#dtsjl a.active").attr("data-conditionValue");
	var stressId = $("#dtsQy a.active").attr("data-conditionValue") == null ? 0 : $("#dtsQy a.active").attr("data-conditionValue");
	var sqId = $("#dtsSq a.active").attr("data-conditionValue") == null ? 0 : $("#dtsSq a.active").attr("data-conditionValue");
	var chaoxiang=$("#dtsCx").val()==null ? 0 :$("#dtsCx").val();
	var startmj =$("#startmjdt").val();
	var endmj =$("#endmjdt").val();
	var zxcd=$("#dtsZx").val()==null ? 0 :$("#dtsZx").val();
	var fwjg=$("#dtsFwjg").val()==null ? 0 :$("#dtsFwjg").val();
	var sHxS  =$("#dtsHxS").val();
	var sHxT  =$("#dtsHxT").val();
	var sHxW  =$("#dtsHxW").val();
	 if($("#dtfwxz").val()!=null&&$("#dtfwxz").val()!=''){
			fwzt=$("#dtfwxz").val();
		}
	if($("#dtsHxS").val()!=null&&$("#dtsHxS").val()!=''){
		shi=$("#dtsHxS").val();

	}else{
		shi =  $("#dtsHx a.active").attr("data-conditionValue") == null ? 0 : $("#dtsHx a.active").attr("data-conditionValue");
	}
	if(startmj!=null&&startmj!=''||endmj!=null&&endmj!=''){
		mianji=startmj+"-"+endmj;
	}else{
		mianji = $("#dtsMj a.active").attr("data-conditionValue") == null||$("#dtsMj a.active").attr("data-conditionValue")==0 ? -1 : $("#dtsMj a.active").attr("data-conditionValue");
	}
	if($("#dtsYt").val()!=null&&$("#dtsYt").val()!=''){
		yongtou=$("#dtsYt").val();
	}else{
		if(obj!=null&&obj!=''){
			yongtou=obj;
		}
		
		
	}
    var url = basePath+"/newenv/lpzd/fanghaoXhjLpfanghadt.action";
    $("#dtmacPageWidget").asynPage(url, "#dttbodyData", buildDataHtmldt, true, true, {
        'xhjLpfanghao.stressId': stressId,
        'xhjLpfanghao.chaoXiang':chaoxiang,
        'xhjLpfanghao.leixing':yongtou,
        'xhjLpfanghao.DecorationStandard':zxcd,
        'xhjLpfanghao.shi': shi,
        'xhjLpfanghao.distance':dtsjl,
        'xhjLpfanghao.xianluId':xianluid,
        'xhjLpfanghao.ting':sHxT,
        'xhjLpfanghao.wei': sHxW,
        'startmj':mianji,
        'xhjLpfanghao.fwzt':fwzt,
        'xhjLpfanghao.sqId':sqId,
        'xhjLpfanghao.buildingType':fwjg
    });
};




function buildDataHtmldt(list,records) {
	$("#fwtsdt").html("共 "+records+" 套")
	$("#dttbodyData").html("");
	var cHtml='';
    $.each(list, function (i, info) {
    	cHtml+='<tr>'
    	cHtml+='<td class="text-center"><input type="checkbox"  onclick="setSelectAll(this)" value="'+info.id+'" /></td>'
    	cHtml+='<td width="110" class="middle-top"><p><a href="'+basePath+'/newenv/lpzd/fanghaogetById.action?id='+info.id+'" >'
    	if(info.imagePath!=null&&info.imagePath!=''){
    		cHtml+='<img src="http://imgbms.xhjfw.com/'+info.imagePath+'" width="80" height="80">'
    	}else{
    		cHtml+='<img src="'+basePath+'/assets/images/hetong.jpg" width="80" height="80">'
    	}
    	cHtml+='</a><p><p>'+ info.number+ '</p></td>'
    	cHtml+='<td><h3><a href="'+basePath+'/newenv/lpzd/fanghaogetById.action?id='+info.id+'" >'+ info.lpName+  '</a> <span style="color:#666;font-size:14px;font-weight: bold; padding-top: 2px;">'+ info.leixingStr+ '</span></h3> <h6 style="color:#666;font-size:14px;font-weight: bold; padding-top: 2px;">'+info.lpdName+'&nbsp;&nbsp;&nbsp;&nbsp;'+info.dyName+'&nbsp;&nbsp;&nbsp;&nbsp;'+info.ceng+'层 '+info.fangHao+'&nbsp;&nbsp;&nbsp;&nbsp;</h6><h6>'+ info.shi+ '室&nbsp;&nbsp;&nbsp;'+ info.ting+ '厅 &nbsp;&nbsp;&nbsp;'+ info.tnmj+ '平米 &nbsp;&nbsp;&nbsp;'+ info.chaoXiangName+ '</h6><div>'
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
   			 cHtml += '<br><div style="height3px10px;"></div>';
			 }
   			cHtml+='<button class="btn btn-bqcolor2 btn-icon btn-icon-standalone btn-xs"><i class="fa-eyedropper"></i><span>'+info+'</span></button>'
   			j++;
   		 });
   	}
    	if(info.isHaving!=null&&info.isHaving!=''){
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
    	cHtml+='<td class="text-center"><a href="'+basePath+'/newenv/lpzd/fanghaogetById.action?id='+info.id+'"  class="btn btn-blue"><i class="fa-file-text"></i> 查看详情 <a></td>'
    	cHtml+='</tr>'
       
    });
    $("#dttbodyData").html(cHtml);
};
