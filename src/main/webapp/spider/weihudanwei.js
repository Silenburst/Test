$(document).ready(function()
{
	// 初始化.
	getSyscsOPTION(939, "maintenanceType");
	
	updateMaintenanceTable();
});

function updateMaintenanceTable()
{
	$("#mantenanceEditorTable tr:not(:first)").empty();
	
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
	
	// 维护信息.
	// ---------------------------------------------
	var mantenanceFields = new Array();

	var txt=$("#maintenanceType").find("option:selected").text();
	if(txt=="开发商")
	{
		// 开发商.
		mantenanceFields[0]='企业单位名称~enterprise~53~enterprise';
		mantenanceFields[1]='联系方式~phone~54~phone';
		mantenanceFields[2]='单位地址~dizhi~49~dizhi';
		mantenanceFields[3]='备注~remark~49~remark';
	}
	else if(txt=="物业管理")
	{
		mantenanceFields[0]='企业单位名称~enterprise~47~enterprise';
		mantenanceFields[1]='联系方式~phone~48~phone';
		mantenanceFields[2]='单位地址~dizhi~49~dizhi';
		mantenanceFields[3]='备注~remark~49~remark';
	}
	else if(txt=="施工单位")
	{
		mantenanceFields[0]='企业单位名称~enterprise~56~enterprise';
		mantenanceFields[1]='联系方式~phone~100~phone';
		mantenanceFields[2]='单位地址~dizhi~49~dizhi';
		mantenanceFields[3]='备注~remark~49~remark';
	}
	else if(txt=="销售代表")
	{
		mantenanceFields[0]='企业单位名称~enterprise~57~enterprise';
		mantenanceFields[1]='联系方式~phone~100~phone';
		mantenanceFields[2]='单位地址~dizhi~49~dizhi';
		mantenanceFields[3]='备注~remark~49~remark';
	}
	else if(txt=="建筑设计")
	{
		mantenanceFields[0]='企业单位名称~enterprise~56~enterprise';
		mantenanceFields[1]='联系方式~phone~100~phone';
		mantenanceFields[2]='单位地址~dizhi~49~dizhi';
		mantenanceFields[3]='备注~remark~49~remark';
		
	}
	else
	{
		// 开发商.
		mantenanceFields[0]='企业单位名称~enterprise~100~enterprise';
		mantenanceFields[1]='联系方式~phone~100~phone';
		mantenanceFields[2]='单位地址~dizhi~100~dizhi';
		mantenanceFields[3]='备注~remark~100~remark';
	}
	
    var mantenanceBodyHtml='';
	for(var i=0;i<mantenanceFields.length;i++)
	{
		var field=mantenanceFields[i].split("~");
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
		
		// 替换‘-’
		/**
		if(index=="54")
		{
			s1=s1.replace(/\-/g,'');
			s2=s2.replace(/\-/g,'');
			s3=s3.replace(/\-/g,'');
		}
		**/
		
		mantenanceBodyHtml=mantenanceBodyHtml+'<tr>';
		mantenanceBodyHtml=mantenanceBodyHtml+'<td style="word-wrap:break-word;">'+title+'</td>';
		mantenanceBodyHtml=mantenanceBodyHtml+'<td style="word-wrap:break-word;"><input id="'+key+'" name="lpxx.'+store+'" type="text" value=""></input></td>';
		mantenanceBodyHtml=mantenanceBodyHtml+'<td onclick="clickUpdate(\''+store+'\',this);" style="cursor:pointer;"><div style="width:125px;word-wrap:break-word;overflow:hidden;text-overflow:ellipsis;" title="'+s1+'">'+s1+'</div></td>';
		mantenanceBodyHtml=mantenanceBodyHtml+'<td onclick="clickUpdate(\''+store+'\',this);" style="cursor:pointer;"><div style="width:125px;word-wrap:break-word;overflow:hidden;text-overflow:ellipsis;" title="'+s2+'">'+s2+'</div></td>';
		mantenanceBodyHtml=mantenanceBodyHtml+'<td onclick="clickUpdate(\''+store+'\',this);" style="cursor:pointer;"><div style="width:125px;word-wrap:break-word;overflow:hidden;text-overflow:ellipsis;" title="'+s3+'">'+s3+'</div></td>';
		mantenanceBodyHtml=mantenanceBodyHtml+'</tr>';
	}
	$("#mantenanceEditorTable").append(mantenanceBodyHtml);
	
	
}

function clickTab2()
{
	mantenanceQuery();
}

function mantenanceInitial()
{
	updateMaintenanceTable();
	
	jQuery('#weihudanwei').modal('show');
}

function updateHtml()
{
	
}

function mantenanceQuery()
{
	var lpid = $("#lpxxid").val();
	var url = basepath + "/add/maintenanceAction!findByPageInFo.action";
	$("#macPageWidget").asynPage(url, "#tbodyData", buildMantenanceDataHtml,true, true,
	{
		'enetiy.lpid' : lpid,
	});
};
var mantenanceDataList;
function buildMantenanceDataHtml(list)
{
	mantenanceDataList=list;
	$("#tbodyData").html("");
	$.each(
					list,
					function(i, info)
					{
						var tr =
						[
								'<tr>',
								'<td class="text-center"></td>',
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
										+ '" onclick="mantenanceUpdate('
										+ info[0]
										+ ')" ><i class="fa-pencil"></i>修改</a><a href="#" onclick="deleteLPM('
										+ info[0]
										+ ')"><i class="fa-trash-o"></i>删除</a></td>',
								'</tr>' ].join('');
						$("#tbodyData").append(tr);
					});
};

// 保存维护信息.
function saveMantenance()
{
	var lpid = $("#lpxxid").val();
	var lpmId = $("#lpmId").val();

	var maintenanceType = $("#maintenanceType").val();
	var companyName = $("#enterprise").val();
	var iphone = $("#phone").val();

	var dizhi = $("#dizhi").val();

	var remark = $("#remark").val();
	
	if(lpid==null || lpid.length<1)
		alert("请先保存基础信息");

	if (lpmCheck())
	{
		$.ajax(
		{
			url : basepath + "/add/maintenanceAction!addData.action",
			dataType : "json",
			type : "POST",
			async : false,
			data :
			{
				"lpmId" : lpmId,
				"lpid" : lpid,
				"mtype" : maintenanceType,
				"companyName" : companyName,
				"tel" : iphone,
				"address" : dizhi,
				"remark" : remark
			},
			success : function(data)
			{
				if (data != null)
				{
					alert('保存成功!');
					
					//jQuery('#weihudanwei').modal('hide');
					updateMaintenanceTable();
					
					mantenanceQuery();
				}
				else
				{
					alert('保存失败!');
				}
			}
		});
	}
}




var fian = false;
function update()
{
	var companyName = $("#enterprise").val();
	$.ajax(
	{
		url : basepath + "/add/maintenanceAction!update.action",
		dataType : "json",
		type : "POST",
		async : false,
		data :
		{
			"companyName" : companyName
		},
		success : function(data)
		{
			if (data > 0)
			{
				alert('名称已重复,请重新输入!');
				return false;
			}
		}
	});
}

function buttong()
{
	$("#maintenanceType option[value='0']").attr("selected", true);
	$("#lpmId").val(0);
	$("#enterprise").val('');
	$("#phone").val('');
	$("#dizhi").val('');
	$("#remark").val('');
}

function uopdayt()
{
	$("#costId").val('0');
	$("#ctype option[value='0']").attr("selected", true);
	$("#payingWay option[value='0']").attr("selected", true);
	$("#price").val('');
	$("#unit").val('');
	$("#remarks").val('');
}

function mantenanceUpdate(lpmId)
{
	mantenanceInitial();
	
	if(mantenanceDataList!=null && mantenanceDataList.length>0)
	{
		for(var i=0;i<mantenanceDataList.length;i++)
		{
			var data=mantenanceDataList[i];
			if(data[0]==lpmId)
			{
				$("#lpmId").val(data[0]);
				updateChangeSelect($("#maintenanceType"),data[7]);
				
				$("#enterprise").val(data[3]);
				$("#phone").val(data[4]);
				$("#dizhi").val(data[5]);
				$("#remark").val(data[6]);
			}
		}
	}
}



// 删除维护单位信息
function deleteLPM(id)
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
				$.ajax(
				{
					url : basepath + "/add/maintenanceAction!deleteLPM.action",
					dataType : "json",
					type : "POST",
					data :
					{
						"lpmId" : id
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
							mantenanceQuery();
						}
						else
						{
							bootbox.alert(
							{
								title : "提示",
								message : "删除失败：" + result.data
							});
						}
						
						mantenanceQuery();
					}
				});
			}
		}
	});
}

// 删除居住成本信息
function deleteCost(id)
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
									}
								});
					}
				}
			});
}




function lpmCheck()
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
	var telTest=checkTelephone(phone);
	if (telTest)
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
function checkNumber(input)
{
	var re = /^[0-9]*]*$/; // 判断字符串是否为数字 //判断正整数 /^[1-9]+[0-9]*]*$/
	if (!input.match(re))
	{
		return false;
	}
	return true;
}
function checkTelephone(input)
{
	var re = /^[0-9|\-|\(|\)|\（|\）|转]*$/; // 判断字符串是否为数字
	if (re.test(input))
	{
		return false;
	}
	
	return true;
}

