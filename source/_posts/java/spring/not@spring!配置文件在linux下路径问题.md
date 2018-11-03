
#  普通java程序获取路径
```
Thread.currentThread().getContextClassLoader().getResource("/").toURI().getPath()
null

Thread.currentThread().getContextClassLoader().getResource("").toURI().getPath()
/D:/workspace/EPEducationManager/build/classes/

UserResource.class.getClassLoader().getResource("/").toURI().getPath()
null

UserResource.class.getClassLoader().getResource("").toURI().getPath()
/D:/workspace/EPEducationManager/build/classes/

UserResource.class.getResource("").toURI().getPath()
/D:/workspace/EPEducationManager/build/classes/com/phy/em/user/rest/

UserResource.class.getResource("/").toURI().getPath()
/D:/workspace/EPEducationManager/build/classes/

System.getProperty("user.dir")
D:\workspace\EPEducationManager
```

# 在java web中获取路径
```

Thread.currentThread().getContextClassLoader().getResource("/").toURI().getPath()
/D:/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/EPEducationManager/WEB-INF/classes/

Thread.currentThread().getContextClassLoader().getResource("").toURI().getPath()
/C:/tomcat7/lib/

UserResource.class.getClassLoader().getResource("/").toURI().getPath()
/D:/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/EPEducationManager/WEB-INF/classes/

UserResource.class.getClassLoader().getResource("").toURI().getPath()
/C:/tomcat7/lib/

UserResource.class.getResource("").toURI().getPath()
/D:/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/EPEducationManager/WEB-INF/classes/com/phy/em/user/rest/

UserResource.class.getResource("/").toURI().getPath()
/C:/tomcat7/lib/

System.getProperty("user.dir")
C:\Program Files (x86)\eclipse
```

# 使用spring读取配置文件

在xml中读取

```
<bean id=”propertyConfigurer” class=”org.springframework.beans.factory.config.PropertyPlaceholderConfigurer”>
　　<property name=”location”>
　　　　<value>/WEB-INF/configInfo.properties</value>
　　</property>
　　<property name=”fileEncoding” value=”utf-8″ />
</bean>
````
# 在xml中使用

```
<property name=”host”>
　　<value>${email.host}</value>
</property>
<property name=”port”>
　　<value>${email.port}</value>
</property>
```
通过以上两步就可以完成在读取property配置文件并注入到对应的bean中，但是有时候我们并不需要为了读取配置而创建一个bean，我们只想代码中直接读取配置文件，可以使用如下的方式

```
ResourceUtils.getFile("classpath:config.properties").getPath()
D:\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\EPEducationManager\WEB-INF\classes\
```

可以直接在代码中使用"classpath"来定位配置文件，获取得到的是一个File对象，当然了获取路径肯定没问题