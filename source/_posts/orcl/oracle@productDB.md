create tablespace productDB --商品管理系统 表空间名：ProductDB
datafile 'E:\xxs\oracleDBFile\productDB.dbf'
size 5M
autoextend on  next 5M maxsize 30M; 

/*
商品类型表TypeInfo：
类型编号typeId int 主键
类型名typeName varchar(50) 不能为空
*/
create table typeInfo(
       typeId int primary key ,
       typeName varchar(50) not null
)tablespace productDB;

/*
商品信息表ProductInfo：
商品编号proId int 主键
商品名proName varchar(30) 不能为空 唯一约束
所属的类型编号typeId  int 外键
库存数量proNum int 值大于等于0
备注proDesp varchar(100)
*/
create table productInfo(
             proId int primary key,
             proName varchar(30) not null unique ,
             typeId int references typeInfo(typeId),
             proNum int check(proNum>0),
             proDesp varchar(100)
)tablespace productDB;


/*
商品销售表(SellInfo)：
销售编号sellId   int  主键
销售日期sellDate date默认为系统当前日期
销售的商品的编号proId  int  外键
销售数量sellNum int 值大于0
销售单价sellPrice float 值大于0
备注sellDesp varchar(50)
*/
create table sellInfo(
             sellId int primary key,
             sellDate date default(sysdate),
             proId int references productInfo(proId),
             sellNum int check(sellNum>0),
             sellPrice float check(sellPrice>0),
             sellDesp varchar(50)
)tablespace productDB

--1.按要求建库、建表、建约束
--2.向每张表中添加数据，每张表不少于3行
insert into typeInfo values(1,'手機');
insert into typeInfo values(2,'電腦');
insert into typeInfo values(3,'服裝');
insert into typeInfo values(4,'食品');
insert into typeInfo values(5,'圖書');

insert into productInfo values(1,'小米note',1,503,'小米手機');
insert into productInfo values(4,'華為V8',1,543,'華為手機');
insert into productInfo values(2,'surface book',2,233,'微軟電腦');
insert into productInfo values(3,'Adidas服裝',3,1343,'名牌系列');
insert into productInfo values(5,'設計模式',5,23,'java編程書籍');
insert into productInfo values(6,'檸檬水',4,2123,'水果飲料');
insert into productInfo values(7,'冰紅茶',4,2233,'水果飲料');

insert into sellInfo values (1,default,1,2,1999.9,'天貓出售');
insert into sellInfo values (2,default,1,1,1599.9,'天貓出售');
insert into sellInfo values (3,default,3,4,589,'天貓出售');
insert into sellInfo values (4,default,2,2,3999,'天貓出售');
insert into sellInfo values (5,default,5,100,23.5,'天貓出售');


--3.删除销售编号为1的销售记录
delete from sellInfo where sellId=1
--4.商品名是'果粒橙'的商品进货10件，修改库存
insert into  productInfo values(8,'果粒橙',4,10,'果汁飲料');
--5.修改编号为2的商品的库存量(减少2)和备注
update productInfo set proNum=proNum-2 where proId=2
--6.查询所有商品的商品名、库存量，为列取中文名
select proName as 商品名,proNum as 庫存量 from productInfo
--7.查询商品库存量在10-20之间的商品信息(用两种方法实现)
select * from productInfo where proNum>=10 and proNum<=200;
         --select * from productInfo where proNum in(...,..,..);
select * from productInfo where proNum between 10 and 200;

--8.查询商品名称中包含'水'字的商品信息
select * from productInfo where proName like '%水%';
--9.查询商品名称最后一个字是'水' 或 '茶'的商品信息 
select * from productInfo where proName like '%水' or proName like '%茶';
--10.查询所有的商品信息，并按库存量降序排列
select * from productInfo order by proNum desc;
--11.查询所有商品的库存量之和
select sum(proNum) 所有庫存量 from productInfo ;
--12.查询销售的总数量，平均单价，最高单价
select sum(sellNum)销售总数,sum(sellPrice)/sum(sellNum) 平均单价,max(sellPrice)最高单价 from sellInfo; --似乎有问题
--13.查询有多少种商品类型，查询的结果是商品类型的数量
select * from productInfo;
select typeId 类型编号,sum(proNum) 各种商品总数 from productInfo group by typeId;
select typeId 类型编号,sum(proNum) 各种商品总数 from productInfo group by typeId;

--14.查询有多少种商品，查询的结果是商品种类的数量
select typeId,count(*) as 该种类的数量 from productinfo group by typeId;
--15.查询每种类型的商品库存量和,只显示和大于50的记录
select typeid,sum(pronum)存量和 from productinfo group by typeId having sum(pronum)>500;
--16.查询商品名、类型名、库存量(表连接)
SELECT proName 商品名称 ,typeName 类型名,proNum 库存量 FROM typeinfo t LEFT OUTER JOIN productinfo p ON t.typeId = p.typeId
--17.查询所有商品的名称以及销售的日期和数量，没有销售销售记录的商品的销售日期和数量以null值填充(表连接)
select p.proname,s.selldate,s.sellnum from  productinfo p left outer join sellinfo s on s.proId=p.proId;
--18.查询没有卖出去的商品名(表连接)
select proName from productinfo where proid not in(select proid from sellinfo);

select * from typeInfo;
select * from productInfo;
select * from sellInfo;