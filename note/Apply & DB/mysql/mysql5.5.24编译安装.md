# 安装必要的组件
```
yum install -y cmake bison ncurses-devel
```

# 添加账户
```
groupadd mysql;useradd mysql -g mysql -M -s /sbin/nologin
```

# 编译安装
```
tar zxvf mysql-5.5.24.tar.gz
cd mysql-5.5.24
cmake \
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DMYSQL_DATADIR=/usr/local/mysql/data \
-DSYSCONFDIR=/usr/local/mysql/etc \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_MEMORY_STORAGE_ENGINE=1 \
-DWITH_READLINE=1 \
-DMYSQL_UNIX_ADDR=/var/lib/mysql/mysql.sock \
-DMYSQL_TCP_PORT=3306 \
-DENABLED_LOCAL_INFILE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci
make && make install
make -j 2 && make install
注：-j 用来指定CPU核心数，可加快编译速度，不加也可以
以下为附加步骤，如果你想在这台服务器上运行MySQL数据库，则执行以下两步。
如果只是希望让PHP支持MySQL扩展库，能够连接其他服务器上的MySQL数据库，以下两步无需执行。
```

# 以mysql用户帐号的身份建立数据表：
```
chown -R mysql:mysql /usr/local/mysql
mv /etc/my.cnf /etc/my.cnf.back
scripts/mysql_install_db --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --user=mysql
```

# 加入开机自启动；并启动mysql
```
cp support-files/mysql.server /etc/init.d/mysqld
chmod 755 /etc/init.d/mysqld
chkconfig --add mysqld
chkconfig --level 35 mysqld on
service mysqld start
```
# 更新mysql用户密码
```
use mysql; update user set password=password('mypass') where user='root';flush privileges;
```

# 创建用户并授权远程登陆但不能本地登陆
```
grant all on *.* to 'dba'@'%' identified by 'mypass';
```
