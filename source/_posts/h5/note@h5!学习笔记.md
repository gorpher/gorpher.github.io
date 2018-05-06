---
title: h5学习笔记
date: {{date}}
categories: note
tags: 
- h5
---
##web视频
	1.Ogg = 带有 Theora 视频编码和 Vorbis 音频编码的 Ogg 文件
	2.MPEG4 = 带有 H.264 视频编码和 AAC 音频编码的 MPEG 4 文件
	3.WebM = 带有 VP8 视频编码和 Vorbis 音频编码的 WebM 文件
###添加视频标签
	```
	<video width="320" height="240" controls="controls">
		  <source src="movie.ogg" type="video/ogg">
		  <source src="movie.mp4" type="video/mp4">
		Your browser does not support the video tag.
	</video>
	
	```
	
###视频属性
	autoplay	autoplay	如果出现该属性，则视频在就绪后马上播放。
	controls	controls	如果出现该属性，则向用户显示控件，比如播放按钮。
	height	pixels	设置视频播放器的高度。
	loop	loop	如果出现该属性，则当媒介文件完成播放后再次开始播放。
	preload	preload			如果出现该属性，则视频在页面加载时进行加载，并预备播放。
							如果使用 "autoplay"，则忽略该属性。
	src	url	要播放的视频的 URL。
	width	pixels	设置视频播放器的宽度。
###video方法属性
	方法	属性	事件
	play()	currentSrc	play
	pause()	currentTime	pause
	load()	videoWidth	progress
	canPlayType	videoHeight	error
		duration	timeupdate
		ended	ended
		error	abort
		paused	empty
		muted	emptied
		seeking	waiting
		volume	loadedmetadata
		height	 
		width
		
##web音频
	###实例
	```
	<audio controls="controls">
	  <source src="song.ogg" type="audio/ogg">
	  <source src="song.mp3" type="audio/mpeg">
		Your browser does not support the audio tag.
	</audio>
	```
	
##audio 标签属性
		属性	值	描述
		autoplay	autoplay	如果出现该属性，则音频在就绪后马上播放。
		controls	controls	如果出现该属性，则向用户显示控件，比如播放按钮。
		loop	loop	如果出现该属性，则每当音频结束时重新开始播放。
		preload	preload	
		如果出现该属性，则音频在页面加载时进行加载，并预备播放。
		如果使用 "autoplay"，则忽略该属性。
		src	url	要播放的音频的 URL。
		###实例
		```
			<!DOCTYPE HTML>
			<html>
			<head>
			<script type="text/javascript">
			function allowDrop(ev)
			{
			ev.preventDefault();  //来避免浏览器对数据的默认处理（drop 事件的默认行为是以链接形式打开）
			}

			function drag(ev)  //
			{
			ev.dataTransfer.setData("Text",ev.target.id);   //设置拖拽的数据
			}

			function drop(ev)  //当放置被拖数据时，会发生 drop 事件。
			{
			调用 preventDefault() {
			ev.preventDefault();  // //来避免浏览器对数据的默认处理（drop 事件的默认行为是以链接形式打开）
			var data=ev.dataTransfer.getData("Text");  //方法获得被拖的数据。该方法将返回在 setData() 方法中设置为相同类型的任何数据。
			ev.target.appendChild(document.getElementById(data)); //把被拖元素追加到放置元素（目标元素）中
			}
			</script>
			</head>
			<body>

			<div id="div1" ondrop="drop(event)"   <!-- 进行放置 - ondrop 当放置被拖数据时，会发生 drop 事件。-->
			ondragover="allowDrop(event)"></div> <!-- 目标div块  放到何处 - ondragover-->
			<img id="drag1" src="img_logo.gif" draggable="true"   <!-- 设置元素为可拖放-->
			ondragstart="drag(event)" width="336" height="69" /><!--  拖动什么 - ondragstart 和 setData()-->
			</body>
			</html>
		```
##canvas 画布
			##实例 --渐变
			```
					
				<canvas id="myCanvas" width="200" height="100" style="border:1px solid #c3c3c3;">
				Your browser does not support the canvas element.
				</canvas>
				<script type="text/javascript">
						//画线
						var c=document.getElementById("myCanvas");
						var cxt=c.getContext("2d");
						cxt.moveTo(10,10);  //第一个点
						cxt.lineTo(150,50);  //第二个点
						cxt.lineTo(10,50);  //第三个点
						cxt.stroke();   //结束
						//画圆
						/*
						var c=document.getElementById("myCanvas");
						var cxt=c.getContext("2d");
						cxt.fillStyle="#FF0000";  //颜色
						cxt.beginPath();    //开始
						cxt.arc(70,18,15,0,Math.PI*2,true);   
						cxt.closePath();   //结束
						cxt.fill();   //画
						*/
						//画渐变
						/*
						var c=document.getElementById("myCanvas");
						var cxt=c.getContext("2d");
						var grd=cxt.createLinearGradient(0,0,175,50);
						grd.addColorStop(0,"#FF0000");
						grd.addColorStop(1,"#00FF00");
						cxt.fillStyle=grd;
						cxt.fillRect(0,0,175,50);
						*/
						//将图片放到画布上
						/*
						var c=document.getElementById("myCanvas");
						var cxt=c.getContext("2d");
						var img=new Image()
						//img.src="flower.png"
						cxt.drawImage(img,0,0);
						*/
						
				</script>
			```
			
			
##内联svg
		###概况
			SVG 指可伸缩矢量图形 (Scalable Vector Graphics)
		### 实例
			```
			<svg xmlns="http://www.w3.org/2000/svg" version="1.1" height="190">
			  <polygon points="100,10 40,180 190,60 10,60 160,180"
			  style="fill:lime;stroke:purple;stroke-width:5;fill-rule:evenodd;" />
			</svg>
			
			```
			详细请看svg教程
##使用地理位置
		###实例
		<p id="demo">点击这个按钮，获得您的坐标：</p>
				<div id="mapholder"></div>
				<button onclick="getLocation()">试一下</button>
				<script>
					var x=document.getElementById("demo");
					function getLocation()
					  {
					  if (navigator.geolocation)
						{
						/* 如果getCurrentPosition()运行成功，则向参数showPosition中规定的函数返回一个coordinates对象*/
						navigator.geolocation.getCurrentPosition(showPosition);  //返回数据 
						//navigator.geolocation.watchPosition(showPosition);  // 返回用户的当前位置，并继续返回用户移动时的更新位置（就像汽车上的 GPS）。
						//....clearWatch() - 停止 watchPosition() 方法
						}
					  else{x.innerHTML="Geolocation is not supported by this browser.";}
					  }
					function showPosition(position)
					  {
					  x.innerHTML="Latitude: " + position.coords.latitude +
					  "<br />Longitude: " + position.coords.longitude;
					  
					  //在google地图上显示位置
					  var latlon=position.coords.latitude+","+position.coords.longitude;
					  var img_url="http://maps.googleapis.com/maps/api/staticmap?center="
					  +latlon+"&zoom=14&size=400x300&sensor=false";  //google地图变成图片api 需要翻墙才能使用
					  console.log(img_url);
					  document.getElementById("mapholder").innerHTML="<img src='"+img_url+"' />";
					  }
					function showError(error)
					  {
					  switch(error.code) 
						{
						case error.PERMISSION_DENIED:  //Permission denied - 用户不允许地理定位
						  x.innerHTML="User denied the request for Geolocation."
						  break;
						case error.POSITION_UNAVAILABLE:  //Position unavailable - 无法获取当前位置
						  x.innerHTML="Location information is unavailable."
						  break;
						case error.TIMEOUT:  //Timeout - 操作超时
						  x.innerHTML="The request to get user location timed out."
						  break;
						case error.UNKNOWN_ERROR:
						  x.innerHTML="An unknown error occurred."
						  break;
						}
					  }
				</script>
		
		### getCurrentPosition() 方法 - 返回数据

		属性				描述
		coords.latitude	十进制数的纬度
		coords.longitude	十进制数的经度
		coords.accuracy	 位置精度
		coords.altitude	 海拔，海平面以上以米计
		coords.altitudeAccuracy	位置的海拔精度
		coords.heading	方向，从正北开始以度计
		coords.speed	速度，以米/每秒计
		timestamp	响应的日期/时间
			
##web存储
		###类别
			localStorage - 没有时间限制的数据存储
			sessionStorage - 针对一个 session 的数据
		####实例
				//localStorage的使用
				```
				<script type="text/javascript"> 	
				if (localStorage.pagecount)   //存储访问网站的次数
				  {
				  localStorage.pagecount=Number(localStorage.pagecount) +1;
				  }
				else
				  {
				  localStorage.pagecount=1;
				  }
				document.write("Visits "+ localStorage.pagecount + " time(s).");
				</script>
				```
				//sessionStorage的使用  在当前 session 中访问页面的次数进行计数
				```
				<script type="text/javascript">
				if (sessionStorage.pagecount)
				  {
				  sessionStorage.pagecount=Number(sessionStorage.pagecount) +1;
				  }
				else
				  {
				  sessionStorage.pagecount=1;
				  }
				document.write("Visits "+sessionStorage.pagecount+" time(s) this session.");
				</script>
				```
##Application Cache	应用缓存
				##要点
				1.html文件中标签  必须包含manifest属性
					```
					<!DOCTYPE HTML>
					<html manifest="demo.appcache">
					...
					</html>
					```
				2.还需要像demo.appcache的 manifest 文件 并且文件分三部分  CACHE MANIFEST NETWORK FALLBAK  如下：
					```
					CACHE MANIFEST   //这个是必须的  并且一下三个文件会被离线下载
					# 2012-02-21 v1.0.0   
					/theme.css
					/logo.gif
					/main.js

					NETWORK:			 //永远不会被缓存
					login.asp

					FALLBACK:			//无法建立因特网连接 用404.html  代替/html5/目录下的所有文件
					/html5/ /404.html
					```
##Web Worker  即后台运行的javascript
				###实例
				```
				<!DOCTYPE html>
				<html>
				<body>
				<p>Count numbers: <output id="result"></output></p>
				<button onclick="startWorker()">Start Worker</button> 
				<button onclick="stopWorker()">Stop Worker</button>
				<br /><br />
				<script>
				var w;
				function startWorker()
				{
				if(typeof(Worker)!=="undefined")  //判断浏览器是否支持web worker
				{
				  if(typeof(w)=="undefined")
					{
					w=new Worker("demo_workers.js");   //创建 Web Worker 对象   运行demo_workers.js文件 
					}
				  w.onmessage = function (event) {			//向 web worker 添加一个 "onmessage" 事件监听器
					document.getElementById("result").innerHTML=event.data;  //当 web worker 传递消息时，会执行事件监听器中的代码。
				  };					//event.data 中存有来自 event.data 的数据。
				}
				else
				{
				document.getElementById("result").innerHTML="Sorry, your browser
				 does not support Web Workers...";
				}
				}

				function stopWorker()
				{
				w.terminate(); //终止 web worker，并释放浏览器/计算机资源，使用 terminate() 方法
				}
				</script>
				</body>
				</html>
				```
				###由于 web worker 位于外部文件中，它们无法访问下例 JavaScript 对象：window 对象 document 对象 parent 对象
				
##Server-Sent  向服务器发送事件 ---单向消息传递
				###接收 Server-Sent 事件通知
				```
				var source=new EventSource("demo_sse.php");   //EventSource用于接收服务器发来的通知
				source.onmessage=function(event)
				  {
				  document.getElementById("result").innerHTML+=event.data + "<br />";
				  };
				```
				###服务器端 代码实例
				  ###PHP 代码 (demo_sse.php)：
						```
						<?php
						header('Content-Type: text/event-stream');
						header('Cache-Control: no-cache');

						$time = date('r');
						echo "data: The server time is: {$time}\n\n";
						flush();
						?>
						```
				###注解："Content-Type" 报头设置为 "text/event-stream"  这个是最主要的向客户端发送事件流
	
	
##表单
				##输入类型
					email  
					url
					number
					range			//range 类型用于应该包含一定范围内数字值的输入域。range 类型显示为滑动条。
					Date pickers (date, month, week, time, datetime, datetime-local)
					search   类型用于搜索域，比如站点搜索或 Google 搜索。search 域显示为常规的文本域。
					color 
				##表单元素
					datalist		//元素规定输入域的选项列表。 列表是通过 datalist 内的 option 元素创建的
					keygen			//提供一种验证用户的可靠方法
					output			//元素用于不同类型的输出
					####datalist
						```
						Webpage: <input type="url" list="url_list" name="link" />
						<datalist id="url_list">
						<option label="W3School" value="http://www.W3School.com.cn" />
						<option label="Google" value="http://www.google.com" />
						<option label="Microsoft" value="http://www.microsoft.com" />
						</datalist>
						```
					####keygen
						```
						<form action="demo_form.asp" method="get">
						Username: <input type="text" name="usr_name" />
						Encryption: <keygen name="security" />
						<input type="submit" />
						</form>
						```
				##表单属性
					#####from属性
						autocomplete
						novalidate
					#####input属性
						autocomplete
						autofocus  //自动获取焦点
						form
						form overrides (formaction, formenctype, formmethod, formnovalidate, formtarget)
						height 和 width
						list
						min, max 和 step
						multiple			//属性规定输入域中可选择多个值。
						pattern (regexp)   //模式（pattern） 是正则表达式
						placeholder 			//属性提供一种提示（hint），描述输入域所期待的值
						required
					###实例
						```
						<form action="demo_form.asp" method="get" autocomplete="on">
						First name: <input type="text" name="fname"   autofocus="autofocus"  /><br />
						Last name: <input type="text" name="lname" /><br />
						E-mail: <input type="email" name="email" autocomplete="off" /><br />
						<input type="submit" formaction="demo_admin.asp" value="Submit as admin" /><!--formaction - 重写表单的 action 属性-->
						<input type="submit" />
						</form>
						
						```
						formaction - 重写表单的 action 属性					
						formenctype - 重写表单的 enctype 属性
						formmethod - 重写表单的 method 属性
						formnovalidate - 重写表单的 novalidate 属性
						formtarget - 重写表单的 target 属性
						
								#####pattern实例
								```
								Country code: <input type="text" name="country_code" pattern="[A-z]{3}" title="Three letter country code" />
								
								```
								
								
