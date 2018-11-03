
定义数字 0，1，2，3，4，5
var zero = function(f){
	return function(x){
		return x;
	}
}
var one = function(f){
	return  function(x){
		return f(x);
	}
}
function add(n,m){  //定义加法
		return function(f){
		return function(x){
			return m(f)(n(f)(x));
		}
	}
}
var three = add(one,two);
var four = add(two,two);
var five = add(three,two);
(three(function(){console.log('print 3 times')}))();  //打印三次

(five(function(){console.log('print 5 times')}))();  //打印五次

function mult(n,m){  //定义乘法
	return function(){
		return function(){
				return m((n)(f))(x);
		}
	}
}
function power(){ //定义乘方  ，乘法运行m次
		return function(f){
			return function(x){
				return (n)(m)(f)(x);
			}
		}
}