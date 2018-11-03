--订单表（orders）列为：
--订单编号（orderId 主键）
-- 订购日期（orderDate）

--订购项目表（orderItem），列为：
---项目编号（ItemiD）
--订单编号（orderId）
--产品类别（itemType）
--产品名称（itemName）
 --订购数量（theNumber）  
 --订购单价（theMoney）
 
 create table orders(
 orderId int primary key,
 orderDate date not null
 );
insert into orders values(1,'1-8月-2016');
insert into orders values(2,'1-8月-2016');
insert into orders values(3,'1-8月-2016');
insert into orders values(4,'1-8月-2016');
insert into orders values(5,'1-8月-2016');
insert into orders values(6,'1-8月-2016');

create table orderItem(
itemId int primary key,
orderId int references orders(orderId),
itemType varchar(10) not null,
itemName varchar(20) not null,
theNumber int not null,
theMoney number(4)
);
insert into orderItem values (1,1,'文具','笔',72,2);
insert into orderItem values (2,1,'文具','尺',10,2);
insert into orderItem values (3,1,'体育用品','篮球',1,56);
insert into orderItem values (4,2,'文具','笔',36,2);
insert into orderItem values (5,2,'文具','固体胶',20,3);
insert into orderItem values (6,2,'日常用品','透明胶',2,1);
insert into orderItem values (7,2,'体育用品','羽毛球',20,3);
insert into orderItem values (8,3,'文具','订书机',20,3);
insert into orderItem values (9,3,'文具','订书针',10,3);
insert into orderItem values (10,3,'文具','彩纸刀',5,5);
insert into orderItem values (11,4,'文具','笔',20,2);
insert into orderItem values (12,4,'文具','信纸',50,1);
insert into orderItem values (13,4,'日常用品','毛巾',4,5);
insert into orderItem values (14,4,'日常用品','透明胶水',30,1);
insert into orderItem values (15,4,'体育用品','羽毛球',20,3);
select * from orders;
select * from orderItem;


--1.查询所有订单订购的所有物品数量总和
select sum(theNumber)  总和 from  orderItem ;
--2.查询订单编号小于3的，平均单价小于10 每个订单订购的所有物品的数量和以及平均单价
select sum(thenumber)所有数量 ,avg(themoney)平均单价  from orders s,orderItem o where s.orderid=o.orderid and  s.orderid<3  group by o.orderid having avg(themoney)<10;
--select sum(thenumber)所有数量 ,avg(themoney)平均单价   from  (select  *  from orders s,orderItem o where s.orderid=o.orderid and  s.orderid<3 ) group by orderid having avg(themoney)<10;
3.查询平均单价小于10并且总数量大于 50 每个订单订购的所有物品数量和以及平均单价

4.查询每种类别的产品分别订购了几次，例如：文具      9
                                          体育用品  3
                                          日常用品  3

5.查询每种类别的产品的订购总数量在100以上的订购总数量和平均单价

6.查询每种产品的订购次数，订购总数量和订购的平均单价，例如：

  产品名称   订购次数  总数量   平均单价 
    笔           3       120       2


7.查询所有的订单的订单的编号，订单日期，订购产品的类别和订购的产品名称，订购数量和订购单价

8.查询订购数量大于50的订单的编号，订单日期，订购产品的类别和订购的产品名称

9.查询所有的订单的订单的编号，订单日期，订购产品的类别和订购的产品名称，订购数量和订购单价以及订购总价

10.查询单价大于等于5并且数量大于等于50的订单的订单的编号，订单日期，订购产品的类别和订购的产品名称，订购数量和订购单价以及订购总价

11.查询每个订单分别订购了几个产品，例如：编号   订购产品数
                                          1        3
                                          2        4

12.查询每个订单里的每个类别的产品分别订购了几次和总数量，例如：

 订单编号       产品类别     订购次数     总数量

    1           文具            2           82
    1           体育用品        1            1
    2           文具            2           56
    2           体育用品        1            2
    2           日常用品        1            20