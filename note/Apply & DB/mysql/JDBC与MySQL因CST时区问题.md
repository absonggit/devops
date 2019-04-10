https://juejin.im/post/5902e087da2f60005df05c3d




## 修改时区设置：
### 写入到配置文件、永久生效
```
[mysqld]
default-time-zone=timezone
修改为
default-time-zone = '+8:00'

systemctl restart mysqld
```

### 临时修改、重启后失效
```
MySQL [(none)]> show variables like '%time_zone%';
+------------------+--------+
| Variable_name    | Value  |
+------------------+--------+
| system_time_zone | CST    |
| time_zone        | system |
+------------------+--------+
2 rows in set (0.00 sec)

MySQL [(none)]> set global time_zone = '+08:00';
Query OK, 0 rows affected (0.00 sec)

MySQL [(none)]> set time_zone = '+08:00';
Query OK, 0 rows affected (0.00 sec)

MySQL [(none)]> flush privileges;
Query OK, 0 rows affected (0.01 sec)

MySQL [(none)]> show variables like '%time_zone%';
+------------------+--------+
| Variable_name    | Value  |
+------------------+--------+
| system_time_zone | CST    |
| time_zone        | +08:00 |
+------------------+--------+
2 rows in set (0.00 sec)

MySQL [(none)]> select now();
+---------------------+
| now()               |
+---------------------+
| 2019-03-29 09:39:39 |
+---------------------+
1 row in set (0.00 sec)


# 临时设置时区、重启后恢复system
```
