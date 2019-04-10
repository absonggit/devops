# tomcat配置https证书
```
$ vim $tomcat/conf/server.xml

<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="443" />
# 8080端口通过redirectPort重定向到443端口、如果没有8080跳转443需求可以忽略

<Connector port="443" protocol="org.apache.coyote.http11.Http11NioProtocol"
           maxThreads="150" SSLEnabled="true">
    <SSLHostConfig>
        <Certificate certificateKeystoreFile="conf/cert/tomcat.jks"
                     certificateKeystorePassword="123456"
                     type="RSA" />
    </SSLHostConfig>
</Connector>
# 配置证书以及证书密码
```
