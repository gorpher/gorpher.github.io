
1. java是实现代码

```java
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class OrderGoods {
	
	public int getOrderGoods(int userId,int proId,int num){
		int orderId=0;
		Connection conn = DBHelper.getConn();
		//编写存储过程sql语句	
		String sql="{CALL PRO_ORDER_GOODS(?,?,?,?)}";
		try {
			//调用存储过程处理类
			CallableStatement call = conn.prepareCall(sql);
			call.setInt(1,userId);
			call.setInt(2,proId);
			call.setInt(3,num);
			call.registerOutParameter(4,Types.INTEGER);
			call.execute();
			orderId = call.getInt(4);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		DBHelper.colseConn(conn);
		return orderId;
	}

	public int getOrderGoodsByFunction(int userId,int proId,int num){
		int orderId=0;
		Connection conn = DBHelper.getConn();	
		//编写函数方法sql语句
		String sql="{?:=call FUN_ORDER_GOODS(?,?,?)}";
		try {
			//调用实现函数语句处理类
			CallableStatement call = conn.prepareCall(sql);
			call.setInt(2,userId);
			call.setInt(3,proId);
			call.setInt(4,num);
			call.registerOutParameter(1,Types.INTEGER);
			call.execute();
			orderId = call.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		DBHelper.colseConn(conn);
		return orderId;
	}
}
```
2.orcle的sql文件
```sql
--创建表空间
create tablespace comDB
datafile 'f:/comDB.dbf'
size 3M;
--会员表
--drop table userinfo
CREATE TABLE USERINFO
(
 USERID INT PRIMARY KEY,
 USERNAME VARCHAR(20) UNIQUE NOT NULL,
 USERPWD VARCHAR(20) NOT NULL,
 USERPOINT INT DEFAULT(0)
);
--创建序列
create sequence USERID
start with 1
increment by 1;

--添加数据
INSERT INTO USERINFO VALUES(USERID.NEXTVAL,'刘宇','123456',DEFAULT);
INSERT INTO USERINFO VALUES(USERID.NEXTVAL,'spring','123456',DEFAULT);
--商品类型表
--drop table typeInfo;
create table typeInfo
(
typeId int primary key,
typeName varchar(20) unique not null,
typeDesp varchar(20) not null
)tablespace comDB;

--序列
--drop sequence typeId;
create sequence typeId
start with 1
increment by 1;

--添加数据
insert into typeInfo(typeId,typeName,typeDesp) values(typeId.Nextval,'肉类','香，美味');
insert into typeInfo(typeId,typeName,typeDesp) values(typeId.Nextval,'水果','甜，好吃');

--商品信息表
--drop table proInfo;
create table proInfo
(
proId int primary key,
proName varchar(20) unique not null,
typeId int references typeInfo(typeId) not null,
proprice float check(proprice>0) not null,
proNum int check(proNum>=0) not null
)tablespace comDB;

--序列
--drop sequence proId;
create sequence proId
start with 101
increment by 1;

--添加数据
insert into proInfo(proId,proName,typeId，proprice，proNum)  values(proId.Nextval,'牛肉',1,34,45);
insert into proInfo(proId,proName,typeId，proprice，proNum)  values(proId.Nextval,'火龙果',2,17,56);
insert into proInfo(proId,proName,typeId，proprice，proNum)  values(proId.Nextval,'羊肉',1,23,33);
insert into proInfo(proId,proName,typeId，proprice，proNum)  values(proId.Nextval,'梨',2,10,67);

--订单信息表
CREATE TABLE ORDERINFO
(
 ORDERID INT PRIMARY KEY,
 USERID INT REFERENCES USERINFO(USERID),
 PROID INT REFERENCES PROINFO(PROID),
 ORDERNUM INT CHECK(ORDERNUM>0),
 ORDERDATA DATE DEFAULT(SYSDATE)
);
--创建序列
create sequence ORDERID
start with 20160001
increment by 1;


--订购商品的存储过程：
--会员订购商品的业务：会员编号  商品编号  订购数量
--涉及的操作：会员积分+2(update)   商品的库存减少(update)  添加订单(insert)
--创建存储过程：
    --输入参数：会员编号  商品编号  订购数量
    --输出参数：订单编号
create or replace procedure orderPro(orderUserId int,orderProId int,orderCount int,newOrderId out int)
as
begin
     update userInfo set userPoint=userPoint+2 where userId=orderUserId; --会员积分+2(update)
     update proInfo set proNum=proNum-orderCount where proId=orderProId; --商品的库存减少
     insert into orderInfo VALUES(ORDERID.Nextval,orderUserId,orderProId,orderCount,default);--添加订单
     select ORDERID.CURRVAL into newOrderId from dual; --查询生成的订单编号并赋值
exception
     when others then
          newOrderId:=-1;
          rollback; --出现异常回滚操作
end orderPro;

--测试:调用存储过程
declare
   newOrderId int;
begin
   orderPro(1,101,50,newOrderId); 
   if newOrderId<0 then
      DBMS_OUTPUT.put_line('订单失败！'); 
   else
      DBMS_OUTPUT.put_line('订购成功，订单编号为：'||newOrderId); 
   end if;
end;

--查询数据
SELECT * FROM USERINFO; --用户
select * from TYPEINFO; --商品类型表
select * from PROINFO; --商品信息表
select * from ORDERINFO; --订购信息表
---代码块
DECLARE 
V_USER_ID USERINFO.USERID%TYPE:=1;
V_PRO_ID PROINFO.PROID%TYPE:=101;
V_ORDER_ID ORDERINFO.ORDERID%TYPE;
V_PRO_NUM INT:=3;
BEGIN 
UPDATE  USERINFO SET USERPOINT=USERPOINT+2  WHERE USERID=V_USER_ID;
UPDATE PROINFO SET PRONUM=PRONUM-V_PRO_NUM WHERE PROID=V_PRO_ID;
INSERT INTO ORDERINFO VALUES(ORDERID.NEXTVAL,V_USER_ID,V_PRO_ID,V_PRO_NUM,DEFAULT);
SELECT  ORDERID.CURRVAL INTO V_ORDER_ID FROM DUAL;
EXCEPTION
WHEN OTHERS             THEN
V_ORDER_ID :=-1;
ROLLBACK;
END;
---
CREATE OR REPLACE PROCEDURE PRO_ORDER_GOODS(V_USER_ID IN USERINFO.USERID%TYPE,
V_PRO_ID IN PROINFO.PROID%TYPE,
V_PRO_NUM IN  INT,
V_ORDER_ID OUT ORDERINFO.ORDERID%TYPE)
AS
BEGIN
UPDATE  USERINFO SET USERPOINT=USERPOINT+2  WHERE USERID=V_USER_ID;
UPDATE PROINFO SET PRONUM=PRONUM-V_PRO_NUM WHERE PROID=V_PRO_ID;
INSERT INTO ORDERINFO VALUES(ORDERID.NEXTVAL,V_USER_ID,V_PRO_ID,V_PRO_NUM,DEFAULT);
SELECT  ORDERID.CURRVAL INTO V_ORDER_ID FROM DUAL;
EXCEPTION
WHEN OTHERS             THEN
V_ORDER_ID :=-1;
ROLLBACK;
END;

```

2016/12/8 jdbc的oracle存储过程实现