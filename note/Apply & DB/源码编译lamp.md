软件版本:mysql-5.1.40-linux-x86_64-icc-glibc23.tar.gz   httpd-2.2.16.tar.gz   php-5.3.28.tar.gz

安装过程如下：
```
关闭防火墙以及seLinux
service iptables stop
vim /etc/sysconfi/selinux    //  修改：7 SELINUX=disabled
sync;reboot   //保存并重新启动
yum install -y epel-release gcc ntpdate  //安装epel扩展源 是为了方便安装依赖包
ntpdate pool.ntp.org   //同步时间
```


# 编译mysql
```
cd /usr/local/src/
tar zxvf mysql-5.1.40-linux-x86_64-icc-glibc23.tar.gz
mv mysql-5.1.40-linux-x86_64-icc-glibc23 /usr/local/mysql
groupadd mysql
useradd -g mysql -s /sbin/nologin -M mysql
mkdir -p /data/mysql
chown -R mysql:mysql /data/mysql
cd /usr/local/mysql/
./scripts/mysql_install_db --user=mysql --datadir=/data/mysql
cp support-files/my-large.cnf /etc/my.cnf
cp support-files/mysql.server /etc/init.d/mysqld
chmod 755 /etc/init.d/mysqld
vim /etc/init.d/mysqld  //设置路径
.....................................................................................
 46 basedir=/usr/local/mysql
 47 datadir=/data/mysql
.....................................................................................
vim /etc/my.cnf    //红色字体为增加内容 设置编码为utf8
.....................................................................................
 22 # Here follows entries for some specific programs
 23 [mysql]
 24 default-character-set = utf8
 25
 26 # The MySQL server
 27 [mysqld]
 28 character_set_server = utf8
 29 port            = 3306
.....................................................................................
chkconfig --add mysqld
chkconfig mysqld on
service mysqld start
```

mysql错误参考：http://blog.csdn.net/wwj_905/article/details/48000559


# apache
```
cd /usr/local/src/
tar zxvf httpd-2.2.16.tar.gz
cd httpd-2.2.16
yum install -y pcre pcre-devel apr apr-devel zlib-devel  //安装所需依赖包
如果是httpd2.4.3版本的需要编译apr,apr-util 或者去掉版本号
mv apr-1.4.6 apr;mv apr-util-1.4.1 apr-util
cp -r apr /usr/local/src/httpd2.4/srclib
cp -r apr-util /usr/local/src/httpd2.4/srclib
./configure --prefix=/usr/local/apache2 --with-included-apr --enable-so --enable-deflate=shared --enable-expires=shared --enable-rewrite=shared --with-pcre   //--prefix 表示安装目录 --enable-so 表示启用DSO [1] --enable-deflate=shared 表示共享的方式编译deflate
make && make install
echo $?
/usr/local/apache2/bin/apachectl -t  //检查配置文件
/usr/local/apache2/bin/apachectl start/stop/restart  //启动、停止、重启
ps aux |grep httpd  //查看服务是否启动
http://IP  //测试默认页面
```


# php
```
cd /usr/local/src/
tar zxvf php-5.3.28.tar.gz
cd php-5.3.28
yum install -y libxml2-devel openssl-devel bzip2-devel libjpeg-turbo libjpeg-turbo-devel libpng-devel freetype-devel libmcrypt-devel  //安装所需依赖包
./configure --prefix=/usr/local/php --with-apxs2=/usr/local/apache2/bin/apxs --with-config-file-path=/usr/local/php/etc --with-gd --with-gettext --with-libxml-dir=/usr/local --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-libxml-dir --with-gd --with-jpeg-dir --with-png-dir --with-freetype-dir --with-iconv-dir --with-zlib-dir --with-bz2 --with-openssl --with-mcrypt --enable-soap --enable-gd-native-ttf --enable-mbstring --enable-sockets --enable-exif --enable-bcmath --enable-mbstring --enable-sockets --disable-ipv6
echo $?
make && make install
echo $?
```



# 配置apache并测试是否加载php
```
/usr/local/apache2/bin/apachectl -M  //查看apache是否加载php_module模块
cp php.ini-production /usr/local/php/etc/php.ini   //拷贝php配置文件
vim /usr/local/apache2/conf/httpd.conf
.....................................................................................
101 ServerName www.example.com:80
170 DirectoryIndex index.html index.htm index.php
313 AddType application/x-httpd-php .php
.....................................................................................
/usr/local/apache2/bin/apachectl -t
/usr/local/apache2/bin/apachectl restart
curl localhost
vim /usr/local/apache2/htdoc
vim /usr/local/apache2/htdocs/1.php
...........................................................
<?php
   phpinfo();
?>
...........................................................
http://IP/1.php   
```
