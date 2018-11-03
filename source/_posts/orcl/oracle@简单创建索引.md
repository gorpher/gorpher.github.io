```

--1.同义词
--访问scott用户下的emp表
SELECT * FROM SCOTT.EMP;

--创建私有同义词
CREATE SYNONYM NEWEMP FOR SCOTT.EMP;

--操作同义词
select * from newemp;

--创建公有同义词
CREATE PUBLIC SYNONYM NEWEMP1 FOR SCOTT.EMP;

select * from newemp1;

--2.序列
--创建序列
CREATE SEQUENCE SEQU1 
START WITH 10
INCREMENT BY 1
MAXVALUE 20
MINVALUE 5
CYCLE
nocache;
--删除序列
DROP SEQUENCE SEQU1;
--从序列取值
SELECT SEQU1.NEXTVAL FROM DUAL;
SELECT SEQU1.CURRVAL FROM DUAL;


delete from score where stuid=109;
--提交
COMMIT;

--3.视图
create or replace view stu_score_view
as
select student.*,scoreId,score from student,score where student.stuid=score.stuid
with read only;
;
--删除视图
drop view stu_score_view;
--基于视图查询
select * from stu_score_view;
--基于视图进行修改数据
update stu_score_view set score=0 where scoreid=3; --可以修改外键表的数据
--错误：update stu_score_view set stuSex='女' where stuid=105; 不能修改主键表的数据


--创建视图存放年龄大于20的学生信息
create or replace view stu_view
as
select * from student where stuage>20
with check option;


select * from stu_view;
update stu_view set stuAge=30 where stuid=102;
update STUDENT set stuAge=0 where stuid=102;


--4.索引
--（1）创建标准索引
CREATE INDEX IDX_STUNAME ON STUDENT(stuname);
--删除索引
DROP INDEX IDX_STUNAME;

--(2)C创建唯一索引(添加了唯一约束)
CREATE UNIQUE INDEX IDX_STUNAME ON STUDENT(stuname);


--（3）组合索引：在经常搜索的多列上添加一个索引
CREATE INDEX IDX_STUNAME ON STUDENT(stuname,stuage);


--（4）位图索引：在类别搜索的列上添加一个索引
CREATE BITMAP INDEX IDX_STUNAME ON STUDENT(stucourse);


--（5）反向索引：操作需要锁定字段时  索引
CREATE INDEX IDX_STUNAME ON STUDENT(stuid) REVERSE;


--（6）区分表索引：数据较多 用分区 索引
CREATE INDEX IDX_STUNAME ON STUDENT(stuid) LOCAL;
CREATE INDEX IDX_STUNAME ON STUDENT(stuid) GLOBAL;

SELECT * FROM STUDENT WHERE stuname like '%a%';
--INSERT INTO STUDENT VALUES(121,'QQ','男',20,1.63,sysdate);
       

SELECT * FROM SCORE;
update score set score=56 where scoreid=1;

```
