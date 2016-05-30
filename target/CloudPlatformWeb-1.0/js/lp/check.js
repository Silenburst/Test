var currentTab = "xhjAddressApplication";

$(function(){
	init();
	
	function init(){
		if(currentTab=="lpxxCollect"){
			$("#checkTabs li:eq(1) a").tab('show');
		} else {
			$("#checkTabs li:eq(0) a").tab('show');
		}
		queryData();
	}
	
	$("#tabLiAddressApplication").click(function(){
		currentTab = "xhjAddressApplication";
		var statusSelect = $("[name='condition.checkStatus']");
		statusSelect.find("option:gt(0)").remove();
		$.each(apStatusNameMap,function(i,n){
			statusSelect.append('<option  value="' + i + '">' + n + '</option>');
		});
		queryData();
	});
	
	$("#tabLiLpConnect").click(function(){
		currentTab = "lpxxCollect";
		var statusSelect = $("[name='condition.checkStatus']");
		statusSelect.find("option:gt(0)").remove();
		$.each(lpStatusNameMap,function(i,n){
			if(i>0)
				statusSelect.append('<option  value="' + i + '">' + n + '</option>');
		});
		queryData();
	});
	
	$("#bnQueryData").click(function(){
	    var k =  $("#"+currentTab+"PageWidget a.current");
	    k.text(1);
	    k.attr("pageNum",1);
		queryData();
	});
	
	function queryData(){
	    var url = currentTab + "!checkList.action";
	    var settings = {};
	    if($("#"+currentTab+"PageWidget a.current")[0]){
	    	settings = {pageNo:$("#"+currentTab+"PageWidget a.current").attr("pageNum")};
	    }
	    $("#"+currentTab+"PageWidget").asynPage(url, "#"+currentTab+"TBodyData", buildDataHtml, true, true, $("form[name='formCondition'").serializeObject(),settings);
	};
	
	function buildDataHtml(list) {
		if(currentTab=="xhjAddressApplication"){
			showAddressApplicationPager(list);
		} else if(currentTab=="lpxxCollect"){
			showLpxxCollectPager(list);
		}
	};
	
	var apStatusNameMap = new Array();
	apStatusNameMap["0"] = "未审核";
	apStatusNameMap["1"] = "审核通过";
	apStatusNameMap["2"] = "驳回";
	apStatusNameMap["3"] = "待审核";
	
	function showAddressApplicationPager(list){
		$("#xhjAddressApplicationTBodyData").html("");
		$("#xhjAddressApplicationPageWidget").text("");
	    $.each(list, function (i, info) {
	        var tr = [
	            '<tr>',
	            '<td style="color:#202020;padding-left:0;font:10px" class="text-center">', apStatusNameMap[info[1]], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[2], '</td>',
	            '<td style="color:#202020;padding-left:0">', '<a href="../cam/campus!updLpxx.action?from=check&fromPageTab=xhjAddressApplication&lpid=' + info[11] + '">' + info[3] + '</a>', '</td>',
	            '<td style="color:#202020;padding-left:0;padding-right:0" class="text-center">', info[4], '</td>',
	            '<td style="color:#202020;padding-left:0;padding-right:0" class="text-center">', info[5], '</td>',
	            '<td style="color:#202020;padding-left:0;padding-right:0" class="text-center">', info[6], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[7], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', format(info[8],"yyyy-MM-dd HH:mm:ss"), '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[9], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[13], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[10], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', format(info[12],"yyyy-MM-dd HH:mm:ss"), '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[14], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', apHandlerColumnHtml(info), '</td>',
	            '</tr>'].join('');
	        $("#xhjAddressApplicationTBodyData").append(tr);
	    });
	}
	
	function apHandlerColumnHtml(info){
		if(info[1]==0 || info[1]==3){
			return '<a class="pr10"  data-toggle="modal" href="#infoModal" data-url="./xhjAddressApplication!preCheck.action?addressapplication.id='+info[0]+'&addressapplication.lpName='+encodeURI(info[3])+'" onclick="showModal(this)">审核</a>';
		} else if(info[1]==1 || info[1]==2){
			return '<a class="pr10"  data-toggle="modal" href="#infoModal" data-url="./xhjAddressApplication!info.action?addressapplication.id='+info[0]+'&addressapplication.lpName='+encodeURI(info[3])+'" onclick="showModal(this)">详情</a>';
		}
	}
	
	var lpStatusNameMap = new Array();
	lpStatusNameMap["1"] = "未审核";
	lpStatusNameMap["2"] = "审核通过";
	lpStatusNameMap["3"] = "驳回";
	
	function showLpxxCollectPager(list){
		$("#lpxxCollectTBodyData").html("");
		$("#lpxxCollectPageWidget").text("");
	    $.each(list, function (i, info) {
	        var tr = [
	            '<tr>',
	            '<td style="color:#202020;padding-left:0;padding-right:0;" class="text-center">', lpStatusNameMap[info[1]], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[2], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[3], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[4], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', '<a href="../cam/campus!updLpxx.action?from=check&fromPageTab=lpxxCollect&lpid=' + info[0] + '">' + info[5] + '</a>', '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[6], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[11], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[7], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', format(info[8],"yyyy-MM-dd HH:mm:ss"), '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', format(info[10],"yyyy-MM-dd HH:mm:ss"), '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', info[12], '</td>',
	            '<td style="color:#202020;padding-left:0" class="text-center">', lpHandlerColumnHtml(info), '</td>',
	            '</tr>'].join('');
	        $("#lpxxCollectTBodyData").append(tr);
	    });
	}
	
	function lpHandlerColumnHtml(info){
		if(info[1]==1){
			return '<a class="pr10"  data-toggle="modal" href="#shenhe" onclick="shenhe(' + info[0] + ',\'' + info[5] + '\',' + info[9] + ')">审核</a>' + 
	      			'<a class="pr10"  data-toggle="modal" href="#bohui" onclick="bohui(' + info[0] + ',\'' + info[5] + '\',' + info[9] + ')">驳回</a>';
		} else if(info[1]==2 || info[1]==3){
			return '<a class="pr10" data-toggle="modal" href="#infoModal" data-url="./lpxxCollect!info.action?lpxx.id=' + info[0] + '" onclick="showModal(this)">详细</a>';
		}
	}
	
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
	
	//获取店组下的人员列表
	function getUsersOfBm(deptId, $bmElement, userId){
		var theSelect = $("#selectUserId");
		theSelect.find("option:gt(0)").remove();
		if(deptId!=""){
			$.ajax({ 
				url: "../base/userProfile!getUserProfilesByDepartmentId.action?departmentId=" + deptId,
				dataType: "json", 
				type: "POST",
				success: function(sqs){
					var options = "";
					$.each(sqs, function(i,n){
						options += '<option  value="' + n.id + '">' + n.fullname + '</option>';
					});
					theSelect.append(options);
					
					if(userId){
						theSelect.val(userId);
					}
		    	}
			});
		}
	}
	
	$('.datepicker').datetimepicker({
		language:  'zh-CN',
        weekStart: 1,
        todayBtn:  1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0,
        format: 'yyyy-mm-dd'
	});
});

function showModal(obj){
	$("#infoModal").html('<div class="modal-dialog"><div class="modal-content"><div class="modal-body"> 加载中...</div></div></div>').load($(obj).attr("data-url"));
}

function shenhe(obj1,obj2,obj3){
	obj=obj1;
	lpname=obj2;
	usrid=obj3;
	$.ajax({
		url:"lpxxCollect!findrequest.action",
		dateType:"json",
		type:"POST",
		data:{"lpxx.id":obj},
		success: function(pager){
			$("[name='shenqingshuoming']").val(pager.remark);
    	}
	})
}
function saveshenhe(){
	$.ajax({ 
		url: "lpxxCollect!shenhe.action", 
		dataType: "json", 
		type: "POST",
		data : {"lpxx.id": obj,"lpxx.lpName": lpname,"lpxx.userId": usrid,"lpxx.checkRemark":$("[name='shenhebeizhu']").val()},
		success: function(pager){
			if(pager.code=="ok"){
				alert("审核成功");
				$("#bnQueryData").trigger("click");
				$("#shenhe").modal("hide");
			}
    	}
	});
}
function bohui(obj1,obj2,obj3){
	obj=obj1;
	lpname=obj2;
	usrid=obj3;
	$.ajax({
		url:"lpxxCollect!findrequest.action",
		dateType:"json",
		type:"POST",
		data:{"lpxx.id":obj},
		success: function(pager){
			$("[name='shenqingshuomingb']").val(pager.remark);
    	}
	})
}
function savebohui(){
	$.ajax({ 
		url: "lpxxCollect!bohui.action", 
		dataType: "json", 
		type: "POST",
		data : {"lpxx.id": obj, "lpxx.lpName": lpname,"lpxx.userId": usrid,"lpxx.checkRemark":$("[name='bohuibeizhu']").val()},
		success: function(pager){
			if(pager.code=="ok"){
				alert("驳回成功");
				$("#bnQueryData").trigger("click");
				$("#bohui").modal("hide");
			}
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
