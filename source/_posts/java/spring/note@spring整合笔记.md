ssh整合笔记
思路：每个框架先搭好，在整合，将Struts要使用方法和sessionFactory注入IOC。
Struts框架
【第一步】
1.导入jar包-->找到Struts官方源码文件夹，到apps文件夹下选择需要的war文件解压（一般选择Struts2-blank.war）将该文件解压
2.配置web.xml-->filter核心控制器 可以在blank解压的web.xml中找到
3.配置Struts.xml--> 可以将了blank文件夹下的Struts.xml拷贝使用（具体写action跳转省略）
【第二步】
1.写action类继承ActionSupport 
2.配置Struts.xml文件跳转
3.测试一波
Hibernate框架
【第一步】
1.导入jar包--> 找到Hibernate官方源码文件，需要hibernate.jar 和lib->required下的所有jar 还有一个jpa文件夹下的jpa.jar (jdbc的jar包)
2.配置hibernat.cfg.xml -->可以去官方api文档中找到cfg配置头文件等相关配置
3.配置*.hbm.xml --关于实体类orm影射配置 也可以去官方文档中找 （建议自己备份一份模板）
【第二步】
1.写hibernateUtil工具类-->>官方文档有配置说明
2.测试一波
spring框架
【第一步】
1.导入jar --找到hibernate官方源码文件，需要的jar：（如果觉得麻烦可以使用全部的发行jar） 一般导入这几个就够用了
            aop，bean，context，core，expression，jdbc，orm，tx,web
2.配置applicationContext.xml-->也在官方文档中有些，但选择可以支持注解的xsd
3.测试注入一波（以上是使用spring框架基本配置）
整合：
【第一步】
1.导入jar包-->去Struts文档中拷贝Struts-spring-plugin-**.jar 有的可能还需要commons-dbcp-1.4.jar和 commons-pool-1.6.jar
2.配置web.xml-->>可以去Struts文档去找集成spring的web配置
也可以直接web加上
	<!-- 指定要加载的Spring核心配置文件 最好放在其他配置上面-->
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>classpath:applicationContext*.xml</param-value>
	</context-param>
	
	</filter-mapping>
	<!-- 加载spring context监听器 -->
	   <listener>
        <listener-class>
            org.springframework.web.context.ContextLoaderListener
        </listener-class>
    </listener>
3.配置applicationContext.xml -->>这个也在Struts官方文档中有配置
也可以直接applicationContext加上
<context:annotation-config />
	<!-- 配置注入action 实例化action类 -->
	<bean id="userAction" class="com.houpu.max.action.UserAction" />
	<!-- 配置业务实现接口 -->
	<bean id="userService" class="com.houpu.max.service.impl.UserServiceImpl" />

<!-- 配置数据源 -->
	<bean id="dataSource"
		class="org.springframework.jdbc.datasource.DriverManagerDataSource">
		<property name="driverClassName" value="oracle.jdbc.driver.OracleDriver" />
		<property name="url" value="jdbc:oracle:thin:@127.0.0.1:1521:orcl" />
		<property name="username" value="scott" />
		<property name="password" value="tiger" />
	</bean>
	<!-- 通过注入方式生成sessionFactory -->
	<bean id="sessionFactory"
		class="org.springframework.orm.hibernate3.LocalSessionFactoryBean">
		<property name="dataSource" ref="dataSource" />
		<property name="mappingResources">
			<list>
				<value>com/houpu/max/entity/User.hbm.xml</value>
				<value>com/houpu/max/entity/Emp.hbm.xml</value>
			</list>
		</property>
		<property name="hibernateProperties">
			<value>
				hibernate.dialect=org.hibernate.dialect.Oracle10gDialect
				hibernate.show_sql=true
				hibernate.current_session_context_class=thread
			</value>
		</property>
	</bean>
4.配置注解注入类
通过@Aatowired注解将action使用方法注入到IOC容器中
通过@Aatowired注解将sessionFactory注入到IOC容器中
就完成了SSH集成
@Autowired
	private UserService userService;
@Autowired
	private SessionFactory sessionFactory;

