<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
			UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
			
	String BMSPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/BMS";
	String id = request.getParameter("id");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>房源采集管理</title>
<script src="./common.js"></script>
<script src="../assets/js/jquery-1.11.1.min.js"></script>
</head>
<body class="page-body">

	<form id="frm" name="frm" method="POST" action="https://passport.58.com/dounionlogin" target="formSubmitFrame">
		<input type='hidden' id='username' name='username' value=''> 
		<input type='hidden' id='password' name='password' value=''> 
		<input id="isweak" type="hidden" value="0" name="isweak">
		<input id="p1" type="hidden" name="p1">
		<input id="p2" type="hidden" name="p2">
		<input id="p3" type="hidden" name="p3">
		<input id="timesign" type="hidden" name="timesign">
		<input id="ptk" type="hidden" value="c698467abb06494ea31d8badc603c82d" name="ptk">
		<input id="cd" type="hidden" value="1125" name="cd">
		<img name="vcodeImg" id="vcodeImg" onclick="this.src='http://passport.58.com/validatecode?temp=123'+ (new Date().getTime().toString(36)); return false;"
			style="cursor: pointer; height: 32px;" src="http://passport.58.com/validatecode">
		<input type="text" size="5" name="validatecode" onkeydown="javascript:if(event.keyCode==13){login();}">
		<input type="button" value="登录" onclick="login();">
	</form>
	<iframe style="visibility: hidden; height: 0px; width: 0px;" src="https://passport.58.com/submit" name="formSubmitFrame" id="formSubmitFrame"></iframe>

	<script src='../js/crawl/58.js' type='text/javascript'></script>
	<script src="http://passport.58.com/rsa/ppt_security.js" type="text/javascript"></script>
	<script type="text/javascript">
	var url = cloudPlatformUrl+"/services/newenv/cloub/personal_site/get?id=<%=id%>";
	var result = $.ajax({url:url,async:false});
	var obj = $.parseJSON(result.responseText);
	document.getElementById("username").value = obj.username;
	document.getElementById("password").value = obj.password;
	document.getElementById("username").value = "hy_luowei";
	document.getElementById("password").value = "alvaluo@58";
	document.getElementsByName("validatecode")[0].focus();
	var timesign = new Date().getTime();
	document.getElementById("timesign").value = timesign;
	var pwd = document.getElementById("password").value;
	document.getElementById("p1").value = getm32str(pwd, timesign+"");
	document.getElementById("p2").value = getm16str(pwd, timesign+"");
	document.getElementById("p3").value = encryptString(timesign + encodeURIComponent(pwd),"010001","008baf14121377fc76eaf7794b8a8af17085628c3590df47e6534574efcfd81ef8635fcdc67d141c15f51649a89533df0db839331e30b8f8e4440ebf7ccbcc494f4ba18e9f492534b8aafc1b1057429ac851d3d9eb66e86fce1b04527c7b95a2431b07ea277cde2365876e2733325df04389a9d891c5d36b7bc752140db74cb69f");
	document.getElementById("password").value = "password";
	function login() {
		setTimeout(function(){	document.getElementById('frm').submit();}, 10);
		setTimeout(redirect, 1000);
		function redirect() {
			try {
				document.getElementById('formSubmitFrame').contentWindow.document.body.innerHTML = "";
				setTimeout(redirect, 1000);
			} catch (e) {
				window.location="http://my.58.com/";
			}
		}
	}
	</script>

</body>
</html>
