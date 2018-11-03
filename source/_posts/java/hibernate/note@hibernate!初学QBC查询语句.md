note@hibernate!初学QBC查询语句
1.实体类Dept 和Employee
```
public class Dept implements Serializable {

	private Integer id;
	private String deptName;
	/*
	constraction and getter setter methods
	*/
}
public class Employee implements Serializable {
	private static final long serialVersionUID = 6641243103508677599L;
	private Integer id;
	private String employeeName;
	private Integer age;
	private String address;
	private Date createTime;
	//多对一,一方配对象
	//private Dept dept;
	//多对多
	private Set<Dept> depts = new HashSet<Dept>(0);
	/*
	constraction and getter setter methods
	*/
}
```
2.ORM关系映射Dept.hbm.xml 和Employee.hbm.xml
```
<hibernate-mapping package="com.hopu.entity">
	<class name="Dept" table="t_dept">
		<id name="id" column="id">
			<generator class="sequence">
				<param name="sequence">seq_dept</param>
			</generator>
		</id>
		<property name="deptName" column="deptname" />
		 <!-- 一对多，多方为集合 -->
		<!--<set name="employees" inverse="true">
			<key column="deptId" />
			<one-to-many class="Employee" />
		</set> -->
		<!-- 多对多，多方用集合表示 -->
		<!-- inverse="true" 控制反转 -->
		<!-- 当在hibernate配置了双向关联，为了提高维护效率，需要将一方的维护权交出 -->
		<!-- 因此在多方添加inverse=true表示交出当前的维护权 -->
		<set name="employees" table="t_employee_dept" inverse="true">
				<key column="dept_id" />
				<many-to-many column="employee_id" class="Employee" />
		</set>
	</class>
</hibernate-mapping>

<hibernate-mapping package="com.hopu.entity">
	<class name="Employee" table="t_employee">
		<id name="id" column="id">
			<generator class="sequence">
				<param name="sequence">seq_employee</param>
			</generator>
		</id>
		
		<property name="employeeName" column="employee_name" />
		<property name="age" column="employee_age" />
		<property name="address" column="employee_address" />
		<property name="createTime" column="createTime" />
		
		<!-- 多对一 -->
		<!-- <many-to-one name="dept" column="deptId"/> -->
		<!-- 多对多，多方用集合表示 -->
		<set name="depts" table="t_employee_dept">
				<key column="employee_id" />
				<many-to-many column="dept_id" class="Dept" />
		</set>
	</class>
</hibernate-mapping>

```
3.DML数据库操作
```
session.beginTransaction();
		//根据部门id查找对应的员工信息
		Dept dept = (Dept)session.get(Dept.class, 2);
		System.out.println("部门对应员工个数: " + dept.getEmployees().size());
		
session.getTransaction().commit();

```
```
		session.beginTransaction();
		//连表查询几种简单方法
		/*1.懒加载式
		Employee employee = (Employee)session.get(Employee.class, 4);
		System.out.println("员工姓名: " + employee.getEmployeeName());
		session.getTransaction().commit();
		System.out.println("部门名称: " + employee.getDept().getDeptName());
		*/

		/*2.query fetch抓取式
		Employee employee = (Employee)session.createQuery("from Employee e inner join fetch e.dept where e.id=4").uniqueResult();
		 session.createCriteria(Employee.class,"emp");
		*/


		/*3.QBC 普通式
		Criteria cri = session.createCriteria(Employee.class,"emp").createCriteria("emp.dept");   
		cri.add(Restrictions.eq("emp.id", 4));
		Employee employee = (Employee) cri.uniqueResult();
		*/
		/*4.QBC fetchMode式
		Employee employee = (Employee)session.createCriteria(Employee.class)
								   .setFetchMode("dept", FetchMode.JOIN)
								   .add(Restrictions.eq("id", 4))
								   .uniqueResult();
		
		System.out.println("员工姓名: " + employee.getEmployeeName());
		//System.out.println("部门名称: " + employee.getDept().getDeptName());
		*/
```

