

```
https://www.cnblogs.com/voidking/p/centos-confluence-wiki.html
下载软件包
开始搭建Wiki前，需要下载一些软件包。

confluence5.6.6
Confluence-5.6.6-language-pack-zh_CN
mysql-connector
confluence_keygen
安装配置java
yum install java
java -version
安装配置mysql
1、安装mysql后，登录mysql控制台，执行如下命令：

create database confluence default character set utf8;
grant all on confluence.* to 'confluenceuser'@'%' identified by 'confluencepasswd' with grant option;
grant all on confluence.* to 'confluenceuser'@localhost identified by 'confluencepasswd' with grant option;
flush privileges;
2、进入/usr/local/mysql文件夹，在my.cnf中添加：

binlog_format=mixed
3、重启mysql

service mysqld stop
service mysqld start
关闭防火墙
systemctl stop firewalld.service
详细步骤
安装confluence
1、使用xftp，上传atlassian-confluence-5.6.6-x64.bin到/root文件夹。

2、上传完成后，执行命令：

chmod 755 atlassian-confluence-5.6.6-x64.bin
./atlassian-confluence-5.6.6-x64.bin
confluence默认安装到/opt/atlassian/confluence和/var/atlassian/application-data/confluence目录下，并且confluence监听的端口是8090。

3、confluence的主要配置文件，存放在/opt/atlassian/confluence/conf/server.xml文件中。

4、测试访问，假设CentOS7的ip地址为192.168.56.101，那么在浏览器输入http://192.168.56.101:8089，即可看到Confluence的欢迎界面。
欢迎

破解confluence
1、点击“Start setup”，看到如下界面。


2、复制Server ID并保存，然后关闭confluence。

/etc/init.d/confluence stop
3、从/opt/atlassian/confluence/confluence/WEB-INF/lib中，拷贝atlassian-extras-decoder-v2-3.2.jar到windows，并重命名为atlassian-extras-2.4.jar。

4、在windows下，生成License Key。

java -jar confluence_keygen.jar
把第二步中复制的Server ID粘贴进去，然后点击“.gen!”，保存生成的key。


5、打补丁。点击“.patch!”，选择第3步中重命名的atlassian-extras-2.4.jar，会生成新的atlassian-extras-2.4.jar。

6、上传新的atlassian-extras-2.4.jar、Confluence-5.6.6-language-pack-zh_CN.jar、mysql-connector-java-5.1.39-bin.jar到/opt/atlassian/confluence/confluence/WEB-INF/lib，并且删除atlassian-extras-decoder-v2-3.2.jar。

5、启动confluence

/etc/init.d/confluence start

```
