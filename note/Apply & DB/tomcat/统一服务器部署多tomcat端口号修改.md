同一服务器部署多个tomcat时，存在端口号冲突的问题，所以需要修改tomcat配置文件server.xml，以tomcat7为例。


tomcat的几个主要端口的含义：
```
<Connector port="8080" protocol="HTTP/1.1"  connectionTimeout="60000"  redirectPort="8443" disableUploadTimeout="false"  executor="tomcatThreadPool" URIEncoding="UTF-8"/>
```
其中8080为HTTP端口，8443为HTTPS端口

```
<Server port="8005" shutdown="SHUTDOWN">
```
8005为远程停服务端口

```
<Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
```
8009为AJP端口，APACHE能过AJP协议访问TOMCAT的8009端口


部署多个tomcat主要修改三个端口：

1.HTTP端口，默认8080，如下改为8081
```
<Connector port="8081" protocol="HTTP/1.1"                  connectionTimeout="60000"                  redirectPort="8443" disableUploadTimeout="false"  executor="tomcatThreadPool"  URIEncoding="UTF-8"/>  
```
2.远程停服务端口，默认8005，如下改为8006
```
<Server port="8006" shutdown="SHUTDOWN">
```
3.AJP端口，默认8009，如下改,8010
```
<Connector port="8010" protocol="AJP/1.3" redirectPort="8443" />
```
