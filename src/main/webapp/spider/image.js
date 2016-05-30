$(document).ready(function()
{
	
	// 图片类型切换.
	var selectshi =document.getElementById("selectshi");
	var fengdiv =document.getElementById("fenggediv");
	$("#houseExclusiveImgType").change(function()
	{
		var houseExclusiveImgTypeid = $("#houseExclusiveImgType").val();
		
		if(houseExclusiveImgTypeid ==1)
		{
			$("#houseExclusiveImgType1").click();
			selectshi.style.display = "block";
			fengdiv.style.display = "none";
		}
		else if(houseExclusiveImgTypeid ==2)
		{
			$("#houseExclusiveImgType2").click();
			selectshi.style.display = "none";
			fengdiv.style.display = "none";
		}
		else if(houseExclusiveImgTypeid ==3)
		{
			$("#houseExclusiveImgType3").click();
			selectshi.style.display = "none";
			fengdiv.style.display = "none";
		}
		else if(houseExclusiveImgTypeid ==4)
		{
			$("#houseExclusiveImgType4").click();
			selectshi.style.display = "none";
			fengdiv.style.display = "block";
		}
		else if(houseExclusiveImgTypeid ==5)
		{
			$("#houseExclusiveImgType5").click();
			selectshi.style.display = "none";
			fengdiv.style.display = "none";
		}
	});
	
	
	// 点击响应.
	$("#houseExclusiveImgType1").click(function()
	{
		$("#houseExclusiveImgType").val(1);
		selectshi.style.display = "block";
		fengdiv.style.display = "none";
	});
	$("#houseExclusiveImgType2").click(function()
	{
		$("#houseExclusiveImgType").val(2);
		selectshi.style.display = "none";
		fengdiv.style.display = "none";
	});
	$("#houseExclusiveImgType3").click(function()
	{
		$("#houseExclusiveImgType").val(3);
		selectshi.style.display = "none";
		fengdiv.style.display = "none";
	});
	
	$("#houseExclusiveImgType4").click(function()
	{
		$("#houseExclusiveImgType").val(4);
		selectshi.style.display = "none";
		fengdiv.style.display = "block";
	});
	$("#houseExclusiveImgType5").click(function()
	{
		$("#houseExclusiveImgType").val(5);
		selectshi.style.display = "none";
		fengdiv.style.display = "none";
	});

	
});




//获取所有选中
$('#houseExclusiveImgType').change(function()
{
	imageQuery();
});


// 查询图片数据.
function imageQuery()
{
	var lpid = $("#lpxxid").val();
	var url = basepath + "/spider/spiderAction!imageQuery.action";
	$("#imagePageWidget").asynPage(url, "#imageListBody", imageBuildDataHtml, true,true,
	{
		'imgUrl' : imgUrl,
		'imgType' : $("#houseExclusiveImgType").val()
	});
	
	$("#tuplpid").val(lpid);
	
	uplptp();
};
var imageDataList;
function imageBuildDataHtml(list)
{
	imageDataList=list;
	$("#imageListBody").html("");
	
	$.each(list,function(i, info)
	{
		var buildHtml =
		[
			'<tr>',
			'<td class="text-center">'+info[3]+'</td>',
			'<td class="text-center"><img src="'+info[2]+'" width="150" height="115" /></td>',
			'</tr>' ].join('');
			$("#imageListBody").append(buildHtml);
		
		
	});

};

