# 给函数concat函数
```js


function addEvent(fn){
	var oldFun = window.onload;
	if(oldFun){
		window.onload = function(){
			oldFun();
			fn();
		}
	}else{
		window.onload = fn;
	}
}
var fn1 = function(){
	console.log(1);
}
var fn2 = function(){
	console.log(2);
}
var fn3 = function(){
	console.log(3)
}
addEvent(fn1);
addEvent(fn2);
addEvent(fn3);
// 加强版本
var fn_concat = function(fn1,fn2){
	if(fn1){
		return function(){
			fn1();
			fn2();
		}
	}
	return fn2;
}
var fn4 = fn_concat(fn1,fn_concat(fn2,fn3));
// 链式调用版本 有错误的代码
var _blank = function(){
}
//看似完美的代码,发现 这个只能传递一个参数 永远做不到链式调用 
var chain=function(fn){
	if(fn){
		return function(){
			_blank();  
			fn();
		}
	}
	return _blank;
}
```