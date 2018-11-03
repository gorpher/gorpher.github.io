```

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBHelper {

	private final static String DRIVER="com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private final static String URL="jdbc:sqlserver://127.0.0.1:1433;database=taobaoDB";
	private final static String Name="sa";
	private final static String Pwd="123456";

	public static Connection getConn(){
		
		Connection conn = null;
		try {
			Class.forName(DRIVER);  //加载驱动 
			conn = DriverManager.getConnection(URL, Name, Pwd);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
	
	/*	//测试连接
	public static void main(String[] args) {
		System.out.println(getConn());
	}*/
	
	public void close(Connection conn,PreparedStatement ps,ResultSet rs){
		if(rs !=null){
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(ps !=null){
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(conn !=null){
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
}
```