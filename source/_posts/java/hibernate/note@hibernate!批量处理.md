note@hibernate!批量处理

1.Hibernate批量处理

    在Hibernate应用中，有两种批量处理方法：一种是通过Hibernate的缓存，另一种是绕过Hibernate，直接调用JDBC API来处理。

 

1）批量插入

（1）通过Hibernate的缓存进行批量插入

    使用这种方法时，首先要在Hibernate的配置文件hibernate.cfg.xml中设置批量尺寸属性hibernate.jdbc.batch_size，且最好关闭Hibernate的二级缓存以提高效率。

 

例如：



<hibernate-configuration>
    <session-factory>
         …
        <property name="hibernate.jdbc.batch_size">50</property>                         // 设置批量尺寸
        <property name="hibernate.cache.use_second_level_cache">false</property>         // 关闭二级缓存
    </session-factory>
</hibernate-configuration>
    下面以4.2.1节的例子中的课程进行批量插入为例，说明批量插入操作的具体过程，这里假设批量插入500个课程到数据中：


Session session=HibernateSessionFactory.getSession();
Transaction ts=session.beginTransaction();
for(int i=0;i<500;i++){
    Kcb kcb=new Kcb();
    // 这里设置课程号为i，在实际应用中应该是被插入的课程对象
    // 已经放在集合或数组中，这里只要取出
    kcb.setKch(i+"");  
    session.save(kcb);
    if(i%50==0){          // 以50个课程为一个批次向数据库提交，此值应与配置的批量尺寸一致
        session.flush();  // 将该批量数据立即插入数据库中
        session.clear();  // 清空缓存区，释放内存供下批数据使用
    }
}
ts.commit();
HibernateSessionFactory.closeSession();
（2）绕过Hibernate直接调用JDBC进行插入

    由于Hibernate只是对JDBC进行了轻量级的封装，因此完全可以绕过Hibernate直接调用JDBC进行批量插入。因此上例可以改成如下代码：


Session session=HibernateSessionFactory.getSession();
Transaction ts=session.beginTransaction();
Connection conn=session.connection();
try {
    PreparedStatement  stmt=conn.prepareStatement("insert into KCB(KCH) values(?)");
    for (int i=0; i < 500; i++) {
        stmt.setString(1, i+"");
        stmt.addBatch();                  // 添加到批处理命令中
    }
    stmt.executeBatch();                   // 执行批处理任务
} catch (SQLException e) {
    e.printStackTrace();
}
ts.commit();
HibernateSessionFactory.closeSession();
2）批量更新

（1）由Hibernate直接进行批量更新

    为了使Hibernate的HQL直接支持update/delete的批量更新语法，首先要在Hibernate的配置文件hibernate.cfg.xml中设置HQL/SQL查询翻译器属性hibernate.query.factory_class。


<hibernate-configuration>       
    <session-factory>
    ……
        <propertyname="hibernate.query.factory_class">org.hibernate.hql.ast.ASTQueryTranslatorFactory</property>
    </session-factory>
<hibernate-configuration>


下面使用HQL批量更新把课程表中的XS修改为30。由于这里是用Hibernate操作，故HQL要用类对象及其属性。


Session session=HibernateSessionFactory.getSession();
Transaction ts=session.beginTransaction();
//在HQL查询中使用update进行批量更新
Query query=session.createQuery("update Kcb set xs=30");
query.executeUpdate();
ts.commit();
HibernateSessionFactory.closeSession();
（2）绕过Hibernate调用JDBC进行批量更新

    由于这里是直接操作数据库，故要操作对应表，而不是类。


Session session=HibernateSessionFactory.getSession();
Transaction ts=session.beginTransaction();
Connection conn=session.connection();
try {
    Statement stmt=conn.createStatement();
    //调用JDBC的update进行批量更新
    stmt.executeUpdate("update KCB set XS=30");
} catch (SQLException e) {
    e.printStackTrace();
}
ts.commit();
HibernateSessionFactory.closeSession();
3）批量删除

（1）由Hibernate直接进行批量删除

    与批量更新一样，为了使Hibernate的HQL直接支持update/delete的批量删除语法，首先要在Hibernate的配置文件hibernate.cfg.xml中设置HQL/SQL查询翻译器属性hibernate.query.factory_class。


<hibernate-configuration>       
    <session-factory>
    ……
        <propertyname="hibernate.query.factory_class">org.hibernate.hql.ast.ASTQueryTranslatorFactory</property>
    </session-factory>
<hibernate-configuration>
    下面将使用HQL批量删除课程表中课程号大于200的课程。


Session session=HibernateSessionFactory.getSession();
Transaction ts=session.beginTransaction();
//在HQL查询中使用delete进行批量删除
Query query=session.createQuery("delete Kcb where kch>200");
query.executeUpdate();
ts.commit();
HibernateSessionFactory.closeSession();
（2）绕过Hibernate调用JDBC进行批量删除

    同样删除课程表中课程号大于200的课程。


Session session=HibernateSessionFactory.getSession();
Transaction ts=session.beginTransaction();
Connection conn=session.connection();
try {
    Statement stmt= conn.createStatement();
    //调用JDBC的delete进行批量删除
    stmt.executeUpdate("delete from KCB where KCH>200");       
} catch (SQLException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
}
ts.commit();
HibernateSessionFactory.closeSession();
2.实体对象生命周期

    是Hibernate应用的一个关键概念。这里的实体对象，特指Hibernate O/R映射关系中的域对象（即O/R中的O）

    实体对象的生命周期有以下3种状态。

1）transient（瞬时态）

    瞬时态，即实体对象在内存中的存在，与数据库中的记录无关。如下面的代码：


Student stu=new Student();
stu.setSnumber("081101");
stu.setSname("李方方");
stu.setSage(21);
2）persisent（持久态）

    在这种状态下，实体对象的引用被纳入Hibernate实体容器中加以管理。处于持久状态的对象，其变更将由Hibernate固化到数据库中。例如下面的代码。

Student stu=new Student();
Student stu1=new Student();
stu.setSnumber("081101");
stu.setSname("李方方");
stu.setSage(21);
stu1.setSnumber("081102");
stu1.setSname("程明");
stu1.setSage(22);                                        // 到此为止，stu和stu1均处于瞬时态
Transaction tx=session.beginTransaction();
session.save(stu); // 通过save()方法，stu对象转换为持久态，由Hibernate纳入实体管理容器，而stu1仍然处于瞬时态
// 事务提交之后，数据库表中插入一条学生的记录，对于stu1则无任何操作
tx.commit();
Transaction tx2=session.beginTransaction();
stu.setSname("李方");
stu1.setSname("程明明");
// 虽然这个事务中没有显示调用session.save()方法保存stu对象，但是由于stu为持久态，将自动被固化到数据库，因此数据库的学号为“081101” 学生记录的姓名已被更改为“李方”，此时stu1仍然是一个普通Java对象，对数据库未产生任何影响
tx2.commit();
处于瞬时态的对象，可以通过Session的save()方法转换成持久状态。同样，如果一个实体对象由Hibernate加载，那么，它也处于持久状态。例如下面的

// 由Hibernate返回的持久对象
Student stu=(Student)session.load(Student.class,new Integer(1));
3）Detached（脱管状态）

    处于持久态的对象，其对应的Session实例关闭之后，此对象就处于脱管状态。Session实例可以看做是持久对象的宿主，一旦此宿主失效，其从属的持久对象进入脱管状态。如下面的代码：


Student stu=new Student();// stu处于瞬时态
Student stu1=new Student();
stu.setSnumber("081101");
stu.setSname("李方方");
stu.setSage(21);
stu1.setSnumber("081102");
stu1.setSname("程明");
stu1.setSage(22);
Transaction tx=session.beginTransaction();
session.save(stu);// stu对象由Hibernate纳入管理容器，处于持久状态
tx.commit();
session.close();// stu对象状态为脱管态，因为与其关联的session已经关闭
    瞬时状态的对象与库表中的数据库缺乏对应关系；而托管状态的对象，却在库表中存在相应的记录，只不过由于其脱离Session这个数据库操作平台，其状态改变无法更新到数据库表中。

3.Hibernate事务管理

    事务是数据库并发控制不可分隔的基本工作单位，具有原子性、一致性、隔离性和持久性的特点。

    事务（Transcation）是工作中的基本逻辑单位，可以用于确保数据库能够被正确修改，避免只修改了一部分导致数据不完整，或者在修改时受到用户干扰。

1）基于JDBC的事务管理

    Hibernate是JDBC的轻量级封装，本身并不具备事务管理能力。在事务管理层，Hibernate将其委托给底层的JDBC或JTA，以实现事务管理和调度功能。

    在JDBC的数据库操作中，一项事务是由一条或多条表达式组成的不可分割的工作单元，通过提交commit()或回滚rollback()来结束事务的操作。

    在JDBC中，事物默认是自动提交。也就是说，一条更新表达式代表一项事物操作。操作成功后，系统将自动调用commit()提交。否则将调用rollback()回滚。

    在JDBC中，可以通过调用setAutoCommit(false)禁止自动提交，之后就可以把多个数据库操作的表达式作为一个事物，在操作完成后调用commit()进行整体提交。

    将事务管理委托给JDBC进行处理是最简单的实现方式，Hibernate对于JDBC事务的封装也比较简单。如下面的代码：


Session session=sessionFactory.openSession();
Transaction tx=session.beginTransaction();
session.save(room);
tx.commit();


从JDBC层面而言，上面的代码实际上对应着：

Connection cn=getConnection;
cn.setAutoCommit(false);
// JDBC调用相关的SQL语句
cn.commit();
    在sessionFactory.open()语句中，Hibernate会初始化数据库连接。与此同时，将其AutoCommit()设为关闭状态(false)。因此在调用commit()之前，下面的代码不会对数据库产生任何效果：



session session=session.Factory.openSession();
session.save(room);
session.close();
    如果要使代码真正作用到数据库，必须显示地调用Transaction指令：


Session session =sessionFactory.openSession();
Transaction tx=sessio.beginTransaction();
session.save(room);
tx.commit();
session.close();
2）基于JTA的事务管理概念

    JTA（Java Transaction API）是由Java EE Transaction Manager去管理的事务。其最大的特点是调用UserTransaction接口的begin、commit和rollback方法来完成事务范围的界定、事务的提交和回滚。JTA可以实现统一事务对应不同的数据库。

    JTA主要用于分布式的多个数据源的两阶段提交的事务，而JDBC的Connection提供单个数据源的事务。后者因为只涉及一个数据源，所以其事务可以由数据库自己单独实现。而JTA事务因为其分布式和多数据源的特性，不可能由任何一个数据源实现事务。因此，JTA中的事务是由“事务管理器”实现的。它会在多个数据源之间统筹事务，具体使用的技术就是所谓的“两阶段提交”。

 

3）锁

    业务逻辑的实现过程中，往往需要保证数据访问的排他性。如在金融系统的日终结算处理中，希望对某个结算时间点的数据进行处理，而不希望在结算过程中（可能是几秒，也可能是几个小时），数据再发生变化。此时，需要通过一些机制来保证这些数据在某个操作过程中不会被外界修改，这样的机制就是所谓的“锁”，即给选定的目标数据上锁，使其无法被其他程序修改。

    Hibernate支持两种锁机制，悲观锁（Pessimistic Locking）和乐观锁（Optimistic Locking）。

（1）悲观锁，它指的是对数据被外界修改持保守态度，因此，在整个数据处理过程中，将数据处于锁定状态。悲观锁的实现，往往依靠数据库提供的锁机制。

（2）乐观锁，悲观锁大多数情况下依靠数据库的锁机制实现，以保证操作最大程度的独占性。但随之而来的就是数据库性能的大量开销，特别是对长事务而言，这样的开销往往无法承受。

    乐观锁，大多是基于数据版本（ Version ）记录机制实现。读取出数据时，将此版本号一同读出，之后更新时，对此版本号加一。此时，将提交数据的版本数据与数据库表对应记录的当前版本信息进行比对，如果提交的数据版本号大于数据库表当前版本号，则予以更新，否则就报错。

    对于上面修改用户帐户信息的例子而言，假设数据库中帐户信息表中有一个version 字段，当前值为 1 ；而当前帐户余额字段（ balance ）为 $100 。

    操作员 A 此时将其读出（ version=1 ），并从其帐户余额中扣除 $50（ $100-$50 ）。

    在操作员 A 操作的过程中，操作员 B 也读入此用户信息（ version=1 ），并从其帐户余额中扣除$20 （ $100-$20 ）。

    操作员 A 完成了修改工作，将数据版本号加一（ version=2 ），连同帐户扣除后余额（ balance=$50 ），提交至数据库更新，此时由于提交数据版本大于数据库记录当前版本，数据被更新，数据库记录 version 更新为 2 。

    操作员 B 完成了操作，也将版本号加一（ version=2 ）试图向数据库提交数据（ balance=$80 ），但此时比对数据库记录版本时发现，操作员 B 提交的数据版本号为 2 ，数据库记录当前版本也为 2 ，不满足 “ 提交版本必须大于记录当前版本才能执行更新 “ 的乐观锁策略，因此，操作员 B 的提交被驳回。这样，就避免了操作员 B 用基于 version=1 的旧数据修改的结果覆盖操作员 A 的操作结果的可能。

    需要注意的是，乐观锁机制往往基于系统中的数据存储逻辑，因此也具备一定的局限性，如在上例中，由于乐观锁机制是在我们的系统中实现，来自外部系统的用户余额更新操作不受我们系统的控制，因此可能会造成脏数据被更新到数据库中。

