$(function(){
	init();
	
	function init(){
		queryData();
	}
	
	$("#bnQueryData").click(function(){
		queryData();
	});
	
	
	$("[name='condition.stressId']").change(function(){
		var theSelect = $("[name='condition.sqId']");
		theSelect.find("option:gt(0)").remove();
		var stressId = $(this).val();
		if(stressId=="")return;
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
	    	}
		});
	});
	
	$("#selectDepartmentId").select2({
	    placeholder: "请选择店组",
	    minimumInputLength: 2,
	    allowClear: true,
	    ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
	        url: "../base/department!queryDepartmentsByName.action",
	        type: "POST",
	        dataType: 'json',
	        quietMillis: 500,
	        data: function (term, page) {
	            return {
	            	"organizationId" : 88,
	                "departmentName": term // search term
	            };
	        },
	        results: function (data, page) { // parse the results into the format expected by Select2.
	            // since we are using custom formatting functions we do not need to alter the remote JSON data
	            //alert(data);
	            return { results: data };
	        },
	        cache: true
	    },
	    formatResult: formatResult, // omitted for brevity, see the source of this page
	    formatSelection: formatSelection  // omitted for brevity, see the source of this page
	
	}).on("change",function(e){
		//alert(e.val);
		getUsersOfBm(e.val, $(this));
	});
	
	function formatResult(node) {
	    return '<div>' + node.name + '</div>';
	};
	
	function formatSelection(node, container) {
	    return node.name;
	};
	
});

function queryData(){
    var url = "lpxxCollect!collectList.action";
    $("#lcPageWidget").asynPage(url, "#lcTBodyData", buildDataHtml, true, true, $("form[name='formCondition'").serializeObject());
};

var statusNameMap = new Array();
statusNameMap["0"] = "未审核";
statusNameMap["1"] = "待审核";
statusNameMap["2"] = "审核通过";
statusNameMap["3"] = "审核驳回";

function buildDataHtml(list){
	$("#lcTBodyData").html("");
    $.each(list, function (i, info) {
        var tr = [
            '<tr>',
            '<td class="text-center">', statusNameMap[info[1]], '</td>',
            '<td class="text-center">', info[2], '</td>',
            '<td class="text-center">', info[3], '</td>',
            '<td class="text-center">', info[4], '</td>',
            '<td class="text-center">', info[5], '</td>',
            '<td class="text-center">', info[6], '</td>',
            '<td class="text-center">', info[7], '</td>',
            '<td class="text-center">', format(info[8],"yyyy-MM-dd HH:mm:ss"), '</td>',
            '<td class="text-center">',lcHandlerColumnHtml(info), '</td>',
            '</tr>'].join('');
        $("#lcTBodyData").append(tr);
    });
}

function lcHandlerColumnHtml(info){
	if(info[1]==0 || info[1]==3){
		return '<a class="pr10" data-toggle="modal" data-target="#Shenqing" onclick="submitLpxx(' + info[0] + ')">提交申请</a>'
		 		+ '<a class="pr10" href="../cam/campus!updLpxx.action?from=apply&lpid=' + info[0] + '">编辑</a>'
		 		+ '<a class="pr10" data-position="" data-toggle="modal" data-target="#Shanchu" onclick="setlpid(' + info[0] + ')">删除</a>';
	} else {
		return '&nbsp;';
	}
}

var lpId;
function submitLpxx(obj){
	lpId=obj;
}
function saveshenqing(){
	$.ajax({ 
		url: "lpxxCollect!tijiao.action", 
		dataType: "json", 
		type: "POST",
		data : {"lpxx.id": lpId,"lpxx.requestRemark":$("[name='shenqingbeizhu']").val()},
		success: function(result){
			if(result.code=="ok"){
				alert("提交成功");
				queryData();
				$("#Shenqing").modal("hide");
			}
		}
	});
}
function setlpid(obj){
	lpId=obj;
}
function deletelp(){
	$.ajax({ 
		url: "lpxxCollect!delete.action", 
		dataType: "json", 
		type: "POST",
		data : {"ids": lpId},
		success: function(result){
			alert("删除成功!");
			queryData();
			$("#Shanchu").modal("hide");
    	}
	});
}

var format = function(time, format){
	if(typeof(time)=="undefined" || time<10000)return "";
    var t = new Date(time);
    var tf = function(i){return (i < 10 ? '0' : '') + i};
    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a){
        switch(a){
            case 'yyyy':
                return tf(t.getFullYear());
                break;
            case 'MM':
                return tf(t.getMonth() + 1);
                break;
            case 'mm':
                return tf(t.getMinutes());
                break;
            case 'dd':
                return tf(t.getDate());
                break;
            case 'HH':
                return tf(t.getHours());
                break;
            case 'ss':
                return tf(t.getSeconds());
                break;
        }
    })
}
