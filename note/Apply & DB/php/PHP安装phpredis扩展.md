php和redis的组合、默认php是不支持redis的、需要手动配置；

phpredis是一个三方的扩展模块、但是获得了PHP官方的授权；


环境：
```
nginx 1.10
mysql5.6
php5.6
redis2.8(redis后安装也可以)
```

安装：
```
1、从github下载phpredis后编译安装：
$ cd /usr/local/src
$ git clone https://github.com/nicolasff/phpredis.git
$ cd phpredis
$ phpize
$ ./configure --with-php-config=/usr/local/php/bin/php-config
$ maketest
$ make && make install
安装成功后、会给出redis.so路径、如下：
Installing shared extensions:     /usr/local/php/lib/php/extensions/no-debug-non-zts-20131226/
```

2、配置php.ini
```
$ vim /usr/local/php/etc/php.ini

extension  /usr/local/php/lib/php/extensions/no-debug-non-zts-20131226/redis.so
```

重启 php-fpm        
```
service php-fpm restart
```

3、测试
IE访问:  ip/phpinfo.php   ctrl+F 搜索 redis 如下所示表示已经开启：
```
Redis Support               enabled
Redis Version               3.1.0
```

4、php中使用redis
```
<?php
$redis = new Redis();
$redis->connect('127.0.0.1', '6379');
$redis->set('test', 'abc');
echo  $redis->get('test');
```
遇到的错误及解决办法：
```
错误1：make test的时候如下提示
+-----------------------------------------------------------+
|                       ! ERROR !                           |
| The test-suite requires that proc_open() is available.    |
| Please check if you disabled it in php.ini.               |
+-----------------------------------------------------------+
解决办法：根据提示 修改php.ini文件(备份的时候加;号即可)、删除proc_open;
 304 disable_functions = passthru,exec,system,chroot,chgrp,chown,shell_exec,proc_open,p     roc_get_status,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthr     u,stream_socket_server,fsocket,popen
```

错误2：make test之后在make的时候 如下提示：
```
Build complete.
Don't forget to run 'make test'.
解决办法：直接make install 即可;
```
