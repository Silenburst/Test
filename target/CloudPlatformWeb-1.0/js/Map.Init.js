/**************地图界面布局初始化**************/
$(function(){
		initMap();
		definedInitialize();
		setTimeout("loadMap()", 800);
	});

//--------------------地图初始函数库--------------------------------------------------------------------------
//创建和初始化地图 by louis
function initMap() {
		changescreenWandH();//地图布局界面调整
		createMap(); //创建地图
		setMapEvent(); //设置地图事件
		addMapControl();//向地图添加控件
		
}

//创建地图of chen
function createMap() {
		var city = "长沙";
		var map = new BMap.Map("controller");
		map.centerAndZoom(city,15); 
		map.enableScrollWheelZoom();
		window.map = map;
		map.addEventListener("click", function (e) { 
	    		addMarker(e.point);
		    });  
	}



/**点击地图标记的时候 带文本的标记*/
/**编写自定义函数,创建标注*/
function addMarker(point){
	var geoc = new BMap.Geocoder();    
	var pt = point;

	//map.centerAndZoom(point, 15);
	geoc.getLocation(pt, function(rs){
		//地区地市
		var addComp = rs.addressComponents;
		
		var value = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
		var opts = {
				  position : point,    // 指定文本标注所在的地理位置
				  offset   : new BMap.Size(-10, -30)    //设置文本偏移量
				};
		var label = new BMap.Label(value,opts);
		
		label.setStyle({
			 color : "red",
			 fontSize : "12px",
			 height : "20px",
			 lineHeight : "20px",
			 fontFamily:"微软雅黑",
			 paddingRight:"200px",
			 paddingTop:"0px"
		 });
		var marker = new BMap.Marker(pt);
		map.addOverlay(marker); 
		
		//marker.setAnimation(BMAP_ANIMATION_BOUNCE);
		//可拖动
		marker.disableDragging(true);  //marker.disableDragging();// 不可拖拽
		
		marker.setLabel(label);
		marker.addEventListener("click",function(event) {
					event.domEvent.stopPropagation();
					//query("txtResultMarker").value = curPoint.lng+","+curPoint.lat; 
					var content = "<div style='width:300px;' >";
					content += value;
					content += "<br><input type='button' onclick ='setpl("
							+ event.point.lng
							+ ","
							+ event.point.lat
							+ ",\""
							+ value
							+ "\")'value='使用此位置？' style='margin-left:40px;'/>";
					content += "<input type='button'onclick='setCenterMap("
							+ event.point.lng
							+ ","
							+ event.point.lat
							+ ")'value='地图居中' style='borderRadius:4px; margin-left:30px;'/></div>";

					var info = new BMap.InfoWindow(content);
					marker.openInfoWindow(info);
				});
		 //移除标注  
	    marker.addEventListener("rightclick", function () { 
	    	  if(confirm("确定删除这个标注吗？"))
	   	   {
	    		  map.removeOverlay(marker);  
	   	   }
	    });  
		
	});
}

//地图事件设置函数 by louis
function setMapEvent() {
	map.enableAutoResize();
	//map.enableDragging(); //启用地图拖拽事件，默认启用(可不写)
	map.enableScrollWheelZoom(); //启用地图滚轮放大缩小
	//map.enableDoubleClickZoom(); //启用鼠标双击放大，默认启用(可不写)
	//map.enableKeyboard(); //启用键盘上下左右键移动地图
	//map.setDraggingCursor('hand');//设置拖拽地图时的鼠标指针样式为扒手
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

//定义取值
function query(id) {
	return document.getElementById(id);//定义query,以便调用
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
	if(query("inputId").value != null && query("inputId").value != "") {
		$("#sqaddress").val(query("inputId").value);
		search();
	}
}
function search() {
	map.clearOverlays();
	var searchTxt = query("inputId").value;
	var ls = new BMap.LocalSearch(
			map,
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
				onMarkersSet : function(pois) {
					for (var i = 0; i < pois.length; i++) {
						( /**第一个(中间是执行的function) 第二个()指的是function内容*/
						/** ( function(){} )() for里面的两个括号代表，调用执行中间的function*/
						function() {
							var index = i;
							var curPoi = pois[i];
							var curPoint = curPoi.point;
							var curMarker = curPoi.marker;
							curMarker.addEventListener(
											"click",
											function(event) {
												event.domEvent.stopPropagation();
												//query("txtResultMarker").value = curPoint.lng+","+curPoint.lat; 
												var content = "";
												content += "<div style='width:300px'>"
														+ curPoi.title
														+ "<br>";
												content += curPoi.address;
												content += "<br><input type='button' onclick ='setpl("
														+ curPoint.lng
														+ ","
														+ curPoint.lat
														+ ",\""
														+ curPoi.address
														+ "\")'value='使用此位置？' style='margin-left:40px;'/>";
												content += "<input type='button'onclick='setCenterMap("
														+ curPoint.lng
														+ ","
														+ curPoint.lat
														+ ")'value='地图居中' style='borderRadius:4px; margin-left:30px;'/></div>";

												var info = new BMap.InfoWindow(
														content);
												curMarker.openInfoWindow(info);

											});
						})();
					}
				}
			});//,pageCapacity:5
	//ls.searchInBounds(searchTxt,map.getBounds());
	ls.search(searchTxt);
}

/*返回X,Y坐标*/
function setpl(lng, lat, address) {
	//返回X坐标和Y坐标
	setXandY(lng,lat,address,"modelClose");
}

function setCenterMap(lng, lat) {
	var point = new BMap.Point(lng, lat);
	map.centerAndZoom(point, 15);
	//window.close;
}

//ziding definedInitialize
function definedInitialize() {
	function DefinedStaticsControl() {
		// 设置默认停靠位置和偏移量
		this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
		this.defaultOffset = new BMap.Size(600, 10);
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
		var sqaddress = query("sqaddress").value;
		if(sqaddress != "") {
			inputText.value = sqaddress;
		} else {
			inputText.placeholder = "请输入要查询的地址...";
		}
		inputText.style.color = "red";
		inputText.style.position = "left";
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
		input.style.color = "blue";

		input.onclick = function() {
			search();
		};
		div.appendChild(input);

		map.getContainer().appendChild(div);
		// map.getPanes().markerMouseTarget.appendChild(div);
		//保存div实例
		this._div = div;
		// alert(query("inputId").value);
		return div;
	};
	var myDefined = new DefinedStaticsControl();
	//alert(map.getCenter().lng);
	map.addControl(myDefined);
}