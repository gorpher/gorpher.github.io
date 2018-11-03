/*学生信息表*/
create table student
(
       stuId number(4) primary key,
       stuName varchar2(20) not null,
       stuSex varchar2(2),
       stuAge number(2),
       stuHeight number(3,2),
       stuDate date
 );
 /*添加数据*/
 insert into student values(105,'aa','男',25,1.69,'1-8月-2012');
 insert into student values(101,'an','女',20,1.69,'1-8月-2012');
 insert into student values(104,'ka','女',15,1.69,'1-8月-2012');
 insert into student values(108,'dd','男',35,1.69,'1-8月-2012');
 insert into student values(109,'mm','男',35,1.69,'1-2月-2013');
  insert into student values(102,'QQ','男',null,1.69,'1-2月-2013');

/*分数信息表*/
create table score
(
 scoreId number(4) primary key,
 stuId number(4) references student(stuId),
 score number(5,2)
);
insert into score values(1,101,96);
insert into score values(3,105,87);
insert into score values(6,104,67);
insert into score values(7,108,56);
insert into score values(8,109,84);
insert into score values(2,105,42);
insert into score values(4,105,25);
insert into score values(5,108,40);
insert into score values(9,109,30);

select * from  student;
select * from  score;
--1.查询参加考试的学生的学号、姓名、以及考试成绩
select  d.stuid,d.stuname,s.score  from  student d,score s  where d.stuid=s.stuid; --内链表查询
select  d.stuid,d.stuname,s.score  from  student d right  join score  s on d.stuid=s.stuid; --外链表查询
select (select  stuid from student where stuid=score.stuid)  stuid,(select stuName from student where stuid=score.stuid) stuname ,score from score; --子查询作为列
--2.查询参加考试的学生的学号、姓名、以及考试成绩，只显示及格的数据
select  d.stuid,d.stuname,s.score  from  student d,score s  where d.stuid=s.stuid and s.score>=60; --内链表查询
--3.查询参加考试的学生的姓名、参加考试的次数，考试的平均分，并按照平均分降序排列
select (select stuName from student where stuid=score.stuid)  姓名, count(*) 參加考試的次數 , avg(score) 平均分  from score group by stuid order by  avg(score) desc ; --子查询作为列
--4.查询男、女生考试的平均分
select  d.stusex,avg(s.score)平均分  from  student d,score s  where d.stuid=s.stuid group by d.stusex; --内链表查询
--5.查询所有学生的学号、姓名以及考试的分数，没有成绩的以NULL填充
select  d.stuid,d.stuname,s.score  from  student d  left  join score  s on d.stuid=s.stuid; --外链表查询
--6.查询没有参加考试的学生学号和姓名
select  stuid,stuname  from student where stuid not in(select  stuid  from  score); --子查询
select  d.stuid,d.stuname,s.score  from  student d  left  join score  s on d.stuid=s.stuid where s.score is null; --外链表條件查询

