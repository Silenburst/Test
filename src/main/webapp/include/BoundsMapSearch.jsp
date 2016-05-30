<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html {width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
		#allmap{width:80%;height:500px;float:left}
		p{margin-left:5px; font-size:14px;}
		#r-result{margin-left:0px;float:right;width:20%}
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=jYNU39RZ3k37NUz1QduizaYD"></script>
<!--加载鼠标绘制工具-->
<script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />


	<title>圆形区域搜索用户数据</title>
</head>
<body>
	<!--二维地图-->
	<div id="mapsou" style="width:923px;height:300px; display:block;">
		<div id="map-di-aa" style="height:30px;line-height:30px;">
			 <p>
				  <a class="mya" href="javascript:void(0)" style="display: none;" onMouseOver="sea('公交')">公交</a>
				 <a class="mya" href="javascript:void(0)" class="om" onMouseOver="sea('公交')">公交</a>
				 <a class="mya" href="javascript:void(0)" onMouseOver="sea('2号线')">地铁</a>
				 <a class="mya" href="javascript:void(0)" onMouseOver="sea('学校')">学校</a>
				 <a class="mya" href="javascript:void(0)" onMouseOver="sea('医院')">医院</a>
				 <a class="mya" href="javascript:void(0)" onMouseOver="sea('银行')">银行</a>
				 <a class="mya" href="javascript:void(0)" onMouseOver="sea('休闲娱乐')">休闲娱乐</a>
				 <a class="mya" href="javascript:void(0)" onMouseOver="sea('购物')">购物</a>
				 <a class="mya" href="javascript:void(0)" onMouseOver="sea('餐饮')">餐饮</a>
				 <a class="mya" href="javascript:void(0)" onMouseOver="sea('运动健身')">运动健身</a>
				 <a class="mya" href="javascript:void(0)" onMouseOver="sea('新环境')">服务网点</a>
			 </p>
		</div>
<!-- 			<div> -->
<!-- 				<input type="text" id = "searchId" oninput = "sea(this.value)"></input> -->
<!-- 				<input type ="button" id = "btn" onclick ="sea($('#searchId'))" value = "button"/> -->
<!-- 			</div> -->
			<div>
				<div id="allmap"></div>
				<div id="r-result"></div>
			</div>
	</div>


	
</body>
</html>
<script type="text/javascript">
	$(document).ready(function(){
		mapParam(x,y,"");
	})
	function sea(name)
	{
		mapParam(x,y,name);
	}
	
	function mapParam(x,y,name){
			var map = new BMap.Map("allmap"); // 创建地图实例
			var point =null;
			// 百度地图API功能
			if(x == null || x=="" ||y==""||y==null)
			{
				point = new BMap.Point(113.013056,28.229237); // 创建点坐标
			}else
			{
				point = new BMap.Point(x,y); // 创建点坐标
			}
			window.point = point;
		var options = {
			renderOptions: {
				map: map,
				panel:"r-result"
			},
			pageCapacity:5
			/* onSearchComplete: function(results) {
				alert('Search Completed');
				//可添加自定义回调函数
			} */
		};
		var localSearch = new BMap.LocalSearch(map, options);
		map.centerAndZoom(point, 13); // 初始化地图，设置中心点坐标和地图级别
		map.enableScrollWheelZoom();
		map.addControl(new BMap.NavigationControl()); //添加默认缩放平移控件
		
		map.addEventListener("load", function() {
			var circle = new BMap.Circle(point, 3000, {
				fillColor: "blue",
				strokeWeight: 1,
				fillOpacity: 0.3,
				strokeOpacity: 0.3
			});		
			map.addOverlay(circle);
		});
	
		var drawingManager = new BMapLib.DrawingManager(map, {
			isOpen: false, //是否开启绘制模式
			enableDrawingTool: true, //是否显示工具栏
			drawingToolOptions: {
				anchor: BMAP_ANCHOR_TOP_RIGHT, //位置
				offset: new BMap.Size(5, 5), //偏离值
				scale: 0.8, //工具栏缩放比例
				drawingModes: [
					BMAP_DRAWING_CIRCLE
				]
			}
		});
		var circle = null;
		drawingManager.addEventListener('circlecomplete', function(e, overlay) {
		//	circlecomplete
		    map.clearOverlays();
			circle = e;
			map.addOverlay(overlay);		
			var radius = parseInt(e.getRadius());
			var center = e.getCenter();
			drawingManager.close();
		});	
			localSearch.searchNearby(name, point, 3000);
	}
</script>
	
	
	
	
	