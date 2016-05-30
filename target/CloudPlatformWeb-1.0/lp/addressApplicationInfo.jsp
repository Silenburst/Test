<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page isELIgnored="false"%>
<style>
	.w800{
		width:800px;
	}
</style>
<div class="modal-dialog w800">
<div class="modal-content">
  <div class="modal-header">
    <button type="button" id="bnCloseAddressCheckDlg" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
    <h4 class="modal-title">地址审核信息</h4>
  </div>
  <div class="panel-body">
    <h4>申请人信息</h4>
    <div class="table-responsive">
    <table width="100%" class="table">
      <tbody>
        <tr>
          <td>姓名</td>
          <td><div class="wbk d-pre1">
           	${addressapplication.applicantName}
            </div></td>
          <td>所属部门</td>
          <td><div class="wbk d-pre1">
              ${addressapplication.bmName}
            </div></td>
          <td>联系电话</td>
          <td><div class="wbk d-pre1">
              ${addressapplication.phone}
            </div></td>
        </tr>
      </tbody>
    </table>
    <h4>申请详情 </h4>
    <table width="100%" class="table">
      <tbody>
        <tr>
          <td>楼盘</td>
          <td><div class="wbk d-pre1">
              ${addressapplication.lpName}
            </div></td>
          <td>城市</td>
          <td><div class="wbk d-pre1">
              <s:select list="#cityList" listKey="id" listValue="cityName" cssClass="form-control" theme="simple" id="selectCityId"
				 		headerKey="" headerValue="选择城市" emptyOption="false" name="addressapplication.cityId"></s:select>
            </div></td>
          <td>城区</td>
          <td><div class="wbk d-pre1">
              <select name="addressapplication.stressId" id="selectStressId" class="form-control"><option value="">选择城区</option></select>
            </div></td>
          <td>商圈</td>
          <td><div class="wbk d-pre1">
              <select name="addressapplication.sqId" id="selectSqId" class="form-control"><option value="">选择商圈</option></select>
            </div></td>
        </tr>
        <tr>
          <td>栋座</td>
          <td><div class="wbk d-pre1">
              <input type="text" name="addressapplication.zdid" value="${addressapplication.zdid}" class="form-control w100 pull-left" placeholder="">
            </div></td>
          <td>单元</td>
          <td><div class="wbk d-pre1">
              <input type="text" name="addressapplication.dyid" value="${addressapplication.dyid}" class="form-control w100 pull-left" placeholder="">
            </div></td>
          <td>楼层</td>
          <td><div class="wbk d-pre1">
              <input type="text" name="addressapplication.lcid" value="${addressapplication.lcid}" class="form-control w100 pull-left" placeholder="">
            </div></td>
          <td>门牌号</td>
          <td><div class="wbk d-pre1">
              <input type="text" name="addressapplication.fangHaoId" value="${addressapplication.fangHaoId}" class="form-control w100 pull-left" placeholder="">
            </div></td>
        </tr>
        <tr>
          <td>总楼层</td>
          <td><div class="wbk d-pre1">
              <input type="text" name="addressapplication.taltollou" value="${addressapplication.taltollou}" class="form-control w100 pull-left" placeholder="">
            </div></td>
          <td>面积</td>
          <td><div class="wbk d-pre1">
              <input type="text" name="addressapplication.mianji" value="${addressapplication.mianji}" class="form-control w100 pull-left" placeholder="">
            </div></td>
          <td>原因</td>
          <td colspan="4">
          <div class="wbk d-pre1">
              <input type="text" name="addressapplication.comment" value="${addressapplication.comment}" class="form-control pull-left" style="width:330px" placeholder="">
            </div>
          </td>
        </tr>
        <tr>
          <td>审核备注</td>
          <td colspan="7"><div class="wbk d-pre1">
              <textarea name="addressapplication.checkerComment"   class='form-control' style="width:650px;height:60px;">${addressapplication.checkerComment}</textarea>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
    </div>
  </div>
  <div class="clearfix"></div>
  <div class="modal-footer">
    <button type="button" class="btn btn-white" onclick="close1()">关闭</button>
  </div>
</div>
</div>
<script type="text/javascript">
 function close1(){
	 $("#bnCloseAddressCheckDlg").trigger("click");
 }
 $(function(){
		
	 $("#selectCityId").change(function(){
			var Id = $(this).val();
			var theSelect = $("#selectStressId");
			theSelect.find("option:gt(0)").remove();
			if(Id!=""){
				$.ajax({ 
					url: SERVICES_BASE_PATH + "/city/" + Id + "/stress",
					dataType: "json", 
					type: "GET",
					success: function(sqs){
						var options = "";
						$.each(sqs, function(i,n){
							options += '<option  value="' + n.id + '">' + n.qyName + '</option>';
						});
						theSelect.append(options);
						if("${addressapplication.stressId}"!=""){
							theSelect.val("${addressapplication.stressId}");
							theSelect.trigger("change");
						}
			    	}
				});
			}
		}).trigger("change");
		
		$("#selectStressId").change(function(){
			var stressId = $(this).val();
			var theSelect = $("#selectSqId");
			theSelect.find("option:gt(0)").remove();
			if(stressId!=""){
				$.ajax({ 
					url: SERVICES_BASE_PATH + "/stress/" + stressId + "/sq",
					dataType: "json", 
					type: "GET",
					success: function(sqs){
						var options = "";
						$.each(sqs, function(i,n){
							options += '<option  value="' + n.id + '">' + n.sqName + '</option>';
						});
						theSelect.append(options);
						if("${addressapplication.sqId}"!=""){
							theSelect.val("${addressapplication.sqId}");
						}
			    	}
				});
			}
		});
		
	});
</script>
