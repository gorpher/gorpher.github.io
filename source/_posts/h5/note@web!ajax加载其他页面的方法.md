---
title: web前端 ajax加载其他页面方法
date: {{date}}
categories: note
tags: 
- h5
- js
- ajax
---
html异步加载静态页面

1. jquery方法 

#load方法：
定义一个函数  等待调用
```html
	<script>
		function jump() {
					var s=$("#mainBody").load("tempDemo.html", function(data) { $("#mainBody").show(100); $("#mainBody").html(data);});
		}
	</script>
```
其中参数tempDemo.html是需要加载的文件
**#mainBody**是接收的div显示的层
show方法可要可不要
#ajax方法
```js
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
```

	