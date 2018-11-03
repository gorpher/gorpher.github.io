note@properties配置文件的几种读取方法
# A.在单纯的java项目中使用比较方便 （不包括web）
通过jdk提供的java.util.Properties类。
此类继承自java.util.HashTable，即实现了Map接口，所以，可使用相应的方法来操作属性文件，
但不建议使用像put、putAll这两个方法，因为put方法不仅允许存入String类型的value，
还可以存入Object类型的。因此java.util.Properties类提供了getProperty()和setProperty()方法来操作属性文件，
同时使用store或save(已过时)来保存属性值（把属性值写入.properties配置文件）。在使用之前，还需要加载属性文件，
它提供了两个方法：load和loadFromXML。
load有两个方法的重载：load(InputStream inStream)、load(Reader reader)，所以，可根据不同的方式来加载属性文件。
可根据不同的方式来获取InputStream，如：
1、通过当前类加载器的getResourceAsStream方法获取

```
	/**获取的是class的根路径下的文件 
     * 优点是：可以在非Web应用中读取配置资源信息，可以读取任意的资源文件信息 
     * 缺点：只能加载类classes下面的资源文件。 
     * 如果要加上路径的话：com/test/servlet/jdbc_connection.properties 
     */  
InputStream inStream = TestProperties.class.getClassLoader().getResourceAsStream("test.properties");  

```
2、从文件获取
```
InputStream inStream = new FileInputStream(new File("filePath"));  
```

3、也是通过类加载器来获取，和第一种一样
```
InputStream in = ClassLoader.getSystemResourceAsStream("filePath");  
```

4、在servlet中，还可以通过context来获取InputStream
```
InputStream in = context.getResourceAsStream("filePath");  
```

5、通过URL来获取
```
URL url = new URL("path");  
InputStream inStream = url.openStream();  
```
6、xml解析控制器
XmlParserHandler.class.getResourceAsStream 与classloader不同
使用的是当前类的相对路径
```
BufferedReader br=new BufferedReader(    
        new InputStreamReader(XmlParserHandler.class.    
                getResourceAsStream("./rain.xml"), "GB2312"));// ./代表当前目录不写也可以    
InputSource is=new InputSource(br);//数据源  
```

读取方法如下：
```
Properties prop = new Properties();  
prop.load(inStream);  
String key = prop.getProperty("username");  
//String key = (String) prop.get("username");  
```

# B.在servlet中常用
采用ServletContext读取，读取配置文件的realpath，然后通过文件流读取出来。
因为是用ServletContext读取文件路径，所以配置文件可以放入在web-info的classes目录中，
也可以在应用层级及web-info的目录中。文件存放位置具体在eclipse工程中的表现是：可以放在src下面，
也可放在web-info及webroot下面等。因为是读取出路径后，用文件流进行读取的，
所以可以读取任意的配置文件包括xml和properties。缺点：不能在servlet外面应用读取配置信息。
```
private void test1(HttpServletRequest request, HttpServletResponseresponse)
    throwsServletException,IOException {
       //response.setContentType("text/html;charset=utf-8");
       String path = "/WEB-INF/jdbc_connection.properties"; //读取WEB-INF中的配置文件
       String realPath = getServletContext().getRealPath(path);//getServletContext()相当于http://localhost/demo05
	   
		//所以后面的path只需要以应用demo/开头具体的部署目录路径即可，如上面的/web-in…
       System.out.println(realPath);
       InputStreamReader reader =new InputStreamReader(newFileInputStream(realPath),"utf-8");
	   
       Properties props = new Properties();
       props.load(reader); //load个人建议还是用Reader来读，因为reader体系中有个InputStreamReader可以指定编码
	   
       String jdbcConValue = props.getProperty("jdbc_con");
       System.out.println(jdbcConValue);
       System.out.println("加载src包下的资源------------------------");
	   
       path = "/WEB-INF/classes/com/test/servlet/jdbc_connection.properties"; //读取WEB-INF中的配置文件
        realPath=getServletContext().getRealPath(path);
       System.out.println(realPath);
       reader = new InputStreamReader(new FileInputStream(realPath),"utf-8");
       props.load(reader); //load个人建议还是用Reader来读，因为reader体系中有个InputStreamReader可以指定编码
       jdbcConValue = props.getProperty("jdbc_con");
       System.out.println("second::"+jdbcConValue);
      
}
```
# C.采用ResourceBundle类读取配置信息
优点是：可以以完全限定类名的方式加载资源后，直接的读取出来，且可以在非Web应用中读取资源文件。
缺点：只能加载类classes下面的资源文件且只能读取.properties文件。
```
/** 
 * 获取指定配置文件中所以的数据 
 * @param propertyName 
 *        调用方式： 
 *            1.配置文件放在resource源包下，不用加后缀 
 *              PropertiesUtil.getAllMessage("message"); 
 *            2.放在包里面的 
 *              PropertiesUtil.getAllMessage("com.test.message"); 
 * @return 
 */  
public static List<String> getAllMessage(String propertyName) {  
    // 获得资源包  
    ResourceBundle rb = ResourceBundle.getBundle(propertyName.trim());  
    // 通过资源包拿到所有的key  
    Enumeration<String> allKey = rb.getKeys();  
    // 遍历key 得到 value  
    List<String> valList = new ArrayList<String>();  
    while (allKey.hasMoreElements()) {  
        String key = allKey.nextElement();  
        String value = (String) rb.getString(key);  
        valList.add(value);  
    }  
    return valList;  
}  
```

# D.PropertiesLoaderUtils工具类
值得提醒的是
```



/** 
 * Spring 提供的 PropertiesLoaderUtils 允许您直接通过基于类路径的文件地址加载属性资源 
 * 最大的好处就是：实时加载配置文件，修改后立即生效，不必重启 
 */  
private static void springUtil(){  
    Properties props = new Properties();  
    while(true){  
        try {  
			//1.loadAllProperties直接使用路径
			//props = PropertiesLoaderUtils.loadAllProperties("E:/config.properties");
			
			//2.在classpath路径下
			//Resource resource = new ClassPathResource("config.properties");
			//props =PropertiesLoaderUtils.loadProperties(resource);
			
			 //在加载的class文件中加载，文件是和类文件放在一下的
			//ClassLoader loader =PropertiesUtil.class.getClassLoader();
			//InputStream inStream = loader.getResourceAsStream("config.properties");
			//props.load(inStream);
			
			
            //Resource resource = new ClassPathResource("config.properties");
			//PropertiesLoaderUtils.fillProperties(properties, resource);
			
			props=PropertiesLoaderUtils.loadAllProperties("message.properties");  
            
			
			for(Object key:props.keySet()){  
                System.out.print(key+":");  
                System.out.println(props.get(key));  
            }  
        } catch (IOException e) {  
            System.out.println(e.getMessage());  
        }  
          
        try {Thread.sleep(5000);} catch (InterruptedException e) {e.printStackTrace();}  
    }  
}  
```


# 下方是更改properties文件的方法可以参考

```
	/** 
     * 传递键值对的Map，更新properties文件 
     *  
     * @param fileName 
     *            文件名(放在resource源包目录下)，需要后缀 
     * @param keyValueMap 
     *            键值对Map 
     */  
    public static void updateProperties(String fileName,Map<String, String> keyValueMap) {  
        //getResource方法使用了utf-8对路径信息进行了编码，当路径中存在中文和空格时，他会对这些字符进行转换，这样，  
        //得到的往往不是我们想要的真实路径，在此，调用了URLDecoder的decode方法进行解码，以便得到原始的中文及空格路径。  
        String filePath = PropertiesUtil.class.getClassLoader().getResource(fileName).getFile();  
        Properties props = null;  
        BufferedWriter bw = null;  
  
        try {  
            filePath = URLDecoder.decode(filePath,"utf-8");      
            log.debug("updateProperties propertiesPath:" + filePath);  
            props = PropertiesLoaderUtils.loadProperties(new ClassPathResource(fileName));  
            log.debug("updateProperties old:"+props);  
              
            // 写入属性文件  
            bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath)));  
              
            props.clear();// 清空旧的文件  
              
            for (String key : keyValueMap.keySet())  
                props.setProperty(key, keyValueMap.get(key));  
              
            log.debug("updateProperties new:"+props);  
            props.store(bw, "");  
        } catch (IOException e) {  
            log.error(e.getMessage());  
        } finally {  
            try {  
                bw.close();  
            } catch (IOException e) {  
                e.printStackTrace();  
            }  
        }  
    }  
```

来源其他博客配置方法

matos：一下还有很多没有弄明白
实际项目中，通常将一些可配置的定制信息放到属性文件中（如数据库连接信息，邮件发送配置信息等），

便于统一配置管理。例中将需配置的属性信息放在属性文件/WEB-INF/configInfo.properties中。 
# 利用java源文件配置
其中部分配置信息（邮件发送相关）： 
Java代码  

  1. #邮件发送的相关配置  
  2. email.host = smtp.163.com  
  3. email.port = xxx  
  4. email.username = xxx  
  5. email.password = xxx  
  6. email.sendFrom = xxx@163.com  

在Spring容器启动时，使用内置bean对属性文件信息进行加载，在bean.xml中添加如下： 
Xml代码  

  1. <beanid="propertyConfigurer"
  2. class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
  3. <propertyname="location">
  4. <value>/WEB-INF/configInfo.properties</value>
  5. property>
  6. <propertyname="fileEncoding"value="utf-8"/>
  7. bean>

属性信息加载后其中一种使用方式是在其它bean定义中直接根据属性信息的key引用value，如邮件发送器bean的配置如下： 
Xml代码  

  1. <bean id="mailSender"
  2. class="org.springframework.mail.javamail.JavaMailSenderImpl">
  3. <property name="host">
  4. <value>${email.host}<\value>
  5. </property>
  6. <property name="port">
  7. <value>${email.port}<\value>
  8. </property>
  9. <propertyname="username">
  10. <value>${email.username}<\value>
  11. </property>
  12. <propertyname="password">
  13. <value>${email.password}<\value>
  14. </property>
  15. <property name="javaMail </Properties">
  16. <props>
  17. <prop key="mail.smtp.auth">true </prop>
  18. <prop key="sendFrom">${email.sendFrom}</prop>
  19. </props>
  20. </property>
  21. </bean>

另一种使用方式是在代码中获取配置的属性信息，可定义一个javabean：ConfigInfo.java，利用注解将代码中需要使用的属性信息注入；如属性文件中有如下信息需在代码中获取使用： 
Java代码  

  1. #生成文件的保存路径  
  2. file.savePath = D:/test/  
  3. #生成文件的备份路径，使用后将对应文件移到该目录  
  4. file.backupPath = D:/test bak/  

ConfigInfo.java 中对应代码： 
Java代码  

  1. @Component("configInfo")  
  2. publicclass ConfigInfo {  
  3. @Value("${file.savePath}")  
  4. private String fileSavePath;  
  5. @Value("${file.backupPath}")  
  6. private String fileBakPath;  
  7. public String getFileSavePath() {  
  8. return fileSavePath;  
  9.     }  
  10. public String getFileBakPath() {  
  11. return fileBakPath;  
  12.     }      
  13. }  

业务类bo中使用注解注入ConfigInfo对象： 
Java代码  

  1. @Autowired
  2. private ConfigInfo configInfo;  

需在bean.xml中添加组件扫描器，用于注解方式的自动注入： 
Xml代码  

  1. <context:component-scanbase-package="com.my.model"/>
（上述包model中包含了ConfigInfo类）。 

第三种方法是：通过把properties文件配置在spring的propertyConfigure中后，通过bean来指定某个Java类然后把properties里面某些内容作为参数传给指定的那个Java类。代码如下：
（1），spring配置文件：

  1. <!-- 配置属性文件 -->  
  2.     <bean id="propertyConfigurer" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">  
  3.         <property name="location">  
  4.             <value>classpath:jdbc.properties</value>  
  5.         </property>  
  6.     </bean>  
  7. <!-- 从这个类中把属性文件某个内容参数传进去给Java代码 -->  
  8.     <bean id="Rss" class="com.rss.RssTimerTasks">  
  9.         <property name="path" value='${path}'/>  
  10.         <property name="top" value='${top}'/>  
  11.     </bean>  
（2）jdbc.properties文件：

  1. jdbc.driverClass=com.mysql.jdbc.Driver  
  2. jdbc.url=jdbc:mysql://localhost:3306/test4  
  3.   
  4. jdbc.username=root  
  5. jdbc.password=123456  
  6.   
  7. pool.c3p0.acquire_increment=3  
  8. pool.c3p0.max_size=15  
  9. pool.c3p0.min_size=1  
  10. pool.c3p0.init_size=3  
  11.   
  12. #(ms)  
  13. pool.c3p0.max_idel_time=60  
  14.   
  15. #rss,log path  
  16. path=F\:\\jsp\\rss  
  17. #rss top  
  18. top=10  
  19. #path=D:\\hosts\\dukai100861671\\webapps\\ROOT  
(3),spring配置文件中要传参给指定的Java类：com.rss.RssTimerTasks

  1. <pre name="code" class="java">
  2. package com.rss;  
  3.   
  4. import java.util.TimerTask;  
  5.   
  6. import org.springframework.beans.factory.annotation.Autowired;  
  7.   
  8. import com.server.AlbumServer;  
  9. import com.server.ArticleServer;  
  10.   
  11. public class RssTimerTasks extends TimerTask{  
  12.   
  13.     @Autowired ArticleServer articleServer;  
  14.     @Autowired AlbumServer albumServer;  
  15.       
  16.     private String path;  
  17.     private int top;  
  18.       
  19.     public void run() {  
  20.         RssAction rss=new RssAction();//生成rss  
  21.         try {  
  22.             rss.testBuildObject(articleServer.getLatestArticle(top),  
  23.                                 null,  
  24.                                 path);  
  25.         } catch (Exception e) {  
  26.             e.printStackTrace();  
  27.         }  
  28.     }  
  29.   
  30.     public void setPath(String path) {  
  31.         this.path = path;  
  32.     }  
  33.   
  34.     public void setTop(int top) {  
  35.         this.top = top;  
  36.     }  
  37.       
  38. }  

这样子，完全不用在Java代码中暴露丑陋的文件路径，不管多少个带有路径参数的方法，都可以直接使用一个参数代替指定的路径。

通过get方法获取对应的属性信息，优点是代码中使用方便，缺点是如果代码中需用到新的属性信息，需对ConfigInfo.java做相应的添加修改。

配置上自己使用的注解读取配置文件  缺点：只能读取classpath 下的  

```
@Configuration
@ImportResource("classpath:/com/acme/properties-config.xml")  //此方式只能导入xml配置文件
public class AppConfig {
@Value("${jdbc.url}")
private String url;
@Value("${jdbc.username}")
private String username;
@Value("${jdbc.password}")
private String password;
@Bean
public DataSource dataSource() {
return new DriverManagerDataSource(url, username, password);
}
}
```
跟以上使用相同
```
properties-config.xml
<beans>
<context:property-placeholder location="classpath:/com/acme/jdbc.properties"/>
</beans>
````

