# 登陆
conn scott/tiger as sysdba 

# 创建用户
create user yonghuming identified by mima; 

# 更改密码
alter user yonghuming identified by 123456; 

# 查看所有用户所有表空间
select username,default_tablespace from dba_users;

# 创建表空间
create tablespace tab_kongjiam datafile 'f:\tab_kongjiam\yonghuming_data.dbf' size 200M;  

# 分配表空间给用户
alter user yonghuming default tablespace tab_kongjiam;  

# 给用户分配权限
grant create session,create table,create view,create sequence,unlimited tablespace to yonghuming; 

# 新用户登陆
conn yonghuming/unis;  

# 查看本用户所有权限
select *from session_privs;

# 删除用户
drop user yonghuming cascade;  