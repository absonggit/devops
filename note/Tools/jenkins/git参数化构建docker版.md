参数化构建过程：
  Git Parameter
    Name: GITLAB_TAG_OPTION
    Description：
    Parmeter Type： Tag

源码管理：
  Git
    Repositories：Repository URL： git地址
    Branchers to build：Branch specifier(blank for 'any') ${GITLAB_TAG_OPTION}

Build：
Root POM：pom.xml
Goals and options: clean package  -Dmaven.test.skip=true

构建脚本：
```
#需要配置nodejs插件
export PATH=$PATH:/usr/local/node/bin/
npm install
npm run build

# update code to production
sed -i "s/\/\*SEDTAG//g" dc-chain-node-api/src/main/java/com/dc/chain/Application.java
sed -i "s/}SEDTAGEND\*\//}/g" dc-chain-node-api/src/main/java/com/dc/chain/Application.java
sed -i "s/{ \/\/SEDTAG//g" dc-chain-node-api/src/main/java/com/dc/chain/Application.java
sed -i "s/<\!--SEDTAG//g"  pom.xml
sed -i "s/SEDTAGEND-->//g"  pom.xml

rm -rf docker
mkdir docker
cd dist
tar zcf dist.tar.gz ./*
mv dist.tar.gz ../docker
cd ../docker
echo 'FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
ENV TZ=Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ADD dist.tar.gz /usr/share/nginx/html/' > Dockerfile

rm -rf docker
mkdir docker
/bin/cp -r dc-chain-node-api/target/dc-chain-service docker
cd docker
tar zcf dc-chain-service.tar.gz dc-chain-service
echo 'FROM tomcat:8.5-jre8-alpine

# 新的修改时区时间问题
RUN apk update && apk add ca-certificates && \
    apk add tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

RUN /bin/rm -rf /usr/local/tomcat/webapps/*
ADD dc-chain-service.tar.gz /usr/local/tomcat/webapps
ADD server.xml /usr/local/tomcat/conf
ADD context.xml /usr/local/tomcat/conf' > Dockerfile
echo '<?xml version="1.0" encoding="UTF-8"?>

  <Service name="Catalina">

    <Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               proxyPort="443"
               sslProtocol="SSL"
               scheme="https"
               redirectPort="443" />
</Context>' > context.xml

# copy local jar to maven library
/bin/mkdir -p /data/jenkins_home/.m2/repository/com/oracle/ojdbc6/11.2.0/
/bin/mkdir -p /data/jenkins_home/.m2/repository/cn/cfca/third/sadk/3.2.3.0.RELEASE/
/bin/mkdir -p /data/jenkins_home/.m2/repository/cn/bubi/access/sdk/
/bin/mkdir -p /data/jenkins_home/.m2/repository/com/shcm/FYOpenApi/1.0/
/bin/mkdir -p /data/jenkins_home/.m2/repository/com/rongcloud/sdk/rongcloud-server-sdk/3.0.0
/bin/cp -f jars/ojdbc6-11.2.0.jar /data/jenkins_home/.m2/repository/com/oracle/ojdbc6/11.2.0/ojdbc6-11.2.0.jar
/bin/cp -f jars/sadk-3.2.3.0.RELEASE.jar /data/jenkins_home/.m2/repository/cn/cfca/third/sadk/3.2.3.0.RELEASE/sadk-3.2.3.0.RELEASE.jar
/bin/cp -rf jars/bubisdk/* /data/jenkins_home/.m2/repository/cn/bubi/access/sdk/
/bin/cp -f jars/FYOpenApi-1.0.jar /data/jenkins_home/.m2/repository/com/shcm/FYOpenApi/1.0/FYOpenApi-1.0.jar
/bin/cp -f jars/rongcloud-server-sdk-3.0.1.jar /data/jenkins_home/.m2/repository/com/rongcloud/sdk/rongcloud-server-sdk/3.0.1

# update code to production
sed -i "s/\/\*SEDTAG//g" dc-chain-service/src/main/java/com/dc/chain/Application.java
sed -i "s/}SEDTAGEND\*\//}/g" dc-chain-service/src/main/java/com/dc/chain/Application.java
sed -i "s/{ \/\/SEDTAG//g" dc-chain-service/src/main/java/com/dc/chain/Application.java
sed -i "s/<\!--SEDTAG//g"  dc-chain-service/pom.xml
sed -i "s/SEDTAGEND-->//g"  dc-chain-service/pom.xml

# 开启集群相关功能-20180406-francis
sed -i "s/\/\/@SchedulerLock/@SchedulerLock/g" dc-chain-service/src/main/java/com/dc/chain/service/task/OrderTaskService.java
sed -i "s/\/\/@SchedulerLock/@SchedulerLock/g" dc-chain-service/src/main/java/com/dc/chain/service/task/ScheduledTaskService.java

[ -z `sudo docker images |grep "reg.9anback.com/dc-chain/dc-chain-node .*stable"` ] || \
sudo docker rmi reg.9anback.com/dc-chain/dc-chain-node:stable
sudo docker build . -t reg.9anback.com/dc-chain/dc-chain-node:stable
sudo docker push reg.9anback.com/dc-chain/dc-chain-node:stable
```
