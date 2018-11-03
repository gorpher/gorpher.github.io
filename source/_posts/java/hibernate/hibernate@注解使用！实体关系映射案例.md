hibernate@注解使用！实体关系映射案例

特别注意：Hibernate的Annotation要依赖于JPA包。

在Hibernate的3.5之前都需要下载Hibernate的Annotation的jar包，在3.5之后Hibernate的Annotation jar包已
经集成到Hibernate包中了。

3.1、基本映射

//注意是javax.persistence.Entity
@Entity
//设置表名
@Table(name="t_user")
public class User {
	private int id;
	private String username;
	private String password;
	private String nickname;
	private Date born;
	private Date createDate;
	
	//@Column可以为这个字段进行定义
	@Column(name="create_date")
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	//标志为id属性
	@Id
	//GeneratedValue表示自动递增
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
3.2、一对一

@Entity
@Table(name="t_id_card")
public class IDCard {
	private int id;
	private String no;
	private Person person;
	
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	
	@OneToOne
	//@JoinColumn可以设置外键的名称。
	//只要使用了OneToOne就会在自己的表中增加外键。
	@JoinColumn(name="pid")
	public Person getPerson() {
		return person;
	}
	public void setPerson(Person person) {
		this.person = person;
	}
@Entity
@Table(name="t_person")
public class Person {
	private int id;
	private String name;
	private IDCard idCard;
	
	//只要设置了@OneToOne就会在自己的表中增加外键，所以只有设置mappedBy="自己在对端的属性名称"
	//才能说明关系由对方维护
	@OneToOne(mappedBy="person") //对端的属性名称，说明关系由对方来维护
	public IDCard getIdCard() {
		return idCard;
	}
	public void setIdCard(IDCard idCard) {
		this.idCard = idCard;
	}
	
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
3.3、一对多

m：1单向：

	@ManyToOne(fetch=FetchType.LAZY) //延迟加载
	//外键名称
	@JoinColumn(name="cid")
	public Classroom getClassroom() {
		return classroom;
	}
	public void setClassroom(Classroom classroom) {
		this.classroom = classroom;
	}
1：m单向：

	@OneToMany
    //加入到对方表中的外键
    @JoinColumn(name="cid")
    //等于xml中的lazy="extra"
	@LazyCollection(LazyCollectionOption.EXTRA)
	public Set<Student> getStudents() {
		return students;
	}
	public void setStudents(Set<Student> students) {
		this.students = students;
	}
双向：

	@ManyToOne(fetch=FetchType.LAZY) //延迟加载
	//外键名称
	@JoinColumn(name="cid")
	public Classroom getClassroom() {
		return classroom;
	}
	public void setClassroom(Classroom classroom) {
		this.classroom = classroom;
	}


    @OneToMany(mappedBy="classroom")
    //@JoinColumn(name="cid")
    //设置了mappedBy就已经等于说明由对方维护关系，所以不同在设置JoinColumn
	@LazyCollection(LazyCollectionOption.EXTRA)
	public Set<Student> getStudents() {
		return students;
	}
	public void setStudents(Set<Student> students) {
		this.students = students;
	}
3.4、多对多

多对多双向：

	@ManyToMany
	//name="t_role_admin"表示关联表的名称，
	//joinColumns={@JoinColumn(name="rid")}表示自己在关联表中的外键名称，是数组
	//inverseJoinColumns={@JoinColumn(name="aid")}表示对方在关联表中的外键名称，也是数组
	@JoinTable(name="t_role_admin",joinColumns={@JoinColumn(name="rid")},
				inverseJoinColumns={@JoinColumn(name="aid")})
	public Set<Admin> getAdmins() {
		return admins;
	}
	public void setAdmins(Set<Admin> admins) {
		this.admins = admins;
	}


    @ManyToMany(mappedBy="admins") //由对方维护关系
	public Set<Role> getRoles() {
		return roles;
	}
	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
两个一对多：

	@OneToMany(mappedBy="course")
	@LazyCollection(LazyCollectionOption.EXTRA)
	public Set<TeacherCourse> getTcs() {
		return tcs;
	}
	public void setTcs(Set<TeacherCourse> tcs) {
		this.tcs = tcs;
	}


    @OneToMany(mappedBy="teacher")
	@LazyCollection(LazyCollectionOption.EXTRA)
	public Set<TeacherCourse> getTcs() {
		return tcs;
	}
	public void setTcs(Set<TeacherCourse> tcs) {
		this.tcs = tcs;
	}


    @ManyToOne
	@JoinColumn(name="tid")
	public Teacher getTeacher() {
		return teacher;
	}
	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}
	
	@ManyToOne
	@JoinColumn(name="cid")
	public Course getCourse() {
		return course;
	}
	public void setCourse(Course course) {
		this.course = course;
	}
	
	<!-- many-to-one用来映射多对一，name表示对象中的属性名称，column用来表示数据库中的外键的名称 -->
		<!-- 当设置了cascade的时候，会自动完成关联，如果添加时没有关联对象，会自动创建一个关联对象 -->
		<!-- 最佳实践：如果没有特殊情况，不要使用cascade，特别注意：可能使用cascade的地方
				一般都是1的一方进行删除时使用，特殊需求才会使用cascade的add，
				正常情况add方法都是应该由程序员完成添加 -->