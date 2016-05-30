/*

   对输入进行验证,现有功能包括验证是否有输入(validateRequired)、输入的长度(validateMaxLength)、短信的长度(validateSmsLength)、两次输入是否相等(validateEqual)，
   输入是否为数字(validateDigits)、整数(validateInt)、浮点数(validateFloat)、手机号码(validateMobile)、电话号码(validateTelephone)、EMAIL(validateEMail)、日期(validateDate)等。
   提供两种函数形式：
   1. Validator.validateXXX(obj,label,required)
   	判断obj的输入是否合法,label是obj的文本标签字符,在输入不合法时会使用label输出提示信息,并聚集到obj.
   	参数required是可选的,用于标识是否需要验证obj中必须有输入.如果调用时不带此参数或此参数为false,则不进行此项验证.
   	验证通过返回true,未通过返回false
	eg: Validator.validateEmail(document.form.EMail,"邮件地址",true)

   2. Validator.isXXX(value)
	判断参数value是否为有效值.
	验证通过返回true,未通过返回false
	eg: Validator.isEMail("ss@mail.com")
	
	(提供Validator.validateForm方法可依据传入的验证配置参数信息对表单进行验证)
	
   @author	chenky
*/

var Validator = {};


//-------------------------------------------------------------------------------------
//验证是否有输入
Validator.validateRequired = function(obj,lb){
	if(obj.value.trim().length<=0){
		alert(lb+"不能为空!");
		obj.focus();
		return false;
	}
	return true;
}

//-------------------------------------------------------------------------------------
//验证输入是否在限定范围内
Validator.validateMaxLength = function(obj,lb,maxLength,required){
	if(required) {
		if(!this.validateRequired(obj,lb)) {
			return false;
		}
	}

	var str = obj.value;
    var l = str.length;

    if(maxLength < l){
    	alert(lb+"输入长度不能超过"+maxLength+"个字");
        obj.focus();
        return false;
    }
	return true;
}

//验证输入是否在限定范围内 -- 中英文都算一个字节
Validator.validateMax1Length = function(obj,lb,maxLength,required){
	if(required) {
		if(!this.validateRequired(obj,lb)) {
			return false;
		}
	}
	var l = 0;
	var str = obj.value;
    for(var i=0;i<str.length;i++){
        if((str.charAt(i)>='!'&&str.charAt(i)<='~')||(str.charAt(i) ==' '))
            l ++;
        else
            l +=2;
    }
    if(maxLength < l){
    	alert(lb+"输入长度不能超过"+maxLength+"字节(汉字2个字节)");
        obj.focus();
        return false;
    }
	return true;
}

Validator.validateFixedLength = function(obj,lb,fixedLength,required){
	var str = obj.value;
    
    if(fixedLength != str.length){
    	alert(lb+"必须是"+fixedLength+"位.");
        obj.focus();
        return false;
    }
	return true;
}

//-------------------------------------------------------------------------------------
//验证两个输入框的输入是否相等
Validator.validateEqual = function(obj1,obj2,lb,required){
	if(required){
		if(!this.validateRequired(obj1,lb)){
			return false;
		}
	}
	if(obj1.value!=obj2.value){
		alert("两次"+lb+"输入不一致!");
		obj1.focus();
		return false;
	}
	return true;
}

//-------------------------------------------------------------------------------------
//验证obj1的输入是否在maxLength限定范围内,如果未超过限制,则在obj2显示还可输入的字数(以字符计数).
Validator.validateSmsLength = function(obj1,obj2,lb,maxLength,required){
	if(required){
		if(!this.validateRequired(obj1,lb)){
			return false;
		}
	}
	var str = obj1.value;
	var strlen=str.length;
	if(strlen<=maxLength){
		obj2.value = maxLength-strlen;
		return true;
	}else{
		obj2.value = "0";
		alert(lb+"已超过"+maxLength+"个字");
		obj1.value = str.substring(0,maxLength);
		obj1.focus();
		return false;
	}
}

//-------------------------------------------------------------------------------------
//验证obj1的输入是否在maxLength限定范围内,如果未超过限制,则在obj2显示还可输入的字数(以字节计数).
Validator.validateTextLength = function(obj1,obj2,lb,maxLength,required){
	if(required){
		if(!this.validateRequired(obj1,lb)){
			return false;
		}
	}
	var str = obj1.value;
	var strlen = 0;
    var overPosition = -1; //记录超出字节长度时的位置	modified by 郭雷
    for(var i=0;i<str.length;i++){
        if((str.charAt(i)>='!'&&str.charAt(i)<='~')||(str.charAt(i) ==' '))
            strlen ++;
        else
            strlen +=2;
            
        if (strlen>maxLength && overPosition == -1) {
           overPosition = i;
        }              
    }
	if(strlen<=maxLength){
		obj2.value = maxLength-strlen;
		return true;
	}else{
		obj2.value = "0";
		alert(lb+"已超过"+maxLength+"个字节");
		//obj1.value = str.msubstr(0,maxLength);
		obj1.value = str.substring(0,overPosition);
		obj1.focus();
		return false;
	}
}

//-------------------------------------------------------------------------------------
//验证是否为数字
Validator.validateDigits = function(obj,lb,required){
	if(required){
		if(!this.validateRequired(obj,lb)){
			return false;
		}
	}
	if(!this.isAllDigits(obj.value)){
		alert(lb+"只能输入数字!");
		obj.focus();
		return false;
	}
	return true;
}

//验证是否为数字
Validator.isAllDigits = function(argvalue) {
    argvalue = argvalue.toString();
    var validChars = "0123456789";
    var startFrom = 0;
    if (argvalue.charAt(0) == "-") {
        startFrom = 1;
    }
    
    for (var n = startFrom; n < argvalue.length; n++) {
        if (validChars.indexOf(argvalue.substring(n, n+1)) == -1) return false;
    }
    return true;
}

//-------------------------------------------------------------------------------------

//验证是否为整数
Validator.validateInt = function(obj,lb,required,maxLength){
	if(required){
		if(!this.validateRequired(obj,lb)){
			return false;
		}
	}
	if(maxLength){
		if(!this.validateMaxLength(obj,lb,maxLength)){
			return false;
		}
	}
	if(!this.isInt(obj.value)){
		alert(lb+"只能输入整数!");
		obj.focus();
		return false;
	}
	return true;
}

//验证最小值
Validator.validateMinValue = function(obj,lb,required,maxLength){
	if(required){
		if(!this.validateRequired(obj,lb)){
			return false;
		}
	}
	if(maxLength){
		if(!this.validateMaxLength(obj,lb,maxLength)){
			return false;
		}
	}
	if(!this.isInt(obj.value)){
		alert(lb+"只能输入整数!");
		obj.focus();
		return false;
	}
	return true;
}

//-------------------------------------------------------------------------------------
//验证是否为浮点数
Validator.validateFloat = function(obj,lb,required){
	if(required){
		if(!this.validateRequired(obj,lb)){
			return false;
		}
	}
	if(!this.isFloat(obj.value)){
		alert(lb+"只能输入浮点数!");
		obj.focus();
		return false;
	}
	return true;
}

//验证是否为浮点数
Validator.isFloat = function(value){
	var bValid = true;
	if (value.length > 0) {
        // remove '.' before checking digits
        var tempArray = value.split('.');
        var joinedString= tempArray.join('');

        if (!this.isAllDigits(joinedString)) {
            bValid = false;
        } else {
            var iValue = parseFloat(value);
            if (isNaN(iValue)) {
                bValid = false;
            }
        }
    }
    return bValid;
}

//-------------------------------------------------------------------------------------
//验证最小值
Validator.validateMinValue = function(obj,lb,minValue){
	if(!this.isFloat(obj.value)){
		alert(lb+"只能输入数字!");
		obj.focus();
		return false;
	} else {
		var fValue = parseFloat(obj.value);
		if(fValue<minValue){
			alert(lb+"不能小于" + minValue);
			obj.focus();
			return false;
		}
	}
	return true;
}

//-------------------------------------------------------------------------------------
//验证最大值
Validator.validateMaxValue = function(obj,lb,maxValue){
	if(!this.isFloat(obj.value)){
		alert(lb+"只能输入数字!");
		obj.focus();
		return false;
	} else {
		var fValue = parseFloat(obj.value);
		if(fValue>maxValue){
			alert(lb+"不能大于" + maxValue);
			obj.focus();
			return false;
		}
	}
	return true;
}

//验证是否为浮点数
Validator.isFloat = function(value){
	var bValid = true;
	if (value.length > 0) {
      // remove '.' before checking digits
      var tempArray = value.split('.');
      var joinedString= tempArray.join('');

      if (!this.isAllDigits(joinedString)) {
          bValid = false;
      } else {
          var iValue = parseFloat(value);
          if (isNaN(iValue)) {
              bValid = false;
          }
      }
  }
  return bValid;
}


//验证是否为整数
Validator.isInt = function(value){
	var bValid = true;
	if (value.length > 0) {         
      if (!this.isAllDigits(value)) {
          bValid = false;
      } else {
          var iValue = parseInt(value);
          if (isNaN(iValue) || !(iValue >= -2147483648 && iValue <= 2147483647)) {
              bValid = false;
         }
     }
 }
 return bValid;
}

//-------------------------------------------------------------------------------------
//验证是否为有效手机号码
Validator.validateMobile = function(obj,lb,required){
	if(required){
		if(!this.validateRequired(obj,lb)){
			return false;
		}
	}
	if(!this.isMobile(obj.value)){
		alert(lb+"输入了无效的手机号码!\n请输入在本平台号段范围内的有效号码!");
		obj.focus();
		return false;
	}
	return true;
}

//验证是否为有效手机号码
Validator.isMobile = function(mobile){
	if (mobile.length == 0) {
        return true;
    }
	if( mobile.length!=11 ) {
		return false;
	}
	if(!this.isAllDigits(mobile)){
		return false;
	}
	var char1 = mobile.charAt(0);
    var char2 = mobile.charAt(1);   
	if(char1 != '1' || char2 != '3' && char2 != '5'){
        return false;
    }
	return true;
}


//-------------------------------------------------------------------------------------
//验证是否为有效电话号码
Validator.validateTelephone = function(obj,lb,required){
	if(required){
		if(!this.validateRequired(obj,lb)){
			return false;
		}
	}
	if(!this.isTelephone(obj.value)){
		alert(lb+"输入了无效的号码!");
		obj.focus();
		return false;
	}
	return true;
}

//验证是否为有效电话号码
Validator.isTelephone = function(tValue){
    if (tValue == "") {
        return true;
    }

    //判断长度不能小于3
	if(tValue.length < 5) {
		return false;
	}
	//判断全是连续数字
	var NUM=new String("0123456789-");
	for(var I=0;I<tValue.length;I++){
		if(NUM.indexOf(tValue.charAt(I))<0){
			return false;
		}
	}
	return true;
}

//-------------------------------------------------------------------------------------
//验证是否为合法的java变量名
Validator.validateVariable = function(obj,lb,required){
	if(required){
		if(!this.validateRequired(obj,lb)){
			return false;
		}
	}

    if(!this.isValiableVariable(obj.value)){
		alert(lb+"输入有误，不能输入汉字及特殊字符!");
		obj.focus();
		return false;
	}
	return true;
}

Validator.isValiableVariable = function(sVar){
	var varPat=new RegExp("^[a-zA-Z_][a-zA-Z0-9_.]*$");
    var matchArray=sVar.match(varPat);
    if (matchArray==null) {
        return false;
    }else{
    	return true;
    }
}

//-------------------------------------------------------------------------------------

//验证是否为有效邮件地址
Validator.validateEMail = function(obj,lb,required){
	if(required){
		if(!this.validateRequired(obj,lb)){
			return false;
		}
	}

    if(!this.isEMail(obj.value)){
		alert(lb+"不是有效的邮件地址!");
		obj.focus();
		return false;
	}
	return true;
}

Validator.isEMail = function(emailStr){
    if (emailStr.length == 0) {
        return true;
    }
    // TLD checking turned off by default
    var checkTLD=0;
    var knownDomsPat=/^(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum)$/;
    var emailPat=/^(.+)@(.+)$/;
    var specialChars="\\(\\)><@,;:\\\\\\\"\\.\\[\\]";
    var validChars="\[^\\s" + specialChars + "\]";
    var quotedUser="(\"[^\"]*\")";
    var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;
    var atom=validChars + '+';
    var word="(" + atom + "|" + quotedUser + ")";
    var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
    var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$");
    var matchArray=emailStr.match(emailPat);
    if (matchArray==null) {
        return false;
    }
    var user=matchArray[1];
    var domain=matchArray[2];
    for (var i=0; i<user.length; i++) {
        if (user.charCodeAt(i)>127) {
            return false;
        }
    }
    for (var i=0; i<domain.length; i++) {
        if (domain.charCodeAt(i)>127) {
            return false;
        }
    }
    if (user.match(userPat)==null) {
        return false;
    }
    var IPArray=domain.match(ipDomainPat);
    if (IPArray!=null) {
        for (var i=1;i<=4;i++) {
            if (IPArray[i]>255) {
                return false;
            }
        }
        return true;
    }
    var atomPat=new RegExp("^" + atom + "$");
    var domArr=domain.split(".");
    var len=domArr.length;
    for (var i=0;i<len;i++) {
        if (domArr[i].search(atomPat)==-1) {
            return false;
        }
    }
    if (checkTLD && domArr[domArr.length-1].length!=2 && 
        domArr[domArr.length-1].search(knownDomsPat)==-1) {
        return false;
    }

    return len >= 2;
}

//-------------------------------------------------------------------------------------
//验证是否为有效日期格式(yyyy-MM-dd)
Validator.validateDate = function(obj,lb,required){
	if(required){
		if(!Validator.validateRequired(obj,lb)){
			return false;
		}
	}
	if(!Validator.isDate(obj.value)){
		alert(lb+"输入了无误的日期!");
		obj.focus();
		return false;
	}
	return true;
}

//验证是否为有效日期格式(yyyy-MM-dd)
Validator.isDate = function(strDate){
	   if(strDate=="") return true;
	   var strSeparator = "-"; //日期分隔符
	   var strDateArray;
	   var intYear;
	   var intMonth;
	   var intDay;
	   var boolLeapYear;
	   
	   strDateArray = strDate.split(strSeparator);
	   
	   if(strDateArray.length!=3) return false;
	   
	   intYear = parseInt(strDateArray[0],10);
	   intMonth = parseInt(strDateArray[1],10);
	   intDay = parseInt(strDateArray[2],10);
	   
	   if(isNaN(intYear)||isNaN(intMonth)||isNaN(intDay)) return false;
	   
	   if(intMonth>12||intMonth<1) return false;
	   
	   if((intMonth==1||intMonth==3||intMonth==5||intMonth==7||intMonth==8||intMonth==10||intMonth==12)&&(intDay>31||intDay<1)) return false;
	   
	   if((intMonth==4||intMonth==6||intMonth==9||intMonth==11)&&(intDay>30||intDay<1)) return false;
	   
	   if(intMonth==2){
	      if(intDay<1) return false;
	      
	      boolLeapYear = false;
	      if((intYear%100)==0){
	         if((intYear%400)==0) boolLeapYear = true;
	      }
	      else{
	         if((intYear%4)==0) boolLeapYear = true;
	      }
	      
	      if(boolLeapYear){
	         if(intDay>29) return false;
	      }
	      else{
	         if(intDay>28) return false;
	      }
	   }
	   return true;
}
 
//验证的配置参数.
Validator.validateParams = null;

/**
 * 对form进行验证,验证时参考params参数。
 * @form   要验证的form
 * @params 两维数组，可选参数,若未提供则找Validator.validateParams变量的值.格式如：
 * new Array(
 *		new Array(objName,label,validators),
 *		......
 *	);
 * eg.
 * new Array(
 *		new Array("unitId","组织编号","required"),
 *		new Array("unitName","组织名称","required,maxlength|50"),
 *		new Array("unitLevel","组织级别","required,int"),
 *		new Array("mobile","手机号码","mobile")
 *		new Array("message,self1","信息内容","smslength|70")
 *		new Array("password,password2","用户密码","required,equal")
 *	);
 *
 */
Validator.validateForm = function(form,params){
	if(params==undefined){
		params = this.validateParams;
	}
	if(params==null)return true;
	
	var validators = null;
	for(var i=0;i<params.length;i++){
		try{
			validators = params[i][2].split(",");
			for(var j=0;j<validators.length;j++){
				if(validators[j]=="required"){
					if(!this.validateRequired(form[params[i][0].split(",")[0]],params[i][1])){
						return false;
					}
				}else if(validators[j]=="mobile"){
					if(!this.validateMobile(form[params[i][0]],params[i][1])){
						return false;
					}
				}else if(validators[j]=="telephone"){
					if(!this.validateTelephone(form[params[i][0]],params[i][1])){
						return false;
					}
				}else if(validators[j]=="email"){
					if(!this.validateEMail(form[params[i][0]],params[i][1])){
						return false;
					}
				}else if(validators[j]=="equal"){
					try{
						var objs = params[i][0].split(",");
						if(!this.validateEqual(form[objs[0]],form[objs[1]],params[i][1])){
							return false;
						}
					}catch(e){
						alert(params[i][1]+"的验证参数不正确!");
					}
				}else if(validators[j]=="digits"){
					if(!this.validateDigits(form[params[i][0]],params[i][1])){
						return false;
					}
				}else if(validators[j]=="int"){
					if(!this.validateInt(form[params[i][0]],params[i][1])){
						return false;
					}
				}else if(validators[j]=="float"){
					if(!this.validateFloat(form[params[i][0]],params[i][1])){
						return false;
					}
				}else if(validators[j].indexOf("maxlength")>-1){
					try{
						if(!this.validateMaxLength(form[params[i][0]],params[i][1],validators[j].split("|")[1])){
							return false;
						}
					}catch(e){
						alert(params[i][1]+"的验证参数不正确!");
					}
				}else if(validators[j].indexOf("max1length")>-1){
					try{
						if(!this.validateMax1Length(form[params[i][0]],params[i][1],validators[j].split("|")[1])){
							return false;
						}
					}catch(e){
						alert(params[i][1]+"的验证参数不正确!");
					}
				}else if(validators[j].indexOf("min")>-1){
					try{
						if(!this.validateMinValue(form[params[i][0]],params[i][1],validators[j].split("|")[1])){
							return false;
						}
					}catch(e){
						alert(params[i][1]+"的验证参数不正确!");
					}
				}else if(validators[j].indexOf("max")>-1){
					try{
						if(!this.validateMaxValue(form[params[i][0]],params[i][1],validators[j].split("|")[1])){
							return false;
						}
					}catch(e){
						alert(params[i][1]+"的验证参数不正确!");
					}
				}else if(validators[j]=="date"){
					if(!this.validateDate(form[params[i][0]],params[i][1])){
						return false;
					}
				}else if(validators[j]=="var"){
					if(!this.validateVariable(form[params[i][0]],params[i][1])){
						return false;
					}
				} else if (validators[j].indexOf("fixedlength")>-1) {
	               	try{
						if(!this.validateFixedLength(form[params[i][0]],params[i][1],validators[j].split("|")[1])){
							return false;
						}
					}catch(e){
						alert(params[i][1]+"的验证参数不正确!");
					}
	            }
			}
		}catch(e){
			alert("验证" + params[i][0] + "出错: " + e);
			return false;
		}
	}
	return true;
}

//-------------------------------------------------------------------------------------
/**
 * 使用方法：
 * var s = "  fd fds ";
 * var st = s.trim();
 */
String.prototype.trim = function() {
    return this.replace( /^\s*/, "" ).replace( /\s*$/, "" );
}

var Global_XMLHttpReq = false;
var Global_Var = 0;
var Global_Id = 0;


function createXMLHttpRequest() {
	if(window.XMLHttpRequest) { 
		Global_XMLHttpReq = new XMLHttpRequest();
	}
	else if (window.ActiveXObject) {
		try {
			Global_XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				Global_XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {}
		}
	}
}
//字符串截取函数,可以解决中文字符的问题
function msubstr(str, len) {
   if(!str || !len) 
      { return ''; }     
   //预期计数：中文2字节，英文1字节
   var a = 0;     
   //循环计数     
   var i = 0;     
   //临时字串     
   var temp = '';      
   for(i=0;i<str.length;i++){
       if (str.charCodeAt(i)>255)
       {             
       //按照预期计数增加2             
           a+=2;         
       }         
       else         
       {             
       a++;         
       }        
       //如果增加计数后长度大于限定长度，就直接返回临时字符串         
       if(a > len) { return temp; }          //将当前内容加到临时字符串         
       temp += str.charAt(i);     
   }//如果全部是单字节字符，就直接返回源字符串     
  return str; 
} 