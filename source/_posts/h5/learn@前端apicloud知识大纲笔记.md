---
title: 前端apicloud知识大纲笔记
---
# app前端布局

1. window
2. frame
3. fremegroup

# 布局方式
1. 头部+内容
2. 头部
3. 侧拉导航

# 布局元素
1. html
2. css
3. api模块

# 数据的交换
1. file
2. db <==sqlite
3. localStorage
4. perference :setPrets ,getPrets,removePrets
5. 云端一体 数据存储
6. api.ajax 服务器数据上传
> cookie session 无法在app中使用

# 网易新闻代码实现方法

# 使用的函数
1. api.openWin();
2. api.openFrame();
3. api.setRefreshHeaderInfo()   api.refreshHeaderLoadDone()


# 云端数据库使用


# 平台事件类型

1. 设备
电池电量：batterylow、batterystatus
物理按键：keyback、keymenu
音量按键：volumeup、volumedown
2. 网络
网络状态：online、offline
云服务状态：smartupdatefinish
3. 交互
手势：swipeup、swipedown、swipeleft、swiperight
滚动：scrolltobottom
点击：tap
长按：longpress
状态栏：noticeclicked
启动页：launchviewclicked
4. 窗口
窗口显示：viewappear
窗口隐藏：viewdisappear
5. 应用
回到前台：resume
进入后台：pause
被其他应用调用：appindent
6. 事件监听机制
添加监听：api.addEventListener()
删除监听：api.removeEventListener()
发送事件：api.sentEvent()
# APP与数据云API通信
1. 接口签名验证
appId   appKey  算法
2. 3种调用方式
    1. 标准 ajax 或 api.ajax
    2. APICloud mcm 模块：user，file，model，query等
    3. APICloud mcm JS框架：
            开源分支
            APICloud-rest.js
            SHA1.js
# 常用对话框窗口使用
1. 提示对话框
    api.alert()
    api.confirm()
    api.prompt()
    api.toast()
2. 状态对话框
    api.showProgress()
    api.hideProgress()
3. 选择对话框
    api.actionSheet()
    api.datePicker()