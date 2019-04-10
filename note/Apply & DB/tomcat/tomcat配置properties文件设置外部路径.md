path 路径，是java编译时需要调用的程序（如java，javac等）所在的地方。一般是jdk的bin目录  eg:/usr/local/jdk8
classpath 类的路径，在编译运行java程序时，如果有调用到其他类的时候，在classpath中寻找需要的类或者理解为class文件的存放路径。  


首先在{CATALINA_HOME}/bin目录下面有个setclasspath.sh文件。在该文件当中加入你想要设置的classpath路径。例如：
```
24 #设置tomcat项目配置文件外部加载路径
25 export CLASSPATH=$CLASSPATH:/opt/app/tomcat_comm_manager/webapps/property
```
 就将/opt/app/tomcat_comm_manager/webapps/property目录设置为了classpath路径，只需要将properties文件放在该目录下面就行了。项目启动的时候会自动加载该目录下面的properties文件



Tomcat启动时class加载的优先顺序:
- 最先是$JAVA_HOME/jre/lib/ext/下的jar文件。
- 环境变量CLASSPATH中的jar和class文件。
- $CATALINA_HOME/common/classes下的class文件。
- $CATALINA_HOME/commons/endorsed下的jar文件。
- $CATALINA_HOME/commons/i18n下的jar文件。
- $CATALINA_HOME/common/lib 下的jar文件。
　　（JDBC驱动之类的jar文件可以放在这里，这样就可以避免在server.xml配置好数据源却出现找不到JDBC Driver的情况。）
- $CATALINA_HOME/server/classes下的class文件。
- $CATALINA_HOME/server/lib/下的jar文件。
- $CATALINA_BASE/shared/classes 下的class文件。
- $CATALINA_BASE/shared/lib下的jar文件。
- 各自具体的webapp /WEB-INF/classes下的class文件。
- 各自具体的webapp /WEB-INF/lib下的jar文件。


class调用时的搜寻顺序：
```
- Bootstrap classes of your JVM
- System class loader classses (described above)
- /WEB-INF/classes of your web application
- /WEB-INF/lib/*.jar of your web application
- $CATALINA_HOME/common/classes
- $CATALINA_HOME/common/endorsed/*.jar
- $CATALINA_HOME/common/i18n/*.jar
- $CATALINA_HOME/common/lib/*.jar
- $CATALINA_BASE/shared/classes
- $CATALINA_BASE/shared/lib/*.jar
```
