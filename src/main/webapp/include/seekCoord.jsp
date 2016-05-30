<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=cwWUeu7m6ZIclzyUBhqMrA05"></script>
  <style type="text/css">
		body, html{width: 100%;height: 100%;margin:0;font-family:"微软雅黑";font-size:14px;}
		#divMap{width:100%;height:100%;float:top;border:1px  solid #000}
		#txtResult{width:100%}
	</style>
  <title>添加定位相关控件</title>
</head>
<body>
	<div id="divMap" ></div>
</body>
		<script src="<%=basePath%>/assets/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
/**************地图界面布局初始化**************/
 $(function () {
		initMap();//初始地图界面
    //动态监听浏览器宽高变化，初始化各部分宽高
    $(window).resize(function () {
        changescreenWandH();
    });    
    mark();
});

//创建和初始化地图 by louis
function initMap() {
		changescreenWandH();//地图布局界面调整
		createMap(); //创建地图
		setMapEvent(); //设置地图事件
		addMapControl();//向地图添加控件
		definedInitialize();
}

//创建地图of chen
function createMap() {
		//var city = "${xhjJccity.cityName}";
		var city="长沙";
		var map = new BMap.Map("divMap");
		map.centerAndZoom(city,12); 
		map.enableScrollWheelZoom();
		window.map = map;
	}
	
//地图事件设置函数 by louis
function setMapEvent() {
	map.enableAutoResize();
	map.enableDragging(); //启用地图拖拽事件，默认启用(可不写)
	map.enableScrollWheelZoom(); //启用地图滚轮放大缩小
//	map.enableDoubleClickZoom(); //启用鼠标双击放大，默认启用(可不写)
	map.enableKeyboard(); //启用键盘上下左右键移动地图
	map.setDraggingCursor('hand');//设置拖拽地图时的鼠标指针样式为扒手
}

//地图控件添加函数 by louis
function addMapControl() {
	// 添加带有定位的导航控件
	  var navigationControl = new BMap.NavigationControl({
	    // 靠左上角位置
	    anchor: BMAP_ANCHOR_TOP_LEFT,
	    // LARGE类型
	    type: BMAP_NAVIGATION_CONTROL_LARGE,
	  });
	  map.addControl(navigationControl);
	
	//向地图中添加比例尺控件
	var ctrl_sca = new BMap.ScaleControl({
		anchor: BMAP_ANCHOR_BOTTOM_LEFT
	});
	map.addControl(ctrl_sca);
	  //切换地图类型的控件  
	  var map_type = new BMap.MapTypeControl();  
	  map.addControl(map_type);  
}

//动态判定地图各部分宽高
function changescreenWandH() {
	//动态判定右侧地图的高度
	var rightbarheight = $(window).height() ; //parseInt(document.body.clientHeight)-topbarheight;

	$("#divMap").css({
		"height": rightbarheight
	});
}

//	map.addEventListener("mouseover", function(e) {
//		document.title = e.point.lng + "," + e.point.lat;
//	});

function loadMap(){
//	if($("inputId").val() != null && $("inputId").val() != "") {
	//var city = "${xhjJccity.cityName}";
	var city="长沙";
		search(city);
//	}
}
function search(city) {
	map.clearOverlays();
	var searchTxt = $("#inputId").val();
 	// var map = new BMap.Map("divMap");
    //map.centerAndZoom(new BMap.Point(108.532769,22.825487), 12);    //这里是定义到了南宁市
    var gc = new BMap.Geocoder();
    gc.getPoint(searchTxt, function(pt){
     	        if(pt){
	        	        	var marker = new BMap.Marker(pt);
	        	        	addInfo(pt);
	        	        	map.addOverlay(marker);        //如果地址解析成功，则添加红色marker
	        	        	setCenterMap(pt.lng, pt.lat);
	        					//第一个(中间是执行的function) 第二个()指的是function内容
	        					//( function(){} )() for里面的两个括号代表，调用执行中间的function
	        					function  addInfo(pt) 
	        					{
	        						var curPoint = pt;
	        						marker.addEventListener
	        						("mouseover",
	        							function(event) {//长沙市芙蓉区八一路95号
	        								var content = "<div style='width:300px;border:1;color:#2E2E2E;background:#C1FFC1'>地址："+searchTxt;
	        								content += "<p><input type='button' onclick ='setpl("
	        										+ curPoint.lng
	        										+ ","
	        										+ curPoint.lat
	        										+ ",\""
													+ searchTxt
													+ "\")'value='使用此位置？' style='margin-left:12px;margin-right:10px;border-radius:10px;'/>";
	        								content += "<input type='button'onclick='setCenterMap("
	        										+ curPoint.lng
	        										+ ","
	        										+ curPoint.lat
	        										+ ")'value='地图居中' style='align:center;border-radius:10px;margin-right:12px;margin-left:10px;'/></div>";
	
	        								var info = new BMap.InfoWindow(content);
	        								marker.openInfoWindow(info);
	        						});
	        					}
        	        }else{
        	        	var ls = new BMap.LocalSearch(map,
            			{
            				renderOptions : {
            					map : map,
            					//panel: "results",//结果容器id
            					autoViewport : true,//自动结果标注 
            					selectFirstResult : false
            				//不指定到第一个目标
            				},
            				pageCapacity : 8,
            				//自定义marker事件
            				onMarkersSet : function(pois) 
            				{
            					if(pois.length >=0)
            					{
	            					for (var i = 0; i < pois.length; i++) 
	            					{( 
	            						//第一个(中间是执行的function) 第二个()指的是function内容
	            						// ( function(){} )() for里面的两个括号代表，调用执行中间的function
	            						function() 
	            						{
	            							var index = i;
	            							var curPoi = pois[i];
	            							var curPoint = curPoi.point;
	            							var curMarker = curPoi.marker;
	            							setCenterMap(curPoint.lng, curPoint.lat);
	            							curMarker.addEventListener
	            							(
	            								"mouseover",
	            								function(event) {
	            									//$("#txtResultMarker").val() = curPoint.lng+","+curPoint.lat; 
	            									var content = "";
	            									content += "<div style='width:300px;border:1;color:#2E2E2E;background:#C1FFC1'>地址："
	            											+ curPoi.title
	            											+ "<br>";
	            									content += curPoi.address;
	            									content += "<p><input type='button' onclick ='setpl("
	            											+ curPoint.lng
	            											+ ","
	            											+ curPoint.lat
	            											+ ",\""
															+ curPoi.address+curPoi.title
															+ "\")'value='使用此位置？' style='margin-left:12px;margin-right:10px;border-radius:10px;'/>";
	            									content += "<input type='button'onclick='setCenterMap("
	            											+ curPoint.lng
	            											+ ","
	            											+ curPoint.lat
	            											+ ")'value='地图居中' style='align:center;border-radius:10px;margin-right:12px;margin-left:10px;'/></div>";
	            									var info = new BMap.InfoWindow(content);
	            									curMarker.openInfoWindow(info);
	            							});
	            						})();
	            					}
            					}else
            					{
            						alert("没找到此位置...请重新输入");
            					}
            				}
            			});
            	ls.search(searchTxt);
     	 }        
    },city);
}


/*返回X,Y坐标*/
function setpl(lng, lat, address) {
	//返回X坐标和Y坐标
	setXandY(lng,lat,address,"modelClose");
	if(confirm("是否需要使用地图上的地址？如果仅使用坐标请点击取消."))
	{
		parent.document.getElementById("address").value =address;
	}
}

function setXandY(x,y,address,winClose){
	var boolean = 	parent.document.getElementById("up");
	if(null == boolean || boolean =="null"|| boolean.value=="0")
	{
		parent.document.getElementById("xxzbx").value = x;
		parent.document.getElementById("xxzby").value = y;
		parent.document.getElementById("windowClose").click();
	}
	else if(boolean.value=="1")
	{	
		parent.document.getElementById("xxzbx1").value = x;
		parent.document.getElementById("xxzby1").value = y;
		parent.document.getElementById("windowClose").click();
	}
	else if(boolean.value=="2")
	{
		parent.document.getElementById("xxzbx2").value = x;
		parent.document.getElementById("xxzby2").value = y;
		parent.document.getElementById("windowClose").click();
	}
	else if(boolean.value=="3")
	{
		parent.document.getElementById("xxzbx3").value = x;
		parent.document.getElementById("xxzby3").value = y;
		parent.document.getElementById("windowClose").click();
	}
};

function setCenterMap(lng, lat) {
	var point = new BMap.Point(lng, lat);
	map.centerAndZoom(point, 18);
	//window.close;
}

//ziding definedInitialize
function definedInitialize() {
	function DefinedStaticsControl() {
		// 设置默认停靠位置和偏移量
		this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
		this.defaultOffset = new BMap.Size(550, 10);
	}

	DefinedStaticsControl.prototype = new BMap.Control();

	DefinedStaticsControl.prototype.initialize = function(map) {
		//保存map
		this._map = map;
		//创建div、元素，作为自定义覆盖器的容器
		var div = document.createElement("div");
		//将添加物添加到覆盖容器
		var inputText = this._input = document.createElement("input");
		inputText.type = "text";
		inputText.id = "inputId";
		var sqaddress =	parent.document.getElementById("address").value;
		if(sqaddress != "") {
			inputText.value = sqaddress;
		} else {
			inputText.placeholder = "请输入要查询的地址...";
		}
		inputText.style.color = "#CD0000";
		inputText.style.position = "center";
		inputText.style.width = "250px";
		inputText.style.height = "30px";
		inputText.style.borderColor="#3385ff";
		inputText.focus();
		inputText.onchange = function() {
			search();
		};
		div.appendChild(inputText);

		var input = this._input = document.createElement("input");
		input.type = "button";
		input.id = "buttonId";
		//input.style.margin = "5px";
		input.value = "搜索";
		input.style.color = "white";
		input.style.width = "100px";
		input.style.height = "37px";
		input.style.fontSize="15px";
	    input.style.backgroundColor="#3385ff";
		input.onclick = function() {
			 	 loadMap();
		};
		div.appendChild(input);

		map.getContainer().appendChild(div);
		// map.getPanes().markerMouseTarget.appendChild(div);
		//保存div实例
		this._div = div;
		// alert($("#inputId").val());
		return div;
	};
	var myDefined = new DefinedStaticsControl();
	//alert(map.getCenter().lng);
	map.addControl(myDefined);
}




/**点击地图标记的时候 带文本的标记*/
/**编写自定义函数,创建标注*/
function addMarker(point){
	var geoc = new BMap.Geocoder();    
	var pt = point;
	map.clearOverlays();
	geoc.getLocation(pt, function(rs){
		//地区地市
		var addComp = rs.addressComponents;
		var searchTxt = addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber;
		var marker = new BMap.Marker(point);
		map.addOverlay(marker); 
		//tiao
		//marker.setAnimation(BMAP_ANIMATION_BOUNCE);
		//可拖动
		marker.disableDragging(true);  //marker.disableDragging();// 不可拖拽
//		rightMenu(marker);
		window.marker = marker;
		infoWindow(pt,searchTxt);
		marker.addEventListener
		("mouseover",
				function(event) {//长沙市芙蓉区八一路95号
					infoWindow(pt,searchTxt);
		});
	});
}


function infoWindow(point,searchTxt)
{
	var content = "<div style='width:300px;border:1;color:#2E2E2E;background:#C1FFC1'>地址："+searchTxt;
	content += "<p><input type='button' onclick ='setpl("
			+ point.lng
			+ ","
			+ point.lat
			+ ",\""
			+ searchTxt
			+ "\")'value='使用此位置？' style='margin-left:12px;margin-right:10px;border-radius:10px;'/>";
	content += "<input type='button'onclick='setCenterMap("
			+ point.lng
			+ ","
			+ point.lat
			+ ")'value='地图居中' style='align:center;border-radius:10px;margin-right:12px;margin-left:10px;'/></div>";
	
	var info = new BMap.InfoWindow(content);
	marker.openInfoWindow(info);
}

/**标注*/
function mark(){
   map.addEventListener("rightclick", function(e){ 
// 		if($("#count").val() == 3)
// 		{
// 			  map.removeContextMenu();
			  if(confirm("确定标记到这里吗？"))
			   {
				   var point = e.point;
					addMarker(point);
			   }
// 		}
	}); 
};

</script>
</html>