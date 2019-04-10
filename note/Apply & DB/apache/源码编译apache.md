```
cd /usr/local/src/
tar zxvf httpd-2.2.16.tar.gz
cd httpd-2.2.16
yum install -y pcre pcre-devel apr apr-devel zlib-devel  //安装所需依赖包
./configure --prefix=/usr/local/apache2 --with-included-apr --enable-so --enable-deflate=shared --enable-expires=shared --enable-rewrite=shared --with-pcre   //--prefix 表示安装目录 --enable-so 表示启用DSO [1] --enable-deflate=shared 表示共享的方式编译deflate
make && make install
echo $?
```
/usr/local/apache2/bin/apachectl -t  //检查配置文件

/usr/local/apache2/bin/apachectl start/stop/restart  //启动、停止、重启

ps aux |grep httpd  //查看服务是否启动

http://IP  //测试默认页面
