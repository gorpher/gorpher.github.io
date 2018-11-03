
// js 变量提升问题 ,es6 则不存在这种问题了
```js
fn = !(function(){
	
	console.log(arguments);  //得到默认参数
	
	
	console.log('a:'+a);  // 1. 打印的是 默认函数申明表达方式 function  a
	
	var  a = '变量  a';  //声明变量a
	
	function a(){
		//申明方式放在后面 却通过 hoist 机制提前了 从而导致 第一个console.log 打印出来值
		return '------------默认函数申明方式  申明a---------------';
	}
	
	console.log('a:'+a);  // 这里的a是变量 var a
	
	var a = function(){
		// 申明其实提前了 ,最后执行的时候将函数赋值给变量
		return '------------函数表达式方式       申明a---------------';
	}
	
	console.log('a:'+a);
	
	
	//console.log(this);  //得到this对象
	
	return a ;
})('arg1','arg2','arg3');
```
//正常的js执行上下文 (建立阶段((变量,函数,arguments对象,参数)(建立作用域链)(确定this的值))执行阶段(变量赋值,函数引用,执行其它代码))
//所以使用默认的申明函数方式 可能会打破js执行上下文的方式,所以千万注意不能使用function fn(){} 这种方式定义函数
