1、什么是Ognl？

OGNL（Object-Graphic Navigation Language）,对象图道行语言。是一种可以方便操作对象属性的开源表达式语言。

2、特点？

a、支持对象的方法调用，形式，eg：objName.methodName();

b、支持静态类的方法调用和值访问，expression：@[类全名（包括包路径）]@[方法名|值名]
eg：@tutorial.MyConstant@App_NAME;

c、支持赋值操作和表达式串联，eg：price=100，discount=80，calculatePrice（）//返回80？？？

d、访问OGNL上下文（OGNL context）和ActionContext

e、操作集合对象

3、使用OGNL表达式

1）“#”符号有三种用途

a、访问非根对象（struts中值栈为根对象），eg：OGNL上下文和Action上下文，#相当于ActionContext.getContext();下表有几个ActionContext中有用的属性：

名称   作用域 
eg
parameters reques session  application
#parameters.id[0]
#request.userName
#session.userName
#application.userName
b、用于过滤和投影

eg：books.{?#this.price>35} 

c、用于构建Map集合

在页面上取一个Map的值：

eg：<s:property value="#myMap['foo1']"/>
2）“%”符号的用途是在标签的属性被理解为字符串类型时，告诉执行环境%{}里的是OGNL表达式
3）“$”符号有两种用途
	在国际化资源文件中，引用OGNL表达式,在struts2配置文件中，引用OGNL表达式
<result type="redirect">listUser.action?msg=${msg}</result>