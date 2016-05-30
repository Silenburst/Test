$(function(){
	jQuery.ajaxSettings.traditional = true;
	
	var ids = [];	//当前选中的多项数据的id组
	var sta = 2;	//2:维护盘, 3:范围盘
	
	var lpxxPageSize = 15;	//楼盘列表每页显示的记录数
	var lcfzPageSize = 10;	//划盘列表每页显示的记录数
	
	var pageQueryCondition = {"sord":"asc"};	//分页查询的条件
	
	//搜索方式单选按钮互斥效果
	$(".searchButton").prop("disabled", false);
	$("[name=seGroup]").click(function(){
		//$(".searchButton").prop("disabled", true);
		//var index = $("[name=seGroup]").index($(this));
		//$(".searchButton").eq(index).prop("disabled", false);
	});

	var fromBmName = "";
	var toBmName = "";
	$("#selectCopyGroupDz, #selectMainDz").select2({
	    placeholder: "请选择店组",
	    minimumInputLength: 2,
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
	});
	
	function formatResult(node) {
	    return '<div>' + node.name + '</div>';
	};
	
	function formatSelection(node, container) {
		if(container.attr("id")=="select2-chosen-1"){
			fromBmName = node.name;
		} else {
			toBmName = node.name;
		}
	    return node.name;
	};

	
	//复制店组方式查询
	$("#bnSearch1").click(function(){
		var dzId = $("#selectCopyGroupDz").val();
		if(dzId==""){
			bootbox.alert({"title":"提示",message:"请选择店组！"});
			return;
		}
		pageQueryCondition.queryType = 1;
		pageQueryCondition.dzId = dzId;
		pageQueryCondition.sta = $("[name=copyGroup2]:checked").val();
		queryLpxxPage();
	});
	
	//选择区域后显示商圈列表信息
	$("#selectQy1").change(function(){  
		$.ajax({ 
			url: SERVICES_BASE_PATH + "/stress/" + $("#selectQy1").val() + "/sq",
			dataType: "json", 
			type: "GET",
			success: function(sqs){
				var theTable = $("#tblSq1");
				theTable.html("");
				var sHtml= '<div class="row">';
				for(var i=0;i<sqs.length;i++){
					if(i>0 && i%4==0){
						sHtml += '</div><div class="row">';
					}
					sHtml += '<div class="col-lg-3 col-sm-6"><label><input type="checkbox" name="locGroup" class="cbr" value="' + sqs[i].id + '" />' + sqs[i].sqName + '</label></div>';
				}
				sHtml+= "</div>";
				theTable.html(sHtml);
	    	}
		});
	});
	
	//商圈方式查询
	$("#bnSearch2").click(function(){
		var qy = $("#selectQy1").val();
		if(qy==""){
			bootbox.alert({"title":"提示",message:"请选择区域！"});
			return;
		}
		var sqs = [];	//商圈ids
		$("[name=locGroup]").each(function(i,n){
			if(n.checked){
				sqs[sqs.length] = n.value;
			}
		});
		if(sqs.length<=0){
			bootbox.alert({"title":"提示",message:"请选择商圈！"});
			return;
		}
		pageQueryCondition.queryType = 2;
		pageQueryCondition.stressId = qy;
		pageQueryCondition.sqIds = sqs;
		queryLpxxPage();
	});
	
	$("#selectQy4").change(function(){
		var theSelect = $("#selectSq4");
		theSelect.find("option:gt(0)").remove();
		var qyId =  $("#selectQy4").val();
		if(qyId=="")return;
		$.ajax({ 
			url: SERVICES_BASE_PATH + "/stress/" + $("#selectQy4").val() + "/sq",
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
	
	//按距离搜索
	$("#bnSearch3").click(function(){
		bootbox.alert({"title":"提示",message:"获取不到店组地址信息，不能按此方式搜索！"});
	});
	
	//单个搜索方式查询
	$("#bnSearch4").click(function(){
		var keyword = $("#keyword4").val();
		if(keyword=="" || keyword=="请输入关键字"){
			bootbox.alert({"title":"提示",message:"请输入关键字！"});
			return;
		}
		var sqId = $("#selectSq4").val();
		pageQueryCondition.queryType = 4;
		pageQueryCondition.keyword = keyword;
		pageQueryCondition.stressId = $("#selectQy4").val();
		pageQueryCondition.sqIds = sqId;
		queryLpxxPage();
	});
	
	//排序
	$("#sortLpxxList").click(function(){
		pageQueryCondition.sord = pageQueryCondition.sord=="asc"?"desc":"asc";
		queryLpxxPage();
	});
	
	var lpxxPager;	//楼盘分页信息
	
	function queryLpxxPage(){
		if(pageQueryCondition.queryType==1){
			loadLcfz1(pageQueryCondition.dzId,pageQueryCondition.sta, "getLcfc1OfBmForCopy", lpxxPageSize, 1, showLpxxPage);
			$(".divCopyAll").show();
		}else {
			if(pageQueryCondition.queryType==2 || pageQueryCondition.queryType==4){
				loadLpxxPageList(lpxxPageSize, 1);
			}
			$(".divCopyAll").hide();
		}
	}
	
	//加载楼盘分页数据
	function loadLpxxPageList(pageSize, pageNo){
		$("#allChoose").prop("checked", false);
		var params = {"pageInfo.rows":pageSize,"pageInfo.page":pageNo,"pageInfo.sidx":"lp_name","pageInfo.sord":pageQueryCondition.sord};
		if(pageQueryCondition.queryType==2){
			params["queryLpxx.stressId"] = pageQueryCondition.stressId;
			params.ids = pageQueryCondition.sqIds; 
		} else if(pageQueryCondition.queryType==4){
			params["queryLpxx.stressId"] = pageQueryCondition.stressId;
			params["queryLpxx.sqId"] = pageQueryCondition.sqIds; 
			params["queryLpxx.lpName"] = pageQueryCondition.keyword; 
		}
		$.ajax({ 
			url: "../cam/campus!queryLpxx.action", 
			dataType: "json", 
			type: "POST",
			data : params,
			success: function(pager){
				showLpxxPage(pager)
	    	}
		});
	}
	
	//显示查询到的楼盘分页信息
	function showLpxxPage(pager){
		lpxxPager = pager;
		$("#lpxxCount").html(pager.records);
		var thePagerUl = $("#accordion-test1");
		thePagerUl.find("div").remove();
		var sHtml = "";
		if(pager.records<=0){
			sHtml += '<div class="form-group ">没有符合条件的数据</div>';
		} else {
			$.each(pager.datas, function(i,n){
				sHtml += getLpxxLiHtml(n)
			});
		}
		thePagerUl.append(sHtml);
	}
	
	//楼盘分页-上一页
	$("#llxxPagerPre").click(function(){
		if(lpxxPager.page<=1)return;
		lpxxPager.page--;
		if(pageQueryCondition.queryType==1){
			loadLcfz1(pageQueryCondition.dzId, pageQueryCondition.sta,"getLcfc1OfBmForCopy", lpxxPageSize, lpxxPager.page, showLpxxPage);
		} else if(pageQueryCondition.queryType==2 || pageQueryCondition.queryType==4){
			loadLpxxPageList(lpxxPageSize, lpxxPager.page);
		}
	});
	
	//楼盘分页-下一页
	$("#llxxPagerNext").click(function(){
		if(lpxxPager.page>=lpxxPager.total)return;
		lpxxPager.page++;
		if(pageQueryCondition.queryType==1){
			loadLcfz1(pageQueryCondition.dzId, pageQueryCondition.sta,"getLcfc1OfBmForCopy", lpxxPageSize, lpxxPager.page, showLpxxPage);
		} else if(pageQueryCondition.queryType==2 || pageQueryCondition.queryType==4){
			loadLpxxPageList(lpxxPageSize, lpxxPager.page);
		}
	});
	
	function getLpxxLiHtml(lpxx){
		return '<div class="form-group "><input type="checkbox" class="cbr" name="midResult" value="' + lpxx.lpId + '" /><span>' + lpxx.lpName + '</span><font>'+ lpxx.sqName +'</font></div>';
	}
	
	//楼盘全选/全不选
	$("#allChoose").click(function(){
		$("input[name=midResult]").prop("checked", $(this).prop("checked"));
	});
	
	//得到选中的楼盘的编号
	function getSelectedLps(){
		ids.length = 0;
		$("input[name=midResult]").each(function(i, n){
			if(n.checked){
				ids[ids.length++] = n.value;
			}
		});
		return ids;
	}
	
	//添加到维护盘
	$("#bnAddtoWhp").click(function(){
		ids = getSelectedLps();	//选中的楼盘
		var dzId = $("#selectMainDz").val();	//选中的店组
		if(ids.length<=0){
			bootbox.alert({"title":"提示",message:"请在左边选择楼盘！"});
			return;
		}
		if(dzId==""){
			bootbox.alert({"title":"提示",message:"请在右边选择店组！"});
			return;
		}
		doBatchAdd(dzId, ids, 2);
	});
	
	//添加到范围盘
	$("#bnAddToFwp").click(function(){
		ids = getSelectedLps();	//选中的楼盘
		var dzId = $("#selectMainDz").val();	//选中的店组
		if(ids.length<=0){
			bootbox.alert({"title":"提示",message:"请在左边选择楼盘！"});
			return;
		}
		if(dzId==""){
			bootbox.alert({"title":"提示",message:"请在右边选择店组！"});
			return;
		}
		doBatchAdd(dzId, ids, 3);
	});
	
	//全部添加到维护盘
	$("#bnAddAlltoWhp").click(function(){
		var dzId = $("#selectMainDz").val();	//选中的店组
		if(dzId==""){
			bootbox.alert({"title":"提示",message:"请在右边选择店组！"});
			return;
		}
		bootbox.confirm({"title":"确认",message:"您确定要将 " + fromBmName + " " +  (pageQueryCondition.sta==2?"维护盘":"范围盘") + "下的所有楼盘划至 " + toBmName + " 的维护盘下吗?",callback:function(result){
			if(result){
				$("#bnAddAlltoWhp").prop("disabled", true);
				$.ajax({ 
					url: "./lcfz1!copy.action", 
					dataType: "json", 
					type: "POST",
					data : {"fromBmId": $("#selectCopyGroupDz").val(), "fromSta":pageQueryCondition.sta, "toBmId":dzId, "toSta":2},
					success: function(result){
			        	if(result.code=="ok"){
			        		alert("划盘成功!");
			        		$("#panel1").trigger("click");
			        	} else {
			        		alert("划盘失败: " + result.data);
			        	}
			        	$("#bnAddAlltoWhp").prop("disabled", false);
			    	}
				});
			}
		}
		});
	});
	
	//全部添加到范围盘
	$("#bnAddAllToFwp").click(function(){
		var dzId = $("#selectMainDz").val();	//选中的店组
		if(dzId==""){
			bootbox.alert({"title":"提示",message:"请在右边选择店组！"});
			return;
		}
		bootbox.confirm({title:"确认",message:"您确定要将 " + fromBmName + " " + (pageQueryCondition.sta==2?"维护盘":"范围盘") + "下的所有楼盘划至 " + toBmName + " 的范围盘下吗?",callback:function(result){
				if(result){
					$("#bnAddAllToFwp").prop("disabled", true);
					$.ajax({ 
						url: "./lcfz1!copy.action", 
						dataType: "json", 
						type: "POST",
						data : {"fromBmId": $("#selectCopyGroupDz").val(), "fromSta":pageQueryCondition.sta, "toBmId":dzId, "toSta":3},
						success: function(result){
				        	if(result.code=="ok"){
				        		bootbox.alert({"title":"提示",message:"划盘成功!"});
				        		$("#panel2").trigger("click");
				        	} else {
				        		bootbox.alert({"title":"提示",message:"划盘失败: " + result.data});
				        	}
				        	$("#bnAddAllToFwp").prop("disabled", false);
				    	}
					});
				}
			}
		});
	});
	
	//选择了右边的店组列表
	$("#selectMainDz").change(function(){
		$("#txtLpName").val("");
		var dzId = $(this).val();
		if(dzId==""){
			bootbox.alert({"title":"提示",message:"请选择店组！"});
			return;
		}
		loadLcfz1(dzId,sta,"getLcfc1OfBm", lcfzPageSize, 1, showLcfzPager);
	});
	
	$("#bnSearchDzLp").click(function(){
		var dzId = $("#selectMainDz").val();
		if(dzId==""){
			bootbox.alert({"title":"提示",message:"请选择店组！"});
			return;
		}
		loadLcfz1(dzId,sta,"getLcfc1OfBm", lcfzPageSize, 1, showLcfzPager);
	});
	
	//点击范围盘选项卡
	$("#panel1").click(function(){
		var dzId = $("#selectMainDz").val();	//选中的店组
		if(dzId==""){
			bootbox.alert({"title":"提示",message:"请选择店组！"});
			return;
		}
		sta = 2;
		$("#panelsAll li").removeClass("tabactive");
		$(this).addClass("tabactive");
		loadLcfz1(dzId,sta,"getLcfc1OfBm", lcfzPageSize, 1, showLcfzPager);
	});
	
	//点击维护盘选项卡
	$("#panel2").click(function(){
		var dzId = $("#selectMainDz").val();	//选中的店组
		if(dzId==""){
			bootbox.alert({"title":"提示",message:"请选择店组！"});
			return;
		}
		sta = 3;
		$("#panelsAll li").removeClass("tabactive");
		$(this).addClass("tabactive");
		loadLcfz1(dzId,sta,"getLcfc1OfBm", lcfzPageSize, 1, showLcfzPager);
	});
	
	var lcfz1Pager;	//划盘数据的分页信息
	//获取店组的划盘信息
	function loadLcfz1(dzId,sta,actionMethod, pageSize, pageNo, callback){
		var params = {"pager.rows":pageSize,"pager.page":pageNo,"lcfz1.bmid": dzId, "lcfz1.sta": sta};
		if(actionMethod=="getLcfc1OfBmForCopy"){
			$("#allChoose").prop("checked", false);
			params["pager.sidx"] = "lp_name";
			params["pager.sord"] = pageQueryCondition.sord;
		}else{ 
			$("#allCho").prop("checked", false);
			params["lcfz1.lpName"] = $("#txtLpName").val();
		}
			
		$.ajax({ 
			url: "./lcfz1!"+actionMethod+".action", 
			dataType: "json", 
			type: "POST",
			data : params,
			success: function(pager){
				callback(pager);
	    	}
		});
	}
	
	function showLcfzPager(pager){
		lcfz1Pager = pager;
		$("#dzLpxxCount").html(pager.records);
		var thePagerTable = $("#tblLcfz1");
		$("#lcfzPager").html((pager.page>pager.total?pager.total:pager.page) + "/" + pager.total);
		thePagerTable.find("tr").remove();
		var sHtml = "";
		$.each(pager.datas, function(i,n){
			sHtml += getLcfz1TrHtml(n)
		});
		thePagerTable.append(sHtml);
	}
	
	//划盘信息分页 - 上一页
	$("#lcfzPagerPre").click(function(){
		if(lcfz1Pager.page<=1)return;
		lcfz1Pager.page--;
		loadLcfz1($("#selectMainDz").val(), sta,"getLcfc1OfBm", lcfzPageSize, lcfz1Pager.page, showLcfzPager);
	});
	
	//划盘信息分页 - 下一页
	$("#lcfzPagerNext").click(function(){
		if(lcfz1Pager.page>=lcfz1Pager.total)return;
		lcfz1Pager.page++;
		loadLcfz1($("#selectMainDz").val(), sta,"getLcfc1OfBm", lcfzPageSize, lcfz1Pager.page, showLcfzPager);
	});
	
	function getLcfz1TrHtml(lcfz1){
		var sHtml = '<tr>' + 
		    	'<td class="text-center"><input class="cbr" type="checkbox" name="tAllCho1" value="' + lcfz1.id + '"/></td>' + 
		        '<td class="text-center"><a href="javascript:void(0);"><input type="hidden" value="'+lcfz1.lpId+'"/>' + lcfz1.lpName + '</a></td>' +
		        '<td class="text-center"><button class="btn btn-secondary tEditView" type="button"><i class="fa-pencil"></i>  查看 </button><button class="btn btn-danger tEditDelTwo" type="button"><i class="fa-trash-o"></i> 删除 </button></td>' + 
		    '</tr>';
		return sHtml;
	}
	
	//维护盘、范围盘全选/全不选
	$("#allCho").click(function(){
		$("input[name=tAllCho1]").prop("checked", $(this).prop("checked"));
	});
	
	//批量删除
	$("#allDel").click(function(){
		ids = getSelectedLpsOfLcfz1();
		if(ids.length<=0){
			bootbox.alert({"title":"提示",message:"请在下面选择要删除的楼盘！"});
			return;
		}
		
		bootbox.confirm({title:"确认",message:"您确定要删除所选楼盘吗？",callback:function(result){
			if(result){
				doBatchDelete();
			}
		}});
		//showDeleteConfirmDlg();
	});
	
	//查看某一行数据
	$(document).on("click", ".tEditView", function(){
		var curLpName = $(this).parent().prev().text();	//当前行的楼盘名称
		$("#viewDlgLpName").text(curLpName);
		$("#viewDlgStaName").text(sta==2?"维护盘":"范围盘");
		$.ajax({ 
			url: "./lcfz1!getBmsOfLcfcForLpxx.action", 
			dataType: "json", 
			type: "POST",
			data : {"lcfz1.lpid": $(this).parents("tr").find("td:eq(1) input").val(), "lcfz1.sta":sta},
			success: function(depts){
				$("#viewDlgCon").html(formatNames(depts));
				showViewDlg();
	    	}
		});
	});
	
	function formatNames(names){
		var sHtml = "<table class='table table-bordered'>";
		$.each(names, function(i,n){
			if(i%3==0){
				if(i>0){
					sHtml += "</tr>";
				}
				sHtml += "<tr>"
			}
			sHtml += '<td>'+ n.name +'</td>';
		});
		if(names.length%3!=0){
			sHtml += "</tr>";
		}
		sHtml += "</table>";
		return sHtml;
	}
	
	//删除某一行数据
	$(document).on("click", ".tEditDelTwo", function () {
		ids = [$(this).parents("tr").find("input:eq(0)").val(),$(this).parents("tr").find("input:eq(1)").val()];	//从这一行第一列的单选按钮上得到当前行的id
		bootbox.confirm({title:"确认",message:"您确定要删除该楼盘吗？",callback:function(result){
			if(result){
				doBatchDelete();
			}
		}});
		//showDeleteConfirmDlg();
	});
	
	//显示查询对话框
	function showViewDlg(){
		$("#modal-6").modal('show');
	}
	
	//显示删除确认对话框
	function showDeleteConfirmDlg(){
		$("#bgTwo").css({
            display: "block", height: $(document).height()
        });
        var $box = $('.delShanchuTwo');
        $box.css({
            //设置弹出层距离左边的位置
            left: ($("body").width() - $box.width()) / 2 - 20 + "px",
            //设置弹出层距离上面的位置
            top: ($(window).height() - $box.height()) / 2 + $(window).scrollTop() + "px",
            display: "block"
        });
	}
	
	//关闭删除确认对话框
	function closeDeleteConfirmDlg(){
		$("#viewBg, .view1, #bgTwo, .delShanchuTwo").css("display", "none");
	}
	
	//在维护盘、范围盘中得到选中的楼盘的编号
	function getSelectedLpsOfLcfz1(){
		ids.length = 0;
		$("input[name=tAllCho1]").each(function(i, n){
			if(n.checked){
				ids[ids.length] = n.value;
				ids[ids.length] = $(n).closest("tr").find("input:eq(1)").val();
			}
		});
		return ids;
	}
	
	//点击对话框的确定按钮
	$(".queren").click(function(){
		doBatchDelete();
		closeDeleteConfirmDlg();
	});
	
	//执行划盘操作
	function doBatchAdd(bmId, ids, sta){
		$.ajax({ 
			url: "./lcfz1!batchAdd.action", 
			dataType: "json", 
			type: "POST",
			data : {"ids": ids, "lcfz1.bmid":bmId, "lcfz1.sta":sta},
			success: function(result){
	        	if(result.code=="ok"){
	        		$("input[name=midResult]").each(function(i, n){
	        			if(n.checked){
	        				$(n).parent().css("color","#ff5400");
	        			}
	        		});
	        		//alert("划盘成功!");
	        		//loadLcfz1($("#selectMainDz").val(),sta,"getLcfc1OfBm", lcfzPageSize, 1, showLcfzPager);
	        		if(sta==2)$("#panel1").trigger("click");
	        		if(sta==3)$("#panel2").trigger("click");
	        	} else {
	        		bootbox.alert({"title":"提示",message:"划盘失败: " + result.data});
	        	}
	    	}
		});
	}
	
	//执行删除操作
	function doBatchDelete(){
		//alert(JSON.stringify({"ids": ids}));
		$.ajax({ 
			url: "./lcfz1!batchDelete.action", 
			dataType: "json", 
			type: "POST",
			data : {"ids": ids},
			success: function(result){
	        	if(result.code=="ok"){
	        		bootbox.alert({"title":"提示",message:"删除成功!"});
	        		loadLcfz1($("#selectMainDz").val(),sta,"getLcfc1OfBm", lcfzPageSize, 1, showLcfzPager);
	        	} else {
	        		bootbox.alert({"title":"提示",message:"删除失败: " + result.data});
	        	}
	    	}
		});
	}
	
	//点击关闭按钮的时候，遮罩层关闭
    $(".quxiao, .close").click(function () {
    	closeDeleteConfirmDlg();
    });
});