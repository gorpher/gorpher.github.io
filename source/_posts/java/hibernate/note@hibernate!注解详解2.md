note@hibernate!注解详解2
@Column —— 注解声明了属性到列的映射。该注解有如下的属性 
  name  可选，列名（默认值是属性名） 
  unique 可选，是否在该列上设置唯一约束（默认值false） 
  nullable 可选，是否设置该列的值可以为空（默认值false） 
  insertable 可选，该列是否作为生成的insert语句中的一个列（默认值true） 
  updatable 可选，该列是否作为生成的update语句中的一个列（默认值true） 
  columnDefinition 可选，为这个特定列覆盖sql ddl片段（这可能导致无法在不同数据库间移植） 
  table 可选，定义对应的表（默认为主表） 
  length 可选，列长度（默认值255） 
  precision 可选，列十进制精度（decimal precision)(默认值0） 
  scale 可选，如果列十进制数值范围（decimal scale）可用，在此设置（默认值0）  
 precision属性和scale属性表示精度时，当字段类型为double时，precision表示数值的总长度，scale表示小数点所占的位数。 

@Digits(integer=12, fraction=3)  检查此值是否是一个数字,并且这个数字的整数部分不超过integer定义的位数, 和小数部分不超过fraction 定义的位数.[对应的数据库表字段会被设置精度(precision)和准度(scale)]

@Email   检查所给的字符串是否符合email地址的格式

@Future 检查给定的日期是否比现在晚

@Past检查标注对象中的值表示的日期比当前早.

@Length(min=, max=)检查该字符串的长度是否在min 和 max规定的范围内.[对应的数据库表字段的长度会被设置成约束中定义的最大值]

@Max检查该值是否小于或等于约束条件中指定的最大值.[会给对应的数据库表字段添加一个check的约束条件]

@NotNull检查该值不为null[对应的表字段不允许为null]

@NotBlank检查该字符串不为null,并且不是空字符串. 本约束和下面的@NotEmpty的不同之处在于,本约束只能被用在字符串类型上,并且会忽略字符串尾部的空

@NotEmpty检查该值不为null同时也不为空.  

@Null检查该值应该为null.

@Range(min=, max=)检查该值是否在[min, max)之间

@Size(min=, max=)检查该值的size是否在[min, max)之间.[对应的数据库表字段的长度会被设置成约束中定义的最大值.]

@URL(protocol=, host=, port=)判断该值是否是一个有效的URL, 如果给出了约束中的protocol, host 或 port 参数的话,那个被校验的值需要和其匹配.

@Valid 递归得对关联对象进行校验, 如果关联对象是个集合或者数组, 那么对其中的元素进行递归校验,如果是一个map,则对其中的值部分进行校验.

@Transient表示该属性并非是一个到数据库表的字段的映射,ORM框架将忽略该属性.
被注解成 @Transient 的 getter 方法或属性，将不会被持久化，hibernate 会忽略这些字段和属性。
 如果一个属性并非数据库表的字段映射,就务必将其标示为@Transient,否则,ORM框架默认其注解为@Basic

@Basic 所有没有定义注解的属性，等价于在其上面添加了 @Basic 注解。通过 @Basic注解可以声明属性的获取策略 ( fetch strategy )，默认的是即时获取(early fetch),这里又讨论到了 
延迟关联获取和延迟属性获取,通常不需要对简单属性设置延迟获取,如需要定义@Basic(fetch=FetchType.LAZY) 
通过@Basic注解可以声明属性的获取策略(lazy与否),默认的是即时获取(early fetch),这里又讨论到了 
延迟关联获取和延迟属性获取,通常不需要对简单属性设置延迟获取,如需要定义@Basic(fetch=FetchType.LAZY) 

@OrderBy(value = "id ASC") 指明加载OrderItem 时按id 的升序排序

hierbate search注解【基于lucene】

@DateBridge(resolution = Resolution.SECOND) 因为lucene有些版本现在貌似只能对字符串进行索引【新的版本貌似支持数值索引】，所有date类型需要转换成string，Resolution.SECOND就是解析成秒格式的字符串，有以下参数

Resolution.YEAR: yyyy

Resolution.MONTH: yyyyMM

Resolution.DAY: yyyyMMdd

 Resolution.HOUR: yyyyMMddHH

Resolution.MINUTE: yyyyMMddHHmm

Resolution.SECOND: yyyyMMddHHmmss

Resolution.MILLISECOND: yyyyMMddHHmmssSSS

@MappedSuperclass  基于代码复用和模型分离的思想，在项目开发中使用JPA的@MappedSuperclass注解将实体类的多个共同属性封装到非实体类中，适合父类和子类的关系

    0、 @MappedSuperclass注解只能标注在类上

    1、标注为@MappedSuperclass的类将不是一个完整的实体类，他不会映射到数据库表，但是他的属性都将映射到其子类的数据库字段中。

    2、标注为@MappedSuperclass的类不能再标注@Entity或@Table注解，也无需实现序列化接口。


    3、如果一个标注为@MappedSuperclass的类继承了另外一个实体类或者另外一个同样标注了@MappedSuperclass的类的话，他将可以使用@AttributeOverride或@AttributeOverrides注解重定义其父类(无论是否是实体类)的属性映射到数据库表中的字段。比如可以重定义字段名或长度等属性，使用@AttributeOverride中的子属性@Column进行具体的定义。

    注意：对于其父类中标注@Lob注解的属性将不能重载，并且@AttributeOverride里的@Column设置都将不起作用。JPA规范中对@Lob注解并没有说明不能同时标注@Column注解，但是在实际使用中Hibernate JPA不支持这种标注方式。

    4、标注为@MappedSuperclass的类其属性最好设置为protected或default类型的，以保证其同一个包下的子类可以直接调用它的属性。