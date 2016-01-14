<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>试卷管理分析系统(教师端)</title>
<!-- Bootstrap Core CSS -->
<link href="<c:url value='/index/bower_components/bootstrap/dist/css/bootstrap.min.css'/>" rel="stylesheet">
<!-- MetisMenu CSS -->
<link	href="<c:url value='/index/bower_components/metisMenu/dist/metisMenu.min.css'/>" rel="stylesheet">
<!-- Timeline CSS -->
<link href="<c:url value='/index/dist/css/timeline.css'/>" rel="stylesheet">
<!-- Custom CSS -->
<link href="<c:url value='/index/dist/css/sb-admin-2.css'/>" rel="stylesheet">
<!-- Morris Charts CSS -->
<link href="<c:url value='/index/bower_components/morrisjs/morris.css'/>" rel="stylesheet">
<!-- Custom Fonts -->
<link href="<c:url value='/index/bower_components/font-awesome/css/font-awesome.min.css'/>" rel="stylesheet" type="text/css">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<style type="text/css">
.sec {
	position: absolute;
	right: 30%;
	top: 60px;
}

.secg {
	position: absolute;
	left: 30%;
	top: 60px;
}
</style>

<script src="<c:url value='/index/bower_components/jquery/dist/jquery.min.js'/>"></script>
<link rel="stylesheet" href="<c:url value='/index/css/drop-down.css'/>" />
<script src="<c:url value='/index/js/jquery-ui.min.js'/>"></script>
<script src="<c:url value='/index/js/select-widget-min.js'/>"></script>


</head>

<body>

<div>
<div class="text-center" style="margin-bottom: 110px;">
	<span style="font-size: 25px;">学生个人学习履历</span>
	<div class="sec text-left">
		<!-- 学生下拉选择框 -->
		<form action="" method="get" class="form">
			<select name="drop1" class="ui-select" id="stu-select">
				<c:forEach items="${stuList}" var="stu">
					<option value="${stu}"
						<c:if test="${stu eq selectedStu}" >
					selected='selected'
				</c:if>>
						${stu}</option>
				</c:forEach>
			</select>
		</form>
	</div>
	<div class="secg text-left">
		<!-- 年级下拉选择框 -->
		<form action="" method="get" class="form">
			<select name="drop1" class="ui-select" id="grade-select">
				<c:forEach items="${stuYearList}" var="stuYear">
					<option value="${stuYear.classyear}"
						<c:if test="${stuYear.classyear eq selectedGrade}" >
					selected='selected'
				</c:if>>
						${stuYear.classyear}</option>
				</c:forEach>
			</select>
		</form>
	</div>
</div>
</div>

<!-- 为ECharts准备一个具备大小（宽高）的Dom -->	
	<div id="mainchinese" style="height:400px;width:80%;margin:0 auto;"></div>
	<div id="prchinese" style="height:400px;width:80%;margin:0 auto;"></div>	
	<div id="mainmath" style="height:400px;width:80%;margin:0 auto;"></div>
	<div id="prmath" style="height:400px;width:80%;margin:0 auto;"></div>	
	<div id="mainenglish" style="height:400px;width:80%;margin:0 auto;"></div>
	<div id="prenglish" style="height:400px;width:80%;margin:0 auto;"></div>
    <!-- ECharts单文件引入 -->
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
    <script type="text/javascript">
    
    // 语文前测数据
    var chineseBefData = [60, 70, 85, 78, 86, 83, 77, 66, 55, 44];
  	// 语文后测数据
    var chineseAftData = [80, 74, 81, 90, 73, 80, 88, 77, 90, 88];
  	// 语文前后测相差数据
  	var chineseGradeCutData = [60, 70, 81, 78, 73, 80, 77, 66, 55, 44];
  	// 语文前后测相差数据起点数据
  	var chineseGradeHighData = [20, 4, 4, 12, 13, 3, 11, 11, 35, 44];
  	// 语文成绩-PR关系数据
    var chineseGradeAndPrData = [[21.5,20.34],[32.5,33.33],[45,40.89],[57.5,60.78],[80.8,75.79],[75,80.45]];
  	
 	// 数学前测数据
    var mathBefData = [60, 70, 85, 78, 86, 83, 77, 66, 55, 44];
  	// 数学后测数据
    var mathAftData = [80, 74, 81, 90, 73, 80, 88, 77, 90, 88];
  	// 数学前后测相差数据
  	var mathGradeCutData = [60, 70, 81, 78, 73, 80, 77, 66, 55, 44];
  	// 数学前后测相差数据起点数据
  	var mathGradeHighData = [20, 4, 4, 12, 13, 3, 11, 11, 35, 44];
  	// 数学成绩-PR关系数据
    var mathGradeAndPrData = [[21.5,20.34],[32.5,33.33],[45,40.89],[57.5,60.78],[80.8,75.79],[75,80.45]];
  	
 	// 英文前测数据
    var englishBefData = [60, 70, 85, 78, 86, 83, 77, 66, 55, 44];
  	// 英文后测数据
    var englishAftData = [80, 74, 81, 90, 73, 80, 88, 77, 90, 88];
  	// 英文前后测相差数据
  	var englishGradeCutData = [60, 70, 81, 78, 73, 80, 77, 66, 55, 44];
  	// 英文前后测相差数据起点数据
  	var englishGradeHighData = [20, 4, 4, 12, 13, 3, 11, 11, 35, 44];
  	// 英文成绩-PR关系数据
    var englishGradeAndPrData = [[21.5,20.34],[32.5,33.33],[45,40.89],[57.5,60.78],[80.8,75.79],[75,80.45]];
    
        // 语文   路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/line',
				'echarts/chart/bar'	// 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('mainchinese')); 
                
                var option = {
                    title :{
						text : '语文',
						subtext : ''
					},
					tooltip : {
						trigger: 'axis',
						formatter: function (params){		//显示信息标签
							return params[0].name + ' : '
								   + (params[2].value - params[1].value > 0 ? '+' : '-') 
								   + params[0].value + '<br/>'
								   + params[2].seriesName + ' : ' + params[2].value + '<br/>'
								   + params[3].seriesName + ' : ' + params[3].value + '<br/>'
						}
					},
					toolbox: {
						show : true,
						feature : {
							magicType : {show: true, type: ['line', 'bar']},
							restore : {show: true},
						}
					},
					legend: {
						data:['前测', '后测'],
						selectedMode:false
					},
					xAxis : [
						{
							type : 'category',
							//x轴
							data : ['T1','T2','T3','T4','S1','T5','T6','T7','T8','S2']
						}
					],
					yAxis : [
						{
							type : 'value',
							min : 0,
							max : 100
						}
					],
					
					series : [
						{
							name:'前测',
							type:'line',
							data:chineseBefData
						},
						{		//前测折线图
							name:'后测',
							type:'line',
							symbol:'none',							
							data:chineseAftData
						},
						{		//关于差距柱状图
							name:'前测2',
							type:'bar',
							stack: '1',
							barWidth: 6,
							itemStyle:{
								normal:{
									color:'rgba(0,0,0,0)'
								},
								emphasis:{
									color:'rgba(0,0,0,0)'
								}
							},
							//柱状图起始高度(前后测比较的小的值)
							data: chineseGradeHighData
						},
						{		//差距柱状图
							name:'变化',
							type:'bar',
							stack: '1',
							data: chineseGradeCutData
						}
					]
                };
        
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );


		// 数学   路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/line',
				'echarts/chart/bar'	// 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('mainmath')); 
                
                var option = {
                    title :{
						text : '数学',
						subtext : ''
					},
					tooltip : {
						trigger: 'axis',
						formatter: function (params){
							return params[0].name + ' : '
								   + (params[2].value - params[1].value > 0 ? '+' : '-') 
								   + params[0].value + '<br/>'
								   + params[2].seriesName + ' : ' + params[2].value + '<br/>'
								   + params[3].seriesName + ' : ' + params[3].value + '<br/>'
						}
					},
					toolbox: {
						show : true,
						feature : {
							magicType : {show: true, type: ['line', 'bar']},
							restore : {show: true}
						}
					},
					legend: {
						data:['前测', '后测'],
						selectedMode:false
					},
					xAxis : [
						{
							type : 'category',
							data : ['T1','T2','T3','T4','S1','T5','T6','T7','T8','S2']
						}
					],
					yAxis : [
						{
							type : 'value',
							min : 0,
							max : 100
						}
					],
					series : [
						{
							name:'前测',
							type:'line',
							data:mathBefData
						},
						{		//前测折线图
							name:'后测',
							type:'line',
							symbol:'none',
							data:mathAftData
						},
						{		//关于差距柱状图
							name:'前测2',
							type:'bar',
							stack: '1',
							barWidth: 6,
							itemStyle:{
								normal:{
									color:'rgba(0,0,0,0)'
								},
								emphasis:{
									color:'rgba(0,0,0,0)'
								}
							},
							//柱状图起始高度(前后测比较的小的值)
							data:mathGradeHighData
						},
						{		//差距柱状图
							name:'变化',
							type:'bar',
							stack: '1',
							data:mathGradeCutData
						}
					]
                };
        
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );

		// 英语   路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/line',
				'echarts/chart/bar'	// 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('mainenglish')); 
                
                var option = {
                    title :{
						text : '英语',
						subtext : ''
					},
					tooltip : {
						trigger: 'axis',
						formatter: function (params){
							return params[0].name + ' : '
								   + (params[2].value - params[1].value > 0 ? '+' : '-') 
								   + params[0].value + '<br/>'
								   + params[2].seriesName + ' : ' + params[2].value + '<br/>'
								   + params[3].seriesName + ' : ' + params[3].value + '<br/>'
						}
					},
					toolbox: {
						show : true,
						feature : {
							magicType : {show: true, type: ['line', 'bar']},
							restore : {show: true},
						}
					},
					legend: {
						data:['前测', '后测'],
						selectedMode:false
					},
					xAxis : [
						{
							type : 'category',
							data : ['T1','T2','T3','T4','S1','T5','T6','T7','T8','S2']
						}
					],
					yAxis : [
						{
							type : 'value',
							min : 0,
							max : 100
						}
					],
					series : [
						{
							name:'前测',
							type:'line',
							data:englishBefData
						},
						{		//前测折线图
							name:'后测',
							type:'line',
							symbol:'none',
							data:englishAftData
						},
						{		//关于差距柱状图
							name:'前测2',
							type:'bar',
							stack: '1',
							barWidth: 6,
							itemStyle:{
								normal:{
									color:'rgba(0,0,0,0)'
								},
								emphasis:{
									color:'rgba(0,0,0,0)'
								}
							},
							//柱状图起始高度(前后测比较的小的值)
							data:englishGradeHighData
						},
						{		//差距柱状图
							name:'变化',
							type:'bar',
							stack: '1',
							data:englishGradeCutData
						}
					]
                };
        
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );

		// 语文散点   路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/scatter'	// 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('prchinese')); 
                
                var option = {
                    title : {
        text: '语文',
        subtext: ''
    },
    tooltip : {
        trigger: 'axis',
        showDelay : 0,
        formatter : function (params) {
            if (params.value.length > 1) {
                return params.seriesName + ' :<br/>'
                   + params.value[0] + '分,PR: ' 
                   + params.value[1] + '% ';
            }
            else {
                return params.seriesName + ' :<br/>'
                   + params.name + ' : '
                   + params.value + '% ';
            }
        },  
        axisPointer:{
            show: true,
            type : 'cross',
            lineStyle: {
                type : 'dashed',
                width : 1
            }
        }
    },
    legend: {
        data:['成绩-PR']
    },
    toolbox: {
        show : true,
        feature : {
            //mark : {show: true},
            dataZoom : {show: true},
            //dataView : {show: true, readOnly: false},
            restore : {show: true},
            //saveAsImage : {show: true}
        }
    },
    xAxis : [
        {
            type : 'value',
            scale:true,
            axisLabel : {
                formatter: '{value} 分'
            }
        }
    ],
    yAxis : [
        {
            type : 'value',
            scale:true,
            axisLabel : {
                formatter: '{value} %'
            }
        }
    ],
 
    series : [
        {
            name:'成绩-PR',
            type:'scatter',
            data: chineseGradeAndPrData,
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name: '平均值'}
                ]
            }
        }        
    ]
                };
        
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );

		// 数学散点   路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/scatter'	// 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('prmath')); 
                
                var option = {
                    title : {
        text: '数学',
        subtext: ''
    },
    tooltip : {
        trigger: 'axis',
        showDelay : 0,
        formatter : function (params) {
            if (params.value.length > 1) {
                return params.seriesName + ' :<br/>'
                   + params.value[0] + '分,PR: ' 
                   + params.value[1] + '% ';
            }
            else {
                return params.seriesName + ' :<br/>'
                   + params.name + ' : '
                   + params.value + '% ';
            }
        },  
        axisPointer:{
            show: true,
            type : 'cross',
            lineStyle: {
                type : 'dashed',
                width : 1
            }
        }
    },
    legend: {
        data:['成绩-PR']
    },
    toolbox: {
        show : true,
        feature : {
            //mark : {show: true},
            dataZoom : {show: true},
            //dataView : {show: true, readOnly: false},
            restore : {show: true},
            //saveAsImage : {show: true}
        }
    },
    xAxis : [
        {
            type : 'value',
            scale:true,
            axisLabel : {
                formatter: '{value} 分'
            }
        }
    ],
    yAxis : [
        {
            type : 'value',
            scale:true,
            axisLabel : {
                formatter: '{value} %'
            }
        }
    ],
    series : [
        {
            name:'成绩-PR',
            type:'scatter',
            data: mathGradeAndPrData,
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name: '平均值'}
                ]
            }
        }        
    ]
                };
        
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );

		// 英语散点   路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/scatter'	// 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('prenglish')); 
                
                var option = {
                    title : {
        text: '英语',
        subtext: ''
    },
    tooltip : {
        trigger: 'axis',
        showDelay : 0,
        formatter : function (params) {
            if (params.value.length > 1) {
                return params.seriesName + ' :<br/>'
                   + params.value[0] + '分,PR: ' 
                   + params.value[1] + '% ';
            }
            else {
                return params.seriesName + ' :<br/>'
                   + params.name + ' : '
                   + params.value + '% ';
            }
        },  
        axisPointer:{
            show: true,
            type : 'cross',
            lineStyle: {
                type : 'dashed',
                width : 1
            }
        }
    },
    legend: {
        data:['成绩-PR']
    },
    toolbox: {
        show : true,
        feature : {
            //mark : {show: true},
            dataZoom : {show: true},
            //dataView : {show: true, readOnly: false},
            restore : {show: true},
            //saveAsImage : {show: true}
        }
    },
    xAxis : [
        {
            type : 'value',
            scale:true,
            axisLabel : {
                formatter: '{value} 分'
            }
        }
    ],
    yAxis : [
        {
            type : 'value',
            scale:true,
            axisLabel : {
                formatter: '{value} %'
            }
        }
    ],
    series : [
        {
            name:'成绩-PR',
            type:'scatter',
            data: mathGradeAndPrData,
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name: '平均值'}
                ]
            }
        }        
    ]
                };
        
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );

	
	//为语文前后侧图赋值
	chineseBefData = [];// 设置语文前测为空
	chineseAftData = [];// 设置语文后测为空
	chineseGradeCutData = [];// 设置语文前后测相差数据为空
	chineseGradeHighData = [];// 设置语文前后测相差数据起点为空
	
	<c:forEach items="${chineseGradeBefList}" var="chineseGradeBef">
	 	<c:choose>
			<c:when test="${chineseGradeBef.score eq 0}">chineseBefData.push("");</c:when>
			<c:otherwise>chineseBefData.push(${chineseGradeBef.score});</c:otherwise>
		</c:choose> 
	</c:forEach>

	<c:forEach items="${chineseGradeAftList}" var="chineseGradeAft">
		<c:choose>
			<c:when test="${chineseGradeAft.score eq 0}">chineseAftData.push("");</c:when>
			<c:otherwise>chineseAftData.push(${chineseGradeAft.score});</c:otherwise>
		</c:choose> 
	</c:forEach>
	
	<c:forEach items="${chineseGradeCutList}" var="chineseGradeCut">
		<c:choose>
			<c:when test="${chineseGradeCut.score eq 0}">chineseGradeCutData.push("");</c:when>
			<c:otherwise>chineseGradeCutData.push(${chineseGradeCut.score});</c:otherwise>
		</c:choose> 
	</c:forEach>
	
	<c:forEach items="${chineseGradeHighList}" var="chineseGradeHigh">
		<c:choose>
			<c:when test="${chineseGradeHigh.score eq 0}">chineseGradeHighData.push("");</c:when>
			<c:otherwise>chineseGradeHighData.push(${chineseGradeHigh.score});</c:otherwise>
		</c:choose> 
	</c:forEach>
	
	chineseGradeAndPrData = [];
	<c:forEach items="${chineseGradeAndPrList}" var="chineseGradeAndPr">
		var tempData = [];
		tempData.push(${chineseGradeAndPr.score});
		tempData.push(${chineseGradeAndPr.pr});
		chineseGradeAndPrData.push(tempData);
	</c:forEach>
	
	//为数学前后侧图赋值
	mathBefData = [];// 设置数学前测为空
	mathAftData = [];// 设置数学后测为空
	mathGradeCutData = [];// 设置数学前后测相差数据为空
	mathGradeHighData = [];// 设置数学前后测相差数据起点为空
	
	<c:forEach items="${mathGradeBefList}" var="mathGradeBef">
	 	<c:choose>
			<c:when test="${mathGradeBef.score eq 0}">mathBefData.push("");</c:when>
			<c:otherwise>mathBefData.push(${mathGradeBef.score});</c:otherwise>
		</c:choose> 
	</c:forEach>

	<c:forEach items="${mathGradeAftList}" var="mathGradeAft">
		<c:choose>
			<c:when test="${mathGradeAft.score eq 0}">mathAftData.push("");</c:when>
			<c:otherwise>mathAftData.push(${mathGradeAft.score});</c:otherwise>
		</c:choose> 
	</c:forEach>
	
	<c:forEach items="${mathGradeCutList}" var="mathGradeCut">
		<c:choose>
			<c:when test="${mathGradeCut.score eq 0}">mathGradeCutData.push("");</c:when>
			<c:otherwise>mathGradeCutData.push(${mathGradeCut.score});</c:otherwise>
		</c:choose> 
	</c:forEach>
	
	<c:forEach items="${mathGradeHighList}" var="mathGradeHigh">
		<c:choose>
			<c:when test="${mathGradeHigh.score eq 0}">mathGradeHighData.push("");</c:when>
			<c:otherwise>mathGradeHighData.push(${mathGradeHigh.score});</c:otherwise>
		</c:choose> 
	</c:forEach>
	
	mathGradeAndPrData = [];
	<c:forEach items="${mathGradeAndPrList}" var="mathGradeAndPr">
		var tempData = [];
		tempData.push(${mathGradeAndPr.score});
		tempData.push(${mathGradeAndPr.pr});
		mathGradeAndPrData.push(tempData);
	</c:forEach>
	
	//为英文前后侧图赋值
	englishBefData = [];// 设置英文前测为空
	englishAftData = [];// 设置英文后测为空
	englishGradeCutData = [];// 设置英文前后测相差数据为空
	englishGradeHighData = [];// 设置英文前后测相差数据起点为空
	
	<c:forEach items="${englishGradeBefList}" var="englishGradeBef">
	 	<c:choose>
			<c:when test="${englishGradeBef.score eq 0}">englishBefData.push("");</c:when>
			<c:otherwise>englishBefData.push(${englishGradeBef.score});</c:otherwise>
		</c:choose> 
	</c:forEach>

	<c:forEach items="${englishGradeAftList}" var="englishGradeAft">
		<c:choose>
			<c:when test="${englishGradeAft.score eq 0}">englishAftData.push("");</c:when>
			<c:otherwise>englishAftData.push(${englishGradeAft.score});</c:otherwise>
		</c:choose> 
	</c:forEach>
	
	<c:forEach items="${englishGradeCutList}" var="englishGradeCut">
		<c:choose>
			<c:when test="${englishGradeCut.score eq 0}">englishGradeCutData.push("");</c:when>
			<c:otherwise>englishGradeCutData.push(${englishGradeCut.score});</c:otherwise>
		</c:choose> 
	</c:forEach>
	
	<c:forEach items="${englishGradeHighList}" var="englishGradeHigh">
		<c:choose>
			<c:when test="${englishGradeHigh.score eq 0}">englishGradeHighData.push("");</c:when>
			<c:otherwise>englishGradeHighData.push(${englishGradeHigh.score});</c:otherwise>
		</c:choose> 
	</c:forEach>
	
	englishGradeAndPrData = [];
	<c:forEach items="${englishGradeAndPrList}" var="englishGradeAndPr">
		var tempData = [];
		tempData.push(${englishGradeAndPr.score});
		tempData.push(${englishGradeAndPr.pr});
		englishGradeAndPrData.push(tempData);
	</c:forEach>
	
    </script>
    
    
    <script>
	//下拉选择框
	$(document).ready(function(){		
		$("#stu-select").selectWidget({
			change       : function (changes) {
				var stu = $("#stu-select").val();
				location.href = "<c:url value='/TeacherGrowServlet?method=loadGradeInfo&stu='/>"+stu;
			},
			effect       : "slide",
			keyControl   : true,
			speed        : 200,
			scrollHeight : 250
		});
		
		$("#grade-select").selectWidget({
			change       : function (changes) {
				var stu = "${selectedStu}";
				var grade = $("#grade-select").val();
				location.href = "<c:url value='/TeacherGrowServlet?method=loadGradeInfo&stu='/>" + stu + "&grade=" + grade; 
			},
			effect       : "slide",
			keyControl   : true,
			speed        : 200,
			scrollHeight : 250
		});
		
	});
    </script>

	<!-- Bootstrap Core JavaScript -->
	<script src="<c:url value='/index/bower_components/bootstrap/dist/js/bootstrap.min.js'/>"></script>
	<!-- Metis Menu Plugin JavaScript -->
	<script src="<c:url value='/index/bower_components/metisMenu/dist/metisMenu.min.js'/>"></script>
	<!-- Morris Charts JavaScript -->
	<script src="<c:url value='/index/bower_components/raphael/raphael-min.js'/>"></script>
	<script src="<c:url value='/index/bower_components/morrisjs/morris.min.js'/>"></script>
	<!-- Custom Theme JavaScript -->
	<script src="<c:url value='/index/dist/js/sb-admin-2.js'/>"></script>
</body>
</html>