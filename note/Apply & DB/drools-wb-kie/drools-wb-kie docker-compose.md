# 介绍
drools, kie-workbench, kie-server是些什么东西

drools 是一个bussiness rule management system (BRMS)，实现了规则引擎中广泛使用的Rete算法

kie-workbench KIE (knowledge is everything)包含了主体drools之外，还有其他一些附加功能。

workbench是一个在线工具，包括drools项目的建立，编辑，版本控制，构建和部署等很多功能，是一个web　IDE.

kie-server 是一个独立的REST服务，主要是执行规则。

# docker-compose部署
droole-kie.yaml
```
version: '3'
services:
  drools-wb:
    container_name: drools
    image: jboss/drools-workbench-showcase:latest
    volumes:
      - /data/docker-compose/drools-kie/data-persistent/wb_kie:/opt/jboss/wildfly/bin/.niogit:Z
      - /data/docker-compose/drools-kie/data-persistent/repository:/opt/jboss/.m2/repository:Z
      - /data/docker-compose/drools-kie/data-persistent/repositories:/opt/jboss/wildfly/bin/repositories:Z
      - /data/docker-compose/drools-kie/data-persistent/configuration:/opt/jboss/wildfly/standalone/configuration:Z
    #restart: always
    ports:
      - "8080:8080"
      - "8001:8001"
    network_mode: default

  kie-server:
    container_name: kie
    image: jboss/kie-server-showcase:latest
    #restart: always
    links:
      - "drools-wb:kie_wb"
    ports:
      - 8180:8080
    #depends_on:
    #  - drools-wb
    #environment:
    #  # KIE Workbench environment variables
    #  # Neccessary to connect the KIE server to the KIE workbench
    #  - KIE_WB_PORT_8080_TCP=tcp://kie_wb:8080
    #  - KIE_WB_ENV_KIE_CONTEXT_PATH=drools-wb
    #  - KIE_WB_PORT_8080_TCP_ADDR=kie_wb
    network_mode: default
```

# tomcat部署
http://blog.xiabb.me/2016/04/14/kie-workbench-and-kie-server/index.html
