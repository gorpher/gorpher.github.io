--创建表空间
create tablespace myDB
datafile 'E:\xxs\Oracle学习笔记\tablespaceFile\myDB.dbf'
size 5M;
--更改表空间名称
alter tablespace myDB
rename to myODB
--在表空间下添加数据文件
alter tablespace myODB
add datafile'E:\xxs\Oracle学习笔记\tablespaceFile\myODB.dbf'
size 5M;
--修改表空间下的数据文件
alter database
datafile 'E:\xxs\Oracle学习笔记\tablespaceFile\myODB.dbf'
resize 10M;
--修改表空间下的数据文件 ：允许自动扩展，每次增长5M，最大容量为50M
alter database
datafile 'E:\xxs\Oracle学习笔记\tablespaceFile\myODB.dbf'
autoextend on next 5M Maxsize 50M;
--删除表空间
--drop tablespace myODB;--查询表空间
select * from user_tablespaces where tablespace_name ='MYODB'
--查询表
select * from user_tables  where table_name='SYSTEM'


/*
create tablespace myODB
datafile 'E:\xxs\oracleDBFile\myodb.dbf'
size 5M
autoextend on next 5M maxsize 50M;
*/
--在表空间myODB下创建部门信息表

--drop table deptInfo;
create table deptInfo
(
 --deptId number(8,2)  --整数+小数的位数为8位，小数2位
 deptId int primary key,
 deptName varchar2(20) unique not null,  --unique唯一约束
 deptDesp varchar2(100)
)tablespace myODB;

--drop table deptInfo;
/*
insert into deptInfo values(1);
insert into deptInfo values(1.5);
insert into deptInfo values(0.96);
insert into deptInfo values(0.968593);
insert into deptInfo values(123456.96);
*/

--注意：创建表时，不指定表空间，默认表创建到system表空间下
--系统表：
--user_tables:当前登录用户下的所有的表
--user_tablespaces：当前登录用户下的所有的表空间
select * from user_tables where TABLE_NAME='DEPTINFO'; 
select * from user_tablespaces;

--在表空间empDB2下创建员工信息表
create table empInfo
(
 empId int primary key,
 empName varchar2(20) not null,
 empSex char(2) check(empSex='男' or empSex='女'),
 empAge int check(empAge>=18 and empAge<=60),
 empAdd varchar2(20) default('湖北武汉'),
 empDate date default(sysdate), --sysdate获取系统当前时间
 deptId int references  deptInfo(deptId)
)tablespace myODB;

--添加数据
insert into deptInfo values(1,'人事部','无');
insert into deptInfo values(2,'财务部','无');
insert into deptInfo values(3,'市场部','无');

insert into empInfo values(101,'matos','男',20,default,default,1);
insert into empInfo values(102,'admin','男',23,default,default,2);
insert into empInfo values(103,'root','女',20,default,default,2);
insert into empInfo values(104,'sa','女',20,default,'8-9月-2016',2);
insert into empInfo values(105,'李易峰','男',20,default,sysdate,2);
--查询
select * from deptInfo;
select * from empInfo;

--序列(sequence)：产生连续递增的数字
/*
create sequence 序列名 
start with 起始值 
increment by 增长值; 
*/
create sequence seq_empid  
start with 1001  
increment by 2; 
--dual虚拟表，为了完善语法
--查询序列的下一个值
select seq_empid.nextval from dual;


--删除员工表的数据
delete from empInfo;

--添加员工信息表的数据，用序列作为编号
insert into empInfo values(seq_empid.nextval,'八十','女',20,default,default,1);
insert into empInfo values(seq_empid.nextval,'艾斯比','女',20,default,default,2);
insert into empInfo values(seq_empid.nextval,'老子','女',20,default,default,2);
insert into empInfo values(seq_empid.nextval,'少女時代','女',20,default,'8-9月-2016',2);
insert into empInfo values(seq_empid.nextval,'是否','女',20,default,sysdate,2);


select * from deptInfo;
