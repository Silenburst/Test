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
    <div id="maincj" style="height:500px;width:1000px;border:1px solid #ccc;padding:10px;"></div>
    <!--Step:2 Import echarts.js-->
    <!--Step:2 引入echarts.js-->
    <script src="<%=basePath%>/js/echarts-all.js"></script>
    
    <script type="text/javascript">
            //--- 折柱 ---
            var myChart = echarts.init(document.getElementById('maincj'));
          
           var option = {
    title : {
        text: '小区房屋走势',
        subtext: '新环境房屋网',
        x: 'center'
    },
    tooltip : {
        trigger: 'axis',
        formatter: function(params) {
            return params[0].name + '<br/>'
                   + params[0].seriesName + ' : ' + params[0].value + ' (元/平方)<br/>'
                   + params[1].seriesName + ' : ' + params[1].value + ' (套)';
        }
    },
    legend: {
        data:['成交均价','成交量'],
        x: 'left'
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            magicType : {show: true, type: ['line', 'bar']},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    dataZoom : {
        show : true,
        realtime : true,
        start : 0,
        end : 100
    },
    xAxis : [
        {
            type : 'category',
            boundaryGap : false,
            axisLine: {onZero: false},
            data : [0,"1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月" ]
        }
    ],
    yAxis : [
        {
            name : '均价(元/平方)',
            type : 'value'
        },
        {
            name : '成交量(套)',
            type : 'value',
            axisLabel : {
                formatter: function(v){
                    return v;
                }
            }
        }
    ],
    series : [
        {
            name:'成交均价',
            type:'line',
            itemStyle: {normal: {areaStyle: {type: 'default'}}},
            data:${junjialist}
        },
        {
            name:'成交量',
            type:'bar',
            yAxisIndex:1,
            itemStyle: {normal: {areaStyle: {type: 'default'}}},
            data: (function(){
                var oriData = ${cslist};
                var len = oriData.length;
                while(len--) {
                    oriData[len] *= 1;
                }
                return oriData;
            })()
        }
    ]
};
                    
                      myChart.setOption(option);
    </script>
</body>
</html>