# SVN与GIT的区别
SVN版本控制系统是集中式的数据管理，存在一个中央版本库，所有开发人员本地开发使用的代码都是来自于这个版本库，提交代码也都必须提交到这个中央版本库。

GIT是分布式版本控制系统，没有中央版本库的说法，各个开发者本地包含完整的git仓库，本地仓库跟远程仓库在身份上是等价的，没有主从之分。

一句话来说，SVN是集中式版本控制系统，GIT是分布式版本控制系统。SVN的端口号是3690


# SVN的安装
直接使用yum安装就好了
```
yum install -y subversion
```

# svnserve命令说明
```
svnserve
     -d [--daemon]     :daemon mode
     -r [--root] arg   :root of directory to serve
```

一般执行启动命令：
```
svnserve -d -r /link/svn
```

# 建立项目版本库
```
svnadmin create /link/svn/testversion1/
```

配置文件说明
```
/link/svn/testversion1/conf/svnserve.conf

[general]
anon-access = none     #禁止匿名访问   
auth-access = write    #访问权限，可写

password-db = /link/svn/testversion1/conf/passwd     #指定密码文件
authz-db = /link/svn/testversion1/conf/authz     #权限控制文件

#chmod 600 /link/svn/testversion1/conf/{passwd,authz}      #非必须，最好改下
```

# passwd文件的配置及说明
```
[users]
# harry = harrysecret
Kevin = Kevin1234
zzc = zzc@11111
```

等号前面是用户名，后面是密码，密码是明文的。更改svnserve.conf的时候，需要重启SVN，更改authz，passwd文件，不需重启。

7、authz文件的配置及说明
```
[groups]
# harry_and_sally = harry,sally,joe
```

groups定义的变量就是组名，1个用户组可以包含1个或者多个用户，逗号分隔，上例中harry_and_sally就是一个组

版本库目录格式：
- [<版本库>:/项目/目录]
- @<用户组名> = <权限>
- <用户名> = <权限>


其中，方框号内部可以有多种写法：
- [/]，表示根目录及以下，根目录是svnserve启动时指定的，我们配置的是/link/svn/，[/]就是表示对全部版本库设置权限。
- [repos:/]，表示对版本库repos设置权限
- [repos:/sadoc]，表示对版本库repos中的sadoc项目设置权限
- [repos:/sadoc/ccc]，表示对版本库repos中sadoc项目的ccc目录设置权限
```
权限主体可以是用户组、用户或*，用户组在前面加@，*表示全部用户。
权限可以是w、r、rw、和空，空表示没有任何权限。
authz中每个参数都要顶格写，开头不能有空格。

[/]
Kevin = rw
@harry_and_sally = r
```

注意：权限配置文件中出现的用户名必须已在用户配置文件中定义

8、Checkout注意事项
在windows上安装客户端TortoiseSVN之后，checkout版本的时候有个地方需要注意。


例如如果创建项目版本库的命令为 # svnadmin create /svn/testversion1/
启动svn服务的命令 # svnserve -d -r /svn/

那么在客户端检出该版本库的URL为：svn://xx.xx.xx.xx/testversion1/

如果启动svn服务的命令为 svnserve -d -r /svn/testversion1/，那么检出的URL则为：svn://xx.xx.xx.xx/
