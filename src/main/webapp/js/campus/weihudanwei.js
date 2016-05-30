function tosave(){
	buttong();
	$("#weihudanweiApp").click();
}
function toleizeng(){
	$("#modalleizeng").click();
	
}
function juzhuchengbenAdd(){
	uopdayt();
	$("#juzhuchengbenAdd").click();
}


function queryData(){
	var lpid = $("#lpxxid").val();
	var url = basepath+"/add/maintenanceAction!findByPageInFo.action";
	$("#macPageWidget").asynPage(url, "#tbodyData", buildDataHtml, true, true, {
		'enetiy.lpid': lpid,
	 });
	};
	function buildDataHtml(list) {
		$("#tbodyData").html("");
	    $.each(list, function (i, info) {
	        var tr = [
	            '<tr>',
	            /*'<td class="text-center">', '<input type="checkbox" class="cbr" ame="id"/>', '</td>',*/
	            '<td class="text-center">', info[2]=="null" ||info[2]=="" || info[2]==null?"":info[2], '</td>',
	            '<td class="text-center">', info[3]=="null" ||info[3]=="" || info[3]==null?"":info[3], '</td>',
	            '<td class="text-center">', info[4]=="null" ||info[4]=="" || info[4]==null?"":info[4], '</td>',
	            '<td class="text-center">', info[5]=="null" ||info[5]=="" || info[5]==null?"":info[5], '</td>',
	            '<td class="text-center">', info[6]=="null" ||info[6]=="" || info[6]==null?"":info[6], '</td>',
	            '<td class="text-center"><a href="#" class="pr10" data-toggle="modal" data-id="'+info[0]+'" onclick="toupdatelpm('+info[0]+')" ><i class="fa-pencil"></i>修改</a><a href="#" onclick="deleteLPM('+info[0]+')"><i class="fa-trash-o"></i>删除</a></td>',
	            '</tr>'].join('');
	        $("#tbodyData").append(tr);
	    });
		
	};

	var fian=false;
	function update(){
	var companyName = $("#enterprise").val();
		$.ajax({
			url: basepath+"/add/maintenanceAction!update.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data :{"companyName":companyName},
			success: function(data){
				if(data>0){
					alert('名称已重复,请重新输入!');
					return false;
					}
			}
		});
	}
	function addData(){
	var lpid = $("#lpxxid").val();
	var lpmId = $("#lpmId").val();
	
	var cityID = $("#mType").val();
	var companyName = $("#enterprise").val();
	var iphone = $("#phone").val();

	var dizhi = $("#dizhi").val();

	var remark = $("#remark").val();

	if(lpmCheck()){
		$.ajax({
			url: basepath+"/add/maintenanceAction!addData.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data :{"lpmId":lpmId,"lpid":lpid,"mtype":cityID,"companyName":companyName,"tel":iphone,"address":dizhi,"remark":remark},
			success: function(data){
				if(data!=null){
					alert('保存成功!');
					jQuery('#weihudanwei').modal('hide');
					queryData();
				} else {
					alert('保存失败!');
				}
			}
		});
		
	}
	
	
	}
	function buttong(){	
		$("#mType option[value='0']").attr("selected", true);
		$("#lpmId").val(0);
		$("#enterprise").val('');
		$("#phone").val('');
		$("#dizhi").val('');
		$("#remark").val('');
	}


	function queryData1(){
	var lpid = $("#lpxxid").val();
	var url1 = basepath+"/add/housingCostAction!pageinfo.action";
		$("#macPageWidget").asynPage(url1, "#tbodyData1", buildDataHtml1, true, true, {
			'enetiy.lpid': lpid,
		});
	};
		function buildDataHtml1(list) {
			$("#tbodyData1").html("");
		    $.each(list, function (i, info) {
		        var tr = [
		            '<tr>',
		            '<td class="text-center">', '<input type="checkbox" class="cbr" ame="id"/>', '</td>',
		            '<td class="text-center">', info[2]=="null" ||info[2]=="" || info[2]==null?"":info[2], '</td>',
		            '<td class="text-center">', info[3]=="null" ||info[3]=="" || info[3]==null?"":info[3], '</td>',
		            '<td class="text-center">', info[4]=="null" ||info[4]=="" || info[4]==null?"":info[4], '</td>',
		            '<td class="text-center">', info[5]=="null" ||info[5]=="" || info[5]==null?"":info[5], '</td>',
		            '<td class="text-center">', info[6]=="null" ||info[6]=="" || info[6]==null?"":info[6], '</td>',
		            '<td class="text-center"><a href="#" class="pr10" data-toggle="modal" data-id="'+info[0]+'" onclick="toupdateCost('+info[0]+')" ><i class="fa-pencil"></i>修改</a><a href="#" onclick="deleteCost('+info[0]+')"><i class="fa-trash-o"></i>删除</a></td>',
		            '</tr>'].join('');
		        $("#tbodyData1").append(tr);
		    });
			
		};
		
		
	function addData1(){
	var id = $("#costId").val();
	var lpid = $("#lpxxid").val();
	var ctype = $("#ctype").val().replace(/\s+/g,"");
	if(ctype == null || ctype == "0") {
		bootbox.alert({title:"提示",message:"请选择类型!"});
		return false;
	}
	var payingWay = $("#payingWay").val().replace(/\s+/g,"");
	if(payingWay == null || payingWay == "0") {
		bootbox.alert({title:"提示",message:"请选择计收方式!"});
		return false;
	}
	
	var price = $("#price").val().replace(/\s+/g,"");
	if(price>=100000000){
		bootbox.alert({title:"提示",message:"请输入金额/单价小于100000000!"});
		return false;
	}else{
		if(checkNumber(price)) {
			bootbox.alert({title:"提示",message:"请输入金额/单价的为数字!"});
			return false;
		}
	}
	
	var unit = $("#unit").val();
	var remarks = $("#jzcbRemarks").val();
	$.ajax({
			url: basepath+"/add/housingCostAction!addDwell.action",
			dataType: "json", 
			type: "POST",
			async : false,
			data :{"costid":id,"lpid":lpid,"ctype":ctype,"payingWay":payingWay,"price":price,"unit":unit,"remark":remarks},
			success: function(data){
			var cHtml = '';
			if(data!=null){
				alert('添加成功!');
				jQuery('#juzhuchengben').modal('hide');
				queryData1();
			} else {
				alert('添加失败!');
			}
				$("#country").append(cHtml);
			}
		});
	} 
	function uopdayt(){
		$("#costId").val('0');
		$("#ctype option[value='0']").attr("selected", true); 
		$("#payingWay option[value='0']").attr("selected", true); 
		$("#price").val('');
		$("#unit").val('');
		$("#jzcbRemarks").val('');
	}
	
	function toupdatelpm(lpmId){
		$("#weihudanweiApp").click();
		$.ajax({
			url:basepath+"/add/maintenanceAction!getById.action",
			type:"GET",
			dataType:"json",
			data:{"lpmId":lpmId},
			success:function(data){
				$("#lpmId").val(data.id);
				$("#mType option[value='"+data.mType+"']").attr("selected", true); 
				$("#enterprise").val(data.companyName);
				$("#lpmlpid").val(data.lpid);
				$("#phone").val(data.tel);
				$("#remark").val(data.remark);
				$("#dizhi").val(data.address);
			}
		});
	}
	
	
	function toupdateCost(costid){
		$("#juzhuchengbenAdd").click();
		$.ajax({
			url:basepath+"/add/housingCostAction!getById.action",
			type:"GET",
			dataType:"json",
			data:{"costid":costid},
			success:function(data){
				$("#costId").val(data.id);
				$("#ctype option[value='"+data.cType+"']").attr("selected", true); 
				$("#payingWay option[value='"+data.payingWay+"']").attr("selected", true); 
				$("#price").val(data.price);
				$("#unit").val(data.unit);
				$("#jzcbRemarks").val(data.remark);
				$("#costlpid").val(data.lpid);
			}
		});
	}
	
	
	
	//删除维护单位信息
	function deleteLPM(id){
		bootbox.confirm({title:"<p>提示",message:"<a>请确定要删除吗",callback:function(result){
		    if(result){//判断是否点击了确定按钮
		        //执行删除等操作
		    	$.ajax({ 
					url : basepath + "/add/maintenanceAction!deleteLPM.action",
					dataType: "json", 
					type: "POST",
					data: {"lpmId" : id},
					success: function(result){
						if(result.data=="success"){
							bootbox.alert({title:"提示",message:"删除成功!"});
							queryData();
						} else {
							bootbox.alert({title:"提示",message:"删除失败：" + result.data});
						}
			    	}
				});
		    }
		}});
	}
	
	
	//删除居住成本信息
	function deleteCost(id){
		bootbox.confirm({title:"<p>提示",message:"<a>请确定要删除吗",callback:function(result){
		    if(result){//判断是否点击了确定按钮
		        //执行删除等操作
		    	$.ajax({ 
		    		url:basepath+"/add/housingCostAction!deleteCost.action",
					dataType: "json", 
					type: "POST",
					data: {"costid" : id},
					success: function(result){
						if(result.data=="success"){
							bootbox.alert({title:"提示",message:"删除成功!"});
							queryData1();
						} else {
							bootbox.alert({title:"提示",message:"删除失败：" + result.data});
						}
			    	}
				});
		    }
		}});
	}
	
	
	 function lpmCheck(){
		 var mType = $("#mType").val();
		 if(mType == null || mType == "" || mType == "0") {
				bootbox.alert({title:"提示",message:"请选择类型!"});
				return false;
			}
		 
		 var enterprise = $("#enterprise").val().replace(/\s+/g,"");
		
			if(enterprise == null || enterprise == "") {
				bootbox.alert({title:"提示",message:"请输入企业单位名称!"});
				return false;
			}
			if(isChineseChar(enterprise)){
				bootbox.alert({title:"提示",message:"请输入由中文数字下划线字母!"});
				return false;
			}
			var phone  = $("#phone").val().replace(/\s+/g,"");
			if(phone != null && phone != ""){
				if(checktel(phone)){
					bootbox.alert({title:"提示",message:"请输入正确的手机号码，例如13203784791或0731-12345678"});
					return false;
				}
			}
			
			return true ;
	 }
	 
	 
	 function action1111(val){
		 	$.ajax({
		 		url: basepath + "/cam/campus!queryCtype.action",
		 		dataType: "json",
		 		type: "POST",
		 		async : false,
		 		data : {"ctype" :val.value},
		 		success: function(data){
		 		$.each(data, function(i,n){
		 			$("#unit").val(n.name);
		 	      });
		 		}
		 	});
		 	
		 }
	 
	