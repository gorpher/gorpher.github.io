note@hibernate！常见错误
no bean specialed.
出错了，jsp页面报错。
原因是html:select 标签 中 option bean is null/.

Set不能加同一实体
在保存数据的时候循环添加一PO数据到Set,居然最后Set的size()为1。各实体设置不同数据啊，只是没Id.
原因是这个PO以前自己实现了Comparable .只比较Id,

HibernateSystemException: SQL insert,update or delete failed
hibernate级联保存或更新时可能会出这个错误
原因是由于子实体的主键设置了不符合保存更新的数据.

No persister for错误
这个错误说的是no persister for java.lang.Integer;
映射文件未添加肯定不是这个问题了。
那只有映射文件出错。
锁定了关联的id;
PO里面写的关联ID，而建表看不出问题。而且映射文件里面基本上看不出来。
出现No persister for错误后一般是3个情况： 
1hbm.xml文件特殊类未制定类型。 
2cfg.xml文件未添加类的hbm.xml文件名。 
3PO和 hbm类映射不匹配。

net.sf.hibernate.LazyInitializationException: Failed to lazily initialize a collection - no session or session was closed
hibernate最常见错误.
Lazy为true
session关闭后调用延迟加载属性．

在session关闭之前如果调用该属性，会加载．
或者是使用Hibernate.Initalize();

BigDecimal对象属性映射出错
这个问题是不小心造成的.
属性映射应该加上 length="2"指定2位小数,或者几位小数,小数位数在0-19之间

property value with CGLIB 错误
比较常见的hibernate错误了.
当PO属性为原始类型(int,double...)时,数据库纪录为null,调出PO时由于这些属性必须有值而出现错误.

把属性值设置为对象属性解决.

hibernate出错
在configure.buildSessionFactory()时java.nullpointException.
在eclipse里没问题，但部署在tomcat里就出问题了，
是由于包冲突了。
还有个可能就是configure(path),path不对。

是由于eclipse的class loader和tomcat不同，在tomcat里，不能有两个一样一起加载。
eclipse里却是指定jar的。

常见错误： 
Caused by: org.dom4j.DocumentException: Invalid byte 2 of 2-byte UTF-8 sequence. Nested exception: Invalid byte 2 of 2-byte UTF-8 sequence.

如果出现这行错误说明你的xml配置文件有不规范的字符，检查下。

net.sf.hibernate.MappingException: Error reading resource: hibernate/Hello_Bean.hbm.xml


如果出现这行错误说明你的hibernate的XML配置文件有错

net.sf.hibernate.MappingException: Resource: hibernate/Hello_Bean.hbm.xml not found


如果出现这行错误说明hibernate的XML配置文件没有找到，你应该把XML文件放在与你的类文件同个目录下,本文中是放在hibernate\classes\hibernate\目录下，也就是跟Hello_Bean.class类文件一起。

net.sf.hibernate.PropertyNotFoundException: Could not find a setter for property name in class hibernate.Hello_Bean


如果出现这行错误说明你的xml文件里设置的字段名name的值与Hello_Bean.java类里的getXXX或setXXX方法不一致。

net.sf.hibernate.HibernateException: JDBC Driver class not found: org.gjt.mm.mysql.Driver 
如果出现这行错误说明你的MYSQL驱动没有加进JB库里或者不在CLASSPATH里。
调试出现 net.sf.hibernate.MappingException 很有可能是由于 
类库文件没有找到,类库的版本不同，他的名字会不同 要重新配置 setenv.bat 
类库的路径。

自己遇到的hibernate常见错误 
1>

错误显示： net.sf.hibernate.PropertyValueException: not-null property references a null or transient value: com.Order.customer

部分原文件：（ customer 和 order 类关系：一对多关联）

Order.hbm.xml …………… < many-to-one         name = "customer"         column = "CUSTOMER_ID"         class = "com.Customer"         not-null = "true"         cascade = "save-update"            /> 执行文件： 
………

Session session = sessionFactory.openSession();

    Transaction tx = null;

    try {

      // Create some data and persist it

     tx = session.beginTransaction();


     Customer customer=new Customer();

     customer.setName("Jack");

    

     Order order=new Order();

     order.setOrderNumber("Jack_Order001");

         session.save(customer);

         session.save(order);

   tx.commit();

原因分析：因为在执行代码中，没有将 customer 和 order 类一对多关联起来，若单独持久化两个类： session.save(customer);session.save(order); 则在保存 order 的时候，由于 CUSTOMER_ID是与 customer类外键，因此无法读取 customer_id, 而在 order.hbm.xml 中指定其不为空，则产生了以上错误。

问题解决： not-null = "true" 改为：not-null="false" 虽然程序无问题，但order表 CUSTOMER_ID为空，不符合逻辑。应该将指定其一对多的关联。 order.setCustomer(customer);       customer.getOrders().add(order);   2〉 错误显示： RROR SessionImpl:2400 - Could not synchronize database state with session net.sf.hibernate.exception.GenericJDBCException: could not delete collection: [com.Customer.orders#2] 
部分原文件：

Session session = sessionFactory.openSession();

    Transaction tx = null;

    try {

      tx = session.beginTransaction();

      Customer customer=(Customer)session.load(Customer.class,new Long(3));

      session.delete(customer);

      tx.commit();

原因分析：因为 cascade默认值为 none，所以当删除customer时，不会自动删除与其关联的order对象。 问题解决：添加语句 cascade = "delete"   3> 
错误显示：

17:24:34,992 ERROR JDBCExceptionReporter:58 - [Microsoft][SQLServer 2000 Driver for JDBC][SQLServer]在关键字 'ORDER' 附近有语法错误。 17:24:34,992 WARN JDBCExceptionReporter:57 - SQL Error: 156, SQLState: HY000 17:24:35,002 ERROR JDBCExceptionReporter:58 - [Microsoft][SQLServer 2000 Driver for JDBC][SQLServer]在关键字 'ORDER' 附近有语法错误。 17:24:35,022 WARN JDBCExceptionReporter:34 - SQL Warning: 0, SQLState: net.sf.hibernate.exception.GenericJDBCException : could not initialize collection: [com.Customer.orders#2] 
部分原文件： order.hbm.xml

< hibernate-mapping >   < class name = "com.Order" table = "ORDER" >      < id name = "id" type = "long" column = "ID" >         < generator class = "increment" />       </ id >    < property name = "orderNumber" type = "string" >         < column name = "ORDER_NUMBER" length = "15" />       </ property >             < many-to-one         name = "customer"         column = "CUSTOMER_ID"         class = "com.Customer"         outer-join = "true"          /> 
原因分析：因为 order 表在 SQL 2000 数据库中已经定义了，如果用户在定义了 order 表，并且程序对该表进行连接等操作就会出错

问题解决：将 引用 order 处改为 [order]

< class name = "com.Order" table = "[ORDER]" >   4> net.sf.hibernate.exception.SQLGrammarException : Could not save object     at net.sf.hibernate.exception.SQLStateConverter.convert( SQLStateConverter.java:58 )     at net.sf.hibernate.exception.JDBCExceptionHelper.convert( JDBCExceptionHelper.java:29 )     at net.sf.hibernate.impl.SessionImpl.convert( SessionImpl.java:4131 )     at net.sf.hibernate.impl.SessionImpl.saveWithGeneratedIdentifier( SessionImpl.java:794 )     at net.sf.hibernate.impl.SessionImpl.save( SessionImpl.java:749 )     at com.BusinessService.saveCategoryWithCascade( BusinessService.java:54 )     at com.BusinessService.test( BusinessService.java:104 )     at com.BusinessService.main( BusinessService.java:109 ) Caused by: java.sql.SQLException : [Microsoft][SQLServer 2000 Driver for JDBC][SQLServer]对象名 'CATEGORIES' 无效。 5〉 
错误显示： net.sf.hibernate.MappingException : Resource: Add valid path not found

部分原文件： hibernate.hbm.xml

< hibernate-configuration >   < session-factory >     < property name = "connection.username" > sa </ property >     < property name = "connection.url" > jdbc:microsoft:sqlserver://localhost:1433;DatabaseName=test </ property >     < property name = "dialect" > net.sf.hibernate.dialect.SQLServerDialect </ property >     < property name = "myeclipse.connection.profile" > MSSQL </ property >     < property name = "connection.password" > hheryh </ property >     < property name = "connection.driver_class" > com.microsoft.jdbc.sqlserver.SQLServerDriver </ property >     < mapping resource = "Add valid path" /> </ session-factory > 
原因分析：找不到有效的 xml 文件

问题解决：将所有配置文件都加到 resource 里

将< mapping resource = "Add valid path" />改为 < mapping resource = "com/Customer.hbm.xml" /> < mapping resource = "com/Order.hbm.xml" /> 6〉 错误显示 net.sf.hibernate.MappingException : Error reading resource: com/Customer.hbm.xml     at net.sf.hibernate.cfg.Configuration.addResource( Configuration.java:340 )     at net.sf.hibernate.cfg.Configuration.doConfigure( Configuration.java:1027 )     at net.sf.hibernate.cfg.Configuration.doConfigure( Configuration.java:983 )     at net.sf.hibernate.cfg.Configuration.configure( Configuration.java:911 )     at net.sf.hibernate.cfg.Configuration.configure( Configuration.java:897 )     at com.BusinessService.<clinit>( BusinessService.java:17 ) Caused by: net.sf.hibernate.MappingException : duplicate import: Customer     at net.sf.hibernate.cfg.Mappings.addImport( Mappings.java:85 )     at net.sf.hibernate.cfg.Binder.bindClass( Binder.java:126 )     at net.sf.hibernate.cfg.Binder.bindRootClass( Binder.java:221 )     at net.sf.hibernate.cfg.Binder.bindRoot( Binder.java:1256 )     at net.sf.hibernate.cfg.Configuration.add( Configuration.java:253 )     at net.sf.hibernate.cfg.Configuration.addInputStream( Configuration.java:289 )     at net.sf.hibernate.cfg.Configuration.addResource( Configuration.java:337 )     ... 5 more 部分原文件 :hibernate.hbm.xml <? xml version = '1.0' encoding = 'UTF-8' ?> <! DOCTYPE hibernate-configuration PUBLIC           "-//Hibernate/Hibernate Configuration DTD 2.0//EN"           "http://hibernate.sourceforge.net/hibernate-configuration-2.0.dtd" >   <!-- Generated by MyEclipse Hibernate Tools.                   --> < hibernate-configuration >   < session-factory >     < property name = "connection.username" > sa </ property >     < property name = "connection.url" > jdbc:microsoft:sqlserver://localhost:1433;DatabaseName=test </ property >     < property name = "dialect" > net.sf.hibernate.dialect.SQLServerDialect </ property >     < property name = "myeclipse.connection.profile" > MSSQL </ property >     < property name = "connection.password" > hheryh </ property >     < property name = "connection.driver_class" > com.microsoft.jdbc.sqlserver.SQLServerDriver </ property >     < mapping resource = "com/Customer.hbm.xml" /> </ session-factory >   </ hibernate-configuration >   
主程序：

static{

     try{

      // Create a configuration based on the properties file we've put

       Configuration config = new Configuration();

       config.addClass(Customer.class);

      // Get the session factory we can use for persistence

      sessionFactory = config

      .configure()

      .buildSessionFactory();

    }catch(Exception e){e.printStackTrace();}


}

解决方法： config.addClass(Customer.class);
sessionFactory = config.configure().buildSessionFactory();

原因分析： hibernaet 配置文件有两种格式，一种是 xml 格式，一种是普通的 .property 格式 .

在 1.2 版本中，编译时自动会在 path 路径中查找 property 格式的配置文件。但不会查询 xml 格式的配置文件，因此需要在程序中手动添加 config.configure() ，但此时就不要加载了。

上面的程序 加载了一次 config.configure() ，又映射了一次，所以出错。


解决方法：

若配置文件为 xml 格式的，程序编写如下：

// Create a configuration based on the properties file we've put

       Configuration config = new Configuration();

             // Get the session factory we can use for persistence

      sessionFactory = config

      .configure()

.buildSessionFactory();


若配置文件为 property 格式的，程序编写如下：

// Create a configuration based on the properties file we've put

       Configuration config = new Configuration();

       config.addClass(Customer.class);

      // Get the session factory we can use for persistence

      sessionFactory = config.buildSessionFactory();

	  
错误显示：
at org.codehaus.jackson.map.ser.ContainerSerializers$AsArraySerializer.serialize(ContainerSerializers.java:142)
	at org.codehaus.jackson.map.ser.BeanPropertyWriter.serializeAsField(BeanPropertyWriter.java:430)
	at org.codehaus.jackson.map.ser.BeanSerializer.serializeFields(BeanSerializer.java:175)
	at org.codehaus.jackson.map.ser.BeanSerializer.serialize(BeanSerializer.java:142)
	at org.codehaus.jackson.map.ser.BeanPropertyWriter.serializeAsField(BeanPropertyWriter.java:430)
	at org.codehaus.jackson.map.ser.BeanSerializer.serializeFields(BeanSerializer.java:175)
	at org.codehaus.jackson.map.ser.BeanSerializer.serialize(BeanSerializer.java:142)
原因分析：

   spring mvc JSON 无限死循环
   
   死循环原因： JSON无法对Album的photos属性进去JSON转换
   
解决办法：
	//在Album实体类上加注释@JsonIgnoreProperties(value={"photos"})
	//@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler","photos"})
	//java转json hibernate关联关系造成的无限递归问题,value里添加映射字段
	//JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler","historyArcticlesLinkMapping"})
    
@Entity
@SuppressWarnings("serial")
@JsonIgnoreProperties(value={"photos"})   
public class Album implements java.io.Serializable {}


