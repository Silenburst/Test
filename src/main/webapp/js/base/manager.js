function queryData(){
		var couId = $("#country a.active").attr("data-id") == null ? 0 : $("#country a.active").attr("data-id");
	    var proId = $("#pro a.active").attr("data-id") == null ? 0 : $("#pro a.active").attr("data-id");
	    var cityId = $("#city a.active").attr("data-id") == null ? 0 : $("#city a.active").attr("data-id");
	    var qyId = $("#sQy a.active").attr("data-id") == null ? 0 : $("#sQy a.active").attr("data-id");
	    var sqName = $("#sqUserName").val();
	    
	    var url = basePath+"/base/regionManager!pageInFo.action";
	    $("#macPageWidget").asynPage(url, "#tbodyData", buildDataHtml, true, true, {
	        'metro.countryId': couId,
	        'metro.pid': proId,
	        'metro.cityID': cityId,
	        'metro.qyID': qyId,
	        'metro.sqName':sqName
	    });
	};
	
	function buildDataHtml(list) {
		$("#tbodyData").html("");
	    $.each(list, function (i, info) {
	    	var newTime = new Date(info[3]); 
	    	var nowStr = newTime.format("yyyy-MM-dd hh:mm:ss"); 
	    	var newDateTime;
	    	var nowStrData;
	    	if(null != info[4]&& info[4]!=''){
	    		 newDateTime = new Date(info[4]);
		    	 nowStrData = newDateTime.format("yyyy-MM-dd hh:mm:ss");
	    	}else{
	    		nowStrData='';
	    	}
	    	
	        var tr = [
	            '<tr>',
	            '<td class="text-center">', '<input type="checkbox" class="cbr" name="id" value="'+info[7]+'"  onclick="setSelectAll(this)" />', '</td>',
	            '<td class="text-center">', info[0]=="null" ||info[0]=="" || info[0]==null?"":info[0], '</td>',
	            '<td class="text-center">', info[2]=="null" ||info[2]=="" || info[2]==null?"":info[2], '</td>',
	            '<td class="text-center">', nowStr, '</td>',
	            '<td class="text-center">',nowStrData, '</td>',
	            '<td><a class="pr10" data-toggle="modal" onclick="jQuery(\'#shangquan-gai\').modal(\'show\'); selectData(\''+info[6]+'\',\''+info[0]+'\',\''+info[2]+'\',\''+info[7]+'\',\''+info[9]+'\',\''+info[10]+'\')"><i class="fa-pencil"></i> 修改</a><a class="pr10" onclick="updateBatchRemove('+info[7]+')"><i class="fa-trash-o" ></i> 删除 </a></td>',
	            '</tr>'].join('');
	        $("#tbodyData").append(tr);
	    });
		
	};
	
	Date.prototype.format = function(format){ 
		var o = { 
		"M+" : this.getMonth()+1, //month 
		"d+" : this.getDate(), //day 
		"h+" : this.getHours(), //hour 
		"m+" : this.getMinutes(), //minute 
		"s+" : this.getSeconds(), //second 
		"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
		"S" : this.getMilliseconds() //millisecond 
		} 

		if(/(y+)/.test(format)) { 
		format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
		} 

		for(var k in o) { 
		if(new RegExp("("+ k +")").test(format)) { 
		format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
		} 
		} 
		return format; 
		} 
