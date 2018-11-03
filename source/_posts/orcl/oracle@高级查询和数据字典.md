topN查询
select  * from emp where rownum=1   or   rownum=2;
select * from   (select * from emp order by    sal desc) where rownum<5;
分页查询
1，
select *    from    (select rownum  no,e.*   from(select * from emp order by sal desc) e where rownum<=5) where no>=3;  
2，
select * from  (select rownum  no,e.* from(select * from emp order by sal  desc)e) where no>3 and no<=5;
exist
select * from t1 where exists (select null from t2 where y=x);
for x in (select * from t1)
loop
    if(exist(select null from t2 where y=x.x))
    
    then
    output the record
     end if;
end loop;
select 1 from dual where null in (0,1,2,null);

多行子查询
select * from emp   where sal>any(select avg(sal) from emp group by deptno);
select * from emp   where sal>all(select avg(sal) from emp group by deptno);
select * from emp   where  job in (select job from emp where ename='MARTIN' or ename='SMITH');

随机返回6条记录
select * from (select ename,job from emp order by dbms_random.value())      where rownum<=6;


处理空值排序  last(first)
select * from emp order by comm desc nulls     last;

查询跳过表中的偶数行
select ename from (select row_number() over (order by ename) rn,ename   from emp) x where mod(rn,2)=1;
查找员工信息与其工资最高最低员工
select ename,sal,max(sal) over(),min(sal) over() from emp;
连续求和
select ename,sal,sum(sal) over(),sum(sal) over(order by ename) from emp;
sum(sal) over(order by ename) 指的是连续求和，是以ename来排序的，若有两个这样的窗口函数，以后面的排序为主。

分部门连续求和
select deptno,sal,sum(sal) over (partition by deptno order by ename) as s from emp;

得到上一行或下一行的数据
select ename,sal,lead(sal) over (order by sal) aaa,lag(sal) over(order by sal) bbb from emp;
统计每月及上个月和下个月的总收入  月份month 人员person 收入income
select [month] ,sum([income]),lead(sum ([income])) over(order by sum([income]))   from [table] group by [month];

根据子串分组
select to_char(hiredate,'yyyy'),avg(sal) from emp group by to_char(hiredate,'yyyy');
确定一年的天数
select add_months(trunc(sysdate,'y'),12)-trunc(sysdate,'y')  as 天数 from dual;

查询emp员工表下每个部门工资前二名的员工信息
1.
select deptno,ename,sal from emp e1 where (select count(1) from emp e2 where e2.deptno=e1.deptno and e2.ename!=e1.ename and e2.sal>e1.sal)<2 order by deptno, sal desc;
2.
select * from (select deptno ,ename,sal,row_number() over (partition by deptno order by sal desc) rn  from emp)  where rn<3;


数据字典
查询某用户下所有的表
select table_name from all_tables where owner='SCOTT';
查询emp表中所有字段（列）
select * from all_tab_columns where table_name='TEMP';
列出表的索引列
select *from  sys.all_ind_columns where table_name='TEMP';
select * from sys.all_ind_columns where upper(table_name)='CAREUSERHAM';
列出表中约束
select  * from all_constraints where table_name='TEMP';
在oracle中描述数据字典视图
select table_name,comments from dictionary where table_name like '%TABLE%';

