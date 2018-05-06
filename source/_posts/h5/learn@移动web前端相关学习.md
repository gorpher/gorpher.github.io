---
title: web前端自适应技巧相关学习
date: {{date}}
categories: learn
tags: 
- h5
---
# meta基础知识
## H5页面窗口自动调整到设备宽度，并禁止用户缩放页面
```js
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
```

## 忽略将页面中的数字识别为电话号码

```js
<meta name="format-detection" content="telephone=no" />
```

## 忽略Android平台中对邮箱地址的识别

```js
<meta name="format-detection" content="email=no" />
```

## 当网站添加到主屏幕快速启动方式，可隐藏地址栏，仅针对ios的safari
```js
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- ios7.0版本以后，safari上已看不到效果 -->
```

## 将网站添加到主屏幕快速启动方式，仅针对ios的safari顶端状态条的样式

```js
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<!-- 可选default、black、black-translucent -->
```

# viewport模板
viewport模板——通用
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<meta content="email=no" name="format-detection">
<title>标题</title>
<link rel="stylesheet" href="index.css">
</head>

<body>
这里开始内容
</body>

</html>
```
viewport模板 - target-densitydpi=device-dpi，android 2.3.5以下版本不支持
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=750, user-scalable=no, target-densitydpi=device-dpi">
<!-- width取值与页面定义的宽度一致 -->
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<meta content="email=no" name="format-detection">
<title>标题</title>
<link rel="stylesheet" href="index.css">
</head>

<body>
这里开始内容
</body>

</html>
```


## 移动端如何定义字体font-family

中文字体使用系统默认即可，英文用Helvetica
```js
/* 移动端定义字体的代码 */
body{font-family:Helvetica;}
```


## 移动端字体单位font-size选择px还是rem

对于只需要适配少部分手机设备，且分辨率对页面影响不大的，使用px即可

对于需要适配各种移动设备，使用rem，例如只需要适配iPhone和iPad等分辨率差别比较挺大的设备

rem配置参考，适合视觉稿宽度为640px的：
```html
<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" name="viewport">
```
```css
html{font-size:10px}
@media screen and (min-width:321px) and (max-width:375px){html{font-size:11px}}
@media screen and (min-width:376px) and (max-width:414px){html{font-size:12px}}
@media screen and (min-width:415px) and (max-width:639px){html{font-size:15px}}
@media screen and (min-width:640px) and (max-width:719px){html{font-size:20px}}
@media screen and (min-width:720px) and (max-width:749px){html{font-size:22.5px}}
@media screen and (min-width:750px) and (max-width:799px){html{font-size:23.5px}}
@media screen and (min-width:800px){html{font-size:25px}}
```
## 移动端click屏幕产生200-300 ms的延迟响应
触摸事件的响应顺序

1、ontouchstart 
2、ontouchmove 
3、ontouchend 
4、onclick


## 什么是Retina 显示屏，带来了什么问题
retina：一种具备超高像素密度的液晶屏，同样大小的屏幕上显示的像素点由1个变为多个，如在同样带下的屏幕上，苹果设备的retina显示屏中，像素点1个变为4个

在高清显示屏中的位图被放大，图片会变得模糊，因此移动端的视觉稿通常会设计为传统PC的2倍

那么，前端的应对方案是：
设计稿切出来的图片长宽保证为偶数，并使用backgroud-size把图片缩小为原来的1/2
```css
//例如图片宽高为：200px*200px，那么写法如下
.css{width:100px;height:100px;background-size:100px 100px;}
```
其它元素的取值为原来的1/2，例如视觉稿40px的字体，使用样式的写法为20px
```css
.css{font-size:20px}
```

## ios系统中元素被触摸时产生的半透明灰色遮罩怎么去掉

```css
a,button,input,textarea{-webkit-tap-highlight-color: rgba(0,0,0,0;)}
```
## 部分android系统中元素被点击时产生的边框怎么去掉
```css
a,button,input,textarea{
-webkit-tap-highlight-color: rgba(0,0,0,0;)
-webkit-user-modify:read-write-plaintext-only; 
}
```
## webkit表单元素的默认外观怎么重置
```css
.css{-webkit-appearance:none;}
```

## 禁止ios和android用户选中文字
```css
.css{-webkit-user-select:none}
```

## 禁止ios 长按时不触发系统的菜单，禁止ios&android长按时下载图片
```css
.css{-webkit-touch-callout: none}

```
# IE10（winphone8）表单元素默认外观如何重置
## 禁用 radio 和 checkbox 默认样式

::-ms-check 适用于表单复选框或单选按钮默认图标的修改，同样有多个属性值，设置它隐藏 (display:none) 并使用背景图片来修饰可得到我们想要的效果。
```css
input[type=radio]::-ms-check,input[type=checkbox]::-ms-check{
display: none;
}
```

## 禁用PC端表单输入框默认清除按钮

当表单文本输入框输入内容后会显示文本清除按钮，::-ms-clear 适用于该清除按钮的修改，同样设置使它隐藏 (display:none) 并使用背景图片来修饰可得到我们想要的效果。
```css
input[type=text]::-ms-clear,input[type=tel]::-ms-clear,input[type=number]::-ms-clear{
display: none;
}
```

## 禁用 select 默认下拉箭头

::-ms-expand 适用于表单选择控件下拉箭头的修改，有多个属性值，设置它隐藏 (display:none) 并使用背景图片来修饰可得到我们想要的效果。
```css
select::-ms-expand {
display: none;
}
```

# 打电话发短信写邮件怎么实现

打电话,发短信(winphone系统无效),写邮件
```html
<a href="tel:0755-10086">打电话给:0755-10086</a>
<a href="sms:10086">发短信给: 10086</a>
<a href="mailto:peun@foxmail.com">peun@foxmail.com</a>
```

## 屏幕旋转的事件和样式
**事件**

window.orientation，取值：正负90表示横屏模式、0和180表现为竖屏模式；
```js
window.onorientationchange = function(){
    switch(window.orientation){
        case -90:
        case 90:
        alert("横屏:" + window.orientation);
        case 0:
        case 180:
        alert("竖屏:" + window.orientation);
        break;
    }
} 
```

**样式**

```css
//竖屏时使用的样式
@media all and (orientation:portrait) {
.css{}
}

//横屏时使用的样式
@media all and (orientation:landscape) {
.css{}
}
```

## audio元素和video元素在ios和andriod中无法自动播放

应对方案：触屏即播
```js
$('html').one('touchstart',function(){
    audio.play()
})
```

## 手机拍照和上传图片

<input type="file">的accept 属性

```html
<!-- 选择照片 -->
<input type=file accept="image/*">
<!-- 选择视频 -->
<input type=file accept="video/*">
```
使用总结：

ios 有拍照、录像、选取本地图片功能
部分android只有选取本地图片功能
winphone不支持
input控件默认外观丑陋

## 微信浏览器用户调整字体大小后页面矬了，怎么阻止用户调整
原因

android侧是复写了layoutinflater 对textview做了统一处理
ios侧是修改了body.style.webkitTextSizeAdjust值
解决方案：

android使用以下代码，该接口只在微信浏览器下有效(感谢jationhuang同学提供)
```js
/**
 * 页面加入这段代码可使Android机器页面不再受到用户字体缩放强制改变大小
 * 但是会有一个1秒左右的延迟，期间可以考虑通过loading展示
 * 仅供参考
 */
(function(){
    if (typeof(WeixinJSBridge) == "undefined") {
        document.addEventListener("WeixinJSBridgeReady", function (e) {
            setTimeout(function(){
                WeixinJSBridge.invoke('setFontSizeCallback',{"fontSize":0}, function(res) {
                    alert(JSON.stringify(res));
                });
            },0);
        });
    } else {
        setTimeout(function(){
            WeixinJSBridge.invoke('setFontSizeCallback',{"fontSize":0}, function(res) {
                alert(JSON.stringify(res));
            });
        },0);
    }
})();
```
ios使用-webkit-text-size-adjust禁止调整字体大小
body{-webkit-text-size-adjust: 100%!important;}
最好的解决方案：

整个页面用rem或者百分比布局


## 消除transition闪屏

网络都是这么写的，但我并没有测试出来

```css
.css{
/*设置内嵌的元素在 3D 空间如何呈现：保留 3D*/
-webkit-transform-style: preserve-3d;
/*（设置进行转换的元素的背面在面对用户时是否可见：隐藏）*/
-webkit-backface-visibility: hidden;
}
```

## 开启硬件加速

解决页面闪白
保证动画流畅
```css
.css {
   -webkit-transform: translate3d(0, 0, 0);
   -moz-transform: translate3d(0, 0, 0);
   -ms-transform: translate3d(0, 0, 0);
   transform: translate3d(0, 0, 0);
}
```

## input在ios下，输入的时候英文首字母的默认大写
```html
<input autocapitalize="off" autocorrect="off" />
```
## android 上去掉语音输入按钮
```css
input::-webkit-input-speech-button {display: none}
```

# 移动端使用框架
1. [zepto.js](http://zeptojs.com/)
2. [iscroll.js](http://cubiq.org/iscroll-5)
解决页面不支持弹性滚动，不支持fixed引起的问题~
实现下拉刷新，滑屏，缩放等功能~
3. [underscore.js](http://underscorejs.org/)

滑屏框架 [slip.js](https://github.com/peunzhang/slip.js) [iSlider.js](https://github.com/peunzhang/iSlider) [fullpage.js](https://github.com/peunzhang/fullpage) 
[swiper.js](http://www.swiper.com.cn/)

4. flex布局
flex布局目前可使用在移动中，并非所有的语法都全兼容，但以下写法笔者实践过，效果良好~

```css
/* ============================================================
   flex：定义布局为盒模型
   flex-v：盒模型垂直布局
   flex-1：子元素占据剩余的空间
   flex-align-center：子元素垂直居中
   flex-pack-center：子元素水平居中
   flex-pack-justify：子元素两端对齐
   兼容性：ios 4+、android 2.3+、winphone8+
   ============================================================ */
.flex{display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;}
.flex-v{-webkit-box-orient:vertical;-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}
.flex-1{-webkit-box-flex:1;-webkit-flex:1;-ms-flex:1;flex:1;}
.flex-align-center{-webkit-box-align:center;-webkit-align-items:center;-ms-flex-align:center;align-items:center;}
.flex-pack-center{-webkit-box-pack:center;-webkit-justify-content:center;-ms-flex-pack:center;justify-content:center;}
.flex-pack-justify{-webkit-box-pack:justify;-webkit-justify-content:space-between;-ms-flex-pack:justify;justify-content:space-between;}
```
实例: 两端对齐
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<meta content="email=no" name="format-detection">
<style type="text/css">
/* ============================================================
   flex：定义布局为盒模型
   flex-v：盒模型垂直布局
   flex-1：子元素占据剩余的空间
   flex-align-center：子元素垂直居中
   flex-pack-center：子元素水平居中
   flex-pack-justify：子元素两端对齐
   兼容性：ios 4+、android 2.3+、winphone8+
   ============================================================ */
.flex{display:-webkit-box;display:-webkit-flex;display:-ms-flexbox;display:flex;}
.flex-v{-webkit-box-orient:vertical;-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}
.flex-1{-webkit-box-flex:1;-webkit-flex:1;-ms-flex:1;flex:1;}
.flex-align-center{-webkit-box-align:center;-webkit-align-items:center;-ms-flex-align:center;align-items:center;}
.flex-pack-center{-webkit-box-pack:center;-webkit-justify-content:center;-ms-flex-pack:center;justify-content:center;}
.flex-pack-justify{-webkit-box-pack:justify;-webkit-justify-content:space-between;-ms-flex-pack:justify;justify-content:space-between;}
</style>
</head>
<body>

<div class="flex flex-pack-justify">
    <div>模块一</div>
    <div>模块二</div>
    <div>模块三</div>
    <div>模块四</div>
</div>

</body>
</html>
```

5. [FastClick](https://github.com/ftlabs/fastclick)

消除在移动浏览器上触发click事件与一个物理Tap(敲击)之间的300延迟

6. [Sea.js](http://seajs.org/)

提供简单、极致的模块化开发体验