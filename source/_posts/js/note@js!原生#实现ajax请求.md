# 自己简单定义js的xmlhttprequest
```js
var ajax = function(url,fn,param,method,file){
 		var xhr=new XMLHttpRequest();
 		if(typeof XDomainRequest != 'undefined') {
            xhr = new XDomainRequest();
        } 
 		if('withCredentials' in xhr) {
		xhr.open(method?method:'GET',url,true);
 		}
		//xhr.overrideMimeType("text/plain; charset=x-user-defined");  //接收二进制数据
	　        xhr.onreadystatechange = function(){
	　　　　if ( xhr.readyState == 4 && xhr.status == 200 ) {
	　　　　　　fn(xhr.responseText?xhr.responseText:xhr.responseXML?xhr.responseXML:'');  //responseXML
			if(xhr.responseType === 'blob'){
				var binStr = xhr.responseText;
				for (var i = 0, len = binStr.length; i < len; ++i) {
				　　　　var c = binStr.charCodeAt(i);
				　　　　var byte = c & 0xff;
				} 
				fn(binStr);
			}
	　　　　}
		}
	　       	var formData = new FormData();
	　       	if(param){
	　       		if(typeof param === 'string'){
		　       		var arr = param.split('&');
		　       		for(i in arr){
		　       			var o = arr[i].split('=');
		　       			formData.append(o[0],o[1]);
		　       		}
		　       	}
		　       	if(typeof param === 'object'){
		　       		for(k in param){
		　       			console.log('is obj');
		　       			formData.append(k,param[k]);
		　       		}
		　       	}
	　       	}
	　       	if(file){
		　       	　for (var i = 0; i < files.length;i++) {
		　   		　　　　formData.append('files[]', files[i]);
		　 		}
	　       	}
	　       	xhr.send(formData);	
	　         xhr.onprogress = function (event) {
	　		　　　　if (event.lengthComputable) {
			　　　　　　var percentComplete = event.loaded / event.total;
			　　　　}
				 if(event.load){
					 console.log('------load----');
					//todo  传输成功完成
				 }
				 if(event.abort){
					 console.log('------abort----');
					// todo 传输被用户取消
				 }
				 if(event.error){
					 console.log('------error----');
					//todo 传输中出现错误
				 }
				 if(event.loadstart){
					 console.log('------loadstart----');
					//todo 传输开始。
				 }
				 if(event.loadEnd){
					 console.log('------loadEnd----');
					//todo 传输结束，但是不知道成功还是失败。
				 }
		}; 
	　    }
 	var s= ajax('http://127.0.0.1:8080/wb3d/data/getDoorAlarm?ywid=D9f6162861fccd6b5aef830e3ce3f2d99',
 	console.log(data));
```