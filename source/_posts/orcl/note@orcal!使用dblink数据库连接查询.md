# dblink 简单使用
# 分配权限 grant create public database link,create database link to scott;

1.创建dblink语法：
CREATE [PUBLIC] DATABASE LINK link 

CONNECT TO username IDENTIFIED BY password

USING ‘connectstring’

1) 权限：创建数据库链接的帐号必须有CREATE DATABASE LINK或CREATE PUBLIC DATABASE LINK的系统权限，用来登录到远程数据库的帐号必须有CREATE SESSION权限。这两种权限都包含在CONNECT角色中（CREATE PUBLIC DATABASE LINK权限在DBA中）。一个公用数据库链接对于数据库中的所有用户都是可用的，而一个私有链接仅对创建它的用户可用。由一个用户给另外一个用户授权私 有数据库链接是不可能的，一个数据库链接要么是公用的，要么是私有的。

2)link :  当GLOBAL_NAME=TRUE时，link名必须与远程数据库的全局数据库名global_name）相同；否则，可以任意命名。

3)connectstring：连接字符串，tnsnames.ora中定义远程数据库的连接串。

4)username、password：远程数据库的用户名，口令。如果不指定，则使用当前的用户名和口令登录到远程数据库。

2.删除数据库链接的语句：

DROP [PUBLIC] DATABASE LINK my_link

3.查看已创建的dblink

select owner,object_name from dba_objects where object_type='DATABASE LINK';

4.dblink的引用：

[user.]table|view@dblink

如:SELECT * FROM camel.worker@my_link ;

5.创建同义词：

对于经常使用的数据库链接，可以建立一个本地的同义词，方便使用：
CREATE SYNONYM worker_syn FOR worker@my_link;

6.创建远程视图：

CREATE VIEW worker AS SELECT * FROM worker@my_link where…;
----------------------------------------------------------------------------------------
修改GLOBAL_NAME的方法：

1.在远程数据库的init.ora文件中将global_names设为false。

或者

2.用sys用户执行如下语句：ALTER SYSTEM SET GLOBAL_NAME=TRUE/FALSE;


修改后重新启动数据库设置才能生效。


数据库全局名称可以用以下命令查出：SELECT * FROM GLOBAL_NAME;

-----------------------------------------------------------------------------------------
# 例子
```sql
create database link mylink 
connect to uname identified by pwd 
using '(DESCRIPTION = 
(ADDRESS_LIST = 
(ADDRESS = (PROTOCOL = TCP)(HOST = 10.142.202.12)(PORT = 1521)) 
) 
(CONNECT_DATA = 
(SERVICE_NAME = orcl) 
) 
)'; 
```
如果都是一起的
```sql
　create public database link
　my_link connect to scott identified by tiger using 'orcl.192.168.0.1';
```