# Docker-tomcat容器时间不正确问题
```
在启动容器的时候将宿主机localtime挂载到容器localtime内，同时可能需要设置环境变量：

docker run -v /etc/localtime:/etc/localtime:ro --name tomcat tomcat:8-jre8
docker run -e TZ="Asia/Shanghai" -v /etc/localtime:/etc/localtime:ro --name tomcat tomcat:8-jre8

在docker-compose.yml中：
tomcat:
  image: tomcat:8-jre8
  volumes:
    - /etc/localtime:/etc/localtime:ro

或者修改基础镜像重新新建Dockerfile：
FROM tomcat:8-jre8
RUN ln -sf /usr/share/zoneinfo/Asia/ShangHai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

如果使用的是alpine镜像：
RUN apk update && apk add ca-certificates && \
    apk add tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone
```
