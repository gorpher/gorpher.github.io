note@spring 提供的基础工具类使用

# 文件操作

## 加载文件资源
	Spring 定义了一个 org.springframework.core.io.Resource 接口，
	Resource 接口是为了统一各种类型不同的资源而定义的，Spring 提供了若干 Resource 接口的实现类，
	这些实现类可以轻松地加载不同类型的底层资源，并提供了获取文件名、URL 地址以及资源内容的操作方法。
## 访问文件资源
	假设有一个文件地位于 Web 应用的类路径下，您可以通过以下方式对这个文件资源进行访问：
	通过 FileSystemResource 以文件系统绝对路径的方式进行访问；
	通过 ClassPathResource 以类路径的方式进行访问；
	通过 ServletContextResource 以相对于 Web 应用根目录的方式进行访问。
	
--- 
在 Web 应用中，您还可以通过 ServletContextResource 以相对于 Web 应用根目录的方式访问文件资源，如下所示：
```
	<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>   
	<jsp:directive.page import="org.springframework.web.context.support.ServletContextResource"/>   
	<jsp:directive.page import="org.springframework.core.io.Resource"/>   
	<%   
	   // ① 注意文件资源地址以相对于 Web 应用根路径的方式表示  
	   Resource res3 = new ServletContextResource(application,"/WEB-INF/classes/conf/file1.txt");   
	   out.print(res3.getFilename());   
	%>   
```
## ResourceUtils 工具类，它支持“classpath:”和“file:”的地址前缀，它能够从指定的地址加载文件资源
``` 
 import java.io.File;   
 import org.springframework.util.ResourceUtils;   
 public class ResourceUtilsExample {   
    public static void main(String[] args) throws Throwable{   
        File clsFile = ResourceUtils.getFile("classpath:conf/file1.txt");   
        System.out.println(clsFile.isFile());   
   
        String httpFilePath = "file:D:/masterSpring/chapter23/src/conf/file1.txt";   
        File httpFile = ResourceUtils.getFile(httpFilePath);   
        System.out.println(httpFile.isFile());          
    }   
 }   
```
## 本地化文件资源
```
 import java.util.Locale;   
 import org.springframework.core.io.Resource;   
 import org.springframework.core.io.support.LocalizedResourceHelper;   
 public class LocaleResourceTest {   
    public static void main(String[] args) {   
        LocalizedResourceHelper lrHalper = new LocalizedResourceHelper();   
        // ① 获取对应美国的本地化文件资源  
        Resource msg_us = lrHalper.findLocalizedResource("i18n/message", ".properties",   
        Locale.US);   
        // ② 获取对应中国大陆的本地化文件资源  
        Resource msg_cn = lrHalper.findLocalizedResource("i18n/message", ".properties",   
        Locale.CHINA);   
        System.out.println("fileName(us):"+msg_us.getFilename());   
        System.out.println("fileName(cn):"+msg_cn.getFilename());   
    }   
 }   
```

## 文件内容拷贝
第一个我们要认识的是 FileCopyUtils，它提供了许多一步式的静态操作方法，
能够将文件内容拷贝到一个目标 byte[]、String 甚至一个输出流或输出文件中。
下面的实例展示了 FileCopyUtils 具体使用方法：
```
 import java.io.ByteArrayOutputStream;   
 import java.io.File;   
 import java.io.FileReader;   
 import java.io.OutputStream;   
 import org.springframework.core.io.ClassPathResource;   
 import org.springframework.core.io.Resource;   
 import org.springframework.util.FileCopyUtils;   
 public class FileCopyUtilsExample {   
    public static void main(String[] args) throws Throwable {   
        Resource res = new ClassPathResource("conf/file1.txt");   
        // ① 将文件内容拷贝到一个 byte[] 中  
        byte[] fileData = FileCopyUtils.copyToByteArray(res.getFile());   
        // ② 将文件内容拷贝到一个 String 中  
        String fileStr = FileCopyUtils.copyToString(new FileReader(res.getFile()));   
        // ③ 将文件内容拷贝到另一个目标文件  
        FileCopyUtils.copy(res.getFile(),   
        new File(res.getFile().getParent()+ "/file2.txt"));   
   
        // ④ 将文件内容拷贝到一个输出流中  
        OutputStream os = new ByteArrayOutputStream();   
        FileCopyUtils.copy(res.getInputStream(), os);   
    }   
 }   
   
```
## Spring 提供的 PropertiesLoaderUtils 允许您直接通过基于类路径的文件地址加载属性资源
```
import java.util.Properties;   
import org.springframework.core.io.support.PropertiesLoaderUtils;   
public class PropertiesLoaderUtilsExample {   
   public static void main(String[] args) throws Throwable {      
       // ① jdbc.properties 是位于类路径下的文件  
       Properties props = PropertiesLoaderUtils.loadAllProperties("jdbc.properties");   
       System.out.println(props.getProperty("jdbc.driverClassName"));   
   }   
}   
```
## 如果文件资源采用了特殊的编码格式（如 UTF-8），
则在读取资源内容时必须事先通过 EncodedResource 指定编码格式，
否则将会产生中文乱码的问题。
```
import org.springframework.core.io.ClassPathResource;   
import org.springframework.core.io.Resource;   
import org.springframework.core.io.support.EncodedResource;   
import org.springframework.util.FileCopyUtils;   
public class EncodedResourceExample {   
       public static void main(String[] args) throws Throwable  {   
           Resource res = new ClassPathResource("conf/file1.txt");   
           // ① 指定文件资源对应的编码格式（UTF-8）  
           EncodedResource encRes = new EncodedResource(res,"UTF-8");   
           // ② 这样才能正确读取文件的内容，而不会出现乱码  
           String content  = FileCopyUtils.copyToString(encRes.getReader());   
           System.out.println(content);    
   }   
} 
```
## 操作 Servlet API 的工具类
```
//WebApplicationContext wac =WebApplicationContextUtils.getWebApplicationContext(servletContext);   
WebApplicationContext wac = (WebApplicationContext) servletContext
							.getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
```
## WebUtils
使用 WebUtils 从 HttpSession 中获取属性对象
```
protected Object formBackingObject(HttpServletRequest request) throws Exception {   
   UserSession userSession = (UserSession) WebUtils.getSessionAttribute(request,   
       "userSession");   
   if (userSession != null) {   
       return new AccountForm(this.petStore.getAccount(   
       userSession.getAccount().getUsername()));   
   } else {   
       return new AccountForm();   
   }   
}  
```


Spring 所提供的过滤器和监听器
Spring 为 Web 应用提供了几个过滤器和监听器，在适合的时间使用它们，可以解决一些常见的 Web 应用问题。
延迟加载过滤器
Hibernate 允许对关联对象、属性进行延迟加载，但是必须保证延迟加载的操作限于同一个 Hibernate Session 范围之内进行。
如果 Service 层返回一个启用了延迟加载功能的领域对象给 Web 层，当 Web 层访问到那些需要延迟加载的数据时，
由于加载领域对象的 Hibernate Session 已经关闭，这些导致延迟加载数据的访问异常。
Spring 为此专门提供了一个 OpenSessionInViewFilter 过滤器，
它的主要功能是使每个请求过程绑定一个 Hibernate Session，
即使最初的事务已经完成了，也可以在 Web 层进行延迟加载的操作。

OpenSessionInViewFilter 过滤器将 Hibernate Session 绑定到请求线程中，
它将自动被 Spring 的事务管理器探测到。
所以 OpenSessionInViewFilter 适用于 Service 层使用 
HibernateTransactionManager 或 JtaTransactionManager 进行事务管理的环境，
也可以用于非事务只读的数据操作中。
要启用这个过滤器，必须在 web.xml 中对此进行配置：
```
 <filter>   
    <filter-name>hibernateFilter</filter-name>   
    <filter-class>   
    org.springframework.orm.hibernate3.support.OpenSessionInViewFilter   
    </filter-class>   
 </filter>   
 <filter-mapping>   
    <filter-name>hibernateFilter</filter-name>   
    <url-pattern>*.html</url-pattern>   
 </filter-mapping> 
```
## 中文乱码过滤器
```
<web-app>   
<!---listener 的配置 -->   
<filter>   
   <filter-name>encodingFilter</filter-name>   
   <filter-class>   
       org.springframework.web.filter.CharacterEncodingFilter ① Spring 编辑过滤器  
   </filter-class>   
   <init-param> ② 编码方式  
       <param-name>encoding</param-name>   
       <param-value>UTF-8</param-value>   
   </init-param>   
   <init-param> ③ 强制进行编码转换  
       <param-name>forceEncoding</param-name>   
       <param-value>true</param-value>   
   </init-param>   
   </filter>   
   <filter-mapping> ② 过滤器的匹配 URL   
       <filter-name>encodingFilter</filter-name>   
       <url-pattern>*.html</url-pattern>   
   </filter-mapping>   
  
<!---servlet 的配置 -->   
</web-app>   
```
## 请求跟踪日志过滤器
 WebAppRootListener 监听器配置
 ```
 <context-param>   
    <param-name>webAppRootKey</param-name>   
    <param-value>baobaotao.root</param-value> ① Web 应用根目录以该属性名添加到系统参数中  
 </context-param>   
 ```
 ```
 <listener>   
   <listener-class>   
   org.springframework.web.util.WebAppRootListener   
   </listener-class>   
</listener>   
 ```
 
 另一个专门用于 Log4J 的监听器是 Log4jConfigListener。
 一般情况下，您必须将 Log4J 日志配置文件以 log4j.properties 为文件名并保存在类路径下。
 Log4jConfigListener 允许您通过 log4jConfigLocation Servlet 上下文参数显式指定 Log4J 配置文件的地址，
 如下所示：
 ```
 <context-param>   
   <param-name>log4jConfigLocation</param-name>   
   <param-value>/WEB-INF/log4j.properties</param-value>   
</context-param> 
 ```
 ```
 <listener>   
   <listener-class>   
   org.springframework.web.util.Log4jConfigListener   
   </listener-class>   
</listener> 
 ```
 当您使用 Log4jConfigListener 后，就没有必须再使用 WebAppRootListener 了。
 
 Introspector 缓存清除监听器
 
 仅需在 web.xml 中配置 IntrospectorCleanupListener 监听器就可以了：
 ```
 <listener>   
   <listener-class>   
   org.springframework.web.util.IntrospectorCleanupListener   
   </listener-class>   
</listener>  
 ```
 
# spring配置装载properties文件

在xml中读取
```
<bean id=”propertyConfigurer” class=”org.springframework.beans.factory.config.PropertyPlaceholderConfigurer”>
　　<property name=”location”>
　　　　<value>/WEB-INF/configInfo.properties</value>
　　</property>
　　<property name=”fileEncoding” value=”utf-8″ />
</bean>
```
在xml中使用
```
<property name=”host”>
　　<value>${email.host}</value>
</property>
<property name=”port”>
　　<value>${email.port}</value>
</property>
```