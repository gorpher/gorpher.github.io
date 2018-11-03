note@js编程学习复习！总结

# 基本语法

## 数据类型

1. number  基本上分为这6种
```js
123; 	// 整数123

0.456;	 // 浮点数0.456

1.2345e3;	 // 科学计数法表示1.2345x1000，等同于1234.5

-99; 	// 负数

NaN; 	// NaN表示Not a Number，当无法计算结果时用NaN表示

Infinity;	 // Infinity表示无限大，当数值超过了JavaScript的Number所能表示的最大值时，就表示为Infinity

```

1. number	**算术运算跟数学上的一致**  ***注意%是求余运算。***
2. 字符串  **字符串是以单引号'或双引号"括起来的任意文本**
3. 布尔值 **布尔值和布尔代数的表示完全一致，一个布尔值只有true、false两种值，要么是true**  *** 或 与 非 比较***
4. null和undefined    ***null 就是空   不是0 和‘’ ***  ***undefined仅仅在判断函数参数是否传递的情况下有用***
5. 数组 *** 组是一组按顺序排列的集合，集合的每个值称为元素。***  创建方式 可以用 **new Array();** 和 **var str = [1,2,4,'',obj]**
6. 对象 ***JavaScript的对象是一组由键-值组成的无序集合*** 
7. 变量  ***变量的概念基本上和初中代数的方程变量是一致的，只是在计算机程序中，变量不仅可以是数字，还可以是任意数据类型*** 但申明变量不可以是**$** 和**_**
8. strict模式 
启用strict模式的方法是在JavaScript代码的第一行写上：
``` 'use strict';```
## 条件判断 循环
```js
> if()else{...}
> for(){...}
> for ....in
> while (){...}
> do{...}while()

```
## map 和 set ，iterable
```js
'use strict';
var m = new Map();
var s = new Set();
alert('你的浏览器支持Map和Set！');

```
### Map是一组键值对的结构，具有极快的查找速度。 里面提供了:*** set get delete has ***方法

```js
var m = new Map(); // 空Map
m.set('Adam', 67); // 添加新的key-value
m.set('Bob', 59);
m.has('Adam'); // 是否存在key 'Adam': true
m.get('Adam'); // 67
m.delete('Adam'); // 删除key 'Adam'
m.get('Adam'); // undefined
```

### Set和Map类似，也是一组key的集合，但不存储value。由于key不能重复，所以，在Set中，没有重复的key。提供了 *** add get delete *** 方法

```js
	var s = new Set([1, 2, 3]);
	s; // Set {1, 2, 3}
	s.delete(3);
	s; // Set {1, 2}
```

### iterable
```js
'use strict';
var a = [1, 2, 3];
for (var x of a) {
}
alert('你的浏览器支持for ... of');
```
	更好的方式是直接使用iterable内置的forEach方法

```js
var a = ['A', 'B', 'C'];
a.forEach(function (element, index, array) {
	// element: 指向当前元素的值
	// index: 指向当前索引
	// array: 指向Array对象本身
	alert(element);
});

```
# 函数

> 函数定义  function fun_name (args){ ...  return}

***arguments*** 你可以获得调用者传入的所有参数。
```js
function abs() {
	if (arguments.length === 0) {
		return 0;
	}
	var x = arguments[0];
	return x >= 0 ? x : -x;
}

abs(); // 0
abs(10); // 10
abs(-9); // 9
```

***rest参数***  function fun_name(a, b, ...rest) {....}

```js
function foo(a, b, ...rest) {
	console.log('a = ' + a);
	console.log('b = ' + b);
	console.log(rest);
}

foo(1, 2, 3, 4, 5);
// 结果:
// a = 1
// b = 2
// Array [ 3, 4, 5 ]

foo(1);
// 结果:
// a = 1
// b = undefined
// Array []

```
## 常量 
> var和let申明的是变量，如果要申明一个常量，在ES6之前是不行的，我们通常用全部大写的变量来表示**这是一个常量，不要修改它的值**

## 方法  ---在一个对象中绑定函数，称为这个对象的方法。

```js
var xiaoming = {
	name: '小明',
	birth: 1990,
	age: function () {
		var y = new Date().getFullYear();
		return y - this.birth;
	}
};

xiaoming.age; // function xiaoming.age()
xiaoming.age(); // 今年调用是25,明年调用就变成26了
```
***apply***

> 根据是否是strict模式，this指向undefined或window
```js
	function getAge() {
	    var y = new Date().getFullYear();
	    return y - this.birth;
	}

	var xiaoming = {
	    name: '小明',
	    birth: 1990,
	    age: getAge
	};

	xiaoming.age(); // 25
	getAge.apply(xiaoming, []); // 25, this指向xiaoming, 参数为空
```

*** 利用apply()，我们还可以动态改变函数的行为。***
```js
var count = 0;
var oldParseInt = parseInt; // 保存原函数

window.parseInt = function () {
	count += 1;
	return oldParseInt.apply(null, arguments); // 调用原函数
};

// 测试:
parseInt('10');
parseInt('20');
parseInt('30');
count; // 3

```
## 高阶函数  也就是函数的函数
### map 
```js
function pow(x) {
	return x * x;
}

var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
arr.map(pow); // [1, 4, 9, 16, 25, 36, 49, 64, 81]
```
```js
var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
arr.map(String); // ['1', '2', '3', '4', '5', '6', '7', '8', '9']

```
### reduce  这个函数必须接收两个参数，reduce()把结果继续和序列的下一个元素做累积计算
> [x1, x2, x3, x4].reduce(f) = f(f(f(x1, x2), x3), x4)

```js
var arr = [1, 3, 5, 7, 9];
arr.reduce(function (x, y) {
return x + y;
}); // 25
```
### filter  它用于把Array的某些元素过滤掉，然后返回剩下的元素。
> filter()把传入的函数依次作用于每个元素，然后根据返回值是true还是false决定保留还是丢弃该元素。
	在一个Array中，删掉偶数，只保留奇数，可以这么写：
```js
var arr = [1, 2, 4, 5, 6, 9, 10, 15];
var r = arr.filter(function (x) {
	return x % 2 !== 0;
});
r; // [1, 5, 9, 15]
```
把一个Array中的空字符串删掉，可以这么写：
```js
var arr = ['A', '', 'B', null, undefined, 'C', '  '];
var r = arr.filter(function (s) {
	return s && s.trim(); // 注意：IE9以下的版本没有trim()方法
});
r; // ['A', 'B', 'C']

```
#### 回调函数

filter()接收的回调函数，其实可以有多个参数。通常我们仅使用第一个参数，表示Array的某个元素。回调函数还可以接收另外两个参数，表示元素的位置和数组本身：

```js
var arr = ['A', 'B', 'C'];
var r = arr.filter(function (element, index, self) {
	console.log(element); // 依次打印'A', 'B', 'C'
	console.log(index); // 依次打印0, 1, 2
	console.log(self); // self就是变量arr
	return true;
});

```
##### 去除重复元素依靠的是indexOf总是返回第一个元素的位置，后续的重复元素位置与indexOf返回的位置不相等，因此被filter滤掉了。

### sort
#### 排序算法
	通常规定，对于两个元素x和y，如果认为x < y，则返回-1，如果认为x == y，则返回0，如果认为x > y，则返回1
```js
// 看上去正常的结果:
['Google', 'Apple', 'Microsoft'].sort(); // ['Apple', 'Google', 'Microsoft'];

// apple排在了最后:
['Google', 'apple', 'Microsoft'].sort(); // ['Google', 'Microsoft", 'apple']

// 无法理解的结果:
[10, 20, 1, 2].sort(); // [1, 10, 2, 20]
```
因为字符'1'比字符'2'的ASCII码小 也就是说sort按照的是ascii来排序
sort()方法也是一个高阶函数，它还可以接收一个比较函数来实现自定义的排序。
```js
var arr = ['Google', 'apple', 'Microsoft'];
arr.sort(function (s1, s2) {
	x1 = s1.toUpperCase();
	x2 = s2.toUpperCase();
	if (x1 < x2) {
		return -1;
	}
	if (x1 > x2) {
		return 1;
	}
	return 0;
}); // ['apple', 'Google', 'Microsoft']
```
## 闭包（Closure）  (matosiki：首先要把函数当作元数据看待，其次，函数和元素的区分可以看看lisp 主要是闭包返回函数 而此函数引用的变量还没使用 或者还在使用局部变量 )
> 高阶函数除了可以接受函数作为参数外，还可以把函数作为结果值返回。
> 返回闭包时牢记的一点就是：返回函数不要引用任何循环变量，或者后续会发生变化的变量
如果不需要立刻求和，而是在后面的代码中，根据需要再计算怎么办？可以不返回求和的结果，而是返回求和的函数！

```js
function lazy_sum(arr) {
	var sum = function () {
		return arr.reduce(function (x, y) {
			return x + y;
		});
	}
	return sum;
}

// var f = lazy_sum([1, 2, 3, 4, 5]); // function sum()
```
这就是闭包的魅力
> 当一个函数返回了一个函数后，其内部的局部变量还被新函数引用
```js
function count() {
	var arr = [];
	for (var i=1; i<=3; i++) {
		arr.push(
		//存放3次匿名函数到arr数组中，并且在调用count方法时已经将i绑定到匿名函数。
		(function (n) {
			return function () {
				return n * n;
			}
		})(i));
	}
	return arr;
}

var results = count();
var f1 = results[0];
var f2 = results[1];
var f3 = results[2];

f1(); // 1
f2(); // 4
f3(); // 9
```
创建一个匿名函数并立刻执行的语法：
``` js
	(function (x) {
	return x * x;
})(3); // 9
```
> 在没有class机制，只有函数的语言里，借助闭包，同样可以封装一个私有变量。我们用JavaScript创建一个计数器：
```js
'use strict';
function create_counter(initial) {
	var x = initial || 0;
	return {
		inc: function () {
			x += 1;
			return x;
		}
	}
}
```
```js
var c1 = create_counter();
c1.inc(); // 1
c1.inc(); // 2
c1.inc(); // 3

```
```js
function make_pow(n) {
	return function (x) {
		return Math.pow(x, n);
	}
}

// 创建两个新函数:
var pow2 = make_pow(2);
var pow3 = make_pow(3);

pow2(5); // 25
pow3(7); // 343
```
#### 脑洞大开 (在函数的世界里，一切皆函数)

很久很久以前，有个叫阿隆佐·邱奇的帅哥，发现只需要用函数，就可以用计算机实现运算，而不需要0、1、2、3这些数字和+、-、*、/这些符号。

JavaScript支持函数，所以可以用JavaScript用函数来写这些计算。来试试：

```js
'use strict';

// 定义数字0:
var zero = function (f) {
	return function (x) {
		return x;
	}
};

// 定义数字1:
var one = function (f) {
	return function (x) {
		return f(x);
	}
};

// 定义加法:
function add(n, m) {
	return function (f) {
		return function (x) {
			return m(f)(n(f)(x));
		}
	}
}
// 定义乘法,n运行m次
function mult(n,m){        
	return function (f){
		return function (x) {
			return m((n)(f))(x);
		}
	}
}
	// 定义乘方,乘法运行m次
function power(n,m){             
	return function (f){
	return function (x) {
		return (n)(m)(f)(x);
		}
	}
}

		// 定义前趋(返回n-1),建一个数组[n,m]然后把它迭代到[n+1,n]再通过返回右支,对[0,0]运算n次就是[n,n-1],返回右支用数字0的定义.其实这是在抵消f就是加法.....
function dec(n){         
	return function(f){
		return function(x){
			n(function(g){
				return function(h){
					return h((g)(f))
				}
			})(function(u){
				return x
			})(function(u){
				return u
			})
			}
	}
}

	// 定义减法n>m
function subb(n,m){   
	return m(dec)(n);  // 对n运行m次前趋运算,既n-1运行m次,相当于n-m
}


// 最后,亲,你要的除法

divide = (\n.((\f.(\x.x x) (\x.f (x x))) (\c.\n.\m.\f.\x.(\d.(\n.n (\x.(\a.\b.b)) (\a.\b.a)) d ((\f.\x.x) f x) (f (c d m f x))) ((\m.\n.n (\n.\f.\x.n (\g.\h.h (g f)) (\u.x) (\u.u)) m) n m))) ((\n.\f.\x. f (n f x)) n))

```

```js
// 计算数字2 = 1 + 1:
var two = add(one, one);

// 计算数字3 = 1 + 2:
var three = add(one, two);

// 计算数字5 = 2 + 3:
var five = add(two, three);

// 你说它是3就是3，你说它是5就是5，你怎么证明？

// 呵呵，看这里:

// 给3传一个函数,会打印3次:
(three(function () {
	console.log('print 3 times');
}))();

// 给5传一个函数,会打印5次:
(five(function () {
	console.log('print 5 times');
}))();

// 继续接着玩一会...
//自己测试 发现输出 
one(function(test){console.log('good-'+test)})('taste') //good-taste
two(function(x){console.log('good-'+x)})('boy') //good-boy   good-undefined 
three(function(x){console.log('good-'+x)})('boy')  //good-boy  good-undefined  good-undefined
``` 
### Arrow Function（箭头函数）
> x = x* x;
> function(x){ return x* x;}
> var fn = x => x * x;
箭头函数相当于匿名函数，并且简化了函数定义。箭头函数有两种格式，一种像上面的，只包含一个表达式，连{ ... }和return都省略掉了。还有一种可以包含多条语句，这时候就不能省略{ ... }和return：

```js
x => {
	if (x > 0) {
		return x * x;
	}
	else {
		return - x * x;
	}
}
```

如果参数不是一个，就需要用括号()括起来：
```js
// 两个参数:
(x, y) => x * x + y * y

// 无参数:
() => 3.14

// 可变参数:
(x, y, ...rest) => {
	var i, sum = x + y;
	for (i=0; i<rest.length; i++) {
		sum += rest[i];
	}
	return sum;
}
```
如果要返回一个对象，就要注意，如果是单表达式
```x => ({ foo: x })```

> 箭头函数和匿名函数有个明显的区别：箭头函数内部的this是词法作用域，由上下文确定。
```js
var obj = {
	birth: 1990,
	getAge: function () {
		var b = this.birth; // 1990
		var fn = () => new Date().getFullYear() - this.birth; // this指向obj对象
		return fn();
	}
};
obj.getAge(); // 25
```

由于this在箭头函数中已经按照词法作用域绑定了，所以，用call()或者apply()调用箭头函数时，无法对this进行绑定，即传入的第一个参数被忽略：

```js
var obj = {
	birth: 1990,
	getAge: function (year) {
		var b = this.birth; // 1990
		var fn = (y) => y - this.birth; // this.birth仍是1990
		return fn.call({birth:2000}, year);
	}
};
obj.getAge(2015); // 25
```
### generator（生成器）是ES6标准引入的新的数据类型。一个generator看上去像一个函数，但可以返回多次。
> 函数在执行过程中，如果没有遇到return语句（函数末尾如果没有return，就是隐含的return undefined;），控制权无法交回被调用的代码。
```js
function*  foo(x) {
	yield x + 1;
	yield x + 2;
	return x + 3;
}
```

>  我们以一个著名的斐波那契数列为例，它由0，1开头：

> 0 1 1 2 3 5 8 13 21 34 ...
要编写一个产生斐波那契数列的函数，可以这么写：

```js
function fib(max) {
	var
		t,
		a = 0,
		b = 1,
		arr = [0, 1];
	while (arr.length < max) {
		t = a + b;
		a = b;
		b = t;
		arr.push(t);
	}
	return arr;
}
```
// 测试:
> fib(5); // [0, 1, 1, 2, 3]
> fib(10); // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]

```js
function* fib(max) {
	var
		t,
		a = 0,
		b = 1,
		n = 1;
	while (n < max) {
		yield a;
		t = a + b;
		a = b;
		b = t;
		n ++;
	}
	return a;
}
```


直接调用试试：
> fib(5); // fib {[[GeneratorStatus]]: "suspended", [[GeneratorReceiver]]: Window}
调用generator对象有两个方法，一是不断地调用generator对象的next()方法：

```js
var f = fib(5);
f.next(); // {value: 0, done: false}
f.next(); // {value: 1, done: false}
f.next(); // {value: 1, done: false}
f.next(); // {value: 2, done: false}
f.next(); // {value: 3, done: true}
```

```js
for (var x of fib(5)) {
	console.log(x); // 依次输出0, 1, 1, 2, 3
}
```

用一个对象来保存状态，得这么写：
```js
var fib = {
	a: 0,
	b: 1,
	n: 0,
	max: 5,
	next: function () {
		var
			r = this.a,
			t = this.a + this.b;
		this.a = this.b;
		this.b = t;
		if (this.n < this.max) {
			this.n ++;
			return r;
		} else {
			return undefined;
		}
	}
};
```

> generator还有另一个巨大的好处，就是把异步回调代码变成同步代码。

```js
ajax('http://url-1', data1, function (err, result) {
	if (err) {
		return handle(err);
	}
	ajax('http://url-2', data2, function (err, result) {
		if (err) {
			return handle(err);
		}
		ajax('http://url-3', data3, function (err, result) {
			if (err) {
				return handle(err);
			}
			return success(result);
		});
	});
});
```

> 有了generator的美好时代，用AJAX时可以这么写:
```js
try {
	r1 = yield ajax('http://url-1', data1);
	r2 = yield ajax('http://url-2', data2);
	r3 = yield ajax('http://url-3', data3);
	success(r3);
}
catch (err) {
	handle(err);
}
```
## 标准对象
### 包装对象
```js
typeof 123; // 'number'
typeof NaN; // 'number'
typeof 'str'; // 'string'
typeof true; // 'boolean'
typeof undefined; // 'undefined'
typeof Math.abs; // 'function'
typeof null; // 'object'
typeof []; // 'object'
typeof {}; // 'object'

```

```js
var n = new Number(123); // 123,生成了新的包装类型
var b = new Boolean(true); // true,生成了新的包装类型
var s = new String('str'); // 'str',生成了新的包装类型
```

闲的蛋疼也不要使用包装对象！

123.toString(); // SyntaxError
遇到这种情况，要特殊处理一下：
```js
123..toString(); // '123', 注意是两个点！
(123).toString(); // '123'

var now = new Date();
now; // Wed Jun 24 2015 19:49:22 GMT+0800 (CST)
now.getFullYear(); // 2015, 年份
now.getMonth(); // 5, 月份，注意月份范围是0~11，5表示六月 
now.getDate(); // 24, 表示24号
now.getDay(); // 3, 表示星期三
now.getHours(); // 19, 24小时制
now.getMinutes(); // 49, 分钟
now.getSeconds(); // 22, 秒
now.getMilliseconds(); // 875, 毫秒数
now.getTime(); // 1435146562875, 以number形式表示的时间戳

var d = Date.parse('2015-06-24T19:49:22.875+08:00');
```
时区
```js
var d = new Date(1435146562875);
d.toLocaleString(); // '2015/6/24 下午7:49:22'，本地时间（北京时区+8:00），显示的字符串与操作系统设定的格式有关
d.toUTCString(); // 'Wed, 24 Jun 2015 11:49:22 GMT'，UTC时间，与本地时间相差8小时

if (Date.now) {
	alert(Date.now()); // 老版本IE没有now()方法
} else {
	alert(new Date().getTime());
}
```
## 正则表达式 regExp
创建正则表达式
```js
	var re1 = /ABC\-001/;
	var re2 = new RegExp('ABC\\-001');
	re1; // /ABC\-001/
	re2; // /ABC\-001/
```

匹配正则表达式
```js
var re = /^\d{3}\-\d{3,8}$/;
re.test('010-12345'); // true
re.test('010-1234x'); // false
re.test('010 12345'); // false
```

切分字符串split()

```js 
'a b   c'.split(' '); // ['a', 'b', '', '', 'c']
```
无法识别连续的空格，用正则表达式试试：
```js
'a b   c'.split(/\s+/); // ['a', 'b', 'c']
```
无论多少个空格都可以正常分割。加入,试试：
```js
'a,b, c  d'.split(/[\s\,]+/); // ['a', 'b', 'c', 'd']
```
再加入;试试：
```js
'a,b;; c  d'.split(/[\s\,\;]+/); // ['a', 'b', 'c', 'd']
```

分组group
```js
var re = /^(\d{3})-(\d{3,8})$/;
re.exec('010-12345'); // ['010-12345', '010', '12345']
re.exec('010 12345'); // null
```
贪婪匹配
```js
var re = /^(\d+)(0*)$/;
re.exec('102300'); // ['102300', '102300', '']
```
加个?就可以让\d+采用非贪婪匹配：
```js
var re = /^(\d+?)(0*)$/;
re.exec('102300'); // ['102300', '1023', '00']
```

```js
var r1 = /test/g;
// 等价于:
var r2 = new RegExp('test', 'g');
```

当我们指定g标志后，每次运行exec()，正则表达式本身会更新lastIndex属性，表示上次匹配到的最后索引：
var s = 'JavaScript, VBScript, JScript and ECMAScript';
var re=/[a-zA-Z]+Script/g;
```js
// 使用全局匹配:
re.exec(s); // ['JavaScript']
re.lastIndex; // 10
re.exec(s); // ['VBScript']
re.lastIndex; // 20
re.exec(s); // ['JScript']
re.lastIndex; // 29
re.exec(s); // ['ECMAScript']
re.lastIndex; // 44
re.exec(s); // null，直到结束仍没有匹配到
```

## json
```js
	number：和JavaScript的number完全一致；
	boolean：就是JavaScript的true或false；
	string：就是JavaScript的string；
	null：就是JavaScript的null；
	array：就是JavaScript的Array表示方式 ---- []；
	object：就是JavaScript的{ ... }表示方式。
```

### 序列化
```js
var xiaoming = {
	name: '小明',
	age: 14,
	gender: true,
	height: 1.65,
	grade: null,
	'middle-school': '\"W3C\" Middle School',
	skills: ['JavaScript', 'Java', 'Python', 'Lisp']
};
JSON.stringify(xiaoming); // '{"name":"小明","age":14,"gender":true,"height":1.65,"grade":null,"middle-school":"\"W3C\" Middle School","skills":["JavaScript","Java","Python","Lisp"]}'
```
JSON.stringify(xiaoming, null, '  ');
输出的格式很好

如果我们只想输出指定的属性，可以传入Array：
```js
{
	"name": "小明",
	"skills": [
	"JavaScript",
	"Java",
	"Python",
	"Lisp"
	]
}
```

还可以传入一个函数，这样对象的每个键值对都会被函数先处理：
```js
function convert(key, value) {
	if (typeof value === 'string') {
		return value.toUpperCase();
	}
	return value;
}
JSON.stringify(xiaoming, convert, '  ');
```
上面的代码把所有属性值都变成大写：
```js
{
	"name": "小明",
	"age": 14,
	"gender": true,
	"height": 1.65,
	"grade": null,
	"middle-school": "\"W3C\" MIDDLE SCHOOL",
	"skills": [
	"JAVASCRIPT",
	"JAVA",
	"PYTHON",
	"LISP"
	]
}
```

如果我们还想要精确控制如何序列化小明，可以给xiaoming定义一个toJSON()的方法，直接返回JSON应该序列化的数据：
```js
var xiaoming = {
	name: '小明',
	age: 14,
	gender: true,
	height: 1.65,
	grade: null,
	'middle-school': '\"W3C\" Middle School',
	skills: ['JavaScript', 'Java', 'Python', 'Lisp'],
	toJSON: function () {
		return { // 只输出name和age，并且改变了key：
			'Name': this.name,
			'Age': this.age
		};
	}
};
JSON.stringify(xiaoming); // '{"Name":"小明","Age":14}'
```
#### 反序列化
拿到一个JSON格式的字符串，我们直接用JSON.parse()把它变成一个JavaScript对象：

```js
JSON.parse('[1,2,3,true]'); // [1, 2, 3, true]
JSON.parse('{"name":"小明","age":14}'); // Object {name: '小明', age: 14}
JSON.parse('true'); // true
JSON.parse('123.45'); // 123.45
```


JSON.parse()还可以接收一个函数，用来转换解析出的属性：
```js
JSON.parse('{"name":"小明","age":14}', function (key, value) {
	// 把number * 2:
	if (key === 'name') {
		return value + '同学';
	}
	return value;
}); // Object {name: '小明同学', age: 14}
```
yahoo api : https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2Cf20cb1667ab30fd1efaa93955e81bef8abe74522%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys

## 面向对象编程
定义对象  申明对象用{} 大括号  声明方法用 fun_name: function(){....} 声明属性 键值对
```js
var robot = {
	name: 'Robot',
	height: 1.6,
	run: function () {
		console.log(this.name + ' is running...');
	}
};
```
对象实例化	
	基于原型 创建一个新对象:
		//var s = Object.create(Student);

### 创建对象
	JavaScript对每个创建的对象都会设置一个原型，指向它的原型对象。
	原型链是javascript 继承的标志
	函数也是对象
	foo ----> Function.prototype ----> Object.prototype ----> null
	构造函数
	除了直接用{ ... }创建一个对象外，JavaScript还可以用一种构造函数的方法来创建对象。
```js
function Student(name) {
	this.name = name;
	this.hello = function () {
		alert('Hello, ' + this.name + '!');
	}
}
```
但是实例化的时候必须用new  不然就是普通函数
```js
var xiaoming = new Student('小明');
xiaoming.name; // '小明'
xiaoming.hello(); // Hello, 小明!
```
我们还可以编写一个createStudent()函数，在内部封装所有的new操作。一个常用的编程模式像这样：
```js
	function Student(props) {
		this.name = props.name || '匿名'; // 默认值为'匿名'
		this.grade = props.grade || 1; // 默认值为1
	}
	Student.prototype.hello = function () {
		alert('Hello, ' + this.name + '!');
	};
	function createStudent(props) {
		return new Student(props || {})
	}
```

### 原型继承  由于这类语言严格区分类和实例，继承实际上是类型的扩展。
//发明json的道琼格拉斯 发明了 利用空函数 f function(){} 做桥梁实现原型链
```js
// PrimaryStudent构造函数:
function PrimaryStudent(props) {
	Student.call(this, props);
	this.grade = props.grade || 1;
}
// 空函数F:
function F() {
}
// 把F的原型指向Student.prototype:
F.prototype = Student.prototype;
// 把PrimaryStudent的原型指向一个新的F对象，F对象的原型正好指向Student.prototype:
PrimaryStudent.prototype = new F();
// 把PrimaryStudent原型的构造函数修复为PrimaryStudent:
PrimaryStudent.prototype.constructor = PrimaryStudent;
// 继续在PrimaryStudent原型（就是new F()对象）上定义方法：
PrimaryStudent.prototype.getGrade = function () {
	return this.grade;
};
// 创建xiaoming:
var xiaoming = new PrimaryStudent({
	name: '小明',
	grade: 2
});
xiaoming.name; // '小明'
xiaoming.grade; // 2
// 验证原型:
xiaoming.__proto__ === PrimaryStudent.prototype; // true
xiaoming.__proto__.__proto__ === Student.prototype; // true
// 验证继承关系:
xiaoming instanceof PrimaryStudent; // true
xiaoming instanceof Student; // true
```
把继承这个动作用一个inherits()函数封装起来，还可以隐藏F的定义，并简化代码：

```js
function inherits(Child, Parent) {
	var F = function () {};
	F.prototype = Parent.prototype;
	Child.prototype = new F();
	Child.prototype.constructor = Child;
}
```

### class 继承
	新的关键字class从ES6开始正式被引入到JavaScript中。class的目的就是让定义类更简单。
```js
class Student {
	constructor(name) {
		this.name = name;
	}

	hello() {
		alert('Hello, ' + this.name + '!');
	}
}
```
实例化对象
var xiaoming = new Student('小明');xiaoming.hello();
继承实现
```js
class PrimaryStudent extends Student {
	constructor(name, grade) {
		super(name); // 记得用super调用父类的构造方法!
		this.grade = grade;
	}

	myGrade() {
		alert('I am at grade ' + this.grade);
	}
}
```
对class 继承转原型链  可使用https://babeljs.io/ 的 Babel


好了关于js基本编程复习到这里 往后是浏览器dom操作复习  