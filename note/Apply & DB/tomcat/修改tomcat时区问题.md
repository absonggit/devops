# 问题描述
tomcat启动后，获取的时间和服务器的时间不一致，查找了linux系统中的所有关于时区设置的地方，没有发现有任何问题，重启服务器也没有解决这个问题。有可能是JVM中的时区和linux系统的时区不一致导致的，检查JVM中的时区。

# 查看JVM时区
```
$ java -XshowSettings:all
或
$ java -XshowSettings:local

可以查看JVM中的设置，服务器在这个设置中有关时区的地方为：
user.timezone=
```

# 修改JVM时区
```
$ vim $tomcat/bin/catalina.sh
export JAVA_OPTS="$JAVA_OPTS -Duser.timezone=Asia/shanghai"
export JAVA_OPTS="-server -Duser.timezone=Asia/shanghai"
```
