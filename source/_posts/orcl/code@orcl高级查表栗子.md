```
-- 确定一年内的天数
select  add_months(trunc(sysdate,'y'),12)-trunc(sysdate,'y') from dual

-- 查询emp员工表下部门工资前二名的员工信息'
select deptno ,ename,sal from emp e1
where 
       (select count(1) from emp e2 
       where e2.deptno=e1.deptno and e2.ename != e1.ename and e2.sal >e1.sal)<2
 order by deptno , sal desc
 
 -----
 select * from
 (select deptno,ename,sal,row_number() over (partition by deptno 
 order by sal desc) rn
 from emp)
       where  rn <3
 --- 查询某用户下所有表
 select table_name from all_tables where owner = 'SCOTT'
 
--- 分页查询1
select * from (select  rownum no,e.* from 
       (select * from emp order by sal desc) e where rownum <5)where no>3
-- 分页查询2
select * 
       from
               (select rownum no,e.* from (select   * from emp order by sal desc) e)
where 
       no>3 and no<10
       
-- 随机返回5条数据
select * from (select ename,job from emp order by dbms_random.value()) where rownum<=5
-- 处理空值排序
select * from emp order by comm desc nulls last --(first)
-- 查询跳过表的偶数行
select ename from (select row_number() over (order by ename) rn ,ename from emp) where mod(rn,2) =1
-- 查询员工信息与其中工资最高员工最低员工
select ename,sal,max(sal) over(),min(sal) over() from emp
--连续求和
select ename,sal,sum(sal) over(),sum(sal) over(order by ename) from emp;
-- 分部门连续求和
select deptno ,sal ,sum(sal) over(partition by deptno order by ename) as s from emp;

--得到上一行下一行数据
select ename,sal,lead(sal) over (order by sal) aaa,lag(sal) over (order by sal) bbb from emp;

```