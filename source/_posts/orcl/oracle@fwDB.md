--房屋出租管理系统 表空间名FwDB
```

create tablespace FwDB 
datafile 'E:\xxs\oracleDBFile\FwDB.dbf'
size 5M
autoextend on next 1M maxsize 30M



--用户信息表(发表出租房屋信息的用户)UserInfo：
--用户编号UserId int 主键
--用户姓名UserName varchar(30) 不能为空
--联系电话UserTel varchar(11) 不能为空
create table userInfo(
userId int primary key ,
userName varchar(30) not null,
userTel varchar(11) not null
)tablespace FwDB;

--房屋类型表(FwLx)：
--类型编号LxId int  主键  
--类型名LxName varchar(20) 不能为空 唯一约束 （列值为别墅、公寓、平房、地下室等等）
create table FwLx
(
lxId int primary key,
lxName varchar(20) not null unique,
)tablespace FwDB

--房屋信息表(FwXx)
--房屋编号FwId  int 主键  
--房屋类型编号LxId  int 外键 引用类型表的类型编号
--房屋地址FwDiZhi varchar(60) 不能为空
--室shi int  不能为空 值大于等于0
--厅ting int  不能为空 值大于等于0
--租金ZuJin  int 不能为空 值大于等于0
--房屋说明FwDesp varchar(500)
--联系人编号userId 外键 引用用户信息表的用户编号
create table FwXx(
fwId int primary key,
lxId int references FwLx(Lxid),
fwDiZhi varchar(60) not null,
shi int not null check(shi>0),
ting int not null check(ting>0),
zuJin int not null check(zuJin>0),
fwDesp varchar(500),
userId references userInfo(userId)
)tablespace FwDB;


insert into userInfo values(0,'admin',110);
insert into userInfo values(1,'system',11234);
insert into userInfo values(2,'matos',1313123);
insert into userInfo values(3,'AMT',3123231);
insert into userInfo values(4,'张三',12323231);
insert into FwLx values(1,'别墅');
insert into FwLx values(2,'公寓');
insert into FwLx values(3,'平房');
insert into FwLx values(4,'地下室');

insert into FwXx values(1,1,'湖北武汉',2,1,1205,'好好好',3);
insert into FwXx values(2,2,'湖北武汉光谷广场',4,2,2146,'好好好',1);
insert into FwXx values(3,2,'湖北武汉江夏',2,2,1008,'好好好',3);
insert into FwXx values(4,3,'湖北武汉藏龙岛',3,2,645,'好好好',2);
insert into FwXx values(5,4,'湖北武汉软件工程学院',1,1,205,'好好好',2);
insert into FwXx values(6,4,'湖北武汉软件工程学院',1,2,705,'好好好',2);
insert into FwXx values(7,3,'湖北武汉软件工程学院',1,2,605,'好好好',4);

--.按要求建库、建表、建约束

--2.向每张表中添加数据，每张表不少于3行

--3.将编号为1的用户的联系电话修改为13088888888
update userInfo set userTel=13088888888 where userId=1;
--4.将所有房屋的租金加200
update FwXx set zuJin=zuJin+200 ;
--5.删除租金大于8000的房屋信息
--delete FwXx where zuJin>8000;
--6.查询所有1室2厅的房屋信息
select * from FwXx where shi=1 and ting=2 ;
--7.查询租金在200-500之间的房屋信息
select * from FwXx where zuJin >=200 and zuJin<=500;
--8.查询房屋类型为‘地下室’的房屋信息
select * from  FwXx where  lxId=(select lxId from FwLx where lxName='地下室');
--9.查询房屋说明中有“好”字的房屋编号、租金和联系人姓名以及电话
select fwId,zuJin,u.userName,u.userTel from FwXx f,userInfo u where fwDesp like '%好%' and f.userId=u.userId; 
--select fwId,zuJin,(select * from userInfo u where u.userId=f.userId ) as userName from FwXx f where fwDesp like '%好%' ;
--10.查询房屋类型为“公寓”或“别墅”的房屋信息
--select * from FwXx where lxId in(1,2);select lxId from FwLx where lxName='公寓',select lxId from FwLx where lxName='别墅'
select * from FwXx where lxId in(select lxId from FwLx where lxName in('公寓','别墅'));
--11.查询房屋类型为“平房”的房屋的编号、租金、联系人姓名以及电话
select fwId,zujin,u.userName,u.userTel from FwLx l,userInfo u,FwXx f where l.lxname='平房' and f.lxid=l.lxid and u.userId=f.userid;
--12.查询房屋地址在光谷的房屋信息，并按租金降序显示查询结果
select * from fwxx where fwdizhi like '%光谷%' order by zujin desc;
--13.查询所有房屋的数量，平均租金，最高租金，以及最低租金
select sum(zujin)总数,avg(zujin)平均租金,max(zujin)最高租金,min(zujin)最低租金 from fwxx;
--14.查询房屋类型是“平房”的最高租金
select max(zujin) 最高租金 from fwxx where lxid=(select lxId from FwLx where lxName='平房');
--15.查询每种类型的房屋的数量，平均租金，最高租金，以及最低租金
select  lxid, sum(zujin) 房屋数量,avg(zujin) 平均租金,max(zujin) 最高租金 ,min(zujin)最低租金 from fwxx group by lxid 
--16.查询房屋的编号，房号地址，房屋租金，类型名称、发布用户的姓名和联系电话
select f.fwid,fwdizhi,zujin,l.lxName,u.userName,u.userTel from fwxx f,fwlx l,userinfo u where f.lxid=l.lxid and f.userId=u.userid;
--17.查询联系人姓名为“张三”的所有的房屋信息
select * from fwxx where userId=(select userId from userInfo where userName='张三');
--18.查询没有发布房屋信息的联系人信息
select * from userinfo where userid not in(select userid  from fwxx);

----
select * from userInfo;
select * from FwLx;
select * from FwXx;
```
