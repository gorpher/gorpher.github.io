```java
1. SQLServer连接--helper工具类
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/*
 * 负责数据库的开关
 */
public class DBHelper {
	//获得连接的方法  将连接返回
	public static Connection openConn(){
		Connection conn = null;
		try {
			//注册驱动
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			//获得连接
			conn = DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;database=newsDB","sa","123456");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	//关闭连接  连接对象作为参数
	public static void closeConn(Connection conn){
		if(conn!=null){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
}
1. oracle连接--helper工具类
public class DBHelper {
	public static Connection getConn() {
		Connection conn=null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:orcl","system","manager");
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return conn;
	}
	public static void colseConn(Connection conn){
		if(conn!=null){
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		}
		
	}
}
3. mysql连接--helper工具类
public class DBHelper {
	public static Connection getConn() {
		Connection conn=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lightnote", "root", "123456");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	public static void colseConn(Connection conn){
		if(conn!=null){
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		}
		
	}
}
```