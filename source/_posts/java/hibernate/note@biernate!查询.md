# note@biernate!查询

1、检索方式（抓取方式）-------查询的方式

         明确：

             解决的是我们在实际开发中实现功能的方式。（实现项目中的功能）

         hibernate的检索方式：

（1）OID查询：使用id来查询实体

                   涉及的方法：

                                   get(Class clazz,Serializable id);

                                   load(Class clazz,Serializable id);

                 共同点：

                           都是根据id查询对象

                 区别：

                           get：

                                    不管用不用，一调用方法马上就去查询。返回的是实体类对象。

                           load：

                                    什么时候用什么时候查询。返回的是实体类对象的代理对象。
get查询：

	/**
	 * 使用get方法查询:
	 * 根据id查询客户的实体
	 * 参数:
	 * 		1:要查询实体的字节码
	 * 		2:查询的id
	 */
	@Test
	public void test01(){
		Session session = HibernateUtils.getCurrentSession();
		Transaction tx = session.beginTransaction();
		
		Customer c = session.get(Customer.class, 1l);//只是接受对象.get方法会去查询
		System.out.println(c.toString());//打印,指真正要看一下里面的数据.get方法已经查询完成,此时不再查了.
		tx.commit();
	}
	
	// 通过走Debug发现：当走完get方法时，就会进行查询（立即加载）
load查询：
	/**
	 * 使用load方法查询
	 * 	根据id查询客户实体
	 * 	参数:
	 * 		1:要查询实体的字节码
	 * 		2:查询的id
	 */
	@Test
	public void test02(){
		Session session = HibernateUtils.getCurrentSession();
		Transaction tx = session.beginTransaction();
		
		Customer c = session.get(Customer.class, 1l);//load方法不回去查询,只是生成实体类代理对象,里面只有OID
		System.out.println(c.toString());//打印,指真正要看一下里面的数据.load方法会发起真正的查询
		tx.commit();
	}
	通过走Debug发现：当走完load方法时，不会立即查询，当使用Customer对象时才会发起真正查询。（延迟加载）
	
Hibernate类级别的检索策略:

       类级别:

           指的就是当前实体类,但是不包含实体类中的其他实体映射

              比如:在一对多中,客户包含了一个联系人集合,类级别就不关心联系人集合什么时候查询

              比如:在多对一中,联系人包含了一个客户对象,类级别就不关心客户对象什么时候查询
			  
			   解决的问题:

           什么时候真正发起查询?

              get:立即加载(永远都是)

              load:是默认情况下延迟加载(懒加载\惰性加载)

                  用配置文件可以将其改为立即加载

                  <class name="Customer" table="cst_customer" lazy="false">

                  lazy="false"  立即加载

                  lazy="true"   延迟加载

              query的list方法也永远都是立即加载
			  
对象导航查询：

         a.明确:

           它只能是通过一个对象实体导航到另一个对象实体或者是对象的实体集合

           要求两个实体必须有关联关系(一对多,多对一,多对多,一对一)

         b.转变:

           我们查询思想要转变

           在我们写新方法完成查询功能之前,先看看已有方法的对象导航能否实现。
		   
```
		public class HibernateDemo02 {
			/**
			 * 查询id为1的联系人所属的客户
			 */
			@Test
			public void test01(){
				Session session = HibernateUtils.getCurrentSession();
				Transaction tx = session.beginTransaction();
				
				LinkMan l = session.get(LinkMan.class, 1l);
				System.out.println(l.getCustomer().getCust_name());//对象导航查询
				tx.commit();
			}
			
			/**
			 * 查询客户id为2的客户所对应的联系人
			 */
			@Test
			public void test02(){
				Session session = HibernateUtils.getCurrentSession();
				Transaction tx = session.beginTransaction();
				
				Customer c = session.get(Customer.class, 2l);
				Set<LinkMan> linkMans = c.getLinkMans();//此行叫做对象导航查询
				System.out.println(c);
				System.out.println(linkMans);
				
				tx.commit();
				
			}
		}
```
		
Query查询：使用HQL语句查询
	查询所有：

	/**
	 * 查询所有
	 * 	需求：查询所有客户
	 */
	@Test
	public void test1(){
		Session s = HibernateUtil.getCurrentSession();
		Transaction tx = s.beginTransaction();
		Query query = s.createQuery("from Customer");
		List list = query.list();
		tx.commit();
		
		for(Object o : list){
			System.out.println(o);
		}
	}
	
	/**
	 * 具名查询: 
需求:查询cust_source为6并且客户名中含有"集"字的所有客户 
具名: 给参数占位符提供一个具体的名称 
书写规范:在HQL语句中占位符需要使用 :名称 在给占位符赋值的时不能写:,直接申明名称
	 */
@Test
	public void test03() {
		Session session = HibernateUtils.getCurrentSession();
		Transaction tx = session.beginTransaction();

		Query query = session
				.createQuery("from Customer where cust_source = :cust_source and cust_name like :cust_name");
		// 给参数占位符赋值
		query.setString("cust_source", "6");
		query.setString("cust_name", "%集%");
		List list = query.list();
		tx.commit();
		for (Object o : list) {
			System.out.println(o);
		}

	}
	
	分页查询：

	/**
	 * 分页查询:
	 * 需求:查询所有客户,每页显示两条
	 * 涉及方法:
	 * 	setFirstResult(int startIndex);//开始记录的索引
	 * 	setMaxResults(int pageSize);//每页显示的条数
	 * 开始记录索引算法:(当前页-1)*pageSize
	 */
	@Test
	public void test04(){
		Session session = HibernateUtils.getCurrentSession();
		Transaction tx = session.beginTransaction();
		
		Query query = session.createQuery("from Customer");
		//给参数占位符赋值
		query.setFirstResult(0);
		query.setMaxResults(2);
		List list = query.list();
		tx.commit();
		for (Object o : list) {
			System.out.println(o);
		}
		
	} 
	
	命名查询：

	/**
	 * 命名查询:
	 * 需求;查询所有性别为male的联系人
	 * 命名查询的含义:是根据配置文件中给定的名称,从配置文件中获取查询语句.从而在修改语句时,无需再修改源码
	 * 涉及的方法:
	 * 	使用session对象的getNamedQuery(String hqlname);来获取查询query对象
	 * 方法参数:
	 * 	指的是配置文件中提供的名称,严格区分大小写
	 * 配置命名位置:
	 * 	是在查询实体类的映射文件中
	 * <query name="findAllLinkMan">
 			<![CDATA[
 				from LinkMan where lkm_gender = ? and lkm_id=?
 			]]>
       </query>
	 */
	
	@Test
	public void test05(){
		Session session = HibernateUtils.getCurrentSession();
		Transaction tx = session.beginTransaction();
		Query query = session.getNamedQuery("findAllLinkMan");//session.createQuery("from LinkMan where lkm_gender = ? and lkm_id=?");
		//给参数占位符赋值
		query.setString(0, "male");
		query.setLong(1, 5l);
		List list = query.list();
		tx.commit();
		for (Object o : list) {
			System.out.println(o);
		}
	}
	
	
	排序查询：
L.
	/**
		 * 排序查询:
		 * 	需求:按照联系人id,倒序排列
		 * HQL语句也支持ordr by 和 desc
		 * 
		 * HQL语句也支持聚合函数
		 * 	count  sum   avg   max   min
		 */
		@Test
		public void test06(){
			Session session = HibernateUtils.getCurrentSession();
			Transaction tx = session.beginTransaction();
			
			Query query = session.createQuery("from LinkMan order by lkm_id desc");
		
			List list = query.list();
			tx.commit();
			for (Object o : list) {
				System.out.println(o);
			}
		}

	@Test
		public void test07(){
			Session session = HibernateUtils.getCurrentSession();
			Transaction tx = session.beginTransaction();
			
			Query query = session.createQuery("select count(lkm_id) from LinkMan");
			List list = query.list();
			tx.commit();
			for (Object o : list) {
				System.out.println(o);
			}
			
		}
		
		
		
多态查询：

/**
	 * 多态查询:
	 * 	需求:查询所有客户和联系人的集合
	 * 	有应用场景,但实际开发中使用不多
	 */
	@Test
	public void test08(){
		Session session = HibernateUtils.getCurrentSession();
		Transaction tx = session.beginTransaction();
		
		Query query = session.createQuery("from java.io.Serializable");
		List list = query.list();
		tx.commit();
		for (Object o : list) {
			System.out.println(o);
		}
		
	}
投影查询：

/**
	 * 投影查询
	 * 	就是我们只查询实体类中的某个或者某些字段时,仍然想让它把这些字段封装到实体类中,而不是Object[]
	 * 使用HQL语句实现投影查询的要求:
	 * 	实体类这个必须包含一个和查询字段名称相对应的构造函数.参数列表必须保持一致
	 * 	在HQL语句中,使用new实体类(参数列表)

	 *注意:
	 *	如果查询实体类在工程中唯一,则可以直接写短类名
	 *	反之,如果查询的实体类在工程中不唯一,则必须写全限定路径类名
	 */
	
	@Test
	public void test09(){
		Session session = HibernateUtils.getCurrentSession();
		Transaction tx = session.beginTransaction();
		
		Query query = session.createQuery("select new Customer(cust_id,cust_name) from Customer");
		List list = query.list();
		tx.commit();
		for (Object o : list) {
			System.out.println(o);
		}
		
	}
左外连接查询：

左外连接查询和迫切左外连接查询
	 * 明确:
	 * 	实际开发中用的不多,由于有对象导航查询的存在
	 * 需求:
	 * 	使用左外连接查询客户和联系人
	 * 左外连接返回的是:Object[]
	 * 	数组中包含的:
	 * 		一个客户的实体和一个联系人的实体
@Test
	public void test10(){
		Session session = HibernateUtils.getCurrentSession();
		Transaction tx = session.beginTransaction();
		
		Query query = session.createQuery("from Customer c left outer join c.linkMans");
		List<Object[]> list = query.list();
		tx.commit();
		for (Object[] os : list) {
			
			for (Object o : os) {
				System.out.println(o);
			}
		}
	}
迫切左外连接查询：

迫切左外连接查询返回的是:实体类的集合
	 * 	集合中都是左表的实体对象
	 * 	但是会不会有重复是由条件决定的
	 * 
	 * 此处我们更多的面试中可能被问到
	 * SQL:select * from cst_customer c left outer join cst-linkman l on c.cust_id=l.customer_id;
@Test
	public void test11(){
		Session session = HibernateUtils.getCurrentSession();
		Transaction tx = session.beginTransaction();
		
		Query query = session.createQuery("from Customer c left outer join fetch c.linkMans");
		List list = query.list();
		tx.commit();
			
		for (Object o : list) {
			System.out.println(o);
		}
	}
	
	（4）Criteria查询：QBC查询。更加面向对象的查询方式，把SQL的条件全都转成了方法。

         明确:它是一种更加面向对象的查询方式,把表名换成了类的名称.把列名换成了属性名称,把条件都用方法表示了

            QBC就是query by criteria

    如何获取criteria对象:

        用session的createCriteria(Class clazz)方法

    Class参数:

        指的是要查询的实体字节码

@Test
	public void test01(){
		Session session = HibernateUtils.getCurrentSession();
		Transaction tx = session.beginTransaction();
		
		Criteria criteria = session.createCriteria(LinkMan.class);
		//条件
		criteria.add(Restrictions.like("lkm_name", "%老%"));
		criteria.add(Restrictions.eq("lkm_gender", "male"));
		//分页
		criteria.setFirstResult(0);
		criteria.setMaxResults(2);
		//添加count结构:把sql语句转成select count(*) from cst_linkman;
		criteria.setProjection(Projections.count("lkm_id"));
		List list = criteria.list();
		tx.commit();
		for (Object object : list) {
			
			System.out.println(object);
		}
		
	}
（5）SQLQuery查询：使用SQL语句查询

2、检索策略（抓取策略）------查询的策略

（1）明确：

             解决如何更好的来查询，提升我们的执行效率。(查询性能的优化)

（2）分为两种：

       第一种：类级别的检索策略

                解决的问题：什么时候真正的去查询当前实体类

                涉及的方法：

                         get：永远都是立即加载。

                         load：默认是延迟加载。可以通过配置文件实现立即加载。

        第二种：关联级别的检索策略

                           当我们查询某个实体时，实体中所引用的关系对象的查询就叫做关联级别。

                                    例如：

                                             在客户中，联系人的集合就是客户的关联级别。

                                             在联系人中，客户对象就是联系人的关联级别。

                           分类：

                                    第一类：有一的一方，查询多的一方。（有少的，查多的）

                                              适用的情况：一对多，多对多。

                                    第二类：有多的一方，查询一的一方。（有多的，查少的）

                                             适用的情况：多对一，一对一。

                           解决的问题：

                                    1、什么时候去查询(立即和延迟)

                                    2、用什么方式去查询(多条语句，子查询，表连接)

                           涉及的配置：

                                    在关联级别第一类的情况下：

                                             配置的位置：都是set标签.

                                             配置的属性： lazy fetch

                                             属性的取值：

                                                                lazy: ['leɪzɪ]

                                                                         true：延迟加载

                                                                         false：立即加载

extra：极懒加载['ekstrə]

                                                                fetch: [fetʃ]

                                                                         select：多条语句

                                                                         subselect：子查询

                                                                         join：左外连接

 

                                    在关联级别第二类的情况下：

                                             配置的位置：是many-to-one,one-to-one标签上

                                             配置的属性：lazy fetch

                                             属性的取值：

                                                                lazy：

                                                                         false：立即加载

                                                                         proxy：看对方类级别检索策略。

                                                                         no-proxy：不用管它。

                                                                         fetch:

                                                                         select:多条语句

                                                                         join：左外连接

总结：

                           在第一类情况下，实际开发中采用的策略：

                                    使用的是：

                                             什么时候查询：延迟加载

                                             用什么方式查询：多条语句  

                                             这个是默认值

配置的位置：都是set标签.

 

当前类中：是关联级别检索策略的第一种情况：
         有少的一方检索多的一方
         我们有客户，根据客户查询联系人的策略
         属性的配置取值
     lazy=true   fetch=select
     <set name="linkmans" table="cst_linkman" lazy="true" fetch="select">（可以不配置，默认就是此）
 

                           在第二类情况下，实际开发中采用的策略：

                                    使用的是：

                                             什么时候查询：立即加载

                                             用什么方式查询：多条语句

配置的位置：是many-to-one,one-to-one标签上

 
 当前类中：是关联级别检索策略的第二种情况：
               有多的一方检索少的一方
               我们有联系人，根据联系人查询客户的策略
   属性的配置取值
     lazy=false         fetch=select
   <many-to-one name="customer" class="Customer" column="lkm_custid" lazy="false" fetch="select"/>
（3）批量抓取：

 

          * 需求：

          *    查询每个客户下的所有联系人

          * 什么时候查询：

          *              延迟加载

          * 用什么方式查询：

          *              多条SQL语句

          * 问题：

          *     通过分析：我们知道4条语句就能查询出来每个客户的所有联系人。

          *              select * from cst_linkman where lkm_custid = 1;

                            select * from cst_linkman where lkm_custid = 2;

                            select * from cst_linkman where lkm_custid = 3;

                            select * from cst_linkman where lkm_custid = 4;

                   而执行结果却是5条语句

                            select * from cst_customer

                            select * from cst_linkman linkmans0_ where linkmans0_.lkm_custid=?

                            select * from cst_linkman linkmans0_ where linkmans0_.lkm_custid=?

                            select * from cst_linkman linkmans0_ where linkmans0_.lkm_custid=?

                            select * from cst_linkman linkmans0_ where linkmans0_.lkm_custid=?

                   hibernate的n+1问题：

                            我们只需要4条语句的时候，会多出一条。多出那条语句就是取查询了主表。

                   解决hibernate中n+1问题：

                            需要配置文件中配置一个属性:

                                               配置的位置：set标签上

                                               配置的属性：batch-size

                                               属性的取值：正整数

                                               batch-size的含义：检索的深度。

                                                                                    简单记为  ?的个数

                                                                                    取值建议在3~10之间。（因为有分页的存在）

A．当有客户查询联系人（一查多）配置：

在一的一方的配置文件的set标签进行配置



B：当有联系人查询客户（多查一）配置：

         还是在一的一方配置，不过是在class标签内配置
	