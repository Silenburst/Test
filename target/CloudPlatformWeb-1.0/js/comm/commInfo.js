var shiObj = new Array();
var fenggeObj = new Array();
var tpDatas = [];
function getSyscsOPTION(sid ,buildDIV){
	$.ajax({ 
		url: basepath + "/cam/campus!getSyscs.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"sid" : sid},
		success: function(data){
			var cHtml = '<option value="0">请选择</option>';
			$.each(data, function(i,n){
				cHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#" + buildDIV).html(cHtml);
	    }
	});
};

function geSyscsRadio(sid, buildDIV, type, name, endHtml){
	$.ajax({ 
		url: basepath + "/cam/campus!getSyscs.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"sid": sid},
		success: function(data){
			var sHtml = '';
			$.each(data, function(i,n){
				if(i != 0 && i%10 == 0 && type == "checkbox"){
					sHtml += "<br>";
				}
				sHtml += '<label class="cbr-inline"><input type="' + type + '" name="' + name + '" value="' + n.id + '">' + n.name + '</label>';
			});
			$("#" + buildDIV).html(sHtml + endHtml);
    	}
		
	});
};

function getSyscsOPTIONCheck(sid ,buildDIV){
	$.ajax({ 
		url: basepath + "/cam/campus!getSyscs.action",
		dataType: "json", 
		type: "POST",
		data : {"sid" : sid},
		success: function(data){
			var cHtml = '<option value="0">请选择</option>';
			$.each(data, function(i,n){
				if($("#" + buildDIV).attr("data-value") == n.id) {
					cHtml += '<option value="'+n.id+'" selected="selected">'+n.name+'</option>';
				} else {
					cHtml += '<option value="'+n.id+'">'+n.name+'</option>';
				}
			});
			$("#" + buildDIV).html(cHtml);
	    }
	});
};

function geSyscsRadioCheck(sid, buildDIV, type, name, endHtml){
	var values = $("#" + buildDIV).attr("data-value");
	$.ajax({ 
		url: basepath + "/cam/campus!getSyscs.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"sid": sid},
		success: function(data){
			var sHtml = '';
			$.each(data, function(i,n){
				if(i != 0 && i%10 == 0 && type == "checkbox"){
					sHtml += "<br>";
				}
				if(values != null && values != "" && values.indexOf(n.id) > -1) {
					sHtml += '<label class="cbr-inline"><input type="' + type + '" name="' + name + '" value="' + n.id + '" checked>' + n.name + '</label>';
				} else {
					sHtml += '<label class="cbr-inline"><input type="' + type + '" name="' + name + '" value="' + n.id + '">' + n.name + '</label>';
				}
			});
			$("#" + buildDIV).html(sHtml + endHtml);
    	}
		
	});
};
//不可选
function geSyscsRadioDisabled(sid, buildDIV, type, name, endHtml){
	var values = $("#" + buildDIV).attr("data-value");
	$.ajax({ 
		url: basepath + "/cam/campus!getSyscs.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"sid": sid},
		success: function(data){
			var sHtml = '';
			$.each(data, function(i,n){
				if(i != 0 && i%10 == 0 && type == "checkbox"){
					sHtml += "<br>";
				}
				if(values != null && values != "" && values.indexOf(n.id) > -1) {
					sHtml += '<label class="cbr-inline"><input type="' + type + '" name="' + name + '" disabled value="' + n.id + '" checked>' + n.name + '</label>';
				} else {
					sHtml += '<label class="cbr-inline"><input type="' + type + '" name="' + name + '" disabled value="' + n.id + '">' + n.name + '</label>';
				}
			});
			$("#" + buildDIV).html(sHtml + endHtml);
    	}
		
	});
};


var home_slide_data="";
function  uphuandengpian(shi,fengge){
	shanchutp(tpDatas,shi,fengge);
	$("#huandengpian").modal('show');
}



function shanchutp(tpDatastp,shi,fengge){
	$('.Homeslide').homeslide("", true, 3000);
	$("#shitp").val(shi);
	$("#fenggetp").val(fengge);
	var json='[';
	$.each(tpDatastp,function(i,info){
		if(info.imgType==1){
			if(info.shi==shi){
				json+='{"url":"javascript:removeExclusiveImg('+i+',\''+info.img+'\',this,'+info.imgType+')","title": "删除","image":"http://imgbms.xhjfw.com/'+info.img+'@200w_150h","thumb":"http://imgbms.xhjfw.com/'+info.img+'@200w_150h","mark":"0"},';
			}
		}else if(info.imgType==4){
			if(info.fengge==fengge){
				json+='{"url":"javascript:removeExclusiveImg('+i+',\''+info.img+'\',this,'+info.imgType+')","title": "删除","image":"http://imgbms.xhjfw.com/'+info.img+'@200w_150h","thumb":"http://imgbms.xhjfw.com/'+info.img+'@200w_150h","mark":"0"},';
			}
		}
	});
	//json=json.substring(0, json.length-1);
	json +="]";
	var jsonStr=eval("("+json+")");
	$('.Homeslide').homeslide(jsonStr, true, 3000);
	return jsonStr;
}

function isChineseChar(str){   
	   var reg =/^[A-Za-z0-9_\u4E00-\u9FA5\uF900-\uFA2D]+$/;
	   if(!reg.test(str)){
			return true;
		}
		return false;
	}

function checkNumber(input){
	    var re =/^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/;   // 判断字符串是否为数字 //判断正整数 /^[1-9]+[0-9]*]*$/
	    if (!input.match(re)){
	    	 return true;
	    }
	    return false;
	}    	

function isCardNo(input)  
{  
   // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X  
   var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;  
   if(!input.match(reg))  
   {  
	   return true;
   }  
   return false;
} 
//验证邮箱
function emailCheck(input) { 
    var reg = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/; 
    if(!input.match(reg)){
        return true; 
    } 
    return false; 
}

//验证邮箱
function QqCheck(input) { 
	var reg =/^[1-9][0-9]{4,9}$/;
    if(!input.match(reg)){
        return true; 
    } 
    return false; 
}
//验证电话号码
function checktel(input){
	    	if (!telCheck(input)){
	    		return false;
	    	}
	    return true;
	}  


function telCheck(phone)
{
 with(document.forms[0]) 
 {
  var patten =/^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$/;
  var pat = /^(\b13[0-9]{9}\b)|(\b14[7-7]\d{8}\b)|(\b15[0-9]\d{8}\b)|(\b18[0-9]\d{8}\b)|(\b17[0-9]\d{8}\b)|\b1[1-9]{2,4}\b$/ ;
  var checkphone=phone.toString().split('-');
  if( checkphone.length>2)
    return true;
   if (phone !="" || phone.length!=0) 
{         
 if (phone.substr(0,3) == "+86") 
 {
          phone = phone.substr(3,phone.length);
   }
   if (phone.substr(0, 2) == "13"||phone.substr(0, 2) == "14" || phone.substr(0, 2) == "15" || phone.substr(0, 2) == "18"|| phone.substr(0, 2) == "17") {
          if(pat.test(phone))
          {            
            return false;
       }
       else 
       {
           return true;
       } 
   } 
   else
   {
     if(patten.test(phone)) 
     {
         return false;
     } 
     else 
     {
            return true;
        }
   }
  } 
  else
  {
      return true;
} 
}
}




function getCityIdOPTIONCheck(pid ,buildDIV){
	$.ajax({ 
		url: basepath+"/cam/campus!getCity.action",
		dataType: "json", 
		type: "POST",
		data : {"pid" : pid},
		success: function(data){
			var cHtml = '<option value="0">请选择</option>';
			$.each(data, function(i,n){
				if($("#" + buildDIV).attr("data-value") == n.id) {
					cHtml += '<option value="'+n.id+'" selected="selected">'+n.cityName+'</option>';
				} else {
					cHtml += '<option value="'+n.id+'">'+n.cityName+'</option>';
				}
			});
			$("#" + buildDIV).html(cHtml);
	    }
	});
};


function getSyscsTypeCheck(name ,id){
	var url = basepath + "/base/school!findBySType.action";
	$.ajax({
		url: url,
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"name" : name},
		success: function(data){
			var pHtml = '<option value="0">请选择</option>';
			$.each(data, function(i,n){
				if($("#" + id).attr("data-value") == n[0]) {
					pHtml += '<option value="'+n[0]+'" selected="selected">'+n[1]+'</option>';
				} else {
					pHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
				}
			});
			$("#"+id).html(pHtml);
	    }
	});
};


