复习：
JDBC（Java Data Base Connectivity）是一种用于执行SQL语句的Java API。
JDBC提供的主要接口：
DriverManager类
Connection类
Statement类
PreparedStatement类
ResultSet类

(1)加载JDBC驱动
(2)实例化数据库连接驱动类
(3)建立数据库连接,取得Connection对象
(4)建立Statement对象或PreparedStatement对象.
(5)执行SQL语句
(6)访问结果记录集ResultSet对象
(7)依次将ResultSet,Statement,PreparedStatement,
Connection对象关闭,释放所占用的资源。



关键词：ORM,JPA,Sessionfactroy,session,transaction,connectionProvider,TransactionFactory

1.ORM
ORM的全称是Object/Relation Mapping，即对象/关系映射。
ORM是一种规范、模型、思想。
2.JPA
JPA（Java Persistence API，Java持久化API）是SUN官方提出的Java持久化规范,hibernates就是依据它实现的。

SessionFactory：单个数据库映射关系经过编译后的内存镜像。

Session：它是应用程序和持久存储层之间交互操作的一个单线程对象.

持久化对象：处于持久化状态的对象
瞬态对象和脱管对象：系统进行new关键字进行创建的Java 实例，没有Session 相关联，此时处于瞬态

事务(Transaction)：代表一次原子操作，它具有数据库事务的概念

连接提供者(ConnectionProvider)：生成JDBC的连接的工厂，同时具备连接池的作用

事务工厂(TransactionFactory)：生成Transaction对象实例的工厂

Configuration对象
org.hibernate.cfg.Configuration实例代表一个应用程序到SQL数据库的映射配置，Configuration提供了一个buildSessionFactory()方法，该方法可以产生一个不可变的SessionFactory对象。

配置Hibernate的方式
使用hibernate.properties文件作为配置文件。
使用hibernate.cfg.xml文件作为配置文件。
不使用任何的配置文件，以编码方式来创建Configuration对象。

hibernate.connection.driver_class：设置连接数据库驱动。
hibernate.connection.url：设置所连接数据库服务的URL。
hibernate.connection.username：连接数据库的用户名。
hibernate.connection.password：连接数据库的密码。
hibernate.connection.pool_size：设置hibernate数据库连接池的最大并发连接数。
hibernate.dialect：设置数据库连接所使用的方言。
hibernate.show_sql：是否在控制台输出Hibernate生成的SQL语句，只能为true或者false两个值
hibernate.format_sql：是否将SQL语句转换成格式良好的SQL语句。
hibernate.use_sql_comments：是否在Hibernate生成的SQL语句中添加有助于调试的注视，只接受true和false两个值。
hibernate,jdbc.fetch_size:指定JDBC抓取数量的大小，它可以接受一个整数值，其实质是调用Statement.setFetchSize()方法。
hibernate.jdbc.batch_size：指定Hibernate使用JDBC2的批量更新的大小，它可接受一个整数值，建议是取5到30之间。
hibernate.connection.autocommit：设置是否自动提交。通常不建议自动提交。
hibernate.hbm2ddl.auto：设置当创建SessionFactory是，将Drop刚建的数据表。该属性可以是update、create和drop-create三个值。



