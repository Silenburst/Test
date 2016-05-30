<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@page import="com.newenv.lpzd.security.service.SecurityUserHolder,com.newenv.lpzd.security.domain.UserLogin"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
UserLogin userLogin = SecurityUserHolder.getCurrentUserLogin();
%>
	<div class="sidebar-menu-inner">
					<header class="logo-env">
						<!-- logo -->
						<div class="logo">
							<a href="<%=path%>/console/index.jsp" class="logo-expanded">
								<img src="<%=path%>/assets/images/logo@2x.png" width="80" alt="">
							</a>

							<a href="<%=path%>/console/index.jsp" class="logo-collapsed">
								<img src="<%=path%>/assets/images/logo-collapsed@2x.png" width="40" alt="">
							</a>
						</div>
						<!-- This will toggle the mobile menu and will be visible only on mobile devices -->
						<div class="mobile-menu-toggle visible-xs">
							<a href="javascript:void(0)" data-toggle="user-info-menu">
								<i class="fa-bell-o"></i>
								<span class="badge badge-success">7</span>
							</a>
							<a href="javascript:void(0)" data-toggle="mobile-menu">
								<i class="fa-bars"></i>
							</a>
						</div>
					</header>
					<ul id="main-menu" class="main-menu">
						<!-- add class "multiple-expanded" to allow multiple submenus to open -->
						<!-- class "auto-inherit-active-class" will automatically add "active" class for parent elements who are marked already with class "active" -->
						<li>
							<a href="<%=basePath%>/crawl/verInfo.jsp">
								<i class="el-home"></i>
								<span class="title">首页</span>

							</a>
						</li>
						<li class="" >
							<a href="javascript:void(0)">
								<i class="linecons-cog"></i>
								<span class="title">云采集</span>
							</a>
							<ul>
								<li id="menu0101">
									<a href="<%=basePath%>/crawl/index.jsp">
										<span class="title">房源采集</span>
									</a>
								</li>
								<li id="menu0102">
									<a href="<%=basePath%>/crawl/custom.jsp">
										<span class="title">客源采集</span>
									</a>
								</li>
							</ul>
						</li>
						</li>
						<li>
							<a href="#">
								<i class="linecons-cog"></i>
								<span class="title">云发布</span>

							</a>
							<ul>
								<li id="menu0201">
									<a href="<%=basePath%>/crawl/saleManagment.jsp">
										<span class="title">出售管理</span>
									</a>
								</li>
								<li id="menu0202">
									<a href="<%=basePath%>/crawl/rentManagment.jsp">
										<span class="title">出租管理</span>
									</a>
								</li>
							</ul>

						</li>
						<li>
							<a href="#">
								<i class="linecons-cog"></i>
								<span class="title">云刷新</span>
							</a>
						</li>
						<li class="" >
							<a href="javascript:void(0)">
								<i class="linecons-cog"></i>
								<span class="title">个人设置</span>
							</a>
							<ul>
								<li class="" id="menu0401">
									<a href="<%=basePath%>/crawl/personalSite.jsp">
										<span class="title">站点管理</span>
									</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
	<script type="text/javascript">

	</script>