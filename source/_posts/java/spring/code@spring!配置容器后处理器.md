  <bean  class="com.beanFactoryProcessor.MyBeanFactoryPostProcessor"/>

public class MyBeanFactoryPostProcessor implements BeanFactoryPostProcessor {
	@Override
	public void postProcessBeanFactory(ConfigurableListableBeanFactory beanFactory)
			throws BeansException {
		System.out.println("程序对Spring所做的BeanFactory的初始化没有改变");
		System.out.println("spring的容器是"+beanFactory);
	}
}



public class Person implements InitializingBean {
	private String name;
	public void setName(String name) {
		System.out.println("Spring 执行依赖关系注入------setName方法");
		this.name = name;
	}
	public Person()
	{
		System.out.println("Spring 实例化bean :Person bean实例------Person构造函数");
	}
	public void information() {
		System.out.print("这个人的名字是：" + name);
	}
	public void init(){
		System.out.println("正在执行初始化 ----------- init方法");
	}
	@Override
	public void afterPropertiesSet() throws Exception {
		System.out.println("正在执行 ----------- afterPropertiesSet方法");
	}
}

public static void main(String[] args) {
		// 读取Spring配置文件
		ApplicationContext act =new     ClassPathXmlApplicationContext("applicationContext.xml");
		//从Spring容器中获取id为p1的bean
		Person p1=act.getBean("p1",Person.class);
		p1.information();
	}
或者使用

public class MyBeanPostProcessor implements BeanPostProcessor {

	@Override
	public Object postProcessAfterInitialization(Object bean, String beanName)
			throws BeansException {
		 System.out.println("Bean后处理器在初始化之后对"+beanName+"进行增强处理");
		return bean;
	}
	@Override
	public Object postProcessBeforeInitialization(Object bean, String beanName)
			throws BeansException {
		
		System.out.println("Bean后处理器在初始化之前对"+beanName+"进行增强处理");
		 //如果该bean是Person类的实例，则改变其属性值
		 if(bean instanceof Person){
			 Person p=(Person)bean;
			 p.setName("maotos");
		 }
		return bean;
	}
}