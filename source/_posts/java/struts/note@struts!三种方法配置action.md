1. 直接使用action!name="?"的值与访问路径对应
2. 设置访问路径：ActionName!方法名 
	一个模块一个action类，一个功能一个方法，一个action元素对应一个action的类
3.通配符*:[actionName]_[methodName] 表示:action_*
	一个模块一个action类，一个功能一个方法，一个action元素对应一个action的类	
4.也是通配符的方式：个模块一个action类，一个功能一个方法
  <action name="*_*" class="{1}Action" method="{2}">	
配置常量的两种方式：
1.利用actio.properties文件存储键值队的方式
2.利用Struts.xml的struts标签中加上一句<consteant name="" value=""></constant>
	在struts核心jar包里面有个default.properties文件，里面配置了很多常量
这里引入default.properties的中文版，供参考

#struts.mapper.class=org.apache.struts2.dispatcher.mapper.DefaultActionMapper
### 指定action的后缀，默认为action
struts.action.extension=action

### 被 FilterDispatcher使用
### 如果为 true 则通过jar文件提供静态内容服务.
### 如果为 false 则静态内容必须位于 <context_path>/struts
struts.serve.static=true

### 被 FilterDispatcher使用
### 指定浏览器是否缓存静态内容，测试阶段设置为false，发布阶段设置为true.
struts.serve.static.browserCache=true

### 设置是否支持动态方法调用，true为支持，false不支持.
struts.enable.DynamicMethodInvocation = true

### 设置是否可以在action中使用斜线，默认为false不可以，想使用需设置为true.
struts.enable.SlashesInActionNames = false

### 是否允许使用表达式语法，默认为true.
struts.tag.altSyntax=true

### 设置当struts.xml文件改动时，是否重新加载.
### - struts.configuration.xml.reload = true
### 设置struts是否为开发模式，默认为false,测试阶段一般设为true.
struts.devMode = false

### 设置是否每次请求，都重新加载资源文件，默认值为false.
struts.i18n.reload=false

###标准的UI主题
### 默认的UI主题为xhtml,可以为simple,xhtml或ajax
struts.ui.theme=xhtml
###模板目录
struts.ui.templateDir=template
# 设置模板类型. 可以为 ftl, vm, or jsp
struts.ui.templateSuffix=ftl

###定位velocity.properties 文件.  默认 velocity.properties
struts.velocity.configfile = velocity.properties

### 设置velocity的context.
struts.velocity.contexts =

### 定位toolbox.
struts.velocity.toolboxlocation=

### 指定web应用的端口.
struts.url.http.port = 80
### 指定加密端口
struts.url.https.port = 443
### 设置生成url时，是否包含参数.值可以为: none, get or all
struts.url.includeParams = get

### 设置要加载的国际化资源文件，以逗号分隔.
# struts.custom.i18n.resources=testmessages,testmessages2

### 对于一些web应用服务器不能处理HttpServletRequest.getParameterMap()
### 像 WebLogic, Orion, and OC4J等，须设置成true,默认为false.
struts.dispatcher.parametersWorkaround = false

### 指定freemarker管理器
#struts.freemarker.manager.classname=org.apache.struts2.views.freemarker.FreemarkerManager

### 设置是否对freemarker的模板设置缓存
### 效果相当于把template拷贝到 WEB_APP/templates.
struts.freemarker.templatesCache=false

### 通常不需要修改此属性.
struts.freemarker.wrapper.altMap=true

### 指定xslt result是否使用样式表缓存.开发阶段设为true,发布阶段设为false.
struts.xslt.nocache=false

### 设置struts自动加载的文件列表.
struts.configuration.files=struts-default.xml,struts-plugin.xml,struts.xml

### 设定是否一直在最后一个slash之前的任何位置选定namespace.
struts.mapper.alwaysSelectFullNamespace=false
