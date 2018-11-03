##这是一个登陆拦截器
#1.web.xml文件正常配置struts过滤器
#2.Struts.xml文件配置
```
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE struts PUBLIC "-//Apache Software Foundation//DTD Struts Configuration 2.1//EN" "http://struts.apache.org/dtds/struts-2.1.dtd">
<struts>
	<constant name="struts.devMode" value="true"></constant>
 	<package name="default" extends="struts-default" namespace="/">
 	<!--配置拦截器容器	-->
 		<interceptors>
		<interceptor name="lointer"
				class="com.houpu.max.intercepter.LoginInterceptor"></interceptor>
		</interceptors>
		<global-results>
			<result name="error">error.jsp</result>
			<result name="success">index.jsp</result>
		</global-results>
		<action name="main_*" class="com.houpu.max.action.Main" method="{1}">
		<!-- 引用默认的拦截器 -->
			<interceptor-ref name="defaultStack"></interceptor-ref>
		<!-- 引用自己定义的拦截器 -->
			<interceptor-ref name="lointer">
				<param name="includeMethods">add,delete</param>
			</interceptor-ref>
		</action>
		<action name="login" class="com.houpu.max.action.UserAction"></action>
	</package>
</struts>    
```
#3.action方法
```
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class LoginInterceptor implements Interceptor {
	public void destroy() {
	System.out.println("my拦截器泡汤了");
	}
	public void init() {
	}
	public String intercept(ActionInvocation arg0) throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		System.out.println("判断登陆的验证前");
		Object ob = session.get("loginUser");
		if (ob == null) {
			return "error";
		}
		String rs = arg0.invoke();  //主要是actionInvaocation的invoke方法
		System.out.println("判断登陆验证后");
		return rs;
	}

}

```

