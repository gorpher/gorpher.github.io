> 利用经典的三张表实现，学生表（stuinfo），课程表（stucourse）和成绩表（stuscore）

##  创建表 ##

```
create table stuinfo(
stuid char(12) primary key,
stuname varchar(6) ,
stuage int check(stuage>18 and stuage<60)
);
```

```
create table stucourse(
coid int  primary key,
coname varchar2(20) not null,
colevel int 
);
```

```
create table  stuscore(
stuid char(12) references stuinfo(stuid),
coid int references stucourse(coid),
score number(3) check(score>=0 and score <=100) not null,
scdate date  default(sysdate)
);
```

创建序列
------

```
create sequence studid
increment by 1
start with 1
maxvalue 9999
minvalue 1
cycle;
```

单行手动插入测试
----------

```
insert into stuinfo values (TO_CHAR(sysdate,'YYYYMMDD')||LPAD(studid.nextval,4,'0'),'孙悟空',23);
insert into stucourse values(1,'计算机基础',1);
```

> 查查表

```
select * from stuinfo;
```

> 利用存储过程插入表stuscore和stuinfo
因为stuid是通过序列和sysdate生成的，因此手动给学生插入成绩就不方便，本人定义一个存储过程，实现
数据库插入测试数据

```
CREATE OR REPLACE PROCEDURE INSERT_TABLE(NUM INT)
AS
 I INT:=1;
  id STUINFO.STUID%type;
BEGIN
     WHILE I<NUM
     LOOP
        dbms_output.put_line(I);
        id := TO_CHAR(sysdate,'YYYYMMDD')||LPAD(studid.nextval,4,'0');
         INSERT INTO stuinfo VALUES (id,TO_CHAR('u'||studid.nextval),FLOOR((DBMS_RANDOM.VALUE*40)+20));
         INSERT INTO stuscore VALUES(id,1,66,default);
        I:=I+1;
       END LOOP;
END INSERT_TABLE;
```

> 插入20条数据

```
CALL INSERT_TABLE(20);
```


----------


## 高级查询##

 1. 随机返回条数据

```
select * from (select * from stuinfo order by dbms_random.value()) where rownum<=5;
```
 2. 处理空值排序last(first)

```
select * from 	stuscore	order	by	score	desc	nulls	last;
```

3.  跳过表中的偶数行

```
select	*	from	(select	row_number()	over	(order by	stuname)	rn,stuname	from	stuinfo)  where	mod(rn,2)=1;
```

4. 确定一年的天数

```
select add_months(trunc(sysdate,'y'),12)-trunc(sysdate,'y') from	dual;
```