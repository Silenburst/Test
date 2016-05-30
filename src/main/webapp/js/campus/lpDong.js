//单个添加栋数
var curDongId = "";
var curDanyuanId = "";
var curCeng = "";
var curFanghaoId = "";
var curCrrHouse = "";
function dongAddTypeClicked(theRdo){
	var theTable = $("#tblAddDong");
	theTable.find("tr:gt(0)").hide();
	theTable.find(".dong"+$(theRdo).val()).show();
};
//显示栋信息
function showDongInfo(val){
	$.ajax({
		url: basepath + "/cam/campus!showDongLp.action",
		dataType: "json", 
		type: "POST",
		data: {"lpid":val},
		success: function(result){
			var pHtml = '';
			$.each(result, function(i,n){
				pHtml += '<tr style="color:#000000" onclick="dongTrClicked(this,\''+n.id+'\')" >'
					  + '<td class="text-center"><input type="checkbox" class="lpLdong" name="" value="'+n.id+'" />'+(i+1)+'</td><td class="text-center" ><a href="javascript:void(0)"  name="lpname" style="color:#000000">'+n.lpdName+'</a></td>'
					  + '<td class="text-center"><a href="javascript:void(0)" class="pr10" data-toggle="modal" data-id="'+n.id
					  + '" onclick="showUpdateDongDlg(this)" data-target="#Xiugai" style="color:#000000">修改</a>'
					  + '<a href="javascript:void(0)" onclick="deleteDong('+n.id+')" style="color:#000000">删除</a></td></tr>';
			});
			$("#dongTbody").html(pHtml);
		}
	});
};

function showAddDongDlg(){
	initAddDongDlg();
};

function queryDong(){
	var lpdName = $("#lpdong_lpdName").val();
	$("#tblLpdong tbody tr").each(function(i,n){
		if(lpdName=="" || $(n).find("td:eq(1)").text().indexOf(lpdName)>-1){
			$(n).show();
		} else {
			$(n).hide();
		}
	});
};


function queryCeng(){
	var lpdName = $("#fangHao_ceng").val();
	$("#tblLpceng tbody tr").each(function(i,n){
		if(lpdName=="" || $(n).find("td:eq(1)").text().indexOf(lpdName)>-1){
			$(n).show();
		} else {
			$(n).hide();
		}
	});
};

function queryFanghao(){
	var lpdName = $("#fangHao_ceng1").val();
	$("#tblLpfanghao tbody tr").each(function(i,n){
		if(lpdName=="" || $(n).find("td:eq(1)").text().indexOf(lpdName)>-1){
			$(n).show();
		} else {
			$(n).hide();
		}
	});
};

//初始化新增栋座对话框
function initAddDongDlg(){
	var theTable = $("#tblAddDong");
	theTable.find("tr:gt(0) input").val("");
	$("[name='xhjLpdong.type']:eq(0)").prop("checked", true);
	theTable.find(".dongBatch").hide();
	theTable.find(".dongSingle").show();
};
//保存栋座备注信息
function saveDzRemark(){
	$.ajax({
		url: basepath + "/cam/campus!saveDzRemark.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data: {"lpid":$("#tuplpid").val(), "dzRemark":$("#dzRemark").val()},
		success: function(result){
			if(result.data == "success"){
				bootbox.alert({title:"提示",message:"保存栋座备注成功!"});
				$("#tabSs").click();
			} else {
				bootbox.alert({title:"提示",message:"保存栋座备注失败：" + result.data});
			}
		}
	});
};

//执行新增栋座操作
function doAddDong(){
	var dongAddType = $("input[name='xhjLpdong.type']:checked").val();
	var $form = $("#tblAddDong");
	var lpxx_lpid=$("#tuplpid").val();
	if(dongAddType=="Single"){	// 单个新增
		var lpdName = $form.find("input[name='xhjLpdong.lpdName']").val();
		if(lpdName==""){
			//弹出提示框
			bootbox.alert({title:"提示",message:"请输入栋座名称！"});
			return;
		}
		$.ajax({
			url: basepath + "/cam/campus!addDong.action",
			dataType: "json", 
			type: "POST",
//			async : false,
			data: $('#donglouForm').serialize(),
			beforeSend: function () {
		        // 禁用按钮防止重复提交
		        $(this).attr("disabled", true);
		        $('.onsubing').css("display","block");//弹出提示框
		    },
			success: function(result){
				if(result.data == "success"){
					//弹出提示框
					bootbox.alert({title:"提示",message:"新增成功!"});
					document.getElementById("donglouForm").reset();
					showDongInfo(lpxx_lpid);
					$('#dongClose').click();
				} else {
					//弹出提示框
					bootbox.alert({title:"提示",message:"新增失败：" + result.data});
				}
			},
		    complete: function () {
		        $(this).removeAttr("disabled");
		    	$('.onsubing').css("display","none");//弹出提示框
		    },
		    error: function (data) {
		        console.info("error: " + data.responseText);
		    }
		});
	} else if(dongAddType=="Batch"){	// 批量新增
		var prefix = $form.find("[name='xhjLpdong.prefix']").val();
		var start = $form.find("[name='xhjLpdong.start']").val();
  	  	if(start=="" || isNaN(start)){
  	  	//弹出提示框
  	  		bootbox.alert({title:"提示",message:"批量序号不正确!"});
  	  		return;
  	  	}
  	  	var end = $form.find("[name='xhjLpdong.end']").val();
  	  	if(end=="" || isNaN(end)){
  	  	//弹出提示框
  	  		bootbox.alert({title:"提示",message:"批量序号不正确!"});
  	  		return;
  	  	}
  	  	var suffix = $form.find("[name='xhjLpdong.suffix']").val();
  	  
  	  	$.ajax({
  	  		url: basepath + "/cam/campus!addDong.action",
			dataType: "json", 
			type: "POST",
//			async : false,
			data: $('#donglouForm').serialize(),
			beforeSend: function () {
		        // 禁用按钮防止重复提交
		        $(this).attr("disabled", true);
		        $('.onsubing').css("display","block");//弹出提示框
		    },
			success: function(result){
				if(result.data == "success"){
					//弹出提示框
					bootbox.alert({title:"提示",message:"新增成功!"});
					document.getElementById("donglouForm").reset();
					showDongInfo(lpxx_lpid);
					$('#dongClose').click();
				} else {
					//弹出提示框
					bootbox.alert({title:"提示",message:"新增失败：" + result.data});
				}
	    	},
		    complete: function () {
		        $(this).removeAttr("disabled");
		    	$('.onsubing').css("display","none");//弹出提示框
		    },
		    error: function (data) {
		        console.info("error: " + data.responseText);
		    }
  	  	});
	}
 };
 //新增单元
 function doAddDanyuan(theButton){
  var danyuanAddType = $("input[name='xhjLpdanyuan.type']:checked").val();
  var $form = $("#tblAddDanyuan");
//  var dType1 = $("#dType1").val();
//  var topNum1= $("#topNum1").val();
//  var underNum1 = $("#underNum1").val();
//  var totalNum = $("#totalNum").val();
//  var dihu= $("#dihu").val();
//  var remarks1 = $("#remarks1").val();
  if(danyuanAddType=="Single"){	//单个新增
	  var dyName = $form.find("input[name='xhjLpdanyuan.dyName']").val();
	  if(dyName==""){
		  //弹出提示框
		  bootbox.alert({title:"提示",message:"请输入单元名称！"});
		  return;
	  }
	  
	  $.ajax({ 
		url: basepath + "/cam/campus!addDany.action",
		dataType: "json", 
		type: "POST",
		data: $('#danyuanForm').serialize(),
		beforeSend: function () {
	        // 禁用按钮防止重复提交
	        $(this).attr("disabled", true);
	        $('.onsubing').css("display","block");//弹出提示框
	    },
		success: function(result){
			if(result.data=="success"){
				 //弹出提示框
				bootbox.alert({title:"提示",message:"新增成功!"});
				document.getElementById("danyuanForm").reset();
				showDanyuanOfDong(curDongId);
				$('#danyClose').click();
			} else {
				 //弹出提示框
				bootbox.alert({title:"提示",message:"新增失败：" + result.data});
			}
    	},
	    complete: function () {
	        $(this).removeAttr("disabled");
	    	$('.onsubing').css("display","none");//弹出提示框
	    },
	    error: function (data) {
	        console.info("error: " + data.responseText);
	    }
	});
  } else if(danyuanAddType=="Batch"){	//批量新增
	  var prefix = $form.find("input[name='xhjLpdanyuan.prefix']").val();
  	  var start = $form.find("input[name='xhjLpdanyuan.start']").val();
  	  if(start=="" || isNaN(start)){
  		 //弹出提示框
  		  bootbox.alert({title:"提示",message:"批量序号不正确!"});
  		  return;
  	  }
  	  var end = $form.find("[name='xhjLpdanyuan.end']").val();
  	  if(end=="" || isNaN(end)){
  		 //弹出提示框
  		  bootbox.alert({title:"提示",message:"批量序号不正确!"});
  		  return;
  	  }
	  var suffix = $form.find("[name='xhjLpdanyuan.suffix']").val();
	  
	  $.ajax({ 
		  	url: basepath + "/cam/campus!addDany.action",
			dataType: "json", 
			type: "POST",
			data: $('#danyuanForm').serialize(),
			beforeSend: function () {
		        // 禁用按钮防止重复提交
		        $(this).attr("disabled", true);
		        $('.onsubing').css("display","block");//弹出提示框
		    },
			success: function(result){
				if(result.data == "success"){
					 //弹出提示框
					bootbox.alert({title:"提示",message:"新增成功!"});
					document.getElementById("danyuanForm").reset();
					showDanyuanOfDong(curDongId);
					$('#danyClose').click();
				} else {
					 //弹出提示框
					bootbox.alert({title:"提示",message:"新增失败：" + result.data});
					}
		    	},
		    	complete: function () {
				        $(this).removeAttr("disabled");
				    	$('.onsubing').css("display","none");//弹出提示框
				    },
				    error: function (data) {
				        console.info("error: " + data.responseText);
				    }
			});
	  }
	  
};
 
//点击栋座某一行显示其下的单元信息
 function dongTrClicked(theLink,id){
	 curDongId = "";
	 curDanyuanId = "";
	 curCeng = "";
	 curCrrHouse = "";
 	  var $dongTable = $("#tblLpdong");
 	  $(".lpdz").prop('checked',false);
 	  $dongTable.find("tbody tr").css("background-color","#F8F8F8");
 	  var theRow = $(theLink);
 	  theRow.css("background-color","#8DEEEE");
 	  curDongId = id;
 	  showDanyuanOfDong(curDongId);
 };
 
 //点击单元某一行显示其下的层信息
 function danyuanTrClicked(theLink,id){
	 curDanyuanId = "";
	 curCeng = "";
	 curCrrHouse = "";
	  var $danyuanTable = $("#tblLpdanyuan");
	  $(".lpdy").prop('checked',false);
//	  $danyuanTable.find("tbody tr").removeClass("active");
	  $danyuanTable.find("tbody tr").css("background-color","#F8F8F8");
	  var theRow = $(theLink);
	  theRow.css("background-color","#8DEEEE");
	  curDanyuanId = id;
	  showCengsOfDy(curDanyuanId);
 };

 //点击某一层显示其下的房号信息
 function cengTrClicked(theLink, id) {
	 curCeng = "";
	 curCrrHouse = "";
	var $cengTable = $("#tblLpceng");
	$(".cbALL").prop('checked',false);
	$cengTable.find("tbody tr").css("background-color","#F8F8F8");
	var theRow = $(theLink);
//	theRow.addClass("active");
	 theRow.css("background-color","#8DEEEE");
	curCeng = id;
	showFanghaosOfCeng(curDanyuanId, curCeng);
};
 
//================单元操作===================================================================
	//显示某一栋的单元信息
function showDanyuanOfDong(dongId){
	  $("#tblLpceng tbody").html("");
	  $("#tblLpfanghao tbody").html("");
	  var $tblLpdanyuan = $("#tblLpdanyuan");
	  curDanyuanId = "";
	  $tblLpdanyuan.find("tbody tr").remove();
	  $.ajax({
		  	url: basepath + "/cam/campus!showLpDanyuan.action",
			dataType: "json",
			type: "POST",
			data: {"dongId":dongId},
////			async:false,
			success: function(dyList){
				//alert(JSON.stringify(dyList));
				var $tbody = $tblLpdanyuan.find("tbody");
				var sHtml = "";
				$.each(dyList, function(i,n){
//						<a href="javascript:void(0)" name="lpname" onclick="dongTrClicked(this,\''+n.id+'\')">'+n.lpdName+'</a>
					sHtml += '<tr onclick="danyuanTrClicked(this,\''+n.id+'\')">' 
							+ '<td class="text-center" class="col-md-1"><input  type="checkbox" class="lpdanyuan" name="" value="'+n.id+'" />'+(i+1)+'</td>' 
							+ '<td class="text-center" ><a name="dyName" href="javascript:void(0)" style="color:#000000">'+n.dyName+'</a></td>' 
							+ '<td class="text-center"><a href="javascript:void(0)" class="pr10" data-toggle="modal" data-id="'+n.id+ '" onclick="showUpdateDyDlg(this)" data-target="#XiugaiDy" style="color:#000000">修改</a>'
							+ '<a href="javascript:void(0)"  onclick="deleteDanyuan(\''+n.id+'\')" style="color:#000000">删除</a></td>' + 
						'</tr>';
				});
				$tblLpdanyuan.find("tbody").html(sHtml);
	    	}
		});
};

//============层信息维护============================================
function showCengsOfDy(dyId){
	  var $tblLpceng = $("#tblLpceng");
	  $("#tblLpfanghao tbody").html("");
	  $tblLpceng.find("tbody tr").remove();
	  $.ajax({ 
		url: basepath + "/cam/campus!showCeng.action",
		dataType: "json", 
		type: "POST",
//		async:false,
		data: {"dyId":dyId},
		success: function(cengList){
			var $tbody = $tblLpceng.find("tbody");
			var sHtml = "";
			if(cengList==null || cengList.length==0){
				sHtml += '<tr class="cengTr">' + 
					'<td class="col-md-3" class="text-center">&nbsp;</td>' + 
					'<td class="text-center" style="color:#000000">暂无数据,请先新增对应房号!</td>' 
				'</tr>';
			} else {
				$.each(cengList, function(i,n){
					sHtml += '<tr class="cengTr" onclick="cengTrClicked(this,\''+n.ceng+'\')">' + 
							'<td class="text-center" class="col-md-3" style="color:#000000">'+(i+1)+'</td>' + 
							//单元ID和层数
							'<td class="text-center" ><a style="color:#000000" href="javascript:void(0)">'+n.ceng+'</a></td>' 
						'</tr>';
				});
			}
			$tblLpceng.find("tbody").html(sHtml);
    	}
	});
};

//根据房号
function showFanghaosOfCeng(dyId, ceng) {
	var $tblLpfanghao = $("#tblLpfanghao");
	$tblLpfanghao.find("tbody tr").remove();
	$.ajax({
		url : basepath + "/cam/campus!showFanghaoOfDanyuan.action",
		dataType : "json",
		type : "POST",
		async : false,
		data : {
			"dyId" : dyId,
			"ceng" : ceng
		},
		success : function(fhList) {
			var $tbody = $tblLpfanghao.find("tbody");
			var sHtml = "";
			$.each(fhList,function(i, n) {
				sHtml += '<tr onclick="fanghaoTrClicked(this,\''+n.id+'\')">'
					+'<td class="text-center"><input type="checkbox" class="fanghaoCB" name="" value="'+n.id+'" />'+ (i + 1) + "</td>"
					+ '<td class="text-center" ><a href="javascript:void(0)"  style="color:#000000">'
					+ n.fhName
					+ '</a></td>'
					+ '<td class="text-center"><a class="pr10"  style="color:#000000" onclick="updateFanghao(this,\''+n.id+'\')">修改</a>'
					+ '<a  style="color:#000000" href="javascript:void(0)"  onclick="deleteFanghao('+n.id+',this)">删除</a></td>'
					+ '</tr>';
			});
			$tblLpfanghao.find("tbody").html(sHtml);
		}
	});
}
//修改栋模态窗初始
 function showUpdateDongDlg(theLink){
	  var theRow = $(theLink).parents("tr");
	  var dongId = $(theLink).attr("data-id");
	  var $theForm = $("#formUpdateDong");
	  $theForm.find("input[name='xhjLpdong.id']").val(dongId);
	  $theForm.find("input[name='xhjLpdong.lpdName']").val(theRow.find("a[name='lpname']").text());
	  $.ajax({
		  url : basepath + "/cam/campus!getDongId.action",
			type:"GET",
			dataType:"json",
			data:{"dzid":dongId},
			beforeSend: function () {
		        // 禁用按钮防止重复提交
		        $(this).attr("disabled", true);
		        $('.onsubing').css("display","block");//弹出提示框
		    },
			success:function(data){
				if(data.dtype!=null && data.dtype!=''&&data.dtype!='undefined'){
					 $("#dTypeup option[value='"+data.dtype+"']").attr("selected", true);
				}else{
					 $("#dTypeup option[value='0']").attr("selected", true);
				}
				 
				 $("#dyNumup").val(data.dyNum);
				$("#agesup").val(data.ages);
				$("#sizeup").val(data.size);
				$("#topNumup").val(data.topNum);
				 $("#underNumup").val(data.underNum);
				 if(data.located!=null && data.located!=''&&data.located!='undefined'){
					 $("#locatedup option[value='"+data.located+"']").attr("selected", true); 
				}else{
					 $("#locatedup option[value='0']").attr("selected", true);
				}
				 if(data.ownership!=null && data.ownership!=''&&data.ownership!='undefined'){
					 $("#ownershipup option[value='"+data.ownership+"']").attr("selected", true);
				 }else{
					 $("#ownershipup option[value='0']").attr("selected", true);
				 }
				
				 
				$("#remarksup").val(data.remarks);
			},
		    complete: function () {
		        $(this).removeAttr("disabled");
		    	$('.onsubing').css("display","none");//弹出提示框
		    },
		    error: function (data) {
		        console.info("error: " + data.responseText);
		    }
		});
};
//关联房源初始化
function fanghaoTrClicked(theLink,val){
	curCrrHouse = "";
	var $danyuanTable = $("#tblLpfanghao");
	$danyuanTable.find("tbody tr").css("background-color","#F8F8F8");
	var theRow = $(theLink);
	 theRow.css("background-color","#8DEEEE");
	curCrrHouse = val;
};
//查询关联房源
function showCorHouseInit(){
	var ids="";
	$('.fanghaoCB').each(function(i){
		if($(this).prop('checked')){
			ids += "," + $(this).val();
		}
	});
	if(curCrrHouse == "" && ids == "") {
		bootbox.alert({title:"提示",message:"请先选择要查看的房号!"});
		return;
	}
	 $.ajax({
	  	url: basepath + "/cam/campus!showCorHouseInit.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data: {"fhid" : curCrrHouse,"idss" : ids.substring(1)},
		beforeSend: function () {
	        // 禁用按钮防止重复提交
	        $(this).attr("disabled", true);
	        $('.onsubing').css("display","block");//弹出提示框
	    },
		success: function(data){
			var sHtml = "";
			if(data != null) {
				$.each(data,function(i, n) {
					var fwzt = n[7] =="null" || n[7] == null ?"":n[7];
					if(fwzt == "0") {
						fwzt = "无效";
					} else if(fwzt == "1"){
						fwzt = "有效";
					} else if(fwzt == "2"){
						fwzt = "定金";
					} else if(fwzt == "3"){
						fwzt = "签约未审核";
					} else if(fwzt == "4"){
						fwzt = "锁定";
					} else if(fwzt == "5"){
						fwzt = "签约已审核";
					} else {
						fwzt = "待审核";
					}
					sHtml += '<tr>'
						+ '<td>'+(n[0] == "null" || n[0] == null ? "" : n[0])+'</td><td>'+(n[1] == "null" || n[1] == null ? "" : n[1])+'</td><td>'+(n[2] == "null" || n[2] == null ? "" : n[2])+'</td><td>'+(n[3] == "null" || n[3] == null ? "" : n[3])+'</td><td>'+(n[4] == "null" || n[4] == null ? "" : n[4])+'</td><td>'+(n[5] == "null" || n[5] == null ? "" : n[5])+'</td>'
						+ '<td>'+(n[6] == "null" || n[6] == null ? "" : n[6])+'</td><td>'+fwzt+'</td><td>'+(n[8] == "null" || n[8] == null ? "" : n[8])+'</td><td>'+(n[9] == "null" || n[9] == null ? "" : n[9])+'</td><td>'+(n[10] == "null" || n[10] == null ? "" : n[10])+'</td>'
						+ '</tr>';
				});
			}
			$("#crrHouse").html(sHtml);
			$("#showCrrHouseModal").click();
	    },
	    complete: function () {
	        $(this).removeAttr("disabled");
	    	$('.onsubing').css("display","none");//弹出提示框
	    },
	    error: function (data) {
	        console.info("error: " + data.responseText);
	    }
	 });
};

//关联房源初始化
function fanghaoTrClicked1(theLink,val){
	var $danyuanTable1 = $("#tblLpdanyuan");
	$danyuanTable1.find("tbody tr").removeClass("active");
	var theRow1 = $(theLink).parent();
	theRow1.addClass("active");
	curCrrHouse = val;
};
//查询关联房源
function showCorHouseInitDanYan(){
	var idss="";
	$('.lpdanyuan').each(function(i){
		if($(this).prop('checked')){
			idss += "," + $(this).val();
		}
	});
	if(curCrrHouse == "" && idss == "") {
		bootbox.alert({title:"提示",message:"请先选择要查看的单元!"});
		return;
	}
	 $.ajax({
	  	url: basepath + "/cam/campus!showCorHouseInitDanYuan.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data: {"idss" : idss.substring(1)},
		beforeSend: function () {
	        // 禁用按钮防止重复提交
	        $(this).attr("disabled", true);
	        $('.onsubing').css("display","block");//弹出提示框
	    },
		success: function(data){
			var sHtml = "";
			if(data != null) {
				$.each(data,function(i, n) {
					var fwzt = n[7] =="null" || n[7] == null ?"":n[7];
					if(fwzt == "0") {
						fwzt = "无效";
					} else if(fwzt == "1"){
						fwzt = "有效";
					} else if(fwzt == "2"){
						fwzt = "定金";
					} else if(fwzt == "3"){
						fwzt = "签约未审核";
					} else if(fwzt == "4"){
						fwzt = "锁定";
					} else if(fwzt == "5"){
						fwzt = "签约已审核";
					} else {
						fwzt = "待审核";
					}
					sHtml += '<tr>'
						+ '<td>'+(n[0] == "null" || n[0] == null ? "" : n[0])+'</td><td>'+(n[1] == "null" || n[1] == null ? "" : n[1])+'</td><td>'+(n[2] == "null" || n[2] == null ? "" : n[2])+'</td><td>'+(n[3] == "null" || n[3] == null ? "" : n[3])+'</td><td>'+(n[4] == "null" || n[4] == null ? "" : n[4])+'</td><td>'+(n[5] == "null" || n[5] == null ? "" : n[5])+'</td>'
						+ '<td>'+(n[6] == "null" || n[6] == null ? "" : n[6])+'</td><td>'+fwzt+'</td><td>'+(n[8] == "null" || n[8] == null ? "" : n[8])+'</td><td>'+(n[9] == "null" || n[9] == null ? "" : n[9])+'</td><td>'+(n[10] == "null" || n[10] == null ? "" : n[10])+'</td>'
						+ '</tr>';
				});
			}
			$("#crrHouse").html(sHtml);
			$("#showCrrHouseModalDanYan").click();
	    },
	    complete: function () {
	        $(this).removeAttr("disabled");
	    	$('.onsubing').css("display","none");//弹出提示框
	    },
	    error: function (data) {
	        console.info("error: " + data.responseText);
	    }
	 });
};


//修改单元模态窗初始
function showUpdateDyDlg(theLink){
	var theRow = $(theLink).parents("tr");
	var danyuanId = $(theLink).attr("data-id");
	var $theForm = $("#formUpdateDanyuan");
	$theForm.find("input[name='xhjLpdanyuan.id']").val(danyuanId);
	$theForm.find("input[name='xhjLpdanyuan.dyName']").val(theRow.find("a[name='dyName']").text());
	$.ajax({
		  url : basepath + "/cam/campus!getDyyuanId.action",
			type:"GET",
			dataType:"json",
			data:{"dyid":danyuanId},
			success:function(data){
				$("#dTypeup1 option[value='"+data.dtype+"']").attr("selected", true); 
				$("#topNumup1").val(data.topNum);
				$("#underNumup1").val(data.underNum);
				$("#totalNumup").val(data.totalNum);
				$("#dihuup").val(data.dihu);
				$("#remarksup1").val(data.remarks);
			}
		});
	$("#myModalUpdateDy").modal("show","center");
}

//修改房号初始化
function updateFanghao(theLink, fanghaoId){
	var theRow = $(theLink).parents("tr");
	curFanghaoId = fanghaoId;
	$.ajax({ 
		url: basepath + "/cam/campus!findFanghaoById.action",
		dataType: "json", 
		type: "POST",
		data: {"fanghId":fanghaoId},
		success: function(fanghaoInfo){
			var $theForm = $("#formUpdateFanghao");
			if(fanghaoInfo.leixing==41){
				$theForm.find("input[dd='"+ fanghaoInfo.leixing +"']").prop("checked", true);
				$theForm.find("input[value='43']").removeAttr("checked");
			}else if(fanghaoInfo.leixing==43){
				$theForm.find("input[dd='"+ fanghaoInfo.leixing +"']").prop("checked", true);
				$theForm.find("input[value='41']").removeAttr("checked");
			}
			$theForm.find("input[name='xhjLpfanghao.fangHao']").val(fanghaoInfo.fangHao);
			$theForm.find("input[name='xhjLpfanghao.fhName']").val(fanghaoInfo.fhName);
			$theForm.find("input[name='xhjLpfanghao.dyId']").val(fanghaoInfo.dyId);
			$theForm.find("input[name='xhjLpfanghao.id']").val(fanghaoInfo.id);
			$("#shiup").val(fanghaoInfo.shi);
			$("#tingup").val(fanghaoInfo.ting);
			$("#chuup").val(fanghaoInfo.chu);
			$("#weiup").val(fanghaoInfo.wei);
			$("#chaoXiangup option[value='"+fanghaoInfo.chaoXiang+"']").attr("selected", true); 
			$("#decorationStandardup option[value='"+fanghaoInfo.decorationStandard+"']").attr("selected", true); 
			$("#cqmjup").val(fanghaoInfo.cqmj);
			$("#tnmjup").val(fanghaoInfo.tnmj);
			$("#remarkup2").val(fanghaoInfo.beiZhu);
			$("#totalFloorup").val(fanghaoInfo.totalFloor);
			$("#updFanghao").click();
    	}
	});
};
//修改栋
function lpDongUpd(){
	 var $theForm = $("#formUpdateDong");
	// var lpxx_lpid=$("#tuplpid").val();
	// var lpdid = $theForm.find("input[name='lpdong.id']").val();
	// var lpdName = $theForm.find("input[name='lpdong.lpdName']").val();
	//	var dType = $("#dTypeup").val();
	//	var dyNum = $("#dyNumup").val();
	//	var ages = $("#agesup").val();
	//	var size = $("#sizeup").val();
	//	var topNum= $("#topNumup").val();
	//	var underNum = $("#underNumup").val();
	//	var located = $("#locatedup").val();
	//	var ownership = $("#ownershipup").val();
	//	var remarks =$("#remarksup").val();
	 $.ajax({
	  	url: basepath + "/cam/campus!updDong.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data: $('#donglouUpForm').serialize(),
		success: function(result){
			if(result.data == "success"){
				bootbox.alert({title:"提示",message:"修改成功!"});
				document.getElementById("donglouUpForm").reset();
				showDongInfo($("#xhjLpdonglpId").val());
				$('#dongUpdClose').click();
			} else {
				bootbox.alert({title:"提示",message:"修改失败：" + result.data});
			}
	    }
	 });
};
//修改单元
function danYuanUpd(){
	var $theForm = $("#formUpdateDanyuan");
//	 var lpdyid = $theForm.find("input[name='xhjLpdanyuan.id']").val();
//	 var dyName = $theForm.find("input[name='xhjLpdanyuan.dyName']").val();
//	  var dType1 = $("#dTypeup1").val();
//	  var topNum1= $("#topNumup1").val();
//	  var underNum1 = $("#underNumup1").val();
//	  var totalNum = $("#totalNumup").val();
//	  var dihu= $("#dihuup").val();
//	  var remarks1 = $("#remarksup1").val();
	 $.ajax({
	  	url: basepath + "/cam/campus!updDany.action",
		dataType: "json", 
		type: "POST",
		async : false,
		data: $('#danyuanUpForm').serialize(),
		success: function(result){
			if(result.data == "success"){
				bootbox.alert({title:"提示",message:"修改成功!"});
				document.getElementById("danyuanUpForm").reset();
				showDanyuanOfDong(curDongId);
				$('#danyUpdClose').click();
			} else {
				bootbox.alert({title:"提示",message:"修改失败：" + result.data});
			}
	    }
	 });
};
//修改房号
function doUpdateFanghao(theButton){
	var $theForm = $("#formUpdateFanghao");
	if($theForm.find("input[name='xhjLpfanghao.fhName']").val()==""){
		bootbox.alert({title:"提示",message:"请输入单元房号!"});
		$theForm.find("input[name='xhjLpfanghao.fhName']").focus();
		return;
	}
	if($theForm.find("input[name='xhjLpfanghao.fangHao']").val()==""){
		bootbox.alert({title:"提示",message:"请输入门牌名称!"});
		$theForm.find("input[name='xhjLpfanghao.fangHao']").focus();
		return;
	}

		
	$.ajax({ 
		url: basepath + "/cam/campus!doUpdateFanghao.action",
		dataType: "json", 
		type: "POST",
		data: $('#fangHaoUpForm').serialize(),
		success: function(result){
			if(result.data=="success"){
				bootbox.alert({title:"提示",message:"保存成功!"});
				showFanghaosOfCeng(curDanyuanId, curCeng);
				$("#fanghaoUpdClose").click();
			} else {
				bootbox.alert({title:"提示",message:"保存失败：" + result.data});
			}
    	}
	});
};

function showAddDanyuanDlg(obj){
	if(curDongId==""){
		bootbox.alert({title:"提示",message:"请点选栋座！"});
		return;
	};
	$("#dydzid").val(curDongId);
	initAddDanyuanDlg();
	$("#addDanYuan").click();
};

function showAddFanghaoDlg(){
	if(curDongId==""){
		bootbox.alert({title:"提示",message:"请点选栋座！"});
		return;
	}
	if(curDanyuanId==""){
		bootbox.alert({title:"提示",message:"请点选单元！"});
		return;
	}
	initAddFanghaoDlg();
	$("#addFanghao").click();
};
//单元信息维护
function danyuanAddTypeClicked(theRdo){
	  var theTable = $("#tblAddDanyuan");
	  theTable.find("tr:gt(0)").hide();
	  theTable.find(".danyuan"+$(theRdo).val()).show();
};

//============房号信息维护=======================================
function fanghaoAddTypeClicked(theRdo){
  var theTable = $("#tblAddFanghao");
  theTable.find("tr:gt(1)").hide();
  theTable.find(".fanghao"+$(theRdo).val()).show();
}

// 初始化新增单元对话框
function initAddDanyuanDlg(){
	  var theTable = $("#tblAddDanyuan");
	  theTable.find("tr:gt(0) input").val("");
	  $("[name='xhjLpdanyuan.type']:eq(0)").prop("checked", true);
	$("#dType1 option[value='0']").attr("selected", true); 
	  theTable.find(".danyuanBatch").hide();
	  theTable.find(".danyuanSingle").show();
};
//初始化新增房号
function initAddFanghaoDlg(){
	$("[name='fanghaoAddType']:eq(0)").trigger("click");
	$("[name='rdoFanghaoRule']:eq(0)").trigger("click");
	var $theForm = $("#formAddFanghao");
	$theForm.find("input[value='41']").prop("checked", true);
	$("#chaoXiang option[value='0']").attr("selected", true); 
	$("#decorationStandard option[value='0']").attr("selected", true);
	$("#formAddFanghao :text").val("");
	$("#formAddFanghao input[name='ceng']").val("");
	$("#fanghaodyId").val(curDanyuanId);
	$("#tdFanghaoPreview").html("");
}

//预览房号
function previewFanghao(){
	var fhPrefix = $("#txtFhPrefix").val();
	var fhSuffix = $("#txtFhSuffix").val();
	//var namingrules = $("#formAddFanghao input[name='namingrules']:checked").val();
	//验证房号输入框数据
	var fhFloorStart = $("#txtFhFloorStart").val();
	if(fhFloorStart=="" || isNaN(fhFloorStart)){
		bootbox.alert({title:"提示",message:"起始层数输入不正确!"});
		return;
	}
	
	var fhFloorEnd = $("#txtFhFloorEnd").val();
	if(fhFloorEnd=="" || isNaN(fhFloorEnd)){
		bootbox.alert({title:"提示",message:"起始层数输入不正确!"});
		return;
	}
	
	var fhStart = $("#txtFhStart").val();
	if(fhStart=="" ){
		bootbox.alert({title:"提示",message:"起始编号输入不正确!"});
		return;
	}
	
	var fhEnd = $("#txtFhEnd").val();
	if(fhEnd==""){
		bootbox.alert({title:"提示",message:"起始编号输入不正确!"});
		return;
	}
	if(isNaN(fhStart)&&!/^.{1}$/.test(fhStart)){
		bootbox.alert({title:"提示",message:"起始编号输入不正确!"});
		return;
	}
	if(isNaN(fhEnd)&&!/^.{1}$/.test(fhEnd)){
		bootbox.alert({title:"提示",message:"起始编号输入不正确!"});
		return;
	}
	var iFloorStart = parseInt(fhFloorStart);
	var iFloorEnd = parseInt(fhFloorEnd);
	var iStart;
	var iEnd; 
	if(isNaN(fhStart)&&isNaN(fhEnd)){
		 iStart = parseInt(toUnicode(fhStart));
		 iEnd = parseInt(toUnicode(fhEnd));
	}else{
		iStart = parseInt(fhStart);
		 iEnd = parseInt(fhEnd);
	}
	
	if(isNaN(fhStart)){
		if(!isNaN(fhEnd)){
			bootbox.alert({title:"提示",message:"起始编号输入不正确!"});
			return;
		}else if(iStart>iEnd){
				bootbox.alert({title:"提示",message:"起始编号输入不正确!"});
				return;
		}
		
	}else{
		if(isNaN(fhEnd)){
			bootbox.alert({title:"提示",message:"起始编号输入不正确!"});
			return;
		}else if(iStart>iEnd){
			bootbox.alert({title:"提示",message:"起始编号输入不正确!"});
			return;
		}
	}
	var fzero = "";	//第一个编号包含0的情况
		for(var i=0;i<fhStart.length;i++){
			if(fhStart.charAt(i)=="0"){
				fzero += "0";
			} else {
				break;
			}
		}
		var zero = "";
		var diffLen = 0;
		var previewContainer = $("#tdFanghaoPreview");
//		var blPutFloorNumToName = $("#chxPutFloorNumToName").prop("checked");
		var sHtml = '<table class="table table-bordered table-striped">';
		for(var i=iFloorStart; i<=iFloorEnd; i++){
			sHtml += '<tr><td><input type="text" style="width:20px;padding:0 2px;" readOnly="true"  value="' + i + '"></td>';
			if(isNaN(fhStart)&&isNaN(fhEnd)){
				for(var j=iStart;j<=iEnd;j++){
					zero = "";
					diffLen = fhStart.length-(String.fromCharCode(j)+"").length;
					if(diffLen>0){
						zero = fzero.substring(fzero.length-diffLen);
					}
					sHtml += '<td><input type="text" style="width:50px" value="'+fhPrefix+i+zero+String.fromCharCode(j)+fhSuffix+'"/></td>';
				}
			}else{
				for(var j=iStart;j<=iEnd;j++){
					zero = "";
					diffLen = fhStart.length-(j+"").length;
					if(diffLen>0){
						zero = fzero.substring(fzero.length-diffLen);
					}
					sHtml += '<td><input type="text"  style="width:50px" value="'+fhPrefix+i+zero+j+fhSuffix + '"/></td>';
				}
			}
			
			sHtml += '</tr>';
		}
		sHtml += "</table>"
	
	previewContainer.html(sHtml);
};

//添加房号
function doAddLpFanghao(obj) {
	var fanghaoAddType = $("input[name='fanghaoAddType']:checked").val();
	var $form = $("#formAddFanghao");
	
	var leixing = $("#formAddFanghao input[name='leixing']:checked").val();
	var shi = $("#shi").val();
	var ting = $("#ting").val();
	var chu = $("#chu").val();
	var wei = $("#wei").val();
	var chaoXiang= $("#chaoXiang").val();
	var decorationStandard = $("#decorationStandard").val();
	var cqmj = $("#cqmj").val();
	var tnmj = $("#tnmj").val();
	var remark2 = $("#remark2").val();
	var totalFloor  = $("#totalFloor").val();
	if (fanghaoAddType == "Single") { //单个新增
		var ceng = $form.find("[name='ceng']").val();
		if (ceng == "") {
			
			bootbox.alert({title:"提示",message:"请输入屋数！"});
			return;
		}
		var fangHao = $form.find("[name='fangHao']").val();
		if (fangHao == "") {
			
			bootbox.alert({title:"提示",message:"请输入房号名称！"});
			return;
		}
		$.ajax({
			url : basepath + "/cam/campus!saveFanghao.action",
			dataType : "json",
			type : "POST",
//			async : false,
			data: $('#fanghaoForm').serialize(),
			beforeSend: function () {
		        // 禁用按钮防止重复提交
		        $(this).attr("disabled", true);
		        $('.onsubing').css("display","block");//弹出提示框
		    },
			success : function(result) {
				if (result.data == "success") {
					
					bootbox.alert({title:"提示",message:"新增成功!"});
					document.getElementById("fanghaoForm").reset();
					showCengsOfDy(curDanyuanId);
					if (curCeng != "") {
						showFanghaosOfCeng(curDanyuanId, curCeng);
					}
					$("#fanghaoClose").click();
				} else {
					
					bootbox.alert({title:"提示",message:"新增失败：" + result.data});
				}
			},
		    complete: function () {
		        $(this).removeAttr("disabled");
		    	$('.onsubing').css("display","none");//弹出提示框
		    },
		    error: function (data) {
		        console.info("error: " + data.responseText);
		    }
		});
	} else if (fanghaoAddType == "Batch") { //批量新增
		var theTable = $("#tdFanghaoPreview").first();
		var datas = "";
		var data = "";
		theTable.find("tr").each(function(i, n) {
			$(n).find("td").each(function(j, node) {
				data = $(node).find("input").val();
				if (j == 0) {
					if (data == "" || isNaN(data)) {
						alert("层号必须是数字");
						$(node).first().focus();
						return;
					}
					datas += (i == 0 ? "" : "##") + data;
				} else {
					if (data != "") {
						datas += "@@" + data;
					}
				}
			});
		});

		if (datas == "") {
			bootbox.alert({title:"提示",message:"请点击生成房号!"});
			//('.onsubing').css("display","block");//弹出提示框
			return;
		}
		$("#datas").val(datas);
		$.ajax({
			url : basepath + "/cam/campus!saveFanghao.action",
			dataType : "json",
			type : "POST",
//			async : false,
			data: $('#fanghaoForm').serialize(),
			beforeSend: function () {
		        // 禁用按钮防止重复提交
		        $(this).attr("disabled", true);
		        $('.onsubing').css("display","block");//弹出提示框
		    },
			success : function(result) {
				if (result.data == "success") {
					bootbox.alert({title:"提示",message:"新增成功!"});
					showCengsOfDy(curDanyuanId);
					if (curCeng != "") {
						showFanghaosOfCeng(curDanyuanId, curCeng);
					}
					$('#fanghaoClose').click();
				} else {
					bootbox.alert({title:"提示",message:"新增失败：" + result.data});
				}
			},
		    complete: function () {
		        $(this).removeAttr("disabled");
		    	$('.onsubing').css("display","none");//弹出提示框
		    },
		    error: function (data) {
		        console.info("error: " + data.responseText);
		    }
		});
	}
}

//删除房号
function deleteFanghao(id,val) {
	bootbox.confirm({title:"确认",message:"您确定要删除该房号信息吗？",callback:function(result){
//	    if(confirm("您确定要删除该房号信息吗？")){//判断是否点击了确定按钮
	 if(result){
	        //执行删除等操作
	    	$.ajax({
				url : basepath + "/cam/campus!deleteFangh.action",
				dataType : "json",
				type : "POST",
				data : {
					"lpid" : $("#tuplpid").val(),
					"id" : id
				},
				success : function(result) {
					if (result.data == "success") {
						alert("删除成功!");
						//showFanghaosOfCeng(curDanyuanId, curCeng);
						 $(val).parent().parent().remove();
						//showCengsOfDy(curDanyuanId);
					} else {
						alert("删除失败：" + result.data);
					}
				}
			});
	    }
	}});
};
function batchDeleteFanghao(){
	var ids="";
	$('.fanghaoCB').each(function(i){
		if($(this).prop('checked')){
			ids += "," + $(this).val();
		}
	});
	if(ids == ""){
		//弹出提示框
		bootbox.alert({title:"提示",message:"请选择要删除的房号"});
		return false;
	};
	bootbox.confirm({title:"确认",message:"您确定要删除该房号信息吗？",callback:function(result){
	    if(result){//判断是否点击了确定按钮
	        //执行删除等操作
	    	
	    	$.ajax({
	    		url : basepath + "/cam/campus!batchDeleteFangh.action", 
	    		dataType : "json", 
	    		type : "POST",
	    		data : {"lpid" : $("#tuplpid").val(),"idsi" : ids.substring(1)},
	    		beforeSend: function () {
			        // 禁用按钮防止重复提交
			        $(this).attr("disabled", true);
			        $('.onsubing').css("display","block");//弹出提示框
			    },
	    		success : function(result){
	    			if(result.data == "success") {
	    				//弹出提示框
	    				bootbox.alert({title:"提示",message:"批量删除房号成功!"});
	    				$(".cbALL").prop('checked',false);
	    				showFanghaosOfCeng(curDanyuanId, curCeng);
	    				//showCengsOfDy(curDanyuanId);
	    			} else {
	    				//弹出提示框
	    				bootbox.alert({title:"提示",message:"批量删除房号失败 : " + result.data});
	    			}
	        	}
			    ,
			    complete: function () {
			        $(this).removeAttr("disabled");
			    	$('.onsubing').css("display","none");//弹出提示框
			    },
			    error: function (data) {
			        console.info("error: " + data.responseText);
			    }
	    	});
	    }
	}});
};
//单元删除
function deleteDanyuan(id) {
	    	$.ajax({
	    		url : basepath + "/cam/campus!getByDyid.action", 
	    		dataType : "json", 
	    		type : "POST",
	    		data : {"dyid" :id},
	    		success : function(result){
//	    			if(result.data == "0") {
	    				bootbox.confirm({title:"确认",message:"您确定要删除该单元所有信息吗？",callback:function(result){
	    				    if(result){//判断是否点击了确定按钮
	    				        //执行删除等操作
	    				    	$.ajax({
	    							url : basepath + "/cam/campus!deleteDany.action",
	    							dataType : "json",
	    							type : "POST",
	    							data : {
	    								"lpid" : $("#tuplpid").val(),
	    								"id" : id
	    							},
	    				    		beforeSend: function () {
	    						        // 禁用按钮防止重复提交
	    						        $(this).attr("disabled", true);
	    						        $('.onsubing').css("display","block");//弹出提示框
	    						    },
	    							success : function(result) {
	    								if (result.data == "success") {
	    									bootbox.alert({title:"提示",message:"删除成功!"});
	    									showDanyuanOfDong(curDongId);
	    								} else {
	    									bootbox.alert({title:"提示",message:"删除失败：" + result.data});
	    								}
	    							}
	    							,
	    						    complete: function () {
	    						        $(this).removeAttr("disabled");
	    						    	$('.onsubing').css("display","none");//弹出提示框
	    						    },
	    						    error: function (data) {
	    						        console.info("error: " + data.responseText);
	    						    }
	    						});
	    				    }
	    				}});
//	    			} else {
//	    				bootbox.alert({title:"<p>注意！！！",message:"此单元下还有房号数据,请重新选择！"});
//	    			}
	        	}
	    	});
	    	
	    
};

function batchdeleteDanyuan(){
	var ids="";
	$('.lpdanyuan').each(function(i){
		if($(this).prop('checked')){
			ids += "," + $(this).val();
		}
	});
	if(ids == ""){
		//弹出提示框
		bootbox.alert({title:"提示",message:"请选择要的单元"});
		return false;
	};
	$.ajax({
		url : basepath + "/cam/campus!getByDyid.action", 
		dataType : "json", 
		type : "POST",
		data : {"dyid" : ids.substring(1)},
		success : function(result){
//			if(result.data == "0") {
				bootbox.confirm({title:"确认",message:"您确定要删除该单元信息吗？",callback:function(result){
				    if(result){//判断是否点击了确定按钮
				    	
				        //执行删除等操作
				    	$.ajax({
				    		url : basepath + "/cam/campus!batchDeleteDany.action", 
				    		dataType : "json", 
				    		type : "POST",
				    		data : {"lpid" : $("#tuplpid").val(),"dyid" : ids.substring(1)},
				    		beforeSend: function () {
						        // 禁用按钮防止重复提交
						        $(this).attr("disabled", true);
						        $('.onsubing').css("display","block");//弹出提示框
						    },
				    		success : function(result){
				    			if(result.data == "success") {
				    				//弹出提示框
				    				bootbox.alert({title:"提示",message:"批量删除单元成功!"});
				    				$(".lpdy").prop('checked',false);
				    				showDanyuanOfDong(curDongId);
				    			} else {
				    				//弹出提示框
				    				bootbox.alert({title:"提示",message:"批量删除单元失败 : " + result.data});
				    			}
				        	},
						    complete: function () {
						        $(this).removeAttr("disabled");
						    	$('.onsubing').css("display","none");//弹出提示框
						    },
						    error: function (data) {
						        console.info("error: " + data.responseText);
						    }
				    	});
				    }
				}});
//			} else {
//				//弹出提示框
//				bootbox.alert({title:"<p>注意！！！",message:"此单元下还有房号数据 ,请重新选择！"});
//			}
    	}
	});
	
};
//删除栋座信息
function deleteDong(id){
	$.ajax({
		url : basepath + "/cam/campus!getByDzid.action", 
		dataType : "json", 
		type : "POST",
		data : {"dzid" :id},
		success : function(result){
//			if(result.data == "0") {
				bootbox.confirm({title:"确认",message:"您确定要删除该栋座所有信息吗？",callback:function(result){
				    if(result){//判断是否点击了确定按钮
				        //执行删除等操作
				    	$.ajax({ 
							url : basepath + "/cam/campus!deleteDong.action",
							dataType: "json", 
							type: "POST",
							data: {"lpid" : $("#tuplpid").val(),"id":id},
							beforeSend: function () {
						        // 禁用按钮防止重复提交
						        $(this).attr("disabled", true);
						        $('.onsubing').css("display","block");//弹出提示框
						    },
							success: function(result){
								if(result.data=="success"){
									bootbox.alert({title:"提示",message:"删除成功!"});
									showDanyuanOfDong(curDongId);
									showFanghaosOfCeng(curDanyuanId, curCeng);
									curDongId='';
									showDongInfo($("#tuplpid").val());
								} else {
									bootbox.alert({title:"提示",message:"删除失败：" + result.data});
								}
					    	},
						    complete: function () {
						        $(this).removeAttr("disabled");
						    	$('.onsubing').css("display","none");//弹出提示框
						    },
						    error: function (data) {
						        console.info("error: " + data.responseText);
						    }
						});
				    }
				}});
//			} else {
//				bootbox.alert({title:"<p>注意！！！",message:"此栋座下还有单元数据 ,请重新选择！"});
//			}
    	}
	});
}

function batchDeleteLpD(){
	var ids="";
	$('.lpLdong').each(function(i){
		if($(this).prop('checked')){
			ids += "," + $(this).val();
		}
	});
	if(ids == ""){
		//弹出提示框
		bootbox.alert({title:"提示",message:"请选择要删除的栋座"});
		return false;
	};
	$.ajax({
		url : basepath + "/cam/campus!getByDzid.action", 
		dataType : "json", 
		type : "POST",
		data : {"dzid" : ids.substring(1)},
		success : function(result){
//			if(result.data == "0") {
				bootbox.confirm({title:"确认",message:"您确定要删除该栋座信息吗？",callback:function(result){
				    if(result){//判断是否点击了确定按钮
				    	
				        //执行删除等操作
				    	$.ajax({
				    		url : basepath + "/cam/campus!batchDeleteLpD.action", 
				    		dataType : "json", 
				    		type : "POST",
				    		data : {"lpid" : $("#tuplpid").val(),"dzid" : ids.substring(1)},
				    		beforeSend: function () {
						        // 禁用按钮防止重复提交
						        $(this).attr("disabled", true);
						        $('.onsubing').css("display","block");//弹出提示框
						    },
				    		success : function(result){
				    			if(result.data == "success") {
				    				//弹出提示框
				    				bootbox.alert({title:"提示",message:"批量删除栋座成功!"});
				    				showDanyuanOfDong(curDongId);
									showFanghaosOfCeng(curDanyuanId, curCeng);
				    				$(".lpdz").prop('checked',false);
				    				showDongInfo($("#tuplpid").val());
				    				curDongId='';
				    			} else {
				    				//弹出提示框
				    				bootbox.alert({title:"提示",message:"批量删除栋座失败 : " + result.data});
				    			}
				        	}
						    ,
						    complete: function () {
						        $(this).removeAttr("disabled");
						    	$('.onsubing').css("display","none");//弹出提示框
						    },
						    error: function (data) {
						        console.info("error: " + data.responseText);
						    }
				    	});
				    }
				}});
//			} else {
//				//弹出提示框
//				bootbox.alert({title:"<p>注意！！！",message:"此栋座下还有单元数据 ,请重新选择！"});
//			}
    	}
	});
	
};


//清空文本框
function  Empty(){
	var dType = $("#dType").val('');
	var dyNum = $("#dyNum").val('');
	var ages = $("#ages").val('');
	var size = $("#size").val('');
	var topNum= $("#topNum").val('');
	var underNum = $("#underNum").val('');
	var located = $("#located").val('');
	var ownership = $("#ownership").val('');
	var remarks =$("#remarks").val('');
}

function  Empty1(){
	 var dType1 = $("#dType1").val('');
	  var topNum1= $("#topNum1").val('');
	  var underNum1 = $("#underNum1").val('');
	  var totalNum = $("#totalNum").val('');
	  var dihu= $("#dihu").val('');
	  var remarks1 = $("#remarks1").val('');
}
function  Empty2(){
	var shi = $("#shi").val('');
	var ting = $("#ting").val('');
	var chu = $("#chu").val('');
	var wei = $("#wei").val('');
	var leibei2= $("#leibei2").val('');
	var chaoXiang= $("#chaoXiang").val('');
	var decorationStandard = $("#decorationStandard").val('');
	var cqmj = $("#cqmj").val('');
	var tnmj = $("#tnmj").val('');
	var remark2 = $("#remark2").val('');
}

function generateSmall_1(start,end){
    var str = [];
    for(var i=start[0];i<=end[0];i++){
        str.push(String.fromCharCode(i));
    }
    return str;
}

function toUnicode(str){
    var codes = [];
    for(var i=0;i<str.length;i++){
        codes.push(str.charCodeAt(i));
    }
    return codes;
}