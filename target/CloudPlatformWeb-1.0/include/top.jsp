<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>
<%
String path = request.getContextPath();
UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
%>
				<nav class="navbar user-info-navbar" role="navigation">
					<!-- Left links for user info navbar -->
					<ul class="user-info-menu left-links list-inline list-unstyled">
						<li class="hidden-sm hidden-xs">
							<a href="#" data-toggle="sidebar">
								<i class="fa-bars"></i>
							</a>
						</li>
					</ul>

					<!-- Right links for user info navbar -->
					<ul class="user-info-menu right-links list-inline list-unstyled">

						<li class="dropdown user-profile">
							<a href="#" data-toggle="dropdown">
								<i class="fa-reorder"></i>
								<span>
										<span id="zhiweiqiehuan" >职位切换</span>&nbsp;&nbsp;<i class="fa-angle-down"></i>
								</span>
							</a>
							<ul class="dropdown-menu user-profile-menu list-unstyled" id="titleList">
								<li>
									<a href="#edit-profile">
										<i class="fa-edit"></i> 职位切换
									</a>
								</li>
								<li>
									<a href="#settings">
										<i class="fa-wrench"></i> 职位切换
									</a>
								</li>
								<li>
									<a href="#profile">
										<i class="fa-user"></i> 职位切换
									</a>
								</li>
								<li>
									<a href="#help">
										<i class="fa-info"></i> 职位切换
									</a>
								</li>
								<li class="last">
									<a href="extra-lockscreen.html">
										<i class="fa-lock"></i> 职位切换
									</a>
								</li>
							</ul>
						</li>

						<li class="dropdown user-profile">
							<a href="#" data-toggle="dropdown">
								<img src="<%=path%>/assets/images/user-4.png" alt="user-image" class="img-circle img-inline userpic-32" width="28" />
								<span>
								<%=userLogin.getUserProfile().getFullname()%>&nbsp;&nbsp;<%=userLogin.getDepartment().getDepartmentName()%>&nbsp;&nbsp;<i class="fa-angle-down"></i>
							</span>
							</a>
							<ul class="dropdown-menu user-profile-menu list-unstyled">
								<li>
									<a href="javascript:void(0)">
										<i class="fa-info"></i> 帮助
									</a>
								</li>
								<li class="last">
									<a href="<%=path%>/loginOut.action">
										<i class="fa-lock"></i> 注销
									</a>
								</li>
							</ul>
						</li>

					</ul>

				</nav>
				


<script type="text/javascript">
	$(function(){
		init();
		
		function init(){
			getTitle();
		}
		
		//获取登录人的所有岗位
		function getTitle(){
			var theSelect = $("#titleList");
			theSelect.find("li").remove();
			var username = "<%=userLogin.getUserLogin().getUsername()%>";
			if(username=="")return;
			$.ajax({
		        type: "POST",
		        url: "<%=path%>/getTitle.action?userLogin.username="+username,
		        dataType: "json",
		        success: function(titles){
				     var str ='';
				     for(var i=0;i<titles.length;i++){
				    	 str += '<li data-titleId="' + titles[i][0] + '"><a href="#profile"><i class="fa-user"></i> ' + titles[i][1] + '</a></li>';
				     }
				     theSelect.html(str); 
				    var typeName = "<%=userLogin.getTitleName()%>";
		        	$("#zhiweiqiehuan").html("<i class='fa-user'></i>"+typeName);
				}
		    });
		}
		
		$("#titleList").on("click","li", function(){
			var titleInfo = $(this).attr("data-titleId");
			$.ajax({
		        type: "POST",
		        url: "<%=path%>/changeTitle.action?title="+titleInfo,
		        dataType: "json",
		        success: function(result){
		        	setTimeout(window.location.reload(),100);
				}
		    });
		});
		
	});
	function logoutToIndex(){
		logout("../index.shtml")
	}
</script>