系统是CentOS 6.7 64位的，默认MySQL5.7.11下载到/usr/local/src,安装目录在/app/local/mysql目录下，MySQL数据放置目录/app/local/data。MySQL从5.1后采用cmake方式编译安装，所以要先编译安装cmake工具，也可以采用yum方式安装cmake。从MySQL5.7开始编译安装需要boost库的支持，所以也要下载boost库

# 下载安装包
```
$ wget http://mirrors.sohu.com/mysql/MySQL-5.7/mysql-5.7.11.tar.gz
$ wget https://cmake.org/files/v3.1/cmake-3.1.3.tar.gz
$ wgethttps://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz
```

# 创建用户以及目录
```
如果没有mysql用户则新建mysql用户。
$ groupadd mysql
$ useradd -g mysql mysql -s /bin/false

# 创建相应的目录
$ mkdir -p /app/local/{mysql,data}
$ mkdir  /usr/local/boost
```

# 编译安装cmake
```
$ tar zxvf cmake-3.1.3.tar.gz
$ cd cmake-3.1.3
$ ./configure
$ make && make install
$ cd ../

#将boost库解压到/usr/local/boost目录下
$ tar zxvf boost_1_59_0.tar.gz
$ cd boost_1_59_0/
$ mv ./* /usr/local/boost/
$ cd ../
```

# 编译安装mysql5.7.11
```
$ tar zxvf mysql-5.7.11.tar.gz
$ cd mysql-5.7.11
$ cmake -DCMAKE_INSTALL_PREFIX=/app/local/mysql/ -DMYSQL_DATADIR=/app/local/data -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DMYSQL_TCP_PORT=3306 -DMYSQL_USER=mysql -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/usr/local/boost
$ make && make install
$ cd ../
$ chown -R mysql:mysql /app/local/data/
$ chown -R mysql:mysql /app/local/mysql/
$ cd /app/local/mysql/bin
$ ./mysqld --initialize --user=mysql --basedir=/app/local/mysql/ --datadir=/app/local/data/#初始化mysql 并且生成一个随机密码
$ mv /etc/my.cnf /etc/my.cnfbak#先备份生成的my.cnf
$ cp ../support-files/my-default.cnf /etc/my.cnf
$ cp ../support-files/mysql.server /etc/init.d/mysqld
$ chmod 755 /etc/init.d/mysqld
$ chkconfig mysqld on
$ service mysqld start
$ mysql -uroot -p
Enter password:
用刚才生成的随机密码登录
要是不行，就在my.cnf里配置password
登录后重置root密码
mysql> SET PASSWORD  FOR 'root'@localhost = PASSWORD（'123456'）；
Query OK, 0 rows affected, 1 warning (0.00 sec)
```
