# 报错
```
上传文件过大，出现 MaxUploadSizeExceededException 异常:

nested exception is org.springframework.web.multipart.MaxUploadSizeExceededException: Maximum upload size of 5242880 bytes exceeded;
nested exception is org.apache.commons.fileupload.FileUploadBase$SizeLimitExceededException: the request was rejected because its size (5845210) exceeds the configured maximum (5242880)] with root cause
org.apache.commons.fileupload.FileUploadBase$SizeLimitExceededException: the request was rejected because its size (5845210) exceeds the configured maximum (5242880)
```

# 处理
```
1、配置tomcat/conf/server.xml，添加maxSwallowSize=”-1”

<Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               maxSwallowSize="-1"
               redirectPort="8443" />

2、SpringMVC 配置 CommonsMultipartResolver属性，添加resolveLazily=”true”

<bean id="multipartResolver"
    class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
        <property name="defaultEncoding" value="UTF-8"/>
        <property name="maxUploadSize" value="20971520"/>
        <property name="resolveLazily" value="true"/>
    </bean>
```
