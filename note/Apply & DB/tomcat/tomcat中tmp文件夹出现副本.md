
解决tomcat中temp文件夹出现项目的副本的情况
TomcatMyeclipseXMLGoogle
在最近开发过程中出现过这样的情况，当我在myeclipse发布项目的时候，在tomcat的temp文件夹中会出现项目的副本，这样的话会产生一些问题如：

当我们在网站中上传东西的时候，由于我们的文件是放在upload文件夹中，当我们再次发布网站项目的时候，tomcat中会产生一个新的项目副本，所以我们之前上传的文件，就不能读取了，例如，我们上传了图片，然后deloy以后，图片就不能显示了。

解决办法：
- 首先确保你的tomcat文件夹下的conf\Catalina\localhost路径中的两个文件host-manager.xml 和manager.xml 存在 antiResourceLocking 和antiJARLocking 的值为false ，至于这两个值的含义，可以google下，这里不解析
- 如果这样还不行的话，可以回到项目下的路径WebRoot\META-INF ，看是否有context.xml 这个文件，如果没有可以自己创建，添加以下语句，如果有的话，请把里面的值设为false：
```
<Context reloadable="true" antiResourceLocking="false" antiJARLocking="false"/>
```
