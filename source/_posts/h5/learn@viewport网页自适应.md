---
title: viewpor网页自适应
date: {{date}}
categories: 
- learn
tags: 
- h5
---
# viewport 手机端浏览器可视窗口大小 
实际浏览器可视域的大小比默认viewport 宽度小 ,就会出现滚动条

# 1px 在不同设备上有不同定义
计算器显示器是通过显示像素点,显示图片的,像素越多看的细,像素越少越模糊,这个就是物理像素.
在css 中也有px属性,叫做设备独立像素
devicePixelRatio = 物理像素 / 独立像素。

# viewport三大理论 ppk
1. layout viewport   layout viewport的宽度可以通过document.documentElement.clientWidth 来获取
2. visual viewport   visual viewport的宽度可以通过window.innerWidth 来获取
3. ideal viewport    没有一个固定的尺寸，不同的设备拥有有不同的ideal viewport。


# 利用meta标签使用viewport
移动设备默认的viewport是layout viewport，也就是那个比屏幕要宽的viewport，但在进行移动设备网站的开发时，我们需要的是ideal viewport。
那么怎么才能得到ideal viewport呢？这就该轮到meta标签出场了。
```html
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
```

width	设置layout viewport  的宽度，为一个正整数，或字符串"device-width"
initial-scale	设置页面的初始缩放值，为一个数字，可以带小数
minimum-scale	允许用户的最小缩放值，为一个数字，可以带小数
maximum-scale	允许用户的最大缩放值，为一个数字，可以带小数
height	设置layout viewport  的高度，这个属性对我们并不重要，很少使用
user-scalable	是否允许用户进行缩放，值为"no"或"yes", no 代表不允许，yes代表允许

# 把当前的viewport宽度设置为 ideal viewport 的宽度
```html
<meta name="viewport" content="width=device-width">  or <meta name="viewport" content="initial-scale=1">
```

# 淘宝的布局方案解析

(1)动态设置viewport的scale
```js
var scale = 1 / devicePixelRatio;  
document.querySelector('meta[name="viewport"]').setAttribute('content','initial-scale=' + scale + ',maximum-scale=' + scale + ', minimum-scale=' + scale + ', user-scalable=no');  
```
淘宝布局的第二个要点，就是html元素的font-size的计算公式，font-size = deviceWidth / 10:
(2)动态设置html的font-size
```js
//flexible中定义<html>font-size
var width = docEl.getBoundingClientRect().width;  
if (width / dpr > 540) {  
    width = 540 * dpr;
}
var rem = width / 10;
docEl.style.fontSize = rem + 'px';
```
(3)布局的时候，各元素的css尺寸=设计稿标注尺寸/设计稿横向分辨率/10
(4)font-size可能需要额外的媒介查询，并且font-size不使用rem

# 淘宝移动端自适应方案—lib.flexible库解析
它的主要js文件有三个，包括flexiblecss.js、flexible.js、makegrid.js
flexible.js—布局的核心js
flexiblecss.js—注入统一的css样式，比如去掉所有元素的内外边距，去掉默认边框等等
makegrid.js—栅格系统

阿里CDN:
<script src="http://g.tbcdn.cn/mtb/lib-flexible/0.3.2/flexible_css.js"></script>
<script src="http://g.tbcdn.cn/mtb/lib-flexible/0.3.2/flexible.js"></script>
<script src="http://g.tbcdn.cn/mtb/lib-flexible/0.3.2/makegrid.js"></script>


其中initial-dpr会把dpr强制设置为给定的值。如果手动设置了dpr之后，不管设备是多少的dpr，都会强制认为其dpr是你设置的值。在此不建议手动强制设置dpr，因为在Flexible中，只对iOS设备进行dpr的判断，对于Android系列，始终认为其dpr为1。
```js
 if (!dpr && !scale) {  
        var isAndroid = win.navigator.appVersion.match(/android/gi);
        var isIPhone = win.navigator.appVersion.match(/iphone/gi);
        var devicePixelRatio = win.devicePixelRatio;
        if (isIPhone) {
            // iOS下，对于2和3的屏，用2倍的方案，其余的用1倍方案
            if (devicePixelRatio >= 3 && (!dpr || dpr >= 3)) {                
                dpr = 3;
            } else if (devicePixelRatio >= 2 && (!dpr || dpr >= 2)){
                dpr = 2;
            } else {
                dpr = 1;
            }
        } else {
            // 其他设备下，仍旧使用1倍的方案
            dpr = 1;
        }
        scale = 1 / dpr;
    }
```
# flexible的实质 能通过js动态更改meta标签
```js
var metaEl = doc.createElement('meta');  
var scale = isRetina ? 0.5:1;  
metaEl.setAttribute('name', 'viewport');  
metaEl.setAttribute('content', 'initial-scale=' + scale + ', maximum-scale=' + scale + ', minimum-scale=' + scale + ', user-scalable=no');  
if (docEl.firstElementChild) {  
 document.documentElement.firstElementChild.appendChild(metaEl);
} else {
    var wrap = doc.createElement('div');
    wrap.appendChild(metaEl);
    documen.write(wrap.innerHTML);
}
```

- 动态改写标签
- 给元素添加data-dpr属性，并且动态改写data-dpr的值
- 给元素添加font-size属性，并且动态改写font-size的值


### 把视觉稿中的px转换成rem

目前Flexible会将视觉稿分成100份，而每一份被称为一个单位a。同时1rem单位被认定为10a。
1a = 7.5px
1rem = 75px
那么我们的视觉稿就分成了10a，也就是整个宽度为10rem，对应的font-size为75px；

## 推荐CSSREM——px转化rem小工具

使用[data-dpr]属性来区分不同dpr下的文本字号大小。
```css
div {  
    width: 1rem; 
    height: 0.4rem;
    font-size: 12px; // 默认写上dpr为1的fontSize
}
[data-dpr="2"] div {
    font-size: 24px;
}
[data-dpr="3"] div {
    font-size: 36px;
}

```
字体慎用rem，误差太大了，因为不能满足任何屏幕下字体大小相同,所以建议标题类用rem，要求字体大小相同的部分还是用px

### 栅格系统—makegrid.js

js 代码
```js
var gridMode = {  
    '750-12'：{     designWidth:750,designUnit:6,columnCount:12,columnXUnit:7,gutterXUnit:3,edgeXUnit:4
    },
    '750-6': { designWidth:750,designUnit:6,columnCount:6,columnXUnit:17,gutterXUnit:3,edgeXUnit:4
   },
   '640-12': { designWidth:640,designUnit:4,columnCount:12,columnXUnit:11,gutterXUnit:2,edgeXUnit:3
   },
   '640-6': { designWidth:640,designUnit:4,columnCount:6,columnXUnit:24,gutterXUnit:2,edgeXUnit:3
   }
}
```
参数说明
lib.flexible.makeGrid(params)
• [Object params]
- designWidth - 设计稿宽度

- designUnit - 设计稿最小单位a（以px为单位）
- columnCount - 栅格列数
- columnXUnit - 栅格列宽（以a为单位）
- gutterXUnit - 栅格间距（以a为单位）

- edgeXUnit - 页面左右边距（以a为单位）
- className - 栅格样式的名称（可省略，默认为grid）

利用meta输出栅格样式
<meta content="designWidth=750, desginUnit=6, columnCount=12, columnXUnit=7, gutterXUnit=3, edgeXUnit=4" name="grid" />

或
<meta content="modeName=750-12" name="grid" />
栅格化代码举例
```js
<meta content="modeName=640-12" name="grid" />  
<div class="grid">  
    <div class="col-4"></div>
    <div class="col-4"></div>
    <div class="col-4"></div>
</div> 
```

## 瞅瞅flexible.js 源码
flexible.js—布局的核心js,里边主要包含下边几点来实现适配布局

1)设置像素比dpr和scale
有两种模式：一种是自适应，一种是手动配置dpr
适应模式：根据已有的meta标签来设置dpr和scale
手动配置：<meta name="flexible" content="initial-dpr=2,maximum-dpr=3" />
2）如果没有设置缩放比，根据苹果用户或者安卓用户设置缩放比。iOS下，对于2和3的屏，用2倍的方案，其余的用1倍方案，安卓的均采用1。
源码:
```js
var isAndroid = win.navigator.appVersion.match(/android/gi);  
var isIPhone = win.navigator.appVersion.match(/iphone/gi);  
var devicePixelRatio = win.devicePixelRatio;  
if (isIPhone) {  
      // iOS下，对于2和3的屏，用2倍的方案，其余的用1倍方案
       if (devicePixelRatio >= 3 && (!dpr || dpr >= 3)) {                
           dpr = 3;
       } else if (devicePixelRatio >= 2 && (!dpr || dpr >= 2)){
            dpr = 2;
      } else {
             dpr = 1;
      }
  } else {
        // 其他设备下，仍旧使用1倍的方案
         dpr = 1;
 }
```
3）前边谈到淘宝布局方案的时候，说到淘宝触屏版布局的前提就是viewport的scale根据devicePixelRatio动态设置
```js
//为html标签添加data-dpr属性
docEl.setAttribute('data-dpr', dpr);  
//如果没有meta[name="viewport"，添加meta标签 
if (!metaEl) {  
   metaEl = doc.createElement('meta');
   metaEl.setAttribute('name', 'viewport');
   metaEl.setAttribute('content', 'initial-scale=' + scale + ', maximum-scale=' + scale + ', minimum-scale=' + scale + ', user-scalable=no');
   if (docEl.firstElementChild) {
      docEl.firstElementChild.appendChild(metaEl);
   } else {
       var wrap = doc.createElement('div');
       wrap.appendChild(metaEl);
       doc.write(wrap.innerHTML);
   }
}
```
4）为html标签添加data-dpr属性
document.documentElement.setAttribute('data-dpr', dpr);
5）刷新页面的rem基准值 （API---lib.flexible.refreshRem()）

```js
//根据dpr和物理像素设置rem
function refreshRem(){  
 //getBoundingClientRect().width相当于物理像素
   var width = docEl.getBoundingClientRect().width;
   // width / dpr > 540等于独立像素
   if (width / dpr > 540) {  
       width = 540 * dpr;
   }
   var rem = width / 10;
   docEl.style.fontSize = rem + 'px';
   flexible.rem = win.rem = rem;
}
```

6)什么时候执行refreshRem()呢？
第一种当窗口大小发生变化，也就是触发resize事件的时候；
```js
win.addEventListener('resize', function() {  
    clearTimeout(tid);
    tid = setTimeout(refreshRem, 300);
}, false);
```
第二种是当重新载入页面时，判断是否是缓存，如果是缓存，执行refreshRem()
```js
win.addEventListener('pageshow', function(e) {  
   if (e.persisted) {
      clearTimeout(tid);
       tid = setTimeout(refreshRem, 300);
   }
}, false);
```
7)rem转化px （API---lib.flexible.rem2px([Number|String digital])）
```js
flexible.rem2px = function(d) {  
   //已定义var rem = width / 10;
   var val = parseFloat(d) * this.rem;
   if (typeof d === 'string' && d.match(/rem$/)) {
       val += 'px';
   }
   return val;
}
```
rem转化px计算公式=d*(width/10)
8)px转化rem （API---lib.flexible.px2rem([Number|String digital])）
```js
flexible.px2rem = function(d) {  
   var val = parseFloat(d) / this.rem;
   if (typeof d === 'string' && d.match(/px$/)) {
       val += 'rem';
   }
   return val;
}
```
px转化rem计算公式=d/(width/10)

# css布局适配问题避免:
1. 盒子，图片等宽度设置首选百分比，次而选择rem，高度可以是固定值
2. 字体可以不用rem，误差太大了，且不能满足任何屏幕下字体大小相同,所以建议标题类用rem，要求字体大小相同的部分还是用px；
3. 遇到内容排列显示的布局，建议放弃float，可以直接使用display:inline-block。
4. 慎用position属性；absolute会脱离文档流，relative则不会
5. 如何解决盒子边框溢出？当你把元素宽度设为 width:100%时，有时可能会遇到元素的宽度超出了屏幕，
    这时可对元素加box-sizing:border-box属性，用来指定盒子大小包含边框和内边距
6. 去除button在ios上的默认样式
    -webkit-appearance: none; border-radius: 0;
7. 不想让按钮touch时有蓝色的边框
    outline:none;
8. 去除webkit的滚动条
    element::-webkit-scrollbar{  
        
    display: none;
    }
9. 遇到过一个问题就是，当手机端点击input弹出键盘，整个视窗的高度就会变为减去键盘的高度，
    页面底部样式会乱，当时解决方法是用js获取整个页面高度赋值给body，等于说在不同的设备下写死不同的body高度值，底部就不会乱了
    $("body").css("height",parseInt($(".wrap").height())+parseInt($(".icon-main").height()));
10. 如果想改变 placeholder里的文字，需要用c伪类
    ::-webkit-input-placeholder{
    
    color:#ccc
    }


# 附上简单淘宝适配源码
```html
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta content="modeName=640-12" name="grid" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="description" content="">
	<meta name="keywords" content="">
	<title></title>
	<style>
	</style>
</head>
<body>
<style>  
   .grid{ 
    margin-top: 1rem ;
    background-color: #ccc;
    padding-top: 0.6rem;
   }
   .grid > div {
    text-align: center;
    font-size:0.4rem;
   }
   .pic{
        width:2rem;
        height:2rem;
        margin-bottom: 0.4rem;
   }
   .pic img{
        width:1.4rem;
        height:1.4rem;
   }
   .pic p{
        width:2rem;
        height:0.6rem;
        position:relative;
        top:2px;
        color:#666;
   }
</style>  
<div class="grid">  
     <div class="col-3">
     <div class="pic">
        <img src="./../../img_lib/persion.png" alt="">
        <p>天猫</p>
     </div>
     <div class="pic">
        <img src="./../../img_lib/persion.png" alt="">
        <p>聚划算</p>
     </div>
     </div>
    <div class="col-3">
        <div class="pic">
            <img src="./../../img_lib/persion.png" alt="">
            <p>天猫</p>
        </div>
        <div class="pic">
            <img src="./../../img_lib/persion.png" alt="">
            <p>聚划算</p>
        </div>
    </div>
    <div class="col-3">
        <div class="pic">
            <img src="./../../img_lib/persion.png" alt="">
            <p>天猫</p>
        </div>
        <div class="pic">
            <img src="./../../img_lib/persion.png" alt="">
            <p>聚划算</p>
        </div>
    </div>
    <div class="col-3">
        <div class="pic">
            <img src="./../../img_lib/persion.png" alt="">
            <p>天猫</p>
        </div>
        <div class="pic">
            <img src="./../../img_lib/persion.png" alt="">
            <p>聚划算</p>
        </div>
    </div>
</div>  
</body>
<script src="http://g.tbcdn.cn/mtb/lib-flexible/0.3.2/flexible_css.js"></script>
<script src="http://g.tbcdn.cn/mtb/lib-flexible/0.3.2/flexible.js"></script>
<script src="http://g.tbcdn.cn/mtb/lib-flexible/0.3.2/makegrid.js"></script>
</html>
```