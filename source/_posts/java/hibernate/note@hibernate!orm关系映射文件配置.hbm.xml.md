简单的orm关系映射,两个实体Score和User

.*.hbm.xml文件配置
   ***Score.hbm.xml***
``
!----->
?xml version="1.0"?>
!DOCTYPE hibernate-mapping PUBLIC
     "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
         "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
hibernate-mapping package="com.houpu.max.bean">
!--name对应实体类名 table对应表名--->
<class name="Score" table="t_score">
       <!--id对应实体变量名 column对应列名--->
	<id name="cor" column="cor">
	<!--主键策略 native sequence  increment UUID Hilo  identity assigned foreign--->
		<generator class="sequence">
			<param name="sequence">seq_cid</param>
		</generator>
	</id>
	<!--name对应变量名 column对应列名--->
	<property name="ssname" column="ssname"></property>
	
</class>
/hibernate-mapping>

``

**Student.hbm.xml***
``
?xml version="1.0"?>
!DOCTYPE hibernate-mapping PUBLIC
     "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
         "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
hibernate-mapping package="com.houpu.max.bean">
<class name="User" table="t_user">
	<id name="uId" column="uuid">
		<generator class="sequence">
			<param name="sequence">seq_uid</param>
		</generator>
	</id>
	<property name="uName" column="uname"></property>
	<property name="uAge" column="uage"></property>
	<!--- 一对多 懒加载开启 column对应另外一个表的列 class对应实体类-->
	<set name="score" lazy="true">
		<key column="cor"></key>
		<one-to-many class="Score" />
	</set>
</class>
/hibernate-mapping>

``
#主键生成策略
   （1）increment
       a)对主键值采取自动顺序增长的方式生成新的主键，值默认从1开始。
       b)原理:在当前应用实例中维持一个变量,以保存当前最大值,之后每次需要生成主键值的时候将此值加1作为主键.不依赖于底层的数据库，因此所有的数据库都可以使用
       c)缺点:通过increment的生成主键的原理可推断，此种主键生成策略不适用于集群、同一时段大量用户并发访问的系统，既当大量用户同一时间段同时进行插入操作的时候，可能存在取得相同的最大值然后再同时+1的情况,这个时候就会造成主键冲突。因此，如果同一数据库有多个实例访问，此方式必须避免使用。
 
   （2）UUID
       a)原理UUID使用128位UUID算法生成主键，能够保证网络环境下的主键唯一性，也就能够保证在不同数据库及不同服务器下主键的唯一性。所以使用于所有数据库。
       b)特点;能够保证数据库中的主键唯一性，但是在生成的主键占用比较多的存贮空间 
 
   （3）Hilo
　     a)原理:通过hi/lo 算法(Hilo使用高低位算法生成主键，高低位算法使用一个高位值和一个低位值，然后把算法得到的两个值拼接起来)实现的主键生成机制，需要额外的数据库表保存主键生成历史状态。
       b)特点：需要额外的数据库表和字段提供高位值来源。默认情况下使用的表是 　　hibernate_unique_key，默认字段叫作next_hi。next_hi必须有一条记录否则会出现错误。需要额外的数据库表的支持，能保证同一个数据库中主键的唯一性，但不能保证多个数据库之间主键的唯一性。Hilo主键生成方式由Hibernate 维护，所以Hilo方式与底层数据库无关。
 
   （4）sequence
       a)sequence实际是就是一张单行单列的表。
       b)实现原理:调用数据库中底层存在的sequence生成主键，需要底层数据库的支持序列，因此他是依赖于数据库的。
       c)支持sequence的数据库有:Oracle 、DB2(MySQL/SQlServer不支持)、PostgreSql、SAPDb等
 
   （5）identity
       a)根据底层数据库，来支持自动增长，不同的数据库用不同的主键增长方式。
       b)特点: 与底层数据库有关，要求数据库支持Identity，如MySQl中是auto_increment, SQL Server 中是Identity。支持的数据库有MySql、SQL Server、DB2、Sybase和HypersonicSQL。
       c)好处:在建表的时候指定了id为自动增长,实际开发中就不需要自己定义插入数据库的主键值,系统会自动顺序递增一个值 。Identity无需Hibernate和用户的干涉，使用较为方便，但由于依赖于数据库，所以不便于在不同的数据库之间移植程序。
　　
   （6）native
       a)作用:根据数据库的类型,自动在sequence 、identity和,hilo进行切换。
       b)实现自动切换的依据:根据Hibernate配置文件中的方言来判断是Oracle还是Mysql、SqlServer,然后针对数据库的类型抉择 sequence还是identity作为主键生成策略。
       c)用处：由于Hibernate会根据底层数据库采用不同的映射方式，因此灵活性高，便于程序移植，项目中如果用到多个数据库时，可以使用这种方式。
 
   （7）assigned
       a)作用:用于手工分配主键生成器,一旦指定为这个了,Hibernate就不在自动为程序做主键生成器了。没有指定<generator>标签时，默认就是assigned主键的生成方式
       b)使用方法:在程序中session.save();之前,由程序员自己指定主键值为多少。
         例如:user.setId(1);这就是在程序中程序员手动为用户表指定主键值为1。
   （8）foreign
       只适用基于共享主键的一对一关联映射的时候使用。即一个对象的主键是参照的另一张表的主键生成的。
    对数据库的依赖性总结
    UUID，increment、Hilo、assigned：对数据库无依赖
    identity：依赖Mysql或sql server，主键值不由hibernate维护
    sequence：适合于oracle等支持序列的dbms，主键值不由hibernate维护，由序列产生。
    native：根据底层数据库的具体特性选择适合的主键生成策略，如果是mysql或sqlserver，选择identity，如果是oracle，选择sequence。