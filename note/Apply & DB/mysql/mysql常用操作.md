# mysql常用命令
查看都有哪些库  show databases;
查看某个库的表 use db; show tables;
查看表的字段 desc tb;
查看建表语句 show create table tb;
当前是哪个用户  select user();
当前库 select database();
创建库 create database db1;
创建表 create table t1 (`id` int(4), `name` char(40));  
查看数据库版本 select version();
查看mysql状态 show status;
修改mysql参数 show variables like 'max_connect%'; set global max_connect_errors = 1000;
查看mysql队列 show processlist;
创建普通用户并授权 grant all on *.* to user1 identified by '123456';
grant all on db1.* to 'user2'@'10.0.2.100' identified by '111222';
grant all on db1.* to 'user3'@'%' identified by '231222';insert into tb1 (id,name) values(1,'aming');
更改密码 UPDATE mysql.user SET password=PASSWORD("newpwd") WHERE user='username' ;   
查询 select count(*) from mysql.user; select * from mysql.db; select * from mysql.db where host like '10.0.%'; 
插入 update db1.t1 set name='aaa' where id=1;  
清空表 truncate table db1.t1;
删除表 drop table db1.t1;
删除数据库 drop database db1;
修复表 repair table tb1 [use frm];


grant all privileges on *.* to 'root'@'%' identified by 'rOOtqwe321' with grant option;



扩展知识：
myisam 和innodb引擎对比  http://www.pureweber.com/article/myisam-vs-innodb/
一台mysql服务器启动多个端口 http://www.lishiming.net/thread-63-1-1.html
SQL语句教程  http://blog.51cto.com/zt/206
sql教程pdf文档   http://class.ccshu.net/00864091/ ... %95%99%E7%A8%8B.pdf
什么是事务？事务的特性有哪些？  http://blog.csdn.net/yenange/article/details/7556094
mysql常用引擎  http://c.biancheng.net/cpp/html/1465.html
批量更改表的引擎    http://www.361way.com/change-mysql-engine/1729.html
mysql 二进制日志binlog的模式   http://lihuipeng.blog.51cto.com/3064864/833017
mysql根据binlog恢复指定时间段的数据   http://www.centoscn.com/mysql/2015/0204/4630.html
mysql字符集调整  http://xjsunjie.blog.51cto.com/999372/1355013
使用xtrabackup备份innodb引擎的数据库  http://www.aminglinux.com/bbs/thread-956-1-1.html
innobackupex 备份 Xtrabackup 增量备份 http://www.aminglinux.com/bbs/thread-1012-1-1.html

来源： http://www.apelearn.com/bbs/thread-7923-1-1.html
