<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page isELIgnored="false"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/validator.js"></script>
<style>
	.w800{
		width:800px;
	}
</style>
  <div class="modal-dialog modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
      <h4 class="modal-title">详细</h4>
    </div>
    <div class="modal-body">
      <table class="table">
        <tbody>
          <tr>
            <td width="60">备注:</td>
            <td><s:property value="lpxx.checkRemark" /></td>
          </tr>
          <tr>
        </tbody>
      </table>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
    </div>
  </div>