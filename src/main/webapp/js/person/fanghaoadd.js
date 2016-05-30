$(document).ready(function(){
	getSyscsTypeCheck("房屋朝向","chaoXiang");
	//getSyscsOPTIONCheck(12,"chaoXiang");
	getSyscsTypeCheck("房屋用途","leixing");
	getSyscsTypeCheck("国籍","nationality");
	getSyscsTypeCheck("消费观念","consumptionConcept");
	getSyscsTypeCheck("产权年限","propertyAg");
	getSyscsTypeCheck("教育程度","education");
	getSyscsTypeCheck("工作性质","workType")
	getSyscsTypeCheck("权属性质","cqxz")
	getCityIdOPTIONCheck("","cityId");
	if(action=="update"){
		getBYLDong($("#fanghaolpid").val()) ;
		getBYdzId(dzid);
		getBYceng(dyid);
		getBYfangHao(ceng);
		fanghaoImg();
		persoImg();
		communicators();
	}else if(action=="save"){
		getSyscsTypeCheck("业主关系","relationType0");
	}
	
});
function  saveFanghao(){
	$('.onsubing').css("display","block");//弹出提示框
	$("#btnSavefanghao").attr("disabled",true);
	jQuery.ajax({
		url: basepath + "/personInfo!saveFanghao.action",
		dataType: "json",
		data: $('#fanghaoForm').serialize(), 
		type: "POST",
		async :false,
		beforeSend: function(){
			//在异步提交前要做的操作
			return fanghaoCheck();
		},
		success: function(result){
			if(result.data == "success") {
				//在异步提交成功后要做的操作
				bootbox.confirm({title:"提示",message:"保存成功",callback:function(result){
				    if(result){//判断是否点击了确定按钮
				    	window.location.href=basepath+"/person/personInfo!queryByLFId.action?lfid="+$("#fangHao").val();
				    }
				}});
				$('.onsubing').css("display","none");//弹出提示框
			} else {
				$("#btnSavefanghao").removeAttr("disabled");
				$('.onsubing').css("display","none");//弹出提示框
				return false;
			}
		}
	});
}
//房号保存校验
function fanghaoCheck(){
	var lpName = $("#lpName").val().replace(/\s+/g,"");
	if(lpName == null || lpName == "") {
		$('.onsubing').css("display","none");//弹出提示框
		$("#btnSavefanghao").removeAttr("disabled");
		bootbox.alert({title:"提示",message:"请输入楼盘名称!"});
		return false;
	}
	var LDong = $("#LDong").val();
	if(LDong == null || LDong == "" || LDong==0) {
		$('.onsubing').css("display","none");//弹出提示框
		$("#btnSavefanghao").removeAttr("disabled");
		bootbox.alert({title:"提示",message:"请选择楼盘栋座!"});
		return false;
	}
	var dyId = $("#dyId").val();
	if(dyId == null || dyId == "" || dyId ==0) {
		$('.onsubing').css("display","none");//弹出提示框
		$("#btnSavefanghao").removeAttr("disabled");
		bootbox.alert({title:"提示",message:"请选择楼盘单元!"});
		return false;
	}
	var ceng = $("#ceng").val();
	if(ceng == null || ceng == "" ||ceng==0) {
		$('.onsubing').css("display","none");//弹出提示框
		$("#btnSavefanghao").removeAttr("disabled");
		bootbox.alert({title:"提示",message:"请选择楼盘层!"});
		return false;
	}
	var fangHao = $("#fangHao").val();
	if(fangHao == null || fangHao == "" || fangHao==0) {
		$('.onsubing').css("display","none");//弹出提示框
		$("#btnSavefanghao").removeAttr("disabled");
		bootbox.alert({title:"提示",message:"请选择房号!"});
		return false;
	}
	var shi = $("#shi").val();
	if(shi == null || shi == "" || shi==0) {
		$('.onsubing').css("display","none");//弹出提示框
		$("#btnSavefanghao").removeAttr("disabled");
		bootbox.alert({title:"提示",message:"请选择户型!"});
		return false;
	}
	
	
	var yezhuname = $("#yezhuname").val().replace(/\s+/g,"");
	if(yezhuname == null || yezhuname == "") {
		$('.onsubing').css("display","none");//弹出提示框
		$("#btnSavefanghao").removeAttr("disabled");
		bootbox.alert({title:"提示",message:"请输入业主姓名!"});
		return false;
	}
	var telephone = $("#telephone").val().replace(/\s+/g,"");
	if(telephone == null || telephone == "" ) {
		$('.onsubing').css("display","none");//弹出提示框
		$("#btnSavefanghao").removeAttr("disabled");
		bootbox.alert({title:"提示",message:"请输入联系电话!"});
		return false;
	}else{
		if(checktel(telephone)){
			$('.onsubing').css("display","none");//弹出提示框
			$("#btnSavefanghao").removeAttr("disabled");
			bootbox.alert({title:"提示",message:"请输入正确的联系电话!"});
			return false;
		}
	}
	
	/*var weXin = $("#weXin").val().replace(/\s+/g,"");
	if(weXin == null || weXin == "") {
		bootbox.alert({title:"提示",message:"请输入业主姓名!"});
		return false;
	}
	*/
	
	var identityCode = $("#identityCode").val().replace(/\s+/g,"");
	if(identityCode!=null&&identityCode!=''){
		if(isCardNo(identityCode)) {
			$('.onsubing').css("display","none");//弹出提示框
			$("#btnSavefanghao").removeAttr("disabled");
			bootbox.alert({title:"提示",message:"请输入正确的身份证号码!"});
			return false;
		}
	}
	
	var email = $("#email").val().replace(/\s+/g,"");
	if(email!=null&&email!=''){
		if(emailCheck(email)) {
			$('.onsubing').css("display","none");//弹出提示框
			$("#btnSavefanghao").removeAttr("disabled");
			bootbox.alert({title:"提示",message:"请输入正确的电子邮箱!"});
			return false;
		}
	}
	
	var qq = $("#qq").val().replace(/\s+/g,"");
	if(qq!=null&&qq!=''){
		if(QqCheck(qq)) {
			$('.onsubing').css("display","none");//弹出提示框
			$("#btnSavefanghao").removeAttr("disabled");
			bootbox.alert({title:"提示",message:"请输入正确的QQ号码!"});
			return false;
		}
	}
	return  true;
	$('.onsubing').css("display","block");//弹出提示框
};



//栋座
function getBYLDong(lpid){
	if(lpid!=null&&lpid!=''){
		$.ajax({
			url: basepath+"/newenv/lpzd/fanghaogetBYLpId.action",
		dataType: "json",
		type: "GET",	
		contentType: "application/json; charset=utf-8",
		data:{"lpid":lpid},
		success: function(data){
			var sHtml ='<option  value="0">请选择</option>';
		$.each(data, function(i,info){
			if($("#LDong").attr("data-value") == info[0]) {
				sHtml += '<option value="'+info[0]+'" selected="selected">'+info[1]+'</option>';
			}else{
				sHtml += '<option   value="'+info[0]+'">'+info[1]+'</option>';
			}
					
				});
				$("#LDong").html(sHtml);
		}

});
	}else{
		
		$("#LDong").html("");
		$("#dyId").html("");
		$("#ceng").html("");
		$("#fangHao").html("");
	}
}

//单元
function getBYdzId(dzId){
	var dzid;
	if(dzId.value!=null&&dzId.value!=''&&dzId.value!='0'){
		dzid=dzId.value;
	}else{
		dzid=dzId;
	}
	if(dzid!=null&&dzid!=''&&dzid!='0'){
		$.ajax({
			url: basepath+"/newenv/lpzd/fanghaogetBYdzId.action",
		dataType: "json",
		type: "GET",	
		contentType: "application/json; charset=utf-8",
		data:{"dzId":dzid},
		success: function(data){
			var sHtml ='<option  value="0">请选择</option>';
				$.each(data, function(i,info){
					if($("#dyId").attr("data-value") == info[0]) {
						sHtml += '<option value="'+info[0]+'" selected="selected">'+info[1]+'</option>';
					}else{
						sHtml += '<option   value="'+info[0]+'">'+info[1]+'</option>';
					}
				});
				$("#dyId").html(sHtml);
		}

});
		
	}else{
		$("#dyId").html("");
		$("#ceng").html("");
		$("#fangHao").html("");
	}
	
}


//层
function getBYceng(dyId){
	var dyid;
	if(dyId.value!=null&&dyId.value!=''&&dyId.value!='0'){
		dyid=dyId.value;
	}else{
		dyid=dyId;
	}
	if(dyid!=null&&dyid!=''&&dyid!='0'){
		$.ajax({
			url: basepath + "/cam/campus!showCeng.action",
			dataType: "json", 
			type: "POST",
			async:false,
			data: {"dyId":dyid},
			success: function(data){
			var sHtml ='<option  value="0">请选择</option>';
			$.each(data, function(i,info){
				if($("#ceng").attr("data-value") == info.ceng) {
					sHtml += '<option value="'+info.ceng+'" selected="selected">'+info.ceng+'</option>';
				}else{
					sHtml += '<option   value="'+info.ceng+'">'+info.ceng+'</option>';
				}
				
				});
				$("#ceng").html(sHtml);
		}

});
		
	}else{
		$("#ceng").html("");
		$("#fangHao").html("");
	}
	
}

//房号
function getBYfangHao(ceng){
	var cengfanghao;
	if(ceng.value!=null&&ceng.value!=''&&ceng.value!='0'){
		cengfanghao=ceng.value;
	}else{
		cengfanghao=ceng;
	}
	var dyId=$("#dyId").val();
	if(action=="update"){
		dyId=dyid;
	}
	if(cengfanghao!=null&&cengfanghao!=''&&cengfanghao!='0'){
		$.ajax({
			url : basepath + "/cam/campus!showFanghaoOfDanyuan.action",
			dataType: "json", 
			type: "POST",
			async:false,
			data : {
				"dyId" : dyId,
				"ceng" : cengfanghao
			},
			success: function(data){
			var sHtml ='<option  value="">请选择</option>';
			$.each(data, function(i,info){
				if($("#fangHao").attr("data-value") == info.id) {
					sHtml += '<option value="'+info.id+'" selected="selected">'+info.fhName+'</option>';
				}else{
					sHtml += '<option   value="'+info.id+'">'+info.fhName+'</option>';
				}
				});
				$("#fangHao").html(sHtml);
		}

});
		
	}else{
		$("#fangHao").html("");
	}
	
}


function fanghaoImg(){
	$.ajax({
		url: basepath + "/personInfo!fanghaotp.action",
		dataType: "json", 
		type: "POST",
		data : {"fanghaoId" : $("#fangHao").attr("data-value")},
		success: function(result){
			var theForm = $("#fanghaoForm #webImageofhouse_image_hidden");
			if(result !=null && result.length>0){
				$.each(result,function(i,item){
					//设置全局下标
					
					var $imgContainer = $("#ulHouseExclusiveFiles0 .panel-body");
			       	
			       
			       	var sHtml = ' <div class="album-image col-lg-3"><img id="file-'+item.id+'" src="http://imgbms.xhjfw.com/'+item.imgPath+'@200w_150h"  width="200" height="150" class="img-thumbnail"></div>';
			       	
			       	var _sHtml = '<input type="hidden" id="txtExclusiveImgFileName' + houseExclusiveImgIndex
									+ '" name="fanghaoImg['+houseExclusiveImgIndex+'].imgPath" value="'
									+ item.imgPath + '"/><input type="hidden" id="txtExclusiveImgIndex'+houseExclusiveImgIndex+'" name="fanghaoImg['+houseExclusiveImgIndex+'].statuss" value="'+item.statuss+'">'
									+ '<input type="hidden" id="txtExclusiveImgType' + houseExclusiveImgIndex
									+ '" name="fanghaoImg['+houseExclusiveImgIndex+'].type" value="'+item.type+'"/>'
									+ '<input type="hidden" id="txtExclusiveImgorderBy' + houseExclusiveImgIndex
									+ '" name="fanghaoImg['+houseExclusiveImgIndex+'].orderBy" value="'+item.orderBy+'"/>';
						$imgContainer.append(sHtml);
						var theImageLi = $('#file-' + item.id).parent();
						theImageLi.append('<div class="text-center"><a href="javascript:void(0)" onclick="removeExclusiveImg('
								+ houseExclusiveImgIndex
								+ ',\''
								+ item.imgPath
								+ '\', this)">删除</a></div>');
						theForm.append(_sHtml);
			       	
					houseExclusiveImgIndex++;
				})
			}
		}
	});
}



function persoImg(){
	$.ajax({
		url: basepath + "/personInfo!persontp.action",
		dataType: "json", 
		type: "POST",
		data : {"personId" : $("#yzid").val()},
		success: function(result){
			var theForm = $("#fanghaoForm #webImageofhouse_image_hidden");
			if(result !=null && result.length>0){
				$.each(result,function(i,item){
					
					var $imgContainer = $("#ulHouseExclusiveFiles1 .panel-body");
			       	
			       
			       	var sHtml = ' <div class="album-image col-lg-3"><img id="file-'+item.id+'" src="http://imgbms.xhjfw.com/'+item.imagePath+'@200w_150h"  width="200" height="150" class="img-thumbnail"></div>';
			       	
			       	var _sHtml = '<input type="hidden" id="txtyzImgFileName' + houseyzeImgIndex
									+ '" name="imgs['+houseyzeImgIndex+'].imagePath" value="'
									+ item.imagePath + '"/><input type="hidden" id="txtIndex'+houseyzeImgIndex+'" name="imgs['+houseyzeImgIndex+'].statuss" value="'+item.statuss+'">'
									+ '<input type="hidden" id="txtType' + houseyzeImgIndex
									+ '" name="imgs['+houseyzeImgIndex+'].imageType" value="'+item.imageType+'"/>'
									+ '<input type="hidden" id="txtdisplayIndex' + houseyzeImgIndex
									+ '" name="imgs['+houseyzeImgIndex+'].displayIndex" value="'+item.displayIndex+'"/>';
						$imgContainer.append(sHtml);
						var theImageLi = $('#file-' + item.id).parent();
						theImageLi.append('<div class="text-center"><a href="javascript:void(0)" onclick="removeyzImg('
								+ houseyzeImgIndex
								+ ',\''
								+ item.imgPath
								+ '\', this)">删除</a></div>');
						theForm.append(_sHtml);
			       	
						houseyzeImgIndex++;
				})
			}
		}
	});
}
	



