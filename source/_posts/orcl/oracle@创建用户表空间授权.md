# ��½
conn scott/tiger as sysdba 

# �����û�
create user yonghuming identified by mima; 

# ��������
alter user yonghuming identified by 123456; 

# �鿴�����û����б�ռ�
select username,default_tablespace from dba_users;

# ������ռ�
create tablespace tab_kongjiam datafile 'f:\tab_kongjiam\yonghuming_data.dbf' size 200M;  

# �����ռ���û�
alter user yonghuming default tablespace tab_kongjiam;  

# ���û�����Ȩ��
grant create session,create table,create view,create sequence,unlimited tablespace to yonghuming; 

# ���û���½
conn yonghuming/unis;  

# �鿴���û�����Ȩ��
select *from session_privs;

# ɾ���û�
drop user yonghuming cascade;  