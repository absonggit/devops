>> http://blog.csdn.net/hguisu/article/details/7325124


# MySQL主从同步的机制
MYSQL主从同步是在MySQL主从复制(Master-Slave Replication)基础上实现的，通过设置在Master MySQL上的binlog(使其处于打开状态)，Slave MySQL上通过一个I/O线程从Master MySQL上读取binlog，然后传输到Slave MySQL的中继日志中，然后Slave MySQL的SQL线程从中继日志中读取中继日志，然后应用到Slave MySQL的数据库中。这样实现了主从数据同步功能。


# MySQL主从同步的作用
1. 可以作为一种备份机制，相当于热备份
2. 可以用来做读写分离，均衡数据库负载


# MySQL主从同步的步骤

## 修改主数据库

### 修改配置文件
```
$ vim /etc/my.cnf
[mysqld]
port = 3306
socket = /tmp/mysql.sock

basedir = /usr/local/mysql
datadir = /data/mysql
pid-file = /data/mysql/mysql.pid
user = mysql
bind-address = 0.0.0.0
server-id = 1    #主数据库端口号
log-bin = mysql-bin    #日志文件名
```

### 创建用于同步的账户
```
mysql > grant replication slave on *.* to 'backup'@'%' identified by 'abc123';
mysql > flush privileges;
```

### 重启mysql、查询master状态
```
$ service mysqld restartmysql > show master status;
+------------------+----------+--------------+------------------+-------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+------------------+----------+--------------+------------------+-------------------+
| mysql-bin.000004 |      120 |              |                  |                   |
+------------------+----------+--------------+------------------+-------------------+
1 row in set (0.00 sec)
```

>> 执行完此步骤就不要在操作主数据库了、防止主数据库状态值变化


## 修改从数据库
### 修改配置文件
```
$ vim /etc/my.cnf
[mysqld]port = 3306
socket = /tmp/mysql.sock

basedir = /usr/local/mysql
datadir = /data/mysql
pid-file = /data/mysql/mysql.pid
user = mysql
bind-address = 0.0.0.0
server-id = 2
```

### 执行同步命令、设置主数据库IP、同步帐号密码、同步位置
```
mysql > change master to master_host='192.168.1.2',master_user='backup',master_password='abc123',master_log_file='mysql-bin.000004',master_log_pos=120;
mysql > start slave;
```

### 检查从数据库状态
```
mysql > show slave status\G
*************************** 1. row ***************************
              Slave_IO_State: Waiting for master to send event
              Master_Host: 192.168.209.12
              Master_User: backup
              Master_Port: 3306
              Connect_Retry: 60
              Master_Log_File: mysql-bin.000004
              Read_Master_Log_Pos: 232
              Relay_Log_File: mysql-relay-bin.000002
              Relay_Log_Pos: 395
              Relay_Master_Log_File: mysql-bin.000004
              Slave_IO_Running: Yes    #此状态说明同步成功、否则失败
              Slave_SQL_Running: Yes    #此状态说明同步成功、否则失败
              Replicate_Do_DB:  
              Replicate_Ignore_DB:   
              Replicate_Do_Table:
                    ...
```

## 其他可能用到的参数
### master端：
```
# 不同步哪些数据库  
binlog-ignore-db = mysql  
binlog-ignore-db = test  
binlog-ignore-db = information_schema    

# 只同步哪些数据库，除此之外，其他不同步  
binlog-do-db = game    

# 日志保留时间  
expire_logs_days = 10    

# 控制binlog的写入频率。每执行多少次事务写入一次  
# 这个参数性能消耗很大，但可减小MySQL崩溃造成的损失  
sync_binlog = 5    

# 日志格式，建议mixed  
# statement 保存SQL语句  
# row 保存影响记录数据  
# mixed 前面两种的结合  
binlog_format = mixed  
```

### slave端：
```
# 停止主从同步  
mysql> stop slave;    

# 连接断开时，重新连接超时时间  
mysql> change master to master_connect_retry=50;    

# 开启主从同步  
mysql> start slave;  
```
