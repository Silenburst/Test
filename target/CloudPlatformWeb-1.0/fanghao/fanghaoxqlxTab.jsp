<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %> 
<%  String basePath = request.getContextPath(); %>
<script type="text/javascript">

$(function(){
if('${type}'==59||'${ltype}'==1){
queryDataxqcs('${schoolid}','${type}','${ltype}',"newenv/lpzd/fanghaoxqkz.action");
}else if('${type}'==88||'${type}'==246){
queryDataxqcs('${schoolid}','${type}','${ltype}',"newenv/lpzd/fanghaoxqcs.action");
}

})
</script>

						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th width="50"><input type="checkbox" class="cbr" /></th>
									<th>编号</th>
									<th colspan="2">房屋</th>
									<th>状态</th>
									<th>数据来源</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody class="middle-align" id="xpcstbodyData">
								
							</tbody>
						</table>
						<div id="xqcsmacPageWidget"></div>
