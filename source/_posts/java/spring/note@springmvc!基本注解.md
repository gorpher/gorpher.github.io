SpringMVC的四个基本注解annotation（控制层，业务层，持久层） @Component、@Repository @Service、@Controller

SpringMVC中四个基本注解：

@Component、@Repository   @Service、@Controller
 
看字面含义，很容易却别出其中三个：
@Controller   控制层，就是我们的action层
@Service        业务逻辑层，就是我们的service或者manager层
@Repository  持久层，就是我们常说的DAO层
 
而@Component  （字面意思就是组件），它在你确定不了事哪一个层的时候使用。
 
其实，这四个注解的效果都是一样的，spring都会把它们当做需要注入的Bean加载在上下文中；
但是在项目中，却建议你严格按照除Componen的其余三个注解的含义使用在项目中。这对分层结构的web架构很有好处！！
 
示例：
1.  控制层
@Controller // 注释为controller
@RequestMapping("/login")
public class LoginAction {
 
 @Autowired  
 @Qualifier("userService") //注释指定注入 Bean 
 private IUserService userService;
 
 。。。。。。 其他略 。。。。。。
}
 
2.  业务逻辑层
@Service("userService")
public class UserServiceImpl implements IUserService {
    @Autowired
    @Qualifier("userDao")
    private IUserDao userDao;  
 
 
 。。。。。。 其他略 。。。。。。
}
 
3.  持久层
@Repository("userDao")
public class UserDaoImpl implements IUserDao {
 private static Logger logger = LoggerFactory.getLogger(UserDaoImpl.class);
 private DataSource dataSource;  
    private JdbcTemplate template;  
      
    @Autowired  
    public UserDaoImpl(DataSource dataSource){  
        this.dataSource= dataSource;  
        template = new JdbcTemplate(this.dataSource);  
    }
 
 。。。。。。 其他略 。。。。。。
}