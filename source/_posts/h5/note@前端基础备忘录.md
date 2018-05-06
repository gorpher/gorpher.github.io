---
title: web前端基础知识备忘录
date: {{date}}
categories: note
tags: 
- h5
---
# 关于前端一些html css js  基础相关知识

## CSS/CSS3长度、时间、频率、角度

### 一、CSS长度值
em	相对于父元素的字体大小
ex	相对于小写字母"x"的高度
gd	一般用在东亚字体排版上，这个与英文并无关系
rem	相对于根元素字体大小
vw	相对于视窗的宽度：视窗宽度是100vw
vh	相对于视窗的高度：视窗高度是100vh
vm	相对于视窗的宽度或高度，取决于哪个更小
ch	相对于0尺寸
px	相对于屏幕分辨率而不是视窗大小：通常为1个点或1/72英寸
in	inch, 表英寸
cm	centimeter, 表厘米
mm	millimeter, 表毫米
pt	1/72英寸
pc	12点活字，或1/12点
%	相对于父元素。正常情况下是通过属性定义自身或其他元素

### 二、时间、频率、角度
deg	degrees, 角度
grad	grads, 百分度
rad	radians, 弧度
turn	turns, 圈数
ms	milliseconds, 毫秒数
s	seconds, 秒数
Hz	Hertz, 赫兹
kHz	kilohertz, 千赫

**动态高度**
```css
min-height:calc(100vh + 51px);
```
**导入自定义字体**
```css
/*定义字体*/
@font-face{

    font-family: matos;/* family name*/
    src:url(fonts/glyphicons.woff),     /*网页标准字体*/
        url(fonts/glyphicons.ttf),     /*apple 和ms 共同推出的字体格式*/
        url(fonts/glyphicons.eot),      /* 支持老版本ie字体*/
        url(fonts/glyphicons.svg),      /* 可变矢量图字体  scalable vector graphics*/
}

/* 使用字体*/
p{
    font-family:matos;
}
```
