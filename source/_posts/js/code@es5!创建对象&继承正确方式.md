#  创建对象的几种方式
1. 构造函数法
```js
function Person(name){
	this.name = name
}
new Person('tom')
Person.prototype.work = function(thing){
	console.log('work some' + thing);
}
```


2. Object.create()法
```js
var Animal = {
		name:'Animal',
		run : function(){
			console.log('run .........');
		}
}
var dog = Object.create(Animal);
// 低版本ie 兼容代码
if(!Object.create){
	Object.create = function(o){
		function F(){}
		F.prototype = o;
		return new F();
	}
}
```


3. 极简主义

```js
var Cat = {
	sound :'汪汪',  // 数据共享
	createNew : function(){
		var cat = {}
		cat.name='二黄';
		var host = '小王'; //私有变量
		cat.makeSound=function(){
			console.log('汪汪...');
		}
		cat.theHost = function(){
			return host;
		}
		cat.changeSound=function(x){
			Cat.sound = x;
		}
		return cat
	}
}
var cat1 = Cat.createNew();
var cat2 = Cat.createNew();
```
# js 遍历对象参数

```js
var o1 = {};
var o2 = new Object();
var o3 = Object.create(Object.prototype);
var obj = { x: 1, y: 2};
var props = [];
var i = 0;
for (props[i++] in obj);
console.log(props) // ['x', 'y']
```

# js apply 方法
```js
var Obj = function(){
	this.name = 'matosiki';
	this.todo = function(fn,args){
		//return arguments[0].apply(this);
		return fn.apply(this,arguments);
	}
}
var arg = "good boy!";
myObj = new Obj();
myObj.todo(function(){
	console.log(this.name);
	console.log(arguments[1]);
},arg);
```




# 对象继承
# 两个对象 继承
```js
　	function Animal(){
　　　　this.species = "动物";
　　}


	function Cat(name,color){
　　　　this.name = name;
　　　　this.color = color;
　　}
```

## 一、 构造函数绑定
使用call或apply方法，将父对象的构造函数绑定在子对象上
```js
　function Cat(name,color){
　　　　Animal.apply(this, arguments);   // 这一行很关键
　　　　this.name = name;
　　　　this.color = color;
　　}
　　var cat1 = new Cat("大毛","黄色");
　　alert(cat1.species); // 动物


```

## 二、 prototype模式

```js
	Cat.prototype = new Animal();
　　Cat.prototype.constructor = Cat;
　　var cat1 = new Cat("大毛","黄色");
　　alert(cat1.species); // 动物
```
## 三、 直接继承prototype

```js

　function Animal(){ }
　Animal.prototype.species = "动物";

  Cat.prototype = Animal.prototype;
　Cat.prototype.constructor = Cat;
　var cat1 = new Cat("大毛","黄色");
　alert(cat1.species); // 动物

//Cat.prototype和Animal.prototype现在指向了同一个对象，那么任何对Cat.prototype的修改，都会反映到Animal.prototype。
```
## 四、 利用空对象作为中介
```js
　 var F = function(){};
　　F.prototype = Animal.prototype;
　　Cat.prototype = new F();
　　Cat.prototype.constructor = Cat;
```
我们将上面的方法，封装成一个函数，便于使用。
```js
	function extend(Child, Parent) {
　　　　var F = function(){};
　　　　F.prototype = Parent.prototype;
　　　　Child.prototype = new F();
　　　　Child.prototype.constructor = Child;
　　　　Child.uber = Parent.prototype;
　　}

　　extend(Cat,Animal);
　　var cat1 = new Cat("大毛","黄色");
　　alert(cat1.species); // 动物
```

## 五、 拷贝继承
```js
  function Animal(){}
　Animal.prototype.species = "动物";


　function extend2(Child, Parent) {
　　　　var p = Parent.prototype;
　　　　var c = Child.prototype;
　　　　for (var i in p) {
　　　　　　c[i] = p[i];
　　　　　　}
　　　　c.uber = p;
　　}
　　extend2(Cat, Animal);
　　var cat1 = new Cat("大毛","黄色");
　　alert(cat1.species); // 动物
```

# 非构造函数的继承
## object()方法
```js
var Chinese = {
　　　　nation:'中国'
};	
var Doctor ={
　　　　career:'医生'
}
function object(o) {
　　　　function F() {}
　　　　F.prototype = o;
　　　　return new F();
}

var Doctor = object(Chinese);

Doctor.career = '医生';

alert(Doctor.nation); //中国

```

## 浅拷贝
```js
function extendCopy(p) {
　　　　var c = {};
　　　　for (var i in p) { 
　　　　　　c[i] = p[i];
　　　　}
　　　　c.uber = p;
　　　　return c;
}

var Doctor = extendCopy(Chinese);
Doctor.career = '医生';
alert(Doctor.nation); // 中国
```

## 深拷贝
```js
function deepCopy(p, c) {
　　　　var c = c || {};
　　　　for (var i in p) {
　　　　　　if (typeof p[i] === 'object') {
　　　　　　　　c[i] = (p[i].constructor === Array) ? [] : {};
　　　　　　　　deepCopy(p[i], c[i]);
　　　　　　} else {
　　　　　　　　　c[i] = p[i];
　　　　　　}
　　　　}
　　　　return c;
}

var Doctor = deepCopy(Chinese);
Chinese.birthPlaces = ['北京','上海','香港'];
Doctor.birthPlaces.push('厦门');

alert(Doctor.birthPlaces); //北京, 上海, 香港, 厦门
alert(Chinese.birthPlaces); //北京, 上海, 香港
```