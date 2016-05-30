<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
	%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>ECharts</title>
</head>

<body>
    <!--Step:1 Prepare a dom for ECharts which (must) has size (width & hight)-->
    <!--Step:1 为ECharts准备一个具备大小（宽高）的Dom-->
    <div id="main" style="height:500px;width:1000px;border:1px solid #ccc;padding:10px;"></div>
    <!--Step:2 Import echarts.js-->
    <!--Step:2 引入echarts.js-->
    <script src="<%=basePath%>/js/echarts-all.js"></script>
    
    <script type="text/javascript">
            //--- 折柱 ---
            var myChart = echarts.init(document.getElementById('main'));
            myChart.setOption({
                tooltip : {
        trigger: 'axis',
        formatter: function(params) {
            return params[0].name + '<br/>'
                   + params[0].seriesName + ' : ' + params[0].value + ' (套)<br/>'
                   + params[1].seriesName + ' : ' + params[1].value + ' (套)<br/>'
                    + params[2].seriesName + ' : ' + params[2].value + ' (套)';
        }
    },
                legend: {
                    data:['全部','在售','在租']
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        data : [0,'1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        name:'成交量(套)',
                        splitArea : {show : true}
                    }
                ],
                series : [
                    {
                        name:'全部',
                        type:'line',
                        data:${ldqianxian==""?"":ldqianxian}
                    },
                    {
                        name:'在售',
                        type:'line',
                        data:${ldcsquxian==""?"":ldcsquxian}
                    },
                    {
                        name:'在租',
                        type:'line',
                        data:${ldczquxian==""?"":ldczquxian}
                    }
                ]
            });
                 window.myChart = myChart;
                 if('${zt}'=='1'){
                  var newOption = myChart.getOption(); // 深拷贝  
                 var seriesstr=  newOption.series;
				seriesstr.splice(0,1);
				seriesstr.splice(1,1);
				myChart.setOption(newOption,true); // 第二个参数表示不和原先的option合并 
                 }else  if('${zt}'=='2'){
                  var newOption = myChart.getOption(); // 深拷贝  
                 var seriesstr=  newOption.series;
				seriesstr.splice(0,1);
				seriesstr.splice(0,1);
				myChart.setOption(newOption,true); // 第二个参数表示不和原先的option合并
                 }
                
				
				
				
				
    </script>
</body>
</html>