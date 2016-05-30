<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %> 
<%  String basePath = request.getContextPath(); %>
<script type="text/javascript">
$(function(){
queryDataxf(0,2);
})
</script>
					<div class="table-responsive">
						<table class="table table-bordered table-striped">
									<thead>
										<tr>
											<th width="50"><input type="checkbox"  onclick="checkAll(this)" /></th>
											<th colspan="2">新房项目</th>
											<th>均价</th>
											<th>数据来源</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody class="middle-align" id="xftbodyData">
									</tbody>
								</table>
									<div id="xfmacPageWidget"></div>
							</div>	
