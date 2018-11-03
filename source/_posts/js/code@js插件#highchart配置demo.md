<!DOCTYPE html>
<html>
	<head>
		<script src="js/jquery-2.2.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/highcharts/highcharts.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/highcharts/modules/exporting.js" type="text/javascript" charset="utf-8"></script>
		<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="css/bootstrap-theme.css" />
		<style type="text/css">
			#temp_container {
				position: absolute;
			/*	display: none;*/
				z-index: 10;
				top: 50px;
				left: 300px;
			}
			
			#container {
				hight: 600px;
				width: 750px;
				right: 0px;
				top: 0px;
				position: relative;
			}
		</style>
	</head>

	<body>

		<script>
			var chart;
			$(document).ready(function() {
				chart = new Highcharts.Chart({
					chart: {
						events: {
							load: function() {
								// set up the updating of the chart each second  相当于每秒做数据
								var series0 = this.series[0];
								var series1 = this.series[1];
								var series2 = this.series[2];
								setInterval(function() {
									var x = (new Date()).getTime(), // current time
										y = Math.random() * 10 + 10;
									series0.addPoint([x, y], true, true);
									series1.addPoint([x, Math.random() * 10 + 10], true, true);
									series2.addPoint([x, Math.random() * 10 + 10], true, true);
								}, 1000);
							}
						},
						renderTo: 'container',
						defaultSeriesType: 'spline', //图表类别，可取值有：line、spline、area、areaspline、bar、column等 
						marginRight: 20,
						marginBottom: 25,
						backgroundColor: '#c3fcb4',
						plotBackgroundColor: '#ffffff',
						borderRadius: 15  //圆角边框属性
					},
					title: {
						text: '温度湿度显示器', //设置一级标题 
						x: -20 //center 
					},
					subtitle: {
						text: '根据小时显示数据', //设置二级标题 
						x: -20
					},
					xAxis: {
						type: 'datetime',
						tickPixelInterval: 150
						//设置x轴的标题 
					},
					yAxis: {
						title: {
							text: 'Temperature (?°C)' //设置y轴的标题 
						},
						plotLines: [{
							value: 0,
							width: 1,
							color: '#808080'
						}]
					},
					tooltip: {
						formatter: function() {
							return '<b>' + this.series.name + '</b><br/>' +
								this.x + ': ' + this.y + '?°C'; //鼠标放在数据点的显示信息，但是当设置显示了每个节点的数据项的值时就不会再有这个显示信息 
						}
					},
					legend: {
						layout: 'vertical',
						align: 'right', //设置说明文字的文字 left/right/top/ 
						verticalAlign: 'top',
						x: -10,
						y: 100,
						borderWidth: 0
					},
					exporting: {
						enabled: false, //用来设置是否显示‘打印’,'导出'等功能按钮，不设置时默认为显示 
						url: "" //导出图片的URL，默认导出是需要连到官方网站去的哦 
					},
					credits: {
						enabled: false
					},
					plotOptions: {
						line: {
							dataLabels: {
								enabled: true //显示每条曲线每个节点的数据项的值 
							},
							enableMouseTracking: false
						}
					},
					series: [{
						name: '3#炸药库', //每条线的名称 
						data: (function() {
							// generate an array of random data 初始化 将数据做到x轴上 
							var data = [],
								time = (new Date()).getTime(),
								i;
							for(i = -19; i <= 0; i += 1) {
								data.push({
									x: time + i * 1000,
									y: Math.random() * 10 + 10
								});
							}
							return data;
						}()), //每条线的数据 
						visible: true
					}]
				});

			});
		</script>
		<div id="temp_container">
			<div class="btn-group" style=" float:right;   position: inherit;  " id="closeTemp">
				<button type="button" class="btn btn-success  btn-sm  " style="float:right;">x</button>
				<div>
					<!--5.导入容器用于显示图表-->
					<div id="container">
					</div>
				</div>
	</body>

</html>
