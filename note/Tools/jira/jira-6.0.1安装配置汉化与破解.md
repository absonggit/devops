JIRA是Atlassian公司出品的项目与事务跟踪工具，被广泛应用于缺陷跟踪、客户服务、需求收集、流程审批、任务跟踪、项目跟踪和敏捷管理等工作领域。

# 系统环境：
linux-centOS6.6_64 装好Development toos开发包 (1台)
软件版本：
atlassian-jira-6.0.1-x64.bin
jdk-7u45-linux-x64.tar.gz(redhat6.4 环境直接不用安装jdk、但是我没试过)
mysql-5.6.27-linux-glibc2.5-x86_64.tar.gz(5版本都可以、其他没试过)
mysql-connector-java-5.1.38.jar(适用所有5版本、其他没试过)

# 安装jdk
参考：http://francis905.blog.51cto.com/3048056/1716740
java -version    //测试显示出版本号就可以了

# 安装mysql
参考：http://francis905.blog.51cto.com/3048056/1721911
```
启动成功后、在mysql里面创建jira用户所用的数据库，并赋以相应的权限：
这个mysql命令已经设置了环境变量、所以可以直接使用、详细参考我的博客/mysql分类里边有设置方法
mysqladmin -uroot password 密码//设置root用户密码
mysql -u root -p 密码//以root用户登陆mysql
mysql>create database jiradb character set utf8;
mysql>grantall on jiradb.* to ‘jira’@’localhost’ identified by ‘jira’;
//grant权限on 数据库.表 y用户 identified by 密码
mysql>flushprivileges;//刷新mysql的系统权限相关表
```

# 安装jira
chomd +x atlassian-jira-6.0.1-x64.bin
./atlassian-jira-6.0.1-x64.bin

我的安装过程
```
[root@test1 ~] ./atlassian-jira-6.0.1-x64.bin
Unpacking JRE ...
Starting Installer ...
Aug 29, 2014 3:29:28 PM java.util.prefs.FileSystemPreferences$2 run
INFO: Created system preferences directory in java.home.

This will install JIRA 6.0.1 on your computer.
OK [o, Enter], Cancel [c]
o
Choose the appropriate installation or upgrade option.
Please choose one of the following:
Express Install (use default settings) [1], Custom Install (recommended for advanced users) [2, Enter], Upgrade an existing JIRA installation [3]
2

Where should JIRA 6.0.1 be installed?
[/opt/atlassian/jira]
/usr/local/jira
Default location for JIRA data
[/var/atlassian/application-data/jira]
/usr/local/jira_data
Configure which ports JIRA will use.
JIRA requires two TCP ports that are not being used by any other
applications on this machine. The HTTP port is where you will access JIRA
through your browser. The Control port is used to Startup and Shutdown JIRA.
Use default ports (HTTP: 8080, Control: 8005) - Recommended [1, Enter], Set custom value for HTTP and Control ports [2]
1
JIRA can be run in the background.
You may choose to run JIRA as a service, which means it will start
automatically whenever the computer restarts.
Install JIRA as Service?
Yes [y, Enter], No [n]
y

Extracting files ...

e wait a few moments while JIRA starts up.
Launching JIRA ...
Installation of JIRA 6.0.1 is complete
Your installation of JIRA 6.0.1 is now ready and can be accessed via your
browser.
JIRA 6.0.1 can be accessed at http://localhost:8080
```
[注：]安装完成之后最好查看下8080端口是否被占用、如果被占用那么修改$jira/conf/service.conf配置文件里的3个端口

安装成功后浏览器登陆http://localhost:8080（8080为你设置的端口）,jira的默认安装目录是/opt/atlassian/jira。如果选择数据库为Mysql，需要将mysql的驱动mysql-connector-java-5.x.x-bin.jar放到 /opt/atlassian/jira/lib/ 中，重启jira。都填好后，点击next，新的页面需要注册一个账号（最好翻墙注册），然后验证邮箱，点击发送的邮件里面的“My Atlassian ”，跳转页面，点击 新密钥，输入server id获取密钥。输入密钥，完成安装。

```
/opt/atlassian/jira/bin/startup.sh//启动jira
/opt/atlassian/jira/bin/stop-jira.sh//停止jira
/opt/atlassian/jira/bin/log/catalina.out//查看日志
```

# 汉化
百度下载language_zh_CN-6.0.jar然后拷贝到
/opt/jira/atlassian-jira/WEB-INF/lib/language_zh_CN-6.0.jar


# 破解
```
下载破解补丁 jira_crack.zip（包含atlassian-extras-2.2.2.jar  atlassian-universal-plugin-manager-plugin-2.10.1.jar  keytpl.txt ）
http://pan.baidu.com/s/1o6iFjuU

unzip jira_crack.zip  
cp atlassian-extras-2.2.2.jar /opt/jira/atlassian-jira/WEB-INF/lib/atlassian-extras-2.2.2.jar
cp atlassian-universal-plugin-manager-plugin-2.10.1.jar  /opt/jira_data/plugins/.bundled-plugins/atlassian-universal-plugin-manager-plugin-2.10.1.jar

打开浏览器，输入http://localhost:8090/
依次输入数据库信息后，填写账号密码后，就可以看到 License 信息
你可以根据自己的注册的jira 账号信息，获取一个license，然后修改相应信息后，替换当前license即可。
破解
Description=JIRA: Commercial,
CreationDate=你的安装日期，格式（yyyy-mm-dd）,
jira.LicenseEdition=ENTERPRISE,
Evaluation=false,
jira.LicenseTypeName=COMMERCIAL,
jira.active=true,
licenseVersion=2,
MaintenanceExpiryDate=你想设置的失效日期如：2099-12-31,
Organisation=joiandjoin,
SEN=你申请到的SEN注意没有前缀LID,
ServerID=你申请到的ServerID,
jira.NumberOfUsers=-1,
LicenseID=LID你申请到的SEN，注意LID前缀不要丢掉,
LicenseExpiryDate=你想设置的失效日期如：2099-12-31,
PurchaseDate=你的安装日期，格式（yyyy-mm-dd）
```

下面是我修改的
``````
Description=JIRA: Commercial,
CreationDate=2014-08-29,
jira.LicenseEdition=ENTERPRISE,
Evaluation=false,
jira.LicenseTypeName=COMMERCIAL,
jira.active=true,
licenseVersion=2,
MaintenanceExpiryDate=2020-12-31,
Organisation=joiandjoin,
SEN=L4511466,
ServerID=B05P-IU97-QMXO-T9Z2,
jira.NumberOfUsers=-1,
LicenseID=LIDL4511461,
LicenseExpiryDate=2020-12-31,
PurchaseDate=2014-08-29,
``````

破解还可以参考：http://blog.csdn.net/alonesword/article/details/12024307
