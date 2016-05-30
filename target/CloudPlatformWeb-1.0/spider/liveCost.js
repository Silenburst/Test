$(document).ready(function()
{
	// 初始化.
	getSyscsOPTION(940,"ctype");
	getSyscsOPTION(22,"payingWay");	
	
});

function juzhuchengbenAdd()
{
	updateLiveTable();
	$("#juzhuchengbenAdd").click();
}

function costInitial()
{
	$("#costId").val(0);
	
	updateLiveTable();
}

function updateLiveTable()
{
	//$("#coseEditorTable tr:not(:first)").empty();
	$("#coseEditorTable tr").eq(1).nextAll().remove();
	
	// 搜房
	var source1=new Array();
	// 安居客
	var source2=new Array();
	// 0731新房网
	var source3=new Array();

	if(crawlDataList!=null && crawlDataList.length>0)
	{
		for(var i=0;i<crawlDataList.length;i++)
		{
			var source = crawlDataList[i][sourceIndex];
			if(source=="搜房")
				source1=crawlDataList[i];
			if(source=="安居客")
				source2=crawlDataList[i];
			if(source=="0731新房网")
				source3=crawlDataList[i];
		}
	}
	
	// 成本信息.
	// ---------------------------------------------
	var costFields = new Array();

	var txt=$("#ctype").find("option:selected").text();
	if(txt=="物业费")
	{
		// 物业费.
		costFields[0]='金额/单价~unitPrice~51~unitPrice';
		costFields[1]='计量单位~unit~100~unit';
		costFields[2]='备注~remarks~47~remarks';
	}
	else if(txt=="水费")
	{
		costFields[0]='金额/单价~unitPrice~100~unitPrice';
		costFields[1]='计量单位~unit~100~unit';
		costFields[2]='备注~remarks~100~remarks';
	}
	else if(txt=="电费")
	{
		costFields[0]='金额/单价~unitPrice~100~unitPrice';
		costFields[1]='计量单位~unit~100~unit';
		costFields[2]='备注~remarks~100~remarks';
	}
	else if(txt=="燃气费")
	{
		costFields[0]='金额/单价~unitPrice~100~unitPrice';
		costFields[1]='计量单位~unit~100~unit';
		costFields[2]='备注~remarks~100~remarks';
	}
	else if(txt=="卫生费")
	{
		costFields[0]='金额/单价~unitPrice~100~unitPrice';
		costFields[1]='计量单位~unit~100~unit';
		costFields[2]='备注~remarks~100~remarks';
	}
	else if(txt=="车位费")
	{
		costFields[0]='金额/单价~unitPrice~100~unitPrice';
		costFields[1]='计量单位~unit~100~unit';
		costFields[2]='备注~remarks~100~remarks';
	}
	else
	{
		costFields[0]='金额/单价~unitPrice~100~unitPrice';
		costFields[1]='计量单位~unit~100~unit';
		costFields[2]='备注~remarks~100~remarks';
	}
	
    var costBodyHtml='';
	for(var i=0;i<costFields.length;i++)
	{
		var field=costFields[i].split("~");
		var title=field[0];
		var key=field[1];
		var index=field[2];
		var store=field[3];
		
		var s1=source1[index];
		if(s1==undefined)
			s1='';
		var s2=source2[index];
		if(s2==undefined)
			s2='';
		var s3=source3[index];
		if(s3==undefined)
			s3='';
		
		if(key=="unitPrice")
		{
			var regExp=/[0-9.]*/g;
			var arr;
			arr = regExp.exec(s1);
			if(arr!=null && arr.length>0)
				s1=arr[0];
			arr = regExp.exec(s2);
			if(arr!=null && arr.length>0)
				s2=arr[0];
			arr = regExp.exec(s3);
			if(arr!=null && arr.length>0)
				s3=arr[0];
		}
		
		costBodyHtml=costBodyHtml+'<tr>';
		costBodyHtml=costBodyHtml+'<td style="word-wrap:break-word;">'+title+'</td>';
		
		costBodyHtml=costBodyHtml+'<td style="word-wrap:break-word;"><input id="'+key+'" name="'+store+'" type="text" value=""></input></td>';
		
		costBodyHtml=costBodyHtml+'<td onclick="clickUpdate(\''+store+'\',this);" style="cursor:pointer;"><div style="width:125px;word-wrap:break-word;overflow:hidden;text-overflow:ellipsis;" title="'+s1+'">'+s1+'</div></td>';
		costBodyHtml=costBodyHtml+'<td onclick="clickUpdate(\''+store+'\',this);" style="cursor:pointer;"><div style="width:125px;word-wrap:break-word;overflow:hidden;text-overflow:ellipsis;" title="'+s2+'">'+s2+'</div></td>';
		costBodyHtml=costBodyHtml+'<td onclick="clickUpdate(\''+store+'\',this);" style="cursor:pointer;"><div style="width:125px;word-wrap:break-word;overflow:hidden;text-overflow:ellipsis;" title="'+s3+'">'+s3+'</div></td>';
		costBodyHtml=costBodyHtml+'</tr>';
	}
	
	$("#coseEditorTable").append(costBodyHtml);
	
	
	var txt=$("#ctype").find("option:selected").text();
	if(txt=="物业费")
		$("#unit").val("元/月/㎡");
	else if(txt=="水费")
		$("#unit").val("元/吨");
	else if(txt=="电费")
		$("#unit").val("元/度");
	else if(txt=="燃气费")
		$("#unit").val("元/ m3");
	else if(txt=="卫生费")
		$("#unit").val("元/月");
	else if(txt=="车位费")
		$("#unit").val("元/月/个");
	
	jQuery('#juzhuchengben').modal('show')
}

function updateUnit()
{
	//if($("#ctype").val())
}

//保存维护信息.
function costSave()
{
	var id = $("#costId").val();
	var lpid = $("#lpxxid").val();
	
	if(lpid==null || lpid.length<1)
		alert("请先保存基础信息");
	
	var ctype = $("#ctype").val().replace(/\s+/g, "");
	if (ctype == null || ctype == "0")
	{
		bootbox.alert(
		{
			title : "提示",
			message : "请选择类型!"
		});
		return false;
	}
	var payingWay = $("#payingWay").val().replace(/\s+/g, "");
	if (payingWay == null || payingWay == "0")
	{
		bootbox.alert(
		{
			title : "提示",
			message : "请选择计费方式!"
		});
		return false;
	}
	
	var price = $("#unitPrice").val();
	if(!checkUnitPrice(price))
	{
		bootbox.alert(
		{
			title : "提示",
			message : "请设定正确的金额/单价!"
		});
		return false;
	}
	
	var unit = $("#unit").val();
	var remarks = $("#remarks").val();
	$.ajax(
	{
		url : basepath + "/add/housingCostAction!addDwell.action",
		dataType : "json",
		type : "POST",
		async : false,
		data :
		{
			"costid" : id,
			"lpid" : lpid,
			"ctype" : ctype,
			"payingWay" : payingWay,
			"price" : price,
			"unit" : unit,
			"flag":1,
			"remark" : remarks
		},
		success : function(data)
		{
			var cHtml = '';
			if (data != null)
			{
				alert('添加成功!');
				
				costInitial();
				//jQuery('#juzhuchengben').modal('hide');
				
				costQuery();
			}
			else
			{
				alert('添加失败!');
			}
			
			//$("#country").append(cHtml);
		}
	});
}

//删除居住成本信息
function costDelete(id)
{
	bootbox.confirm(
			{
				title : "<p>提示",
				message : "<a>请确定要删除吗",
				callback : function(result)
				{
					if (result)
					{// 判断是否点击了确定按钮
						// 执行删除等操作
						$
								.ajax(
								{
									url : basepath
											+ "/add/housingCostAction!deleteCost.action",
									dataType : "json",
									type : "POST",
									data :
									{
										"costid" : id
									},
									success : function(result)
									{
										if (result.data == "success")
										{
											bootbox.alert(
											{
												title : "提示",
												message : "删除成功!"
											});
											
										}
										else
										{
											bootbox.alert(
											{
												title : "提示",
												message : "删除失败：" + result.data
											});
										}
										
										costQuery();
									}
								});
					}
				}
			});
}

function costUpdate(costid)
{
	
	if(costDataList!=null && costDataList.length>0)
	{
		for(var i=0;i<costDataList.length;i++)
		{
			var data=costDataList[i];
			if(data[0]==costid)
			{
				$("#costId").val(data[0]);
				updateChangeSelect($("#ctype"),data[7]);
				updateChangeSelect($("#payingWay"),data[8]);
			}
		}
	}
	
	updateLiveTable();
	
	if(costDataList!=null && costDataList.length>0)
	{
		for(var i=0;i<costDataList.length;i++)
		{
			var data=costDataList[i];
			if(data[0]==costid)
			{
				$("#costId").val(data[0]);
				updateChangeSelect($("#ctype"),data[7]);
				updateChangeSelect($("#payingWay"),data[8]);
				
				$("#unitPrice").val(data[4]);
				$("#unit").val(data[5]);
				$("#remarks").val(data[6]);
			}
		}
	}
}


// 查询成本数据.
function costQuery()
{
	var lpid = $("#lpxxid").val();
	var url1 = basepath + "/add/housingCostAction!pageinfo.action";
	$("#macPageWidget").asynPage(url1, "#costBody", costBuildDataHtml, true,true,
	{
		'enetiy.lpid' : lpid,
	});
};
var costDataList;
function costBuildDataHtml(list)
{
	costDataList=list;
	$("#costBody").html("");
	
	$
			.each(
					list,
					function(i, info)
					{
						var buildHtml =
						[
								'<tr>',
								'<td class="text-center">',
								'<input type="checkbox" class="cbr" ame="id"/>',
								'</td>',
								'<td class="text-center">',
								info[2] == "null" || info[2] == ""
										|| info[2] == null ? "" : info[2],
								'</td>',
								'<td class="text-center">',
								info[3] == "null" || info[3] == ""
										|| info[3] == null ? "" : info[3],
								'</td>',
								'<td class="text-center">',
								info[4] == "null" || info[4] == ""
										|| info[4] == null ? "" : info[4],
								'</td>',
								'<td class="text-center">',
								info[5] == "null" || info[5] == ""
										|| info[5] == null ? "" : info[5],
								'</td>',
								'<td class="text-center">',
								info[6] == "null" || info[6] == ""
										|| info[6] == null ? "" : info[6],
								'</td>',
								'<td class="text-center"><a href="#" class="pr10" data-toggle="modal" data-id="'
										+ info[0]
										+ '" onclick="costUpdate('
										+ info[0]
										+ ')" ><i class="fa-pencil"></i>修改</a><a href="#" onclick="costDelete('
										+ info[0]
										+ ')"><i class="fa-trash-o"></i>删除</a></td>',
								'</tr>' ].join('');
						$("#costBody").append(buildHtml);
					});

};




function toleizeng()
{
	$("#modalleizeng").click();
}



function costWindowClose()
{
	$("#costId").val('0');
	$("#ctype option[value='0']").attr("selected", true);
	$("#payingWay option[value='0']").attr("selected", true);
	$("#unitPrice").val('');
	$("#unit").val('');
	$("#remarks").val('');
}



function costCheck()
{
	var maintenanceType = $("#maintenanceType").val();
	if (maintenanceType == null || maintenanceType == "" || maintenanceType == "0")
	{
		bootbox.alert(
		{
			title : "提示",
			message : "请选择类型!"
		});
		return false;
	}

	var enterprise = $("#enterprise").val().replace(/\s+/g, "");

	if (enterprise == null || enterprise == "")
	{
		bootbox.alert(
		{
			title : "提示",
			message : "请输入企业单位名称!"
		});
		return false;
	}
	if (isChineseChar(enterprise))
	{
		bootbox.alert(
		{
			title : "提示",
			message : "企业单位名称,请输入中文!"
		});
		return false;
	}
	
	var phone = $("#phone").val().replace(/\s+/g, "");
	if (checktel(phone))
	{
		bootbox.alert(
		{
			title : "提示",
			message : "请输入正确的手机号码或电话号码!"
		});
		return false;
	}
	return true;
}
function isChineseChar(str)
{
	var reg = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
	if (!reg.test(str))
	{
		return true;
	}
	return false;
}
function checkUnitPrice(input)
{
	var re = /^[0-9.]*]*$/; // 判断字符串是否为数字 //判断正整数 /^[1-9]+[0-9]*]*$/
	if (!input.match(re))
	{
		return false;
	}
	return true;
}
function checktel(input)
{
	var re = /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/; // 判断字符串是否为数字
	// //判断正整数
	// /^[1-9]+[0-9]*]*$/
	if (!input.match(re))
	{
		return false;
	}
	return true;
}