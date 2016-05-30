// 百度地图API功能
var map = new BMap.Map("allmap"); // 创建地图实例
function maps(x, y){
	if(x!=null && y!=null){
		point = new BMap.Point(x, y); // 创建点坐标
	} else {
		point = new BMap.Point(113.013056,28.21462); // 创建点坐标
	}
		options = {
			renderOptions: {
				map: map,
				panel:"r-result"
			},
			pageCapacity:3
		};
		localSearch = new BMap.LocalSearch(map, options);

		map.addEventListener("load", function() {
		var circle = new BMap.Circle(point, 3000, {
			fillColor: "blue",
				strokeWeight: 1,
				fillOpacity: 0.3,
				strokeOpacity: 0.3
			});		
			map.addOverlay(circle);
		});
		map.centerAndZoom(point, 12); // 初始化地图，设置中心点坐标和地图级别
		map.enableScrollWheelZoom();
		map.addControl(new BMap.NavigationControl()); //添加默认缩放平移控件

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
//			circlecomplete
		    map.clearOverlays();
			circle = e;
			map.addOverlay(overlay);		
			var radius = parseInt(e.getRadius());
			var center = e.getCenter();
			drawingManager.close();
		});
}

function sea(name)
{
	localSearch.searchNearby(name, point, 3000);
}

