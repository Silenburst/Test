function genjin(fhid){
	$("#fhid").val(fhid);
	$("#messages").val('');
	getSyscsTypeCheck("跟进类型","utpye");
	jQuery('#Genjin').modal('show');
}

function savelpUpdatingRecord(){
	$("#lpUpdatingRecordbtn").attr("disabled",true);
	jQuery.ajax({
		url: basepath + "/personInfo!savelpUpdateRecord.action",
		dataType: "json",
		data: $('#lpUpdatingRecordForm').serialize(), 
		type: "POST",
		async :false,
		success: function(result){
			if(result.data == "success") {
				//在异步提交成功后要做的操作
				bootbox.alert({title:"提示",message:"保存成功!"});
				queryData1($("#fhid").val());
				jQuery('#Genjin').modal('hide');
				//跳到下一步
			} else {
				alert(result.data);
				$("#lpUpdatingRecordbtn").removeAttr("disabled");
				return false;
			}
		}
	});
	
	$("#lpUpdatingRecordbtn").removeAttr("disabled");
	return false;
}

function Openmore(){
	  $("#openmore").toggle();
}

function deldiv(obj,val)
{
	$(obj).parent().remove();
}
var index=1;
function adddiv()
{
var aHtml = '<div class="input-group input-group-minimal" >';
aHtml+='<span class="input-group-addon red">联系电话：</span>';
aHtml+='<input type="text" class="form-control" name="contact['+index+'].telephone"/>';
aHtml+='<span class="input-group-addon" style="padding: 0;"></span>';
aHtml+=' <select class="form-control"  id="relationType'+index+'" name="contact['+index+'].relationType"   style="width: 80px">';
aHtml+='<option value="0">请选择</option> ';
aHtml+='</select> ';
aHtml+='<a href="javascript:void(0)" class="input-group-addon" onclick="deldiv(this)"><i class="fa-trash-o" ></i></a>';
aHtml+='</div>';
/*aHtml+='<p class="help-block red">系统查询到该联系方式下有3位经纪人维护<a href="#">查询</a></p>';*/
$("#addButton").append(aHtml);
getSyscsTypeCheck("业主关系","relationType"+index);
index++;
}

function communicators(){
	$.ajax({
		url: basepath + "/personInfo!communicators.action",
		dataType: "json", 
		type: "POST",
		data : {"personId" : $("#yzid").val()},
		success: function(result){
			var aHtml='';
			if(result !=null && result.length>0){
				$.each(result, function(i,n){
					if(i==0){
						aHtml+= '<div class="input-group input-group-minimal" >';
						aHtml+='<span class="input-group-addon red">联系电话：</span>';
						aHtml+='<input type="text" class="form-control" name="contact['+i+'].telephone" id="telephone" value="'+n.telephone+'"/>';
						aHtml+='<span class="input-group-addon" style="padding: 0;"></span>';
						aHtml+=' <select class="form-control"  id="relationType'+i+'" name="contact['+i+'].relationType"  data-value="'+n.relationType+'"  style="width: 80px">';
						aHtml+='<option value="0">请选择</option> ';
						aHtml+='</select> ';
						aHtml+='<span class="input-group-addon" onclick="adddiv()"><i class="fa-plus" ></i></span>';
						aHtml+='</div>';	
						aHtml+='<p class="help-block red">系统查询到该联系方式下有3位经纪人维护<a href="#">查询</a></p>';
						getSyscsOPTIONCheck(791,"relationType"+i);
						//getSyscsTypeCheck("业主关系","relationType"+i);
					}else{							
						aHtml+= '<div class="input-group input-group-minimal" >';
						aHtml+='<span class="input-group-addon red">联系电话：</span>';
						aHtml+='<input type="text" class="form-control" name="contact['+index+'].telephone" value="'+n.telephone+'"/>';
						aHtml+='<span class="input-group-addon" style="padding: 0;"></span>';
						aHtml+=' <select class="form-control"  id="relationType'+index+'" name="contact['+index+'].relationType"  data-value="'+n.relationType+'"  style="width: 80px">';
						aHtml+='<option value="0">请选择</option> ';
						aHtml+='</select> ';
						aHtml+='<a href="javascript:void(0)" class="input-group-addon" onclick="deldiv(this)"><i class="fa-trash-o" ></i></a>';
						aHtml+='</div>';
						getSyscsOPTIONCheck(791,"relationType"+index);
						//getSyscsTypeCheck("业主关系","relationType"+index);
						index++;
					}
					
					});
				$("#addButton").html(aHtml);
			}
			
			
		}
	});
}


function person(){
	getSyscsTypeCheck("国籍","yznationality");
	getSyscsTypeCheck("消费观念","consumptionConcept");
	getSyscsTypeCheck("教育程度","education");
	getSyscsTypeCheck("工作性质","workType")
	getCityIdOPTIONCheck("","cityId");
	jQuery('#Xinzeng').modal('show');
	communicators();
}

function saveyezhu(){
	$('.onsubing').css("display","block");//弹出提示框
	$("#personbtn").attr("disabled",true);
	jQuery.ajax({
		url: basepath + "/personInfo!savayezhu.action",
		dataType: "json",
		data: $('#yezhuForm').serialize(), 
		type: "POST",
		async :false,
		beforeSend: function(){
			//在异步提交前要做的操作
			return yezhuCheck();
		},
		success: function(result){
			if(result.data == "success") {
				$('.onsubing').css("display","none");//弹出提示框
				//在异步提交成功后要做的操作
				bootbox.alert({title:"提示",message:"保存成功!"});
				jQuery('#Xinzeng').modal('hide');
				//跳到下一步
			} else {
				$('.onsubing').css("display","none");//弹出提示框
				bootbox.alert({title:"提示",message:"保存失败!"+result.data});
				$("#personbtn").removeAttr("disabled");
				return false;
			}
		}
	});
	$('.onsubing').css("display","none");//弹出提示框
	$("#personbtn").removeAttr("disabled");
	return false;
}

function yezhuCheck(){
	
	var yezhuname = $("#yezhuname").val().replace(/\s+/g,"");
	if(yezhuname == null || yezhuname == "") {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入业主姓名!"});
		return false;
	}
	var telephone = $("#telephone").val().replace(/\s+/g,"");
	if(telephone == null || telephone == "" ) {
		$('.onsubing').css("display","none");//弹出提示框
		bootbox.alert({title:"提示",message:"请输入联系电话!"});
		return false;
	}else{
		if(checktel(telephone)){
			$('.onsubing').css("display","none");//弹出提示框
			bootbox.alert({title:"提示",message:"请输入正确的联系电话!"});
			return false;
		}
	}
	
	
	var identityCode = $("#yzidentityCode").val().replace(/\s+/g,"");
	if(identityCode!=null&&identityCode!=''){
		if(isCardNo(identityCode)) {
			$('.onsubing').css("display","none");//弹出提示框
			bootbox.alert({title:"提示",message:"请输入正确的身份证号码!"});
			return false;
		}
	}
	
	var email = $("#yzemail").val().replace(/\s+/g,"");
	if(email!=null&&email!=''){
		if(emailCheck(email)) {
			$('.onsubing').css("display","none");//弹出提示框
			bootbox.alert({title:"提示",message:"请输入正确的电子邮箱!"});
			return false;
		}
	}
	
	var qq = $("#yzqq").val().replace(/\s+/g,"");
	if(qq!=null&&qq!=''){
		if(QqCheck(qq)) {
			$('.onsubing').css("display","none");//弹出提示框
			bootbox.alert({title:"提示",message:"请输入正确的QQ号码!"});
			return false;
		}
	}
};

