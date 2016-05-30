<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>html5图表</title>

<script type="text/javascript" src="<%=basePath%>/js/simplequxian/jQuery.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/simplequxian/jqplot.js"></script>
<script type="text/javascript">
var basepath = "<%=basePath%>";
$(document).ready(function() {
	var data0 = [[1,2,3,4,5,6,7,8,9,10,11,12],[3,6,8,1,11,22,4,21,6,2,5,3],[1,2,3,1,11,8,1,5,21,0,0,0],[10,22,13,1,1,5,11,15,12,0,0,0]];
	var data = [[1,2,3,4,5,6,7,8,9],[3,6,8,1,11,22,4,21,6]];
	var data_max = 30; //Y轴最大刻度
	var line_title0 = ["全部","在租","在售","空置"]; //圆柱名称
	var line_title = ["二手房","租房"]; //曲线名称
	
	var y_label = "成交量基数"; //Y轴标题
	var x_label = "时间日期"; //X轴标题
	var x = ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']; //定义X轴刻度值
	var title0 = "小区房屋走势"; //统计图标标题
	var title = "小区房屋走势"; //统计图标标题
	j.jqplot.diagram.base("chart1", data0, line_title0, title0, x, x_label, y_label, data_max, 1);
	//j.jqplot.diagram.base("chart2", data0, line_title,title, x, x_label, y_label, data_max,2);
});
</script>

</head>
<body>

	<div id="chart1" style="width:500px;heigth:500px"></div>
	<!-- <div id="chart2"></div> -->

</body>
</html>

