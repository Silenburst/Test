<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.opensymphony.xwork2.util.ValueStack,com.newenv.pagination.PageInfo" %>
<%
try{
	ValueStack vs = (ValueStack)request.getAttribute("struts.valueStack");
	PageInfo pager = (PageInfo)request.getAttribute("pager");
	if(pager==null){
		pager = (PageInfo)vs.findValue("pager");
	}
	int curPage = -1;		//当前是哪一页
	int totalPage = -1;//总页数
	int records=-1; //总记录数
	if (pager!=null){
		curPage=pager.getPage() ;
		totalPage=pager.getTotal();
		records=pager.getRecords();
	}
		
	int pagesLinkToShow = 3;			//在当前页前后显示多少个页链接
	
%>
	<%
		if(records==0){
	%>
		<div align="center">没有查询到数据</div>
	<%
		}
	%>
	<div class="row-fluid margin-bottom-40">
		<div class="col-lg-2  pagination "></div>
		<div class="col-lg-10 text-right">
			<ul class="pagination">
				<li><a href="#" class="radius12"> 共 <b> <%=records%></b> 条</a>
				</li>
				<li><a class="radius4 padd0"> <input type="text" value="<%=curPage%>" id="pager_txtPageNo" style="width:40px;text-align: center;" class="daxiao">
				</a>
				</li>
				<li><a href="javascript:void(0)" class="mainaasdw" onclick="pager_gotoCustPage()"> 跳转</a>
				</li>
				<li><a href="javascript:void(0)" onclick="pager_gotoPage(1)">首页</a>
				</li>
				<li><a href="javascript:void(0)" onclick="pager_gotoPage(<%=(curPage>1?(curPage-1):1)%>)"><i class="fa-angle-left"></i>
				</a>
				</li>
				   <%
				  	if(curPage-pagesLinkToShow>1){
				  %>
				  		<li class="pull-left previous"><a href="javascript:void(0)" data-toggle="pager" data-placement="top">...</a></li>
				  <%
				  	}
				  %>
				  
				  <%
				  	  int fromPage = curPage-pagesLinkToShow;
					  if(fromPage<1)fromPage=1;
					  int toPage =  curPage+pagesLinkToShow;
					  if(toPage>totalPage)toPage=totalPage;
					  for(int i=fromPage;i<=toPage;i++){
				  %>
				  	<li <% if(i==curPage){%>class="active"<%} %>><a href="javascript:void(0)" onclick="pager_gotoPage(<%=i%>)"><%=i %></a></li>
				  <%
				  }
				  %>
				  <%
				  	if(curPage+pagesLinkToShow<totalPage){
				  %>
				  		<li class="previous"><a href="javascript:void(0)" data-toggle="pager" data-placement="top">...</a></li>
				  <%
				  	}
				  %>
  
				<li><a href="javascript:void(0)" onclick="pager_gotoPage(<%=(curPage<totalPage?(curPage+1):totalPage)%>)"><i class="fa-angle-right"></i>
				</a>
				</li>
				<li><a href="javascript:void(0)" onclick="pager_gotoPage(<%=totalPage%>)">尾页</a>
				</li>
			</ul>
	
		</div>
	</div>
<%
}catch(Exception e){
	out.println("页码显示出错：" + e.getMessage());
}
%>
<script type="text/javascript">
	var divId;
	var url;
	var formId;
	function pager_gotoPage(pageNo){
		//序列化查询条件
		
		var condition = {};
		var pageInfo = {"pageInfo.page":pageNo};
		 var arr = $("#"+formId).serializeArray();
		for(var i = 0; i < arr.length ; ++i){
			eval(" condition."+arr[i].name+" = '"+arr[i].value+"' ");        
		} 
		if(pageNo == 0){
			return ;
		}
		$.extend(condition, pageInfo);
		$("#"+ divId).load(url, condition);
	}
	
	function pager_gotoCustPage(){
		var pageNo = $("#pager_txtPageNo").val();
		if(pageNo=="" || isNaN(pageNo)){
			alert("页码无效，请重新输入！");
			$("#pager_txtPageNo").focus();
		} else {
			pager_gotoPage(pageNo)
		}
	}
	
	$("#pager_txtPageNo").keydown(function(e){
		if(e.keyCode==13){
			pager_gotoCustPage();
		}
	});
</script>
