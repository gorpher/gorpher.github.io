conn system/manager
1. 数据库database
物理存储结构 
数据文件，重做日志文件，空值文件

desc v$logfile;
select member from v$logfile;
v$controlfile
v$datafile;
逻辑存储结构
表空间，段，区，块
