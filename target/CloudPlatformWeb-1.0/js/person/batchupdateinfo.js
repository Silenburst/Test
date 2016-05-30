$(document).ready(function(){
	getSyscsType("房屋朝向" ,"chaoXiang");
	if(null != chaoXiang && chaoXiang!="" && chaoXiang!="null"  && cqmj!="0")
	{
		$("#chaoXiang").val(chaoXiang);
	}
	getSyscsType("权属性质" ,"cqxz");
	if(null != cqxz && cqxz!="" && cqxz!="null"  && cqmj!="0")
	{
		$("#cqxz").val(cqxz);
	}
	getSyscsType("房屋用途" ,"leixing");
	if(null != leixing && leixing!="" && leixing!="null"  && cqmj!="0")
	{
		$("#leixing").val(leixing);
	}
	getSyscsType("产权年限" ,"propertyAg");
	if(null != propertyAge && propertyAge!="" && propertyAge!="null"  && cqmj!="0")
	{
		$("#propertyAg").val(propertyAge);
	}
	if(null != cqmj && cqmj!="" && cqmj!="null" && cqmj!="0")
	{
		$("#cqmj").val(cqmj);
	}
	if(null != tnmj && tnmj!="" && tnmj!="null"  && cqmj!="0")
	{
		$("#tnmj").val(tnmj);
	}
		
});	

function batchUpdate()
{
	$("#zuoyou").val(zuoyous);
//	$("#zuoyou").val(JSON.stringify(zuoyous));
	 var url = basepath+"/personInfo!batchUpdate.action";
	 $.ajax({
			url: url,
			dataType: "json",
			data: $('#batchFanghaoForm').serialize(), 
			type: "POST",
			async :false,
			beforeSend: function(){
				//在异步提交前要做的操作
				return fanghaoCheck();
			},
			success: function(result){
				if(result>0) {
					//在异步提交成功后要做的操作
					alert("批量修改成功.");
					window.location.href=basepath+"/person/batchupdate.jsp";
					$('.onsubing').css("display","none");//弹出提示框
					//跳到下一步
				} else {
					$('.onsubing').css("display","none");//弹出提示框
				}
			}
		});
		$('.onsubing').css("display","none");//弹出提示框
}
function fanghaoCheck()
{
	var tnmj = $("#tnmj").val();
	if(tnmj == null || tnmj =="0" || tnmj == 0)
	{
		alert("请填写套内面积.");
		return false;
	}
	
	var propertyAg = $("#propertyAg").val();
	if(propertyAg == null || propertyAg =="0" || propertyAg == 0)
	{
		alert("请填写产权年限.");
		return false;
	}
}


function getSyscsType(name ,id){
	var url = basepath + "/base/school!findBySType.action";
	$.ajax({
		url: url,
		dataType: "json", 
		type: "POST",
		async : false,
		data : {"name" : name},
		success: function(data){
			var pHtml = '<option value="0">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n[0]+'">'+n[1]+'</option>';
			});
			$("#"+id).html(pHtml);
	    }
	});
};

