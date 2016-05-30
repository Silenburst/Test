<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %> 
<%  String basePath = request.getContextPath(); %>
<script type="text/javascript">
$(function(){
queryDataxq();
})
</script>
						<table class="table table-bordered table-striped">
									<thead>
										<tr>
											<th width="50"><input type="checkbox"   onclick="checkAll(this)" /></th>
											<th colspan="2">学校</th>
											<th>划片小区</th>
											<th>房屋信息</th>
										</tr>
									</thead>
									<tbody class="middle-align" id="xqtbodyData">
									
									</tbody>
								</table>
									<div id="xqmacPageWidget"></div>