1、开启服务：先开启Lisenterner服务 再开启ORCL服务
2、oracle登录
   用户：管理员       sysDBA - 无密码 
         系统用户    system - manager
         普通用户 scott - tiger
         
  sqlplus scott/tiger                       DOS窗口中用sqlplus命令，以scott用户的身份登录到oracle
  conn  sys/sys as sysdba;                         以无密码的系统管理员的身份重新连接（相当于SQLSERVER的windows身份验证）
  alter user 用户名 identified by 密码;     更改用户的密码
  show user;                                查看当前登录的用户
  
3、ORCL 数据库
   表空间(tablespace)：在磁盘中形成磁盘文件，相关表的集合
   表（table）
   管理表中的数据(insert delete update select)

4、创建 create 删除drop 修改alter
   创建表空间：	 
	 create tablespace 表空间名
	 datafile '物理存放路径.dbf'
	 size 大小;
    
       create table 表名(
   		列名  数据类型 约束,
   		列名  数据类型 约束,
   		列名  数据类型 约束,
   		....
   )；
   数据类型：
   数字：number 可以存整数和小数，可以指定小数位数  
   							number(P,S)   P精度(小数+整数的位数)  S小数位数
         int  整数
         float 小数
   非数字：char(10)    固定   存储数据时，不够长度以空格填补，要存满10个字节
           varchar(10) 可变   存储的内容实际的长度，不需要存满10个字节
           varchar2(长度) 同 varchar  4000个字符
           long 可变的字符串 2GB
   日期：date
          
6、向表插入数据

7、序列：生成递增的数字
    
    同义词的分类：同义词共有两种类型：
	公有同义词可被所有的数据库用户访问。
	私有同义词只能在其模式内访问，且不能与当前模式的对象同名。
	CREATE (PUBLIC) SYNONYM 同义词名 FOR 模式名.表名;
	
	注意：一个用户对应一个模式
   create sequence 序列名
   start with 初始值
   increment by 递增;
   maxvalue 最大值
   minvalue 最小值
   NOCYCLE/CYCLE
   cache 缓存值;
   缓存值不指定默认为20，nocache缓存预先不分配值，缓存的值必须小于循环的值
   nimvalue与循环（cycle）一起使用，指下次循环的开始值
   start with 起始值 ：第一次取值的起始值
   序列取值：
   			序列名.nextVal  下一个值
   			序列名.currVal  当前值
   			
1、查询
		条件查询、聚合函数、分组查询、连接查询、子查询
		
1、基本查询
select 列信息 from 表名  where 条件 group by 分组列 having  分组后筛选 order by 排序列 acs/desc

2、多表查询：内连接、外连接

3、子查询：作为条件、列、表
   select ... from ... where ...
   update 表 set 列=更新值 where (子查询)
   delete from 表 where （子查询）

4、视图：简化SQL语句,实际存放的是查询语句，不是数据，数据存放在源表中
CREATE [OR REPLACE] VIEW 视图名
as
查询语句
[with check option]  主要针对视图的查询语句带条件，对视图执行修改操作时，不允许使视图的查询结果行数变少
[with read only]  只读


5.索引：提高查询的速度
主键列默认添加索引
(1).标准的索引：create index 索引名 on  表名(列名);
索引添加在经常搜索的列上

(2).唯一索引：索引列值不重复
create unique index 索引名 on  表名(列名);

（3）、组合索引：经常按照多列搜索，则可以在多列上创建一个索引
create index 索引名 on  表名(列名1,列名2);

（4）、反向键索引：列值连续
通常索引是建立在连续增长的列上，使数据均匀地分布在整个索引上，索引存储在硬盘上是以块的形式存储的，
如果数据的修改导致顺序发生改变，则系统会锁定修改记录所在的数据块，这样同一个块中的数据要发生操作必须等待，
大大降低了并发性
反向键索引就是反转索引列中的每一个字节，使数据分散的存放到磁盘不同的块上，提高数据访问的并发性
将反转后的键按照常规索引存储
语法：CREATE INDEX 索引名  ON 表名 (列名) REVERSE;
（5）、位图索引：列值大量重复
语法：CREATE BITMAP INDEX 索引名  ON 表名 (列名);

PL/SQL 是过程语言(Procedural Language)与结构化查询语言(SQL)结合而成的编程语言
PL/SQL 是对 SQL 的扩展
支持多种数据类型，如大对象和集合类型，可使用条件和循环等控制结构
可用于创建存储过程、触发器和程序包，给SQL语句的执行添加程序逻辑
与 Oracle 服务器和 Oracle 工具紧密集成，具备可移植性、灵活性和安全性

优点：
1、可以编写逻辑代码
2、PL/SQL中的代码自动形成一个事物，出现异常就会一起回滚
3、更佳的性能，减少客户端对ORACLE服务器端的访问量，PL/SQL 经过编译执行的
*/

/*
存储过程（procedure）：命名的PL/SQL代码快，类似JAVA的方法
一个功能定义到一个存储过程中，需要使用时直接调用

条件结构
IF 条件 THEN
   语句;
ELSIF 条件 THEN   
      语句;
ELSIF 条件 THEN
      语句;
....
ELSE
    语句N;
END IF;
*/
/*
转账：
1、修改 对方账户 余额增加
2、修改 本账户 余额减少
3、添加 一条 交易记录
*/

--3.根据指定的学号查询的学生的信息，如果存在输出学生信息，不存在提示对应的信息
--带参数的存储过程
CREATE OR REPLACE PROCEDURE PROC1(id student.stuid%type)
AS
   --变量与表中的一行数据进行映射,语法：变量名 表名%rowtype;
   stu student%rowtype;
   num int; --存放根据学号查询的记录行数
begin
   select count(*) into num from student where stuid=id;
   --判断
   if num=0 then
         dbms_output.put_line('学号不存在！');
   else
         select * into stu from student where stuid=id;  
         dbms_output.put_line(stu.stuid||'-'||stu.stuname);
   end if;
end proc1;
--调用存储过程并传参数
call proc1(0);

--循环：
--LOOP循环
/*
LOOP
      EXIT  WHEN  退出循环的条件表达式;
      执行语句;
END  LOOP;
*/
--循环输出1-10
create or replace procedure proc1
as
  i int:=1;  --定义变量并赋初值
begin
  LOOP
      EXIT WHEN I>10;
      dbms_output.put_line(I);
      I:=I+1;
  END LOOP;   
end proc1;

--
CALL PROC1();

--WHILE循环
/*
WHILE循环语法：
WHILE  进行循环条件
LOOP
      执行语句；
END  LOOP;

*/
create or replace procedure proc1
as
  i int:=1;  --定义变量并赋初值
begin
    WHILE i<=10
    LOOP
        dbms_output.put_line(I);
        I:=I+2;
    END LOOP;
end proc1;
--
CALL PROC1();

--for循环
/*
FOR  变量  IN  起始值..结束值
LOOP
      执行语句；
END  LOOP;
*/
create or replace procedure proc1
as
begin
     for i in 1..10
     loop
         dbms_output.put_line(I);
     end loop;
end;
--
call proc1();
--定义存储过程向学生信息表添加20行测试数据
create or replace procedure proc1
as
begin
     for i in 1..20
     loop
         insert into student values(i,'测试'||i,'男',20,1.68,sysdate);
     end loop;
end;
--
call proc1();

--判断某张表是否存在，如果存在就删除
CREATE OR REPLACE PROCEDURE CHECKTABLE(TABLENAME VARCHAR)
AS
  NUM INT;
BEGIN
  SELECT COUNT(*) INTO NUM FROM USER_TABLES WHERE TABLE_NAME=TABLENAME;  
  IF NUM>0 THEN
     --删除表  
     --DROP TABLE TABLENAME;
     EXECUTE IMMEDIATE 'DROP TABLE '||TABLENAME;
  END IF; 
END;
--注意：PL/SQL中不支持DDL语句：create drop，需要使用命令 EXECUTE IMMEDIATE 'DDL语句' 执行
CALL CHECKTABLE('ABC');
CREATE TABLE ABC
(
       EMPID INT
);    


SELECT * FROM USER_TABLES WHERE TABLE_NAME='ABC';


SELECT * FROM STUDENT;
SELECT * FROM SCORE;

commit;




