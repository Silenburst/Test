var WEB_ROOT = "http://localhost:8080/XHJLPZDServices";
var SERVICES_BASE_PATH = WEB_ROOT + "/services/newenv/lpzd";
var SERVICES_BASE_URL = WEB_ROOT + "/newenv/lpzd";
var IMAGE_PATH = "http://imgbms.xhjfw.com/";
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

function back(){
	window.location.href=basePath+"/fanghao/fanghaoindex.jsp?p=house";
	}


function historyback(){
	history.back(1);
	}

