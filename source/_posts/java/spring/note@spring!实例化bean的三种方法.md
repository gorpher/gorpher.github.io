1.构造方法
applicationContext.xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
http://www.springframework.org/schema/beans/spring-beans.xsd">
	<bean id="factoryMethod" class="com.houpu.max.action.FactoryMethod2" >
	<constructor-arg name="userDao" ref="us"/>
	</bean>
	<bean id="us" class="com.houpu.max.dao.impl.UserDaoImpl"/>
</beans>
FactoryMethod2.java
private UserDaoApi userDao;
	public void oparetor() {
		userDao.login("gof", "123344");
		System.out.println("我做我自己想做的事");
	}
	public FactoryMethod2(UserDaoApi userDao) {
		this.userDao = userDao;
	}
2.静态工厂方法
<!-- 静态方法方法实例化 只是简简单单的实例化自己-->
	<bean id="factoryMethod"  name="ftmd"  class="com.houpu.max.action.FactoryMethod" factory-method="getInstance">
	</bean>
	<alias name="ftmd" alias="fm"/>

	private static FactoryMethod fm = new FactoryMethod();
	private FactoryMethod() {
	}
	public static FactoryMethod getInstance(){
		return fm;
	}
	public void oparetor() {
		System.out.println("我做我自己想做的事");
	}

3.实例工厂方法
	<!-- 使用工厂方法实例化 -->
	<bean id="factoryMethod" class="com.houpu.max.action.FactoryMethod3" />
	
	<bean id="userDao" factory-bean="factoryMethod" factory-method="getInstance" />
	
	<bean id="userBao" factory-bean="factoryMethod" factory-method="getInstance2" />

    private static UserDaoApi userDao = new UserDaoImpl2();
	private static UserDaoApi userBao = new UserDaoImpl();
	
	private FactoryMethod3() {}
	public  UserDaoApi getInstance(){
		return userDao;
	}
	public UserDaoApi getInstance2(){
		return userBao;
	}
	public void oparetor() {
		userDao.login("admin", "123455");
		System.out.println("我做我自己想做的事");
		userBao.login("sadfsfad", "asiofo");
	}