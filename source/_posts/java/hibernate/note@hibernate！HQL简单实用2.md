note@hibernate！HQL简单实用2
1.util类
```
//HibernateSessionFactory.getSession().createQuery("HQL")
			//1、查询所有的学生信息     默认 list中封装的是实体类，一行数据是一个实体类
			//String hql= "from Student";//list<实体类>
			
			
			//2.查询部分列(1)   默认  list中封装的是数组，一行数据是一个数组
			//String hql="select stu.stuid,stu.stuname from Student stu";
			
			
			//3.查询部分列（2） list中封装的是实体类， 一行数据是一个实体类，注意问题：实体类中有对应的构造方法
			//String hql="select new Student(stu.stuid,stu.stuname) from Student stu";
			
			
			//4.查询部分列（3） list中封装的是Map， 将每行数据封装成Map对象
			//String hql="select new Map(stu.stuid as id,stu.stuname as name,stu.stuage as age) from Student stu";
			
			
			//5.条件查询(通过?设置参数)
			//用户输入的值
//			int age = 18; 
			
//			String hql = "from Student stu where stu.stuage>?";
//			Query query = HibernateSessionFactory.getSession().createQuery(hql);
//			//设置参数的值，注意参数的索引号从0开始
//			query.setLong(0, age);
			
			
			//6.条件查询2 （通过参数名设置参数）
			//用户输入的
//			int age=15;
//			String name="x";
			
//			String hql="from Student stu where stu.stuage>:a and stu.stuname like :b order by stu.stuage";
//			Query query = HibernateSessionFactory.getSession().createQuery(hql);
//			//设置参数的值
//			query.setLong("a", age);
//			query.setString("b", "%"+name+"%");
			
			//7.聚合函数查询:查询所有学生平均年龄
//			String hql="select avg(stu.stuage) from Student stu";
//			Query query = HibernateSessionFactory.getSession().createQuery(hql);
//			return query.list();
			
			//8.表连接查询  集合封装的是数组，数组的元素student  room的实体类
//			String hql="from Student stu inner join stu.room";
//			Query query = HibernateSessionFactory.getSession().createQuery(hql);
//			return query.list();
			
			//9.表连接查询  集合封装的是实体类，fetch:抓取
//			String hql="from Student stu inner join fetch stu.room";
//			Query query = HibernateSessionFactory.getSession().createQuery(hql);
//			return query.list();
			
			//10.分页查询  pageNo当前的页码   pageSize:每页显示的数据行
			int pageNo=2,pageSize=8;
			String hql="from Student stu order by stu.stuid";
			Query query=HibernateSessionFactory.getSession().createQuery(hql);
			//setFirstResult(arg0)  该页的起始行号
			//setMaxResults(arg0)  每页显示的最大的数据行数
			query.setMaxResults(pageSize);
			//pageNo:1  0-4   
			//       2  5-9
			//       3  10-14
			query.setFirstResult(pageSize*(pageNo-1));
			//11. 查询每个寝室的地址 以及 该寝室的人数
			return query.list();
```
2.测试返回结果
```
public static void main(String[] args) {
		StuDao stuDao = new StuDao();
		//1、查询所有学生信息
		List<Student> list = stuDao.findAll();
		for (Student stu : list) {
			Room room = stu.getRoom();
				System.out.println(stu.getStuid()+"\t"+stu.getStuname()+"\t"+room.getRoomaddress());
		}
		
		//2.查询部分列 (1)
		List<Object[]> list = stuDao.findAll();
		for (Object[] objects : list) {
			System.out.println(objects[0]+"\t"+objects[1]);
		}
		
		//3.查询部分列（2）
		List<Student> list = stuDao.findAll();
		for (Student student : list) {
			System.out.println(student.getStuid()+"\t"+student.getStuname());
		}
		
		//4.查询部分列（3）
		List<Map<String, Object>> list = stuDao.findAll();
		for (Map<String, Object> map : list) {
			System.out.println(map.get("id")+"\t"+map.get("name")+"\t"+map.get("age"));
		}
		
		//5.条件查询
		List<Student> list = stuDao.findAll();
		for (Student stu : list) {
			Room room = stu.getRoom();
//HibernateSessionFactory.getSession().createQuery("HQL")
			//1、查询所有的学生信息     默认 list中封装的是实体类，一行数据是一个实体类
			//String hql= "from Student";//list<实体类>
			
			
			//2.查询部分列(1)   默认  list中封装的是数组，一行数据是一个数组
			//String hql="select stu.stuid,stu.stuname from Student stu";
			
			
			//3.查询部分列（2） list中封装的是实体类， 一行数据是一个实体类，注意问题：实体类中有对应的构造方法
			//String hql="select new Student(stu.stuid,stu.stuname) from Student stu";
			
			
			//4.查询部分列（3） list中封装的是Map， 将每行数据封装成Map对象
			//String hql="select new Map(stu.stuid as id,stu.stuname as name,stu.stuage as age) from Student stu";
			
			
			//5.条件查询(通过?设置参数)
			//用户输入的值
		int age = 18; 
			
			String hql = "from Student stu where stu.stuage>?";
			Query query = HibernateSessionFactory.getSession().createQuery(hql);
			//设置参数的值，注意参数的索引号从0开始
		query.setLong(0, age);
			
			
			//6.条件查询2 （通过参数名设置参数）
			//用户输入的
			int age=15;
			String name="x";
			
			String hql="from Student stu where stu.stuage>:a and stu.stuname like :b order by stu.stuage";
			Query query = HibernateSessionFactory.getSession().createQuery(hql);
			//设置参数的值
			query.setLong("a", age);
			query.setString("b", "%"+name+"%");
			
			//7.聚合函数查询:查询所有学生平均年龄
		String hql="select avg(stu.stuage) from Student stu";
		Query query = HibernateSessionFactory.getSession().createQuery(hql);
		return query.list();
			
			//8.表连接查询  集合封装的是数组，数组的元素student  room的实体类
		String hql="from Student stu inner join stu.room";
		Query query = HibernateSessionFactory.getSession().createQuery(hql);
		return query.list();
			
			//9.表连接查询  集合封装的是实体类，fetch:抓取
		String hql="from Student stu inner join fetch stu.room";
		Query query = HibernateSessionFactory.getSession().createQuery(hql);
		return query.list();
			
			//10.分页查询  pageNo当前的页码   pageSize:每页显示的数据行
			int pageNo=2,pageSize=8;
			String hql="from Student stu order by stu.stuid";
			Query query=HibernateSessionFactory.getSession().createQuery(hql);
			//setFirstResult(arg0)  该页的起始行号
			//setMaxResults(arg0)  每页显示的最大的数据行数
			query.setMaxResults(pageSize);
			//pageNo:1  0-4   
			//       2  5-9
			//       3  10-14
			query.setFirstResult(pageSize*(pageNo-1));
			//11. 查询每个寝室的地址 以及 该寝室的人数
			return query.list();		System.out.println(stu.getStuid()+"\t"+stu.getStuname()+"\t"+room.getRoomaddress()+"\t"+stu.getStuage());	}
		
		//6.聚合查询
	List list = stuDao.findAll();
	System.out.println(list.get(0));
		
		//uniqueResult()方法的使用： 返回唯一值
	Object obj = stuDao.find();
	System.out.println(obj);
		
		//8.表连接查询
	List<Object[]> list = stuDao.findAll();
	for (Object[] objects : list) {
		//System.out.println(objects[0]+"\t"+objects[1]);
		Student stu = (Student) objects[0];
		Room room = (Room) objects[1];
		System.out.println(stu.getStuname()+"\t"+room.getRoomaddress());
	}
		
		//9.
		List<Student> list = stuDao.findAll();
		for (Student s : list) {
			System.out.println(s.getStuname()+"\t"+s.getRoom().getRoomaddress()+"\t"+s.getRoom().getRoomid());
	}
		
		//10.分页：pageNo当前的页码   pageSize:每页显示的数据行
		List<Student> list = stuDao.findAll();
		for (Student student : list) {
			System.out.println(student.getStuid()+"\t"+student.getStuname());
		}
	}
```