# 修改指定用户密码密码
```
$ mysqladmin -uroot password passwd    //为mysql设置第一个密码
$ mysqladmin -uroot -pold_passwd password new_passwd   //修改密码
```


# 忘记密码
```
skip-grant-tables
顾名思义，数据库启动的时候 跳跃权限表的限制，不用验证密码，直接登录。

$ vim /etc/my.cnf
[mysqld]
skip-grant-tables

重启MySQL使得参数生效：
service mysqld restart

mysql> update mysql.user set password=password('1AjSeXakR80') where user= 'root';
mysql> FLUSH PRIVILEGES;

去掉参数,密码修改好了之后再将配置文件中 skip-grant-tables去掉,再次重启数据库。
```

# 修改root远程登录权限
```
mysql> GRANT ALL PRIVILEGES ON *.* TO root@"%" IDENTIFIED BY "nihao123!";
mysql>  flush privileges;

第一句中"%"表示任何主机都可以远程登录到该服务器上访问。如果要限制只有某台机器可以访问，将其换成相应的IP即可，如：
GRANT ALL PRIVILEGES ON *.* TO root@"172.168.193.25" IDENTIFIED BY "root";
第二句表示从mysql数据库的grant表中重新加载权限数据。因为MySQL把权限都放在了cache中，所以在做完更改后需要重新加载。
```

# 删除用户
```
mysql>DELETE FROM user WHERE User="testuser" and Host="localhost";
mysql>flush privileges;
```
