note@ js ！跨域请求异步请求

# jquery 异步请求
```
	<script>
		function flightHandler(str){
					console.log(str);
				}
				jQuery(document).ready(function(){
					$.ajax({
						type: "get",
						async: true,
						crossDomain: true,
						url: "http://127.0.0.1:8080/servlet/proxy.jsp?url=http://61.183.83.186:8101/a/warehouse/getDianziXungengData?shebeiId=8001001124",
						dataType: "json",
						complete: function(){
							console.log("请求完成！");
						},
						success: function(data){
							console.log(data);
							
						},
						error: function(){
							console.log("请求错误");
						}
					});
				});
				
	</script>
```
#  jquery获取json
```
	<script type="text/javascript">
				$(function(){
				alert("有来过");
				$.getJSON("http://127.0.0.1:8080/servlet/proxy.jsp?url=http://61.183.83.186:8101/a/warehouse/getDianziXungengData?shebeiId=8001001124",
			      function(json){
			    		console.log(json);
			        });
					
				});
				
	</script>
```

# js xmlhttp原生请求
```
	<script type="text/javascript">
			var thr;
			function getanswer() {
				try { 
					//alert(thr.responseText); 
					console.log(thr.responseText);
				} catch(e) {
					
					alert("getanswer error:" + e.message);
				}
			}

			function testone() {
				try {
					thr = createXMLRequestObj();
					var url = "http://127.0.0.1:8080/servlet/proxy.jsp?url=http://61.183.83.186:8101/a/warehouse/getDianziXungengData?shebeiId=8001001124";
					var param = "name=wang";
					//alert("first readystate:"+thr.readyState+" status:");
					thr.open("GET", url, true);
					thr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
					//上面这句不可少啊！！！！！！！！！！！！！！！ 
					thr.onreadystatechange = getanswer;
					if(thr == null) { alert("not create sucess"); return; }
					thr.send(null);
				} catch(e) { alert("error" + e.message); }
			}

			function createXMLRequestObj() {
				var xmlReqObj = null;
				if(xmlReqObj == null) {
					try {
						xmlReqObj = new XMLHttpRequest();
					} //非IE 
					catch(e) { xmlReqObj = null; }
				}
				if(xmlReqObj == null) {
					try { xmlReqObj = new ActiveXObject("Msxml2.XMLHTTP"); } catch(e) { xmlReqObj = null; }
				}
				if(xmlReqObj == null) {
					try { xmlReqObj = new ActiveXObject("Microsoft.XMLHTTP"); } catch(e) { xmlReqObj = null; }
				}
				return xmlReqObj;
			}
			testone();
		</script>
```