note@mysql学习笔记!对用户账户管理
```

--创建用户，并分配权限；
	1.通过分配权限创建一般分为四种情况
	
			//创建用户名为matosiki密码为matosiki的用户，并分配最高权限，可用任何主机。
		GRANT ALL PRIVILEGES ON *.* TO 'matosiki'@'%' IDENTIFIED BY 'matosiki' WITH GRANT OPTION;
		
			//创建用户名为matosiki密码为matosiki的用户，并分配最高权限，只能在本机访问。
		GRANT ALL PRIVILEGES ON *.* TO 'matosiki'@'localhost' IDENTIFIED BY 'matosiki' WITH GRANT OPTION;  
		
			// 一个账户有用户名admin，没有密码。该账户只用于从本机连接。授予了RELOAD和PROCESS管理权限。
			//这些权限允许admin用户执行mysqladmin reload、mysqladmin refresh和mysqladmin flush-xxx命令，
			//以及mysqladmin processlist。未授予访问数据库的权限。你可以通过GRANT语句添加此类权限。
		GRANT RELOAD,PROCESS ON *.* TO 'admin'@'localhost';
			// 一个账户有用户名dummy，没有密码。该账户只用于从本机连接。未授予权限。通过GRANT语句中的USAGE权限，
			//你可以创建账户而不授予任何权限。它可以将所有全局权限设为'N'。假定你将在以后将具体权限授予该账户。
		GRANT USAGE ON *.* TO 'dummy'@'localhost';
		
		除了GRANT，你可以直接用INSERT语句创建相同的账户，然后使用 FLUSH PRIVILEGES告诉服务器重载授权表：
	2.	
			分配数据库wb_map的所有操作权限给 admin账户
			GRANT all ON wb_map.* TO 'admin'@'%' identified by 'admin' with grant option;
	
	3.查看数据用户
		> use mysql
		> select * from user;
	4.删除用户
		@>mysql -u root -p

　　	@>密码

 　　mysql>Delete FROM user Where User='test' and Host='localhost';

 　　mysql>flush privileges;

 　　mysql>drop database testDB; //删除用户的数据库

		删除账户及权限：>drop user 用户名@'%';

　　　　　　　　>drop user 用户名@ localhost; 

	5.修改指定用户密码

  　　@>mysql -u root -p

  　　@>密码

  　　mysql>update mysql.user set password=password('新密码') where User="test" and Host="localhost";

  　　mysql>flush privileges;
  
  
	5. 列出所有数据库

　　mysql>show database;

		

	6. 切换数据库

	　　mysql>use '数据库名';

	 

	7. 列出所有表

	　　mysql>show tables;

	 

	8. 显示数据表结构

	　　mysql>describe 表名;						
```
