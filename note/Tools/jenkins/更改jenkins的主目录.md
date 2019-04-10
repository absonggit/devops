工作中，由于Jenkins默认的主目录空间太小，导致需要将Jenkins默认的主目录修改到其它目录。本文针对更改Jenkins的主目录详细介绍。

注意：在Jenkins运行时是不能更改的. 请先将Jenkins停止运行。

# Windows环境更改Jenkins的主目录
Windows环境中，Jenkins主目录默认在C:\Documents and Settings\AAA\.jenkins 。

可以通过设置环境变量来修改，例如： JENKINS_HOME=C:\jenkins，然后重新启动jenkins。


# Linux环境更改Jenkins的主目录
Linux环境中，Jenkins主目录默认在/root/.jenkins
Jenkins储存所有的数据文件在这个目录下. 你可以通过以下几种方式更改：

## 使用你Web容器的管理工具设置JENKINS_HOME环境参数.
```
打开tomcat的bin目录，编辑catalina.sh文件。
在# OS specific support.  $var _must_ be set to either true or false.上面添加：export JENKINS_HOME=""在引号中填入你的路径。
```

## 在启动Web容器之前设置JENKINS_HOME环境变量.
```
用root用户登录
编辑profile文件：vi /etc/profile
在最后加入：export JENKINS_HOME=xxxx
保存，退出后执行：source  /etc/profile
让配置生效
```

##（不推荐）更改Jenkins.war（或者在展开的Web容器）内的web.xml配置文件）
```
<!-- if specified, this value is used as the Hudson home directory -->
  <env-entry>
    <env-entry-name>HUDSON_HOME</env-entry-name>
    <env-entry-type>java.lang.String</env-entry-type>
    <env-entry-value></env-entry-value>
  </env-entry>
  <!-- 在<env-entry-value>节点中填入路径，windows系统建议使用/分隔路径 -->
```
