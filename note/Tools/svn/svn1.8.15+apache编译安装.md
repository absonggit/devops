```
apr报错解决 rm: cannot remove `libtoolT': No such file or directory

vim configure
30204     cfgfile="${ofile}T"
30205     trap "$RM \"$cfgfile\"; exit 1" 1 2 15
30206 #    $RM "$cfgfile"	//注释掉这行
30207
30208     cat <<_LT_EOF >> "$cfgfile"
```

# 编译apr和apr-util
```
[lvyu@jenkins ~]$ cd /opt/app/package/
[lvyu@jenkins package]$ tar zxvf apr-1.5.2.tar.gz
[lvyu@jenkins package]$ cd apr-1.5.2
[lvyu@jenkins apr-1.5.2]$ vim configure		//注释掉第30206行
[lvyu@jenkins apr-1.5.2]$ ./configure --prefix=/opt/app/apr
[lvyu@jenkins apr-1.5.2]$ make && make install
[lvyu@jenkins apr-1.5.2]$ cd ..
[lvyu@jenkins package]$ tar zxvf apr-util-1.5.4.tar.gz
[lvyu@jenkins package]$ cd apr-util-1.5.4
[lvyu@jenkins apr-util-1.5.4]$ ./configure --prefix=/opt/app/apr-util --with-apr=/opt/app/apr
[lvyu@jenkins apr-util-1.5.4]$ make && make install
[lvyu@jenkins apr-util-1.5.4]$ cd ..
```

# 编译zlib
```
[lvyu@jenkins package]$ tar zxvf zlib-1.2.8.tar.gz
[lvyu@jenkins package]$ cd zlib-1.2.8
[lvyu@jenkins zlib-1.2.8]$ ./configure --prefix=/opt/app/zlib
[lvyu@jenkins zlib-1.2.8]$ make && make install
[lvyu@jenkins zlib-1.2.8]$ cd ..
```

# 编译expat   
```
[lvyu@jenkins ~]$ rpm -ql expat
/lib64/libexpat.so.1
/lib64/libexpat.so.1.5.2
#看到别人的文档把这个也编译了、事实我在试验的时候没有编译、也没报错、系统默认已经安装过、如果报错那就同上编译一下就好了
```

# 编译sqlite
 ```
[lvyu@jenkins package]$ tar zxvf sqlite-autoconf-3080000.tar.gz
[lvyu@jenkins package]$ cd sqlite-autoconf-3080000
[lvyu@jenkins sqlite-autoconf-3080000]$ ./configure --prefix=/opt/app/sqlite
[lvyu@jenkins sqlite-autoconf-3080000]$ make && make install
[lvyu@jenkins sqlite-autoconf-3080000]$ cd ..
```

# 编译httpd
```
[lvyu@jenkins package]$ tar zxvf httpd-2.2.16.tar.gz
[lvyu@jenkins package]$ cd httpd-2.2.16
[lvyu@jenkins httpd-2.2.16]$ ./configure --prefix=/opt/app/apache --with-apr=/opt/app/apr/bin/apr-1-config --with-apr-util=/opt/app/apr-util/bin/apu-1-config --enable-so --enable-dav --enable-mainta  --enable-iner-mode --enable-rewrite
[lvyu@jenkins httpd-2.2.16]$ make &&  make install
[lvyu@jenkins httpd-2.2.16]$ cd ..
```

# 编译subversion
```
[lvyu@jenkins package]$ tar zxvf subversion-1.8.15.tar.gz
[lvyu@jenkins package]$ cd subversion-1.8.15
[lvyu@jenkins subversion-1.8.15]$ ./configure --prefix=/opt/app/svn --with-apxs=/opt/app/apache/bin/apxs --with-apr=/opt/app/apr/bin/apr-1-config --with-apr-util=/opt/app/apr-util/bin/apu-1-config --with-ssl --with-zlib=/opt/app/zlib --with-sqlite=/opt/app/sqlite --enable-maintainer-mode
[lvyu@jenkins subversion-1.8.15]$ make && make install
[lvyu@jenkins subversion-1.8.15]$ cd ~
```

# 配置apache
```
[lvyu@jenkins ~]$ cp /opt/app/svn/libexec/mod_* /opt/app/apache/modules/
[lvyu@jenkins ~]$ ll /opt/app/apache/modules/
总用量 3476
-rw-rw-r-- 1 lvyu lvyu    9083 1月  14 14:43 httpd.exp
-rwxr-xr-x 1 lvyu lvyu  178543 1月  14 15:40 mod_authz_svn.so
-rwxr-xr-x 1 lvyu lvyu 3365915 1月  14 15:40 mod_dav_svn.so

[lvyu@jenkins ~]$ vim /opt/app/apache/conf/httpd.conf
 40 Listen 8000		//修改端口号、因为普通用户对1024以下端口没有权限
 97 ServerName www.example.com:80	//去掉注释符号
 53 LoadModule dav_svn_module modules/mod_dav_svn.so	//加载dav模块
 54 LoadModule authz_svn_module modules/mod_authz_svn.so		//加载authz模块
 66 User lvyu
 67 Group lvyu
```
```
#在最后面添加svn配置文件
 412 <Location /svn/lvyushequ>
 413    DAV svn
 414    SVNPath /home/lvyu/svn/lvyushequ
 415    AuthType Basic
 416    AuthName "Subversion"
 417    AuthUserFile /home/lvyu/svn/passwd
 418    AuthzSVNAccessFile /home/lvyu/svn/authz
 419    Require valid-user
 420 </Location>
[lvyu@jenkins svn]$ /opt/app/apache/bin/apachectl -t
Syntax OK
```

# 配置subversion
```
[lvyu@jenkins ~]$ mkdir svn
[lvyu@jenkins ~]$ /opt/app/svn/bin/svnadmin create svn/lvyushequ
[lvyu@jenkins ~]$ /opt/app/apache/bin/htpasswd -c /home/lvyu/svn/passwd wangweijing	//创建第二个用户的时候去掉 -c （-c表示创建文件）
[lvyu@jenkins ~]$ vim svn/authz
[groups]
management = manager
doc = wujietian
src = baoxiaobing,liujiaqi,yangling,dengguangyi,gongyu,wangxue,chihang,zhangjianlin,zangyv,wangweijing


[/]     #表示根下也就是lvyushequ文件下  所有文件对于 @management @doc @src组有读写权限  对于其他用户有可读权限
@management = rw
@doc = rw
@src = rw
* = r


[lvyushequ:/wwj]       #表示/wwj也就是lvyushequ/wwj文件下  所有文件对于 @doc 组有读写权限  对于其他用户没有任何权限 即不可见 强行用路径访问显示403权限拒绝
@doc = rw
* =
```

# 启动apache和subversion测试
```
[lvyu@jenkins ~]$ /opt/app/svn/bin/svnserve -d -r /home/lvyu/svn/lvyushequ/
[lvyu@jenkins ~]$ /opt/app/apache/bin/apachectl start
http://192.168.6.243:8000/svn/lvyushequ
输入用户名密码即可
ssh 35522
jenkins_tomcat 8080
svn_httpd 8000
nexus 8081

export JAVA_HOME=/usr/java/jdk7/jdk1.7.0_80
export CLASSPATH=.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:$CLASSPATH
export PATH=$JAVA_HOME/bin:$PATH

[root@localhost svn]# svn list svn://192.167.1.81/allProject
svn: E160043: Unable to connect to a repository at URL 'svn://192.167.1.81/allProject'
svn: E160043: 期望文件系统格式在“1”到“4”之间；发现格式“6”
```

SVN 的服务端仓库里 当前项目/db/format 文件打开 把6改为4即可，但我后
```
svnadmin dump D:\svn\vos D:\svn\vos\vos.dump
Svnadmin load E:\svn\vos < e:\vos.dump
```
