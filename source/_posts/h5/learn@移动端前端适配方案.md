---
title: 移动端前端适配方案
---

关于移动适配技术方案4种对比:
1. 媒体查询的方式即CSS3的meida queries
2. flex 弹性布局  (天猫首页)
3. rem+viewport缩放 (淘宝首页)
4. rem 方式  (魅族移动端的实现方式)

# Media Queries
meida queries 的方式可以说是我早期采用的布局方式，它主要是通过查询设备的宽度来执行不同的 css 代码，最终达到界面的配置。核心语法是：

```css
@media screen and (max-width: 600px) { /*当屏幕尺寸小于600px时，应用下面的CSS样式*/
  /*你的css代码*/
}
```
## 优点
- media query可以做到设备像素比的判断，方法简单，成本低，特别是对移动和PC维护同一套代码的时候。目前像- Bootstrap等框架使用这种方式布局
- 图片便于修改，只需修改css文件
- 调整屏幕宽度的时候不用刷新页面即可响应式展示

## 缺点

- 代码量比较大，维护不方便
- 为了兼顾大屏幕或高清设备，会造成其他设备资源浪费，特别是加载图片资源
- 为了兼顾移动端和PC端各自响应式的展示效果，难免会损失各自特有的交互方式

# flex弹性布局
它的viewport是固定的：<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
**高度定死，宽度自适应，元素都采用px做单位。**

# rem+viewport 缩放
根据屏幕宽度设定 rem 值，需要适配的元素都使用 rem 为单位，不需要适配的元素还是使用 px 为单位。
根据rem将页面放大dpr倍, 然后viewport设置为1/dpr.

- 如iphone6 plus的dpr为3, 则页面整体放大3倍, 1px(css单位)在plus下默认为3px(物理像素)
- 然后viewport设置为1/3, 这样页面整体缩回原始大小. 从而实现高清。

设备的物理分辨率/(devicePixelRatio * scale)
在scale为1的情况下，device-width = 设备的物理分辨率/devicePixelRatio 。

# rem 实现
viewport也是固定的：<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
通过以下代码来控制rem基准值(设计稿以720px宽度量取实际尺寸)
```js
!function (d) {
    var c = d.document;
    var a = c.documentElement;
    var b = d.devicePixelRatio;
    var f;

    function e() {
      var h = a.getBoundingClientRect().width, g;
      if (b === 1) {
        h = 720
      }
      if(h>720) h = 720;//设置基准值的极限值
      g                = h / 7.2;
      a.style.fontSize = g + "px"
    }

    if (b > 2) {
      b = 3
    } else {
      if (b > 1) {
        b = 2
      } else {
        b = 1
      }
    }
    a.setAttribute("data-dpr", b);
    d.addEventListener("resize", function () {
      clearTimeout(f);
      f = setTimeout(e, 200)
    }, false);
    e()
  }(window);
```

css通过sass预编译，设置量取的px值转化rem的变量$px: (1/100)+rem;;


## 淘宝实现方式

transform: scale(0.5)

CSS代码：

```css
div{
    width: 1px;
    height: 100%;
    display: block;
    border-left: 1px solid #e5e5e5;
    -webkit-transform: scaleX(.5);
    transform: scaleX(.5);
}
```
## 缺点：

- 圆角无法实现，实现4条边框比较麻烦，并且只能单独实现，如果嵌套，会对包含的效果产生不想要的效果，所以此方案配合:after和before独立使用较多。
box-shadow

**实现方法：**

利用CSS对阴影处理的方式实现0.5px的效果。
```css
-webkit-box-shadow:0 1px 1px -1px rgba(0, 0, 0, 0.5);
```
优点：

基本所有场景都能满足，包含圆角的button，单条，多条线。

## 缺点：

- 颜色不好处理， 黑色 rgba(0,0,0,1) 最深的情况了。有阴影出现，不好用。
- 大量使用box-shadow可能会导致性能瓶颈。
- 四条边框实现效果不理想。


**图片实现**

使用 background-image 实现1px有两种方式: 渐变 linear-gradient 或直接使用图片(base64)。

渐变 linear-gradient (50%有颜色，50%透明)

**单条线：**
```css
div {
  height: 1px;
  background-image: -webkit-linear-gradient(top,transparent 50%,#000 50%);
  background-position: top left;
  background-repeat: no-repeat
  background-size: 100% 1px;
}
```
**多条线：**
```css
div {
  background-image:-webkit-linear-gradient(top, transparent 50%, #000 50%),-webkit-linear-gradient(bottom, transparent 50%, #000 50%),-webkit-linear-gradient(left, transparent 50%, #000 50%),-webkit-linear-gradient(right, transparent 50%, #000 50%);
  background-size: 100% 1px,100% 1px,1px 100%,1px 100%;
  background-repeat: no-repeat;
  background-position: top left, bottom left, left top, right top;
}
```
## 优点:

- 可以设置单条,多条边框
- 可以设置颜色
## 缺点:

- 大量使用渐变可能导致性能瓶颈
- 代码量大
- 多背景图片有兼容性问题