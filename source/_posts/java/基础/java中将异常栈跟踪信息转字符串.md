---

title: java中将异常栈跟踪信息转字符串
date: {{ date }}
categories: learn
tags: [java]
banner: http://img.matosiki.site/sky/20180515.jpg
thumbnail : http://img.matosiki.site/sky/20180514.jpg
---

# 1. 使用原生java代码
```java
StringWriter sw = new StringWriter();
PrintWriter pw = new PrintWriter(sw);
e.printStackTrace(pw);
```

# 2. 使用**Common lang**工具在类
```java
String stacktrace = ExceptionUtils.getStacktrace(e);
```

总结 获取跟踪栈异常默认不能用String,在java9中添加了**StackWalking API**支持栈异常跟踪
