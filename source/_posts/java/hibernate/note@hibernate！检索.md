note@hibernate！检索
<strong>Hibernate提供了以下几种检索对象的方式</strong>
¨      导航对象图检索方式:  根据已经加载的对象导航到其他对象

¨      OID 检索方式:  按照对象的 OID 来检索对象

¨      HQL 检索方式: 使用面向对象的 HQL 查询语言

¨      QBC 检索方式: 使用 QBC(Query By Criteria) API 来检索对象. 这种 API 封装了基于字符串形式的查询语句, 提供了更加面向对象的查询接口.

¨      本地 SQL 检索方式: 使用本地数据库的 SQL 查询语句


HQL检索Demo

package hjds.test;

import hjds.domain.privilege.Admin;
import hjds.util.HiberSessionFactory;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.junit.Test;

public class HQLTest {

	
	@Test
	public void test1(){
		//获取session对象
		Session session =HiberSessionFactory.getSession();
		Class clazz = Admin.class;
		//hql查询    from 类名 
		Query query = session.createQuery("from "+clazz.getName());
		
		//获取结果
		List<Admin> admins =query.list();
		
		for(Admin admin:admins){
			System.out.println(admin.getName());
		}
		
		HiberSessionFactory.closeSession();
		
	}
	@Test
	public void test2(){
		//获取session对象
		Session session =HiberSessionFactory.getSession();
		
		//hql查询    from 类名 
	
		//获取结果
		List<Admin> admins =session.createQuery("from Admin").list();
		
		for(Admin admin:admins){
			System.out.println(admin.getName());
		}
		
		HiberSessionFactory.closeSession();
		
	}
	
	
	@Test
	public void test3(){
		//获取session对象s
		Session session =HiberSessionFactory.getSession();
		
		//hql查询    from 类名 
	
		//获取结果   name=?  位置从0开始
	    Admin admin= (Admin) session.createQuery("from Admin admin where admin.name=?").setString(0, "junjun10").uniqueResult();

		
	    System.out.println(admin.getName());
	
		
		HiberSessionFactory.closeSession();
		
	}
	
	
	@Test
	public void test4(){
		//获取session对象s
		Session session =HiberSessionFactory.getSession();
		
		//hql查询    from 类名 
	
		//获取结果   name=:names  names
	    Admin admin= (Admin) session.createQuery("from Admin admin where admin.name=:names").setString("names", "junjun10").uniqueResult();

		
	    System.out.println(admin.getName());
	
		
		HiberSessionFactory.closeSession();
		
	}
	
	
	@Test
	public void test5(){
		//获取session对象
		Session session =HiberSessionFactory.getSession();
		
		//hql查询    from 类名 
	
		//获取结果
		List<Admin> admins =session.createQuery("from Admin admin order by admin.id desc").list();
		
		for(Admin admin:admins){
			System.out.println(admin.getName());
		}
		
		HiberSessionFactory.closeSession();
		
	}
	
	
	@Test
	public void test6(){
		//获取session对象
		Session session =HiberSessionFactory.getSession();
		
		//hql查询    from 类名 
	
		//setFirstResult(开始位置).setMaxResult(每页显示的数量);
		//获取结果
		List<Admin> admins =session.createQuery("from Admin admin order by admin.id desc").setFirstResult(0).setMaxResults(3).list();
		
		for(Admin admin:admins){
			System.out.println(admin.getName());
		}
		
		HiberSessionFactory.closeSession();
		
	
	}
	
	
	@Test
	public void test7(){
		//获取session对象
		Session session =HiberSessionFactory.getSession();
		
		//hql查询    from 类名 
	
		//setFirstResult(开始位置).setMaxResult(每页显示的数量);
		//获取结果
		List list =session.createQuery("select admin.name,admin.pass from Admin admin order by admin.id desc").setFirstResult(0).setMaxResults(3).list();
		Iterator it = list.iterator();
		while(it.hasNext()){
			Object obj[]=(Object[]) it.next();
			System.out.println(obj[0]);
		}
		
		HiberSessionFactory.closeSession();
		
	}
	
	
	
	
	@Test
	public void test8(){
		//获取session对象
		Session session =HiberSessionFactory.getSession();
		
		//hql查询    from 类名 
	
		//setFirstResult(开始位置).setMaxResult(每页显示的数量);
		//获取结果
		List list =session.createQuery("select admin.name from Admin admin order by admin.id desc").setFirstResult(0).setMaxResults(3).list();
		Iterator it = list.iterator();
		while(it.hasNext()){
			 String name=(String) it.next();
			System.out.println("--"+name);
		}
		
		HiberSessionFactory.closeSession();
		
	}
	
	
	
	@Test
	public void test9(){
		//获取session对象
		Session session =HiberSessionFactory.getSession();
		
		//hql查询    from 类名 
	
		//setFirstResult(开始位置).setMaxResult(每页显示的数量);
		//获取结果
		List<Admin> admins =session.createQuery("select new hjds.domain.privilege.Admin(admin.name,admin.pass) from Admin admin order by admin.id desc").setFirstResult(0).setMaxResults(3).list();
		
		for(Admin admin:admins){
			System.out.println(admin.getName());
		}
		
		HiberSessionFactory.closeSession();
		
	}
	
	
	
	@Test
	public void test10(){
		//获取session对象
		Session session =HiberSessionFactory.getSession();
		
		//hql查询    from 类名 
	
		Class clazz = Admin.class;
		//setFirstResult(开始位置).setMaxResult(每页显示的数量);
		//获取结果
	    long count =(Long) session.createQuery("select count(c) from "+clazz.getName()+" c").uniqueResult();
		System.out.println(count);
		HiberSessionFactory.closeSession();
		
		/*
		 java.lang.ClassCastException: java.lang.Long cannot be cast to java.lang.Integer
	at hjds.test.HQLTest.test10(HQLTest.java:207)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:483)
	at org.junit.runners.model.FrameworkMethod$1.runReflectiveCall(FrameworkMethod.java:47)
	at org.junit.internal.runners.model.ReflectiveCallable.run(ReflectiveCallable.java:12)
	at org.junit.runners.model.FrameworkMethod.invokeExplosively(FrameworkMethod.java:44)
	at org.junit.internal.runners.statements.InvokeMethod.evaluate(InvokeMethod.java:17)
	at org.junit.runners.ParentRunner.runLeaf(ParentRunner.java:271)
	at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:70)
	at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:50)
	at org.junit.runners.ParentRunner$3.run(ParentRunner.java:238)
	at org.junit.runners.ParentRunner$1.schedule(ParentRunner.java:63)
	at org.junit.runners.ParentRunner.runChildren(ParentRunner.java:236)
	at org.junit.runners.ParentRunner.access$000(ParentRunner.java:53)
	at org.junit.runners.ParentRunner$2.evaluate(ParentRunner.java:229)
	at org.junit.runners.ParentRunner.run(ParentRunner.java:309)
	at org.eclipse.jdt.internal.junit4.runner.JUnit4TestReference.run(JUnit4TestReference.java:50)
	at org.eclipse.jdt.internal.junit.runner.TestExecution.run(TestExecution.java:38)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:467)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:683)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.run(RemoteTestRunner.java:390)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.main(RemoteTestRunner.java:197)


		 */
		
	}
	
	
	@Test
	public void test11(){
		//获取session对象
		Session session =HiberSessionFactory.getSession();
		
		//hql查询    from 类名 
	
		//setFirstResult(开始位置).setMaxResult(每页显示的数量);
		//获取结果
	    int count =session.createQuery("from Admin").list().size();
		System.out.println(count);
		HiberSessionFactory.closeSession();
		
	}
	@Test
	public void test12(){
		//获取session对象
		Session session =HiberSessionFactory.getSession();
		
		//hql查询    from 类名 
		
		//setFirstResult(开始位置).setMaxResult(每页显示的数量);
		//获取结果
		Admin admin =(Admin) session.getNamedQuery("findAdminByName").setString("name", "junjun10").uniqueResult();
		System.out.println(admin.getPass());
		HiberSessionFactory.closeSession();
		
	}
	@Test
	public void test13(){
		//获取session对象
		Session session =HiberSessionFactory.getSession();
		
		Transaction ts =  session.beginTransaction();
		//hql查询    from 类名 
		
		//setFirstResult(开始位置).setMaxResult(每页显示的数量);
		String delete="delete from Admin a where a.id=:id";
		//获取结果
		int num=session.createQuery(delete).setInteger("id", 2).executeUpdate();
		System.out.println(num);
		
		ts.commit();
		HiberSessionFactory.closeSession();
		
	}
	
}

QBC检索Demo
package hjds.test;

import hjds.domain.privilege.Admin;
import hjds.util.HiberSessionFactory;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.junit.Test;

public class QBCTest {
	
	
	@Test
	public void test1(){
		Session session =HiberSessionFactory.getSession();
		//
		Criteria criteria =session.createCriteria(Admin.class);
		
		List<Admin> admin =criteria.list();
		
		for(Admin adm:admin){
			System.out.println(adm.getName());
		}
		
		HiberSessionFactory.closeSession();
	}
	
	

	@Test
	public void test2(){
		Session session =HiberSessionFactory.getSession();
		//
	
		List<Admin> admin =session.createCriteria(Admin.class).list();
		
		for(Admin adm:admin){
			System.out.println(adm.getName());
		}
		
		HiberSessionFactory.closeSession();
	}
	
	
	@Test
	public void test3(){
		Session session =HiberSessionFactory.getSession();
		//
	
		Admin admin =(Admin) session.createCriteria(Admin.class).add(Restrictions.eq("name", "junjun10")).uniqueResult();
		
		
			System.out.println(admin.getName());
		
		
		HiberSessionFactory.closeSession();
	}
	
	
	@Test
	public void test4(){
		Session session =HiberSessionFactory.getSession();
		//
	
		List<Admin> admin=session.createCriteria(Admin.class).setFirstResult(0).setMaxResults(3).list();
		
		for(Admin adm:admin){
			System.out.println(adm.getName());
		}
		
		HiberSessionFactory.closeSession();
	}
	
	
	@Test
	public void test5(){
		Session session =HiberSessionFactory.getSession();
		//
	
		List<Admin> admin=session.createCriteria(Admin.class).setFirstResult(0).setMaxResults(3).addOrder(Order.desc("id")).list();
		
		for(Admin adm:admin){
			System.out.println(adm.getName());
		}
		
		HiberSessionFactory.closeSession();
	}
	
	
	@Test
	public void test6(){
		Session session =HiberSessionFactory.getSession();
		//
	
		List<Admin> admin=session.createSQLQuery("select id,name,pass from admin").addEntity(Admin.class).list();
		
		for(Admin adm:admin){
			System.out.println(adm.getName());
		}
		
		HiberSessionFactory.closeSession();
	}
	

	
	@Test
	public void test7(){
		Session session =HiberSessionFactory.getSession();
		//
	
		Admin admin=(Admin) session.createSQLQuery("select id,name,pass from admin where id=?").addEntity(Admin.class).setInteger(0, 1).uniqueResult();
		
		System.out.println(admin.getName());
		
		HiberSessionFactory.closeSession();
	}
	
}