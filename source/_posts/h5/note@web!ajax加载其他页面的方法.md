---
title: web前端 ajax加载其他页面方法
---
html异步加载静态页面

1.jquery方法 

	#load方法：
	定义一个函数  等待调用
	<script>
		function jump() {
					var s=$("#mainBody").load("tempDemo.html", function(data) { $("#mainBody").show(100); $("#mainBody").html(data);});
		}
	</script>
	其中参数tempDemo.html是需要加载的文件
	#mainBody是接收的div显示的层
	show方法可要可不要
	#ajax方法
	function jump() {
				$.ajax({
					url: 'tempDemo.html',
					type: 'get',
					dataType: 'html',
					data: parames,
					error: function() { alert('error'); },
					success: function(data) {
						$("#mainBody").html(data);
					}
				});
	}
	同样的参数  不在赘述

	
	其他方法暂时没有!!

	