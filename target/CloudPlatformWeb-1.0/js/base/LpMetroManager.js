function queryData(){
		var couId = $("#country a.active").attr("data-id") == null ? 0 : $("#country a.active").attr("data-id");
	    var proId = $("#pro a.active").attr("data-id") == null ? 0 : $("#pro a.active").attr("data-id");
	    var cityId = $("#city a.active").attr("data-id") == null ? 0 : $("#city a.active").attr("data-id");
	    var leiBieid = $("#leiBie a.active").attr("data-id") == null ? 0 : $("#leiBie a.active").attr("data-id");
	    var xianluId = $("#xianlu a.active").attr("data-id") == null ? 0 : $("#xianlu a.active").attr("data-id");
	    var zdName = $("#zdUserName").val();
	    
	    var url = basePath+"/base/lpMetroManager!pageList.action";
	    $("#macPageWidget").asynPage(url, "#tbodyData", buildDataHtml, true, true, {
	        'metro.countryId': couId,
	        'metro.pid': proId,
	        'metro.cityID': cityId,
	        'metro.leibeiID': leiBieid,
	        'metro.xianID':xianluId,
	        'metro.zdName':zdName
	    });
	};
	
	function buildDataHtml(list) {
		$("#tbodyData").html("");
	    $.each(list, function (i, info) { 
	    	var x = info[7]=="null" ||info[7]=="" || info[7]==null?"":info[7];
	    	var y = info[8]=="null" ||info[8]=="" || info[8]==null?"":info[8];
	        var tr = [
	            '<tr>',
	            '<td class="text-center">', '<input type="checkbox" class="cbr" name = "id" value="'+info[3]+'" id="'+info[4]+'"   onclick="setSelectAll(this)" />', '</td>',
	            '<td class="text-center">', info[0]=="null" ||info[0]=="" || info[0]==null?"":info[0], '</td>',
	            '<td class="text-center">', info[1]=="null" ||info[1]=="" || info[1]==null?"":info[1], '</td>',
	            '<td class="text-center">', info[2]=="null" ||info[2]=="" || info[2]==null?"":info[2], '</td>',
	            '<td><a class="pr10" data-toggle="modal" onclick="jQuery(\'#shangquan-gai\').modal(\'show\');updateXianLu('+info[5]+','+info[6]+');selectData(\''+info[0]+'\',\''+info[2]+'\','+info[3]+','+info[5]+','+info[6]+',\''+x+'\',\''+y+'\')"><i class="fa-pencil"></i> 修改</a><a class="pr10" onclick="deldata('+info[3]+')"><i class="fa-trash-o" ></i> 删除 </a></td>',
	            '</tr>'].join('');
	        $("#tbodyData").append(tr);
	    });
	};