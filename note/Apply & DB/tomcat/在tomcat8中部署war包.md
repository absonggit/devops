# 修改配置文件

在server.xml中为Web应用程序增加Context元素，且必须把Web应用程序的Context元素嵌套在Host容器元素中。

```
# 默认的配置文件
<Host name="localhost " appBase="webapps"
  unpackWARs="true " autoDeploy="true "
  xmlValidation="false " xmlNamespaceAware="false ">
  .....
</Host>
```
- unpackWARs的值为true或false，这要根据从打包的WAR文件还是在第一次解包后从解包的目录提供文件而定。

   笔者建议您设置该值为true，并允许Tomcat解包WAR文件且从解包目录下提供文件，因为这样处理可以使您很容易就能检测到Tomcat提供什么样的Web应用程序文件和内容。查看本站早期“Host”一节。以了解笔者为何这样建议的详细理由。

   通常，因为默认情况下主机名是localhost，而且通过Tomcat的网络服务器传递给机器的请求都将默认主机作为(默认)路由，所以在默认Host中增加Context能工作。

   在Host中增加Context的情况如下所示：
```
<Host name="localhost"  appBase="webapps"
      deployOnStartup="false" deployXML="false"
      unpackWARs="true" autoDeploy="false"
      xmlValidation="false" xmlNamespaceAware="false">
<Context path="" docBase="project.war" debug="0" reloadable="false" />
</Host>
```

> 将Host元素上的autoDeploy设置为“false”非常重要，从而可以避免两次部署Web应用程序。如果将autoDeploy设置为true，就会发生再次部署的现象，第一次因server.xml中的Context配置而被部署(因为deployOnstartup="true ")，而第二次因autoDeploy被设置为true而发生自动部署(默认情况下，在没有显式Context的这些属性时，它们每个的默认值都是true)。



   当Tomcat启动的时候，它将查找路径CATALINA_HOME/webapps/my-webapp.war中Web应用程序的WAR文件。

   如果Tomcat在该路径下找到了您的Web应用程序，Tomcat将尝试部署您的Web应用程序，而且将它安装到URI路径为/my-webapp的Web服务器上。

   如果在启动和停止Web应用程序时，Tomcat没有遇到任何错误(查看日期)，您就可以通过浏览http://localhost:8080/my-webapp进行访问。

   相反，如果您想让这个特殊的Web应用程序映射为服务器的根URI(“/”)，如通过http://localhost:8080访问您的Web应用程序，您需要执行下列特殊步骤：

   一、停止Tomcat。

   二、确定不存在CATALINA_HOME/conf/[EngineName]/[Hostname]/ROOT.xml配置文件如果存在，只要删除就可以了。

   三、编辑server.xml文件，并使<Host>和<context>其看起来如下所示：

   <Host name="localhost " appBase="webapps"
      unpackWARs="true " autoDeploy="false "
      xmlValidation="false " xmlNamespaceAware="false ">
      <Context docBase="my-webapp.war " path=""/>
   </Host>

   注意在Context元素上path=""，这让Tomcat把您的Web应用程序映射为root URI路径。

   在这种情况下，没有其他程序被映射为root URI路径，而且您的Web应用程序已经被显示映射为root URI路径。

   请再次确定autoDeploy被设置为false，否则，您的Web应用程序将被部署两次(一次在root URI上被server.xml文件显式配置的路径所部署，另一次在/my-webapp URI路径下被自动部署)。


   Tomcat下server.xml中context介绍
conf/Context.xml是Tomcat公用的环境配置;若在server.xml中增加<Context path="/test" docBase="D:\test" debug="0" reloadable="false"/>的话,则myApp/META-INF/Context.xml就没用了(被server.xml中的Context替代),

<Context>代表了运行在<Host>上的单个Web应用，一个<Host>可以有多个<Context>元素，每个Web应用必须有唯一的URL路径，这个URL路径在<Context>中的属性path中设定。 <Context path="bbs" docBase="bbs" debug="0" reloadable="true"/>  

<Context>元素的属性:
一：　path:指定访问该Web应用的URL入口。
二：　docBase:指定Web应用的文件路径，可以给定绝对路径，也可以给定相对于<Host>的appBase属性的相对路径，如果Web应用采用开放目录结构，则指定Web应用的根目录，如果Web应用是个war文件，则指定war文件的路径。
三：　reloadable:如果这个属性设为true，tomcat服务器在运行状态下会监视在WEB-INF/classes和WEB-INF/lib目录下class文件的改动，如果监测到有class文件被更新的，服务器会自动重新加载Web应用。
　　在开发阶段将reloadable属性设为true，有助于调试servlet和其它的class文件，但这样用加重服务器运行负荷，建议在Web应用的发存阶段将reloadable设为false。
