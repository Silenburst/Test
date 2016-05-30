//加载某条地铁线路下的所有站
function loadZhan(val){
	$.ajax({
		url: basepath + "/cam/campus!loadZhan.action",
		dataType: "json",
		type: "POST",
		data: {"xid" : val},
		success: function(data){
			var pHtml = '';
			$.each(data, function(i,n){
				pHtml += '<tr><td><input type="checkbox" name="ckbox" class="cbr" value="'+n.id+'" /></td><td>'+n.zdName+'</td></tr>';
			});
			$("#zhanTbody").html(pHtml);
	    }
	});
};

//初始化新增地铁线路模态窗体
function addMetorInit(obj){
	$("#dtxianlu option[value='0']").attr("selected","selected");
	$("#zhanTbody").html('');
	$(obj).parent().find("a").click();
};

function saveMetorsInfo(){
	var $theForm = $("#zhanTbody");
	var xianlu = "";
	$theForm.find("[name='ckbox']").each(function(i,n){
		if($(n).prop("checked")){
			xianlu += (xianlu == "" ? "" : ",") + $(n).val();
		}
	});
	if(xianlu == "") {
		bootbox.alert({title:"提示",message:"请至少选择一个站名"});
		return;
	}
	$('.onsubing').css("display","block");//弹出提示框
	$.ajax({
		url: basepath + "/cam/campus!saveLpZhan.action",
		dataType: "json",
		type: "POST",
		async : false,
		data: {"zhanids" : xianlu,"lpid" : $("#tuplpid").val()},
		success: function(result){
			if(result.data == "success") {
				bootbox.alert({title:"提示",message:"保存成功!"});
				metorInfo();
				$("#addMetorClose").click();
			} else {
				bootbox.alert({title:"提示",message:"保存失败" +result.data});
			}
			$('.onsubing').css("display","none");//弹出提示框
	    }
	});
};
//显示楼盘地铁信息
function metorInfo(){
	$.ajax({
		url: basepath + "/cam/campus!showLpZhan.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"lpid" : $("#tuplpid").val()},
		success: function(result){
			var sHtml = '';
			$.each(result, function(i,n){
				sHtml += '<tr>' 
						+ '<td>'+(i+1)+'</td>' 
						+ '<td>'+n.xName+'</td>' 
						+ '<td>'+n.zdName+'</td>'
						+ '<td><button class="btn btn-danger" onclick="deleteLpZhan(\''+n.id+'\')">删除</button></td>' + 
						'</tr>';
			});
			$("#metorInfo").html(sHtml);
	    }
	});
};
//删除楼盘地铁线
function deleteLpZhan(id){
	bootbox.confirm({title:"确认",message:"您确定要删除此地铁线信息吗？",callback:function(result){
	    if(result){//判断是否点击了确定按钮
	        //执行删除等操作
	    	$.ajax({
				url: basepath + "/cam/campus!deleteLpZhan.action",
				dataType: "json",
				type: "POST",
				async : false,
				data : {"zhanid" : id, "lpid" : $("#tuplpid").val()},
				success: function(result){
					if(result.data == "success") {
						bootbox.alert({title:"提示",message:"删除成功!"});
						metorInfo();
					} else {
						bootbox.alert({title:"提示",message:"删除失败" +result.data});
					}
			    }
			});
	    }
	}});
};
//初始化新增学校
function schoolInit(){
	$("#schoolType option[value='0']").attr("selected","selected");
	$("#schoolNameDetail").parent().find("div a span").eq(0).text("");
	$("#schoolNameDetail").html('<option value="0">请选择</option>');
	showSchoolDong("schoolDong");
	$("#schoolFang").html("");
	loadSchoolDongTree();
	$("#showSchoolAdd").click();
};
//初始化学校修改页面
function schoolUpdInit(obj){
	var id = $(obj).attr("data-id");
	var sid = $(obj).attr("data-sid");
	var type = $(obj).attr("data-type");
	var stype = $(obj).attr("data-stype");
	$("#lpschoolpUpdId").val(id);
	$("#lpschoolpUpdType").val(type);
	$("#schoolUpdType option[value='"+stype+"']").attr("selected","selected");
	showSchoolUpdDetail(stype);
	$("#schoolUpdNameDetail option[value='"+sid+"']").attr("selected","selected");
	$("#schoolUpdNameDetail").parent().find("div a span").eq(0).text($("#schoolUpdNameDetail option[value='"+sid+"']").text());
	if(type == 1) {
		$("#schoolTitle").val("学区");
		$("#schoolUpdDong").show();
		$("#schoolUpdDong").html("");
		$("#schoolUpdFang").hide();
		showDongLpUpd(id);
	} else {
		$("#schoolTitle").val("学位");
		$("#schoolUpdDong").hide();
		$("#schoolUpdFang").show();
		$("#schoolUpdFang").html("");
		showSchoolFangUpd(id);
	}
	$("#showUpd").click();
};

//初始化对应的学校名称
function showSchoolDetail(shchoolType){
	$.ajax({
		url: basepath + "/cam/campus!showSchoolDetail.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"id" : shchoolType},
		success: function(data){
			$("#schoolNameDetail").parent().find("div a span").eq(0).text("");
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#schoolNameDetail").html(pHtml);
	    }
	});
};
//修改初始化对应的学校名称
function showSchoolUpdDetail(shchoolType){
	$.ajax({
		url: basepath + "/cam/campus!showSchoolDetail.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"id" : shchoolType},
		success: function(data){
			$("#schoolUpdNameDetail").parent().find("div a span").eq(0).text("");
			var pHtml = '<option value="0" selected="selected">请选择</option>';
			$.each(data, function(i,n){
				pHtml += '<option value="'+n.id+'">'+n.name+'</option>';
			});
			$("#schoolUpdNameDetail").html(pHtml);
	    }
	});
};
///显示当前楼盘下的所有栋信息
function showSchoolDong(buildDIV){
	$.ajax({
		url: basepath + "/cam/campus!showDongLp.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"lpid" : $("#tuplpid").val()},
		success: function(data){
			var pHtml = '';
			$.each(data, function(i,n){
				pHtml += '<div class="col-xs-4"><label><input type="checkbox" class="cbr" name="schoolDongInfo" data-text="'+n.lpdName+'" value="'+n.id+'">'+n.lpdName+'</label></div>';
			});
			$("#" + buildDIV).html(pHtml);
	    }
	});
};
//显示当前要修改的楼盘新
function showDongLpUpd(val){
	$.ajax({
		url: basepath + "/cam/campus!showDongLpUpd.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"lpid" : $("#tuplpid").val(),"lpsid" : val},
		success: function(data){
			var pHtml = '';
			$.each(data, function(i,n){
				if(n.checked) {
					pHtml += '<div class="col-xs-4"><label><input type="checkbox" checked class="cbr" name="schoolDongInfo" data-text="'+n.lpdName+'" value="'+n.id+'">'+n.lpdName+'</label></div>';
				} else {
					pHtml += '<div class="col-xs-4"><label><input type="checkbox" class="cbr" name="schoolDongInfo" data-text="'+n.lpdName+'" value="'+n.id+'">'+n.lpdName+'</label></div>';
				}
			});
			$("#schoolUpdDong").html(pHtml);
	    }
	});
};
var tree = null;
function loadSchoolDongTree(){
	var loader = new Ext.tree.TreeLoader({
		url :  basepath + "/cam/campus!showSchoolFang.action?lpid=" + $("#tuplpid").val()
	});
	loader.on("beforeload", function(loader, node) {
		loader.baseParams.nodeId = node.id;
	});
	tree = new Ext.tree.TreePanel({
	    renderTo : "schoolFang",
	    root : new Ext.tree.AsyncTreeNode({
	    	//默认加载
	        id : '0',
	        text : '学位房号信息'
	    }),
	    loader : loader,
	    listeners:{
	    	click:function(n){
//	        		n.attributes.id;
//	        	  	n.text;
			},
			checkchange : function(node, state) {
				// 选中所有子节点
				node.expand();
				node.attributes.checked = state;
				node.eachChild(function(child) {
					child.ui.toggleCheck(state);
					child.attributes.checked = state;
					child.fireEvent('checkchange', child, state);
				});
				//选中当前父节点
				var pNode = node.parentNode;
				if (state || tree.getChecked(id, pNode) == "") {
					pNode.ui.toggleCheck(state);
					pNode.attributes.checked = state;
				}
			}
	    }
	});
	tree.root.expand(false, false);
	tree.root.on('load',function(){
		tree.root.expandChildNodes(false);
	}); 
};
//修改树
function showSchoolFangUpd(val){
	var loader = new Ext.tree.TreeLoader({
		url :  basepath + "/cam/campus!showSchoolFangUpd.action?lpid=" + $("#tuplpid").val() + "&lpsid=" + val
	});
	loader.on("beforeload", function(loader, node) {
		loader.baseParams.nodeId = node.id;
	});
	tree = new Ext.tree.TreePanel({
	    renderTo : "schoolUpdFang",
	    root : new Ext.tree.AsyncTreeNode({
	    	//默认加载
	        id : '0',
	        text : '学位房号信息'
	    }),
	    loader : loader,
	    listeners:{
			checkchange : function(node, state) {
				// 选中所有子节点
				node.expand();
				node.attributes.checked = state;
				node.eachChild(function(child) {
					child.ui.toggleCheck(state);
					child.attributes.checked = state;
					child.fireEvent('checkchange', child, state);
				});
				//选中当前父节点
				var pNode = node.parentNode;
				if (state || tree.getChecked(id, pNode) == "") {
					pNode.ui.toggleCheck(state);
					pNode.attributes.checked = state;
				}
			}
	    }
	});
	tree.root.expand(true, false);
	tree.root.expandChildNodes();
};

function saveSchool() {
	var schoolType = $("#schoolType").val();
	if(schoolType == null || schoolType == "" || schoolType == "0"){
		bootbox.alert({title:"提示",message:"请选择学校类型!"});
		return;
	};
	var schoolName = $("#schoolNameDetail").val();
	if(schoolName == null || schoolName == "" || schoolName == "0"){
		bootbox.alert({title:"提示",message:"请选择学校名称!"});
		return;
	};
	var dongIds = "";
	var dongNames = "";
	var arrChk=$("#schoolDong input[name='schoolDongInfo']:checked");
	$(arrChk).each(function(i,n){
		dongIds += (i == 0 ? "" : ",") + $(this).val();
		dongNames += (i == 0 ? "" : ",") + $(this).attr("data-text");
    });
	//获取选中的房号
	var checkedNodes = tree.getChecked();
	//房号ID
	var ids = "";
	//房号名
	var names = "";
	for(var i=0;i<checkedNodes.length;i++){
		ids += (i == 0 ? "" : ",") + checkedNodes[i].id;
		names += (i == 0 ? "" : ",") + checkedNodes[i].text;
	};
	//判断非Y或非C
	if((dongIds == null || dongIds == "") && (ids == null || ids == "")) {
		bootbox.alert({title:"提示",message:"请至少选择一个学区信息或者学位房号信息!"});
		return;
	};
	$('.onsubing').css("display","block");//弹出提示框
	$.ajax({
		url: basepath + "/cam/campus!saveLpSchool.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {
			"lpid" : $("#tuplpid").val(),
			"dongIds" : dongIds,
			"schoolid" : schoolName,
			"schoolType" : schoolType,
			"dongNames" : dongNames,
			"idss" : ids,
			"names" : names
		},
		success: function(result){
			if(result.data == "success") {
				bootbox.alert({title:"提示",message:"保存成功!"});
				loadLpSchoolInfo();
				$("#addLpSchoolClose").click();
			} else {
				bootbox.alert({title:"提示",message:"保存失败" +result.data});
			}
			$('.onsubing').css("display","none");//弹出提示框
	    }
	});
	$('.onsubing').css("display","none");//弹出提示框
};
//修改学校片区信息
function updSchool(){
	var schoolType = $("#schoolUpdType").val();
	if(schoolType == null || schoolType == "" || schoolType == "0"){
		bootbox.alert({title:"提示",message:"请选择学校类型!"});
		return;
	};
	var schoolName = $("#schoolUpdNameDetail").val();
	if(schoolName == null || schoolName == "" || schoolName == "0"){
		bootbox.alert({title:"提示",message:"请选择学校名称!"});
		return;
	};
	var dongIds = "";
	var dongNames = "";
	var flag = false;
	if($("#lpschoolpUpdType").val() == "1") {	
		var arrChk=$("#schoolUpdDong input[name='schoolDongInfo']:checked");
		$(arrChk).each(function(i,n){
			dongIds += (i == 0 ? "" : ",") + $(this).val();
			dongNames += (i == 0 ? "" : ",") + $(this).attr("data-text");
	    });
		if(dongIds == null || dongIds == "") {
			bootbox.alert({title:"提示",message:"请至少选择一个栋座信息"});
			flag = true;
		}
	} else {
		//获取选中的房号
		var checkedNodes = tree.getChecked();
		for(var i=0;i<checkedNodes.length;i++){
			dongIds += (i == 0 ? "" : ",") + checkedNodes[i].id;
			dongNames += (i == 0 ? "" : ",") + checkedNodes[i].text;
		};
		if(dongIds == null || dongIds == "") {
			bootbox.alert({title:"提示",message:"请至少选择一个房号信息"});
			flag = true;
		}
	}
	if(flag) {
		return;
	}
	$('.onsubing').css("display","block");//弹出提示框
	$.ajax({
		url: basepath + "/cam/campus!updLpSchool.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {
			"lpid" : $("#tuplpid").val(),
			"lpsid" : $("#lpschoolpUpdId").val(),
			"schoolid" : schoolName,
			"schoolType" : schoolType,
			"lpsType" : $("#lpschoolpUpdType").val(),
			"dongIds" : dongIds,
			"dongNames" : dongNames
		},
		success: function(result){
			if(result.data == "success") {
				bootbox.alert({title:"提示",message:"修改成功!"});
				loadLpSchoolInfo();
				$("#addLpSchoolUpdClose").click();
			} else {
				bootbox.alert({title:"提示",message:"修改失败" +result.data});
			}
			$('.onsubing').css("display","none");//弹出提示框
	    }
	});
};
//删除某个片区数据
function deleteLpSchool(val){
	bootbox.confirm({title:"确认",message:"您确定要删除此学校划分记录吗？",callback:function(result){
	    if(result){//判断是否点击了确定按钮
	        //执行删除等操作
	    	$.ajax({
				url: basepath + "/cam/campus!deleteLpSchool.action",
				dataType: "json",
				type: "POST",
				async : false,
				data : {"lpid" : $("#tuplpid").val(),"lpsid" : val},
				success: function(result){
					if(result.data == "success") {
						bootbox.alert({title:"提示",message:"删除成功!"});
						loadLpSchoolInfo();
						$("#addLpSchoolClose").click();
					} else {
						bootbox.alert({title:"提示",message:"删除失败" +result.data});
					}
			    }
			});
	    }
	}});
};
//加载所有划片学校信息
function loadLpSchoolInfo(){
	$.ajax({
		url: basepath + "/cam/campus!loadLpSchoolInfo.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"lpid" : $("#tuplpid").val()},
		success: function(data){
			var sHtml = '';
			$.each(data, function(i,n){
				var type = n.type;
				if(type == "1") {
					type = "学区";
				} else {
					type = "学位";
				};
				sHtml += '<tr>' 
						+ '<td>'+n.schoolType+'</td>' 
						+ '<td>'+n.schoolName+'</td>' 
						+ '<td>'+n.names+'</td>'
						+ '<td>'+type+'</td>'
						+ '<td><button class="btn btn-secondary btn-sm btn-icon icon-left" data-type="'+n.type+'" data-sid="'+n.schoolid
						+ '" data-stype="'+n.schooltype2+'" data-id="'+n.id
						+ '" onclick="schoolUpdInit(this);">修改</button><a href="#"data-toggle="modal" id="showUpd" data-target="#xinzenhuapian1"></a>'
						+ '<button class="btn btn-danger btn-sm btn-icon icon-left" onclick="deleteLpSchool('+n.id+')">删除</button></td></tr>';
			});
			$("#lpSchoolInfo").html(sHtml);
	    }
	});
};


/***************************************
 * 服务网店		
 * *************************************/
//新增责任盘初始化
function addZerenInit(){
	$("#zeirSource option[value='0']").attr("selected","selected");
	$("#addZrService").parent().find("div a span").eq(0).text("");
	$("#addZrService option[value='0']").attr("selected","selected");
	$("#serAddress").text("");
	$("#serTel").text("");
	showSchoolDong("zerDong");
	$("#zerenModal").click();
};
//部门加载地址电话
function setAddress(val,buildDIV){
	if(val != null && val != "" && val != "0") {
		$.ajax({
			url: basepath + "/base/department!queryDepartAddress.action",
			dataType: "json",
			type: "POST",
			async : false,
			data : {"deptId" : val},
			success: function(data){
				$.each(data, function(i,n){
					$("#"+buildDIV+"Address").text(n.address);
					$("#"+buildDIV+"Tel").text(n.tel);
				});
		    }
		});
	} else {
		$("#"+buildDIV+"Address").text("");
		$("#"+buildDIV+"Tel").text("");
	}
};
//保存责任盘信息
function saveZeren(val){
	var source = $("#zeirSource").val();
	if(source ==null || source == "" || source == "0") {
		bootbox.alert({title:"提示",message:"服务来源不允许为空!"});
		return;
	}
	var addZrService = $("#addZrService").val();
	if(addZrService == null || addZrService == "" || addZrService == "0") {
		bootbox.alert({title:"提示",message:"服务网点不允许为空!"});
		return;
	}
	var dongIds = "";
	var arrChk=$("#zerDong input[name='schoolDongInfo']:checked");
	$(arrChk).each(function(i,n){
		dongIds += (i == 0 ? "" : ",") + $(this).val();
    });
	if(dongIds == "") {
		bootbox.alert({title:"提示",message:"请选择责任盘对应的栋数!"});
		return;
	}
	$.ajax({
		url: basepath + "/cam/campus!saveZeren.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {
			"sta" : val,
			"source" : source,
			"addZrService" : addZrService,
			"lpid" : $("#tuplpid").val(),
			"dongIds" : dongIds
		},
		success: function(result){
			if(result.data == "success") {
				bootbox.alert({title:"提示",message:"保存成功!"});
				loadLpFuzh();
				$("#zerModalClose").click();
			} else {
				bootbox.alert({title:"提示",message:"保存失败" +result.data});
			}
			$('.onsubing').css("display","none");//弹出提示框
	    }
	});
};
//新增维护盘初始化
function addWeihInit(buildDIV){
	$("#"+buildDIV+"Source option[value='0']").attr("selected","selected");
	$("#"+buildDIV+"addService").parent().find("div a span").eq(0).text("");
	$("#"+buildDIV+"addService option[value='0']").attr("selected","selected");
	$("#"+buildDIV+"Address").text("");
	$("#"+buildDIV+"Tel").text("");
	$("#"+buildDIV+"Modal").click();
};
//保存维护盘和范围盘数据
function saveWeih(val,buildDIV){
	var source = $("#"+buildDIV+"Source").val();
	if(source ==null || source == "" || source == "0") {
		bootbox.alert({title:"提示",message:"服务来源不允许为空!"});
		return;
	}
	var addZrService = $("#"+buildDIV+"addService").val();
	if(addZrService == null || addZrService == "" || addZrService == "0") {
		bootbox.alert({title:"提示",message:"服务网点不允许为空!"});
		return;
	}
	$.ajax({
		url: basepath + "/cam/campus!saveWeih.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {
			"sta" : val,
			"source" : source,
			"addZrService" : addZrService,
			"lpid" : $("#tuplpid").val()
		},
		success: function(result){
			if(result.data == "success") {
				bootbox.alert({title:"提示",message:"保存成功!"});
				loadLpFuzh();
				$("#"+buildDIV+"ModalClose").click();
			} else {
				bootbox.alert({title:"提示",message:"保存失败" +result.data});
			}
			$('.onsubing').css("display","none");//弹出提示框
	    }
	});
};

//加载责任盘,范围盘,维护盘
function loadLpFuzh(){
	var findsta = $("#serFindFw").val();
	var bmid = $("#serviceWD").val();
    
    var url = basepath + "/cam/campus!loadLpFuzh.action"
    $("#macPageWidget").asynPage(url, "#showLpHuaPanInfo", buildLpfuzhuHtml, true, true, {
        'lpid': $("#tuplpid").val(),
        'findsta': findsta,
        'bmid': bmid
    });
};

function buildLpfuzhuHtml(data){
	var pHtml = '';
	$.each(data, function(i,n){
		var sta = n[1];
		if(sta == "1"){
			sta = "责任盘";
		} else if(sta == "2") {
			sta = "维护盘";
		} else {
			sta = "范围盘";
		}
		var source = n[2];
		if(source == "1") {
			source = "公司内部";
		} else if(source == "2") {
			source = "外部加盟";
		} else {
			source = "其他";
		}
		pHtml += '<tr>'
			+'<td><input name="id" type="checkbox"value="'+n[0]+'" onclick="setSelectAll(this)"  class="cbr"></td><td>'+sta+'</td>'
			+'<td>'+source+'</td><td>'+n[3]+'</td><td>'+n[4]+'</td><td>'+n[5]+'</td>'
			+'<td>'
			+'<a href="#" class="pr10" data-id="'+n[0]+'" data-lpid="'+n[6]
			+'" data-sta="'+n[1]+'" data-source="'+n[2]+'" data-bmid="'+n[7]+'" data-add="'+n[4]+'"  data-tel="'+n[5]+'" onclick="updLpFuzhInit(this)"><i class="fa-pencil"></i>修改</a>'
			+'<a data-toggle="modal" id="fuzShowUpd" data-target="#xinzenhuapian5"></a>'
			+'<a href="#" onclick="deleteLpFuzh(this)"><i class="fa-trash-o"></i>删除</a></td>'
			+'</tr>';
	});
	$("#showLpHuaPanInfo").html(pHtml);
};

//修改页面
function updLpFuzhInit(obj){
	var id = $(obj).attr("data-id");
	var lpid = $(obj).attr("data-lpid");
	var sta = $(obj).attr("data-sta");
	var source = $(obj).attr("data-source");
	var bmid = $(obj).attr("data-bmid");
	var add = $(obj).attr("data-add");
	var tel = $(obj).attr("data-tel");
	
	$("#fanwUpdId").val(id);
	$("#fanwUpdSta").val(sta);
	$("#fuzAddress").text(add);
	$("#fuzTel").text(tel);
	$("#fanwUpdSource option[value='"+source+"']").attr("selected","selected");
	
	$("#updFuzhuWd option[value='"+bmid+"']").attr("selected","selected");
	$("#updFuzhuWd").parent().find("div a span").eq(0).text($("#updFuzhuWd option[value='"+bmid+"']").text());
	if(sta == 1) {
		$(".fuzTitle").text("修改责任盘");
		$(".fuzDong").show();
		//改成UPD对应的--修改先删除后增加
		showLpfuZhuDongUpd(lpid,bmid);
	} else {
		$(".fuzTitle").text("修改范围盘/维护盘");
		$(".fuzDong").hide();
		$("#fuzDong").html("");
	}
	$("#fuzShowUpd").click();
};
//楼盘信息删除
function deleteLpFuzh(obj){
//	bootbox.confirm({title:"确认",message:"您确定要删除该划盘信息吗？",callback:function(result){
	if(confirm("您确定要删除该划盘信息吗？"))
	{
//	    if(result){//判断是否点击了确定按钮
	        //执行删除等操作
	    	var info = $(obj).parent().find("a.pr10");
	    	var lppid = $(info).attr("data-id");
	    	var lpid = $(info).attr("data-lpid");
	    	var sta = $(info).attr("data-sta");
	    	var bmid = $(info).attr("data-bmid");
			
			$.ajax({
				url: basepath + "/cam/campus!deleteLpFuzh.action",
				dataType: "json",
				type: "POST",
				async : false,
				data : {
					"lppid" : lppid,
					"sta" : sta,
					"bmid" : bmid,
					"lpid" : lpid
				},
				success: function(result){
					if(result.data == "success") {
						bootbox.alert({title:"提示",message:"删除成功!"});
						loadLpFuzh();
						$("#updLpFuzModelClose").click();
					} else {
						bootbox.alert({title:"提示",message:"删除失败" +result.data});
					}
					$('.onsubing').css("display","none");//弹出提示框
			    }
			});
	    }
//	};
};
//责任盘加载勾选栋信息
function showLpfuZhuDongUpd(lpid,bmid){
	$.ajax({
		url: basepath + "/cam/campus!showLpfuZhuDongUpd.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {"lpid" : lpid, "bmid" : bmid},
		success: function(data){
			var pHtml = '';
			$.each(data, function(i,n){
				if(n.checked) {
					pHtml += '<div class="col-xs-4"><label><input type="checkbox" checked class="cbr" name="schoolDongInfo" data-text="'+n.lpdName+'" value="'+n.id+'">'+n.lpdName+'</label></div>';
				} else {
					pHtml += '<div class="col-xs-4"><label><input type="checkbox" class="cbr" name="schoolDongInfo" data-text="'+n.lpdName+'" value="'+n.id+'">'+n.lpdName+'</label></div>';
				}
			});
			$("#fuzDong").html(pHtml);
	    }
	});
};

//保存责任盘信息
function updLpFuzh(val){
	var source = $("#fanwUpdSource").val();
	if(source ==null || source == "" || source == "0") {
		bootbox.alert({title:"提示",message:"服务来源不允许为空!"});
		return;
	}
	var bmid = $("#updFuzhuWd").val();
	if(bmid == null || bmid == "" || bmid == "0") {
		bootbox.alert({title:"提示",message:"服务网点不允许为空!"});
		return;
	}
	var sta = $("#fanwUpdSta").val();
	var lppid = $("#fanwUpdId").val();
	var dongIds = "";
	if(sta == 1) {
		var arrChk=$("#fuzDong input[name='schoolDongInfo']:checked");
		$(arrChk).each(function(i,n){
			dongIds += (i == 0 ? "" : ",") + $(this).val();
	    });
		if(dongIds == "") {
			bootbox.alert({title:"提示",message:"请选择责任盘对应的栋数!"});
			return;
		}
	}
	$.ajax({
		url: basepath + "/cam/campus!updLpFuzh.action",
		dataType: "json",
		type: "POST",
		async : false,
		data : {
			"lppid" : lppid,
			"sta" : sta,
			"source" : source,
			"bmid" : bmid,
			"lpid" : $("#tuplpid").val(),
			"dongIds" : dongIds
		},
		success: function(result){
			if(result.data == "success") {
				bootbox.alert({title:"提示",message:"保存成功!"});
				loadLpFuzh();
				$("#updLpFuzModelClose").click();
			} else {
				bootbox.alert({title:"提示",message:"保存失败" +result.data});
			}
			$('.onsubing').css("display","none");//弹出提示框
	    }
	});
};

/**
 * 全选或不选
 * @param obj
 */
function checkAll(obj) {
	var isCheckAll = obj.checked;
	$(".table tr td input[type='checkbox']").each(function(i) {
		if (isCheckAll) {
			this.checked = "checked";
		} else {
			this.checked = "";
		}
	});
}

//子复选框的事件  
function setSelectAll(obj){  
	var isCheckChild = obj.checked;
  //当没有选中某个子复选框时，SelectAll取消选中  
  if (!isCheckChild ){  
      $(".table thead tr th input[type='checkbox']").prop("checked", false);  
  }  
  var chsub = $(".table tbody tr td  input[type='checkbox']").length; //获取subcheck的个数  
  var checkedsub = $(".table tbody tr td input[type='checkbox']:checked").length; //获取选中的subcheck的个数  
  if (checkedsub == chsub) {  
	  $(".table thead tr th input[type='checkbox']").prop("checked", true);  
  }  
}  