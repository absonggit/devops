

# Docker Swarm - 编排Docker实例、集群以及容器管理
## swarm特性

- 容错能力的去中心化设计
- 内置服务发现
- 负载均衡
- 路由网格
- 动态伸缩
- 滚动更新
- 安全传输

## swarm基本概念

- 管理节点 | Swarm集群的管理
  docker swarm 命令只能在管理节点执行（节点退出集群命令 docker swarm leave 可以在工作节点执行）
  管理节点可以有多个，但只有一个为leader。默认也是工作节点

- 工作节点 | 任务在工作节点执行
  docker service 命令管理该节点的服务

## Docker Swarm 集群管理指令
```
   初始化集群
   # docker swarm init --advertise-addr <IP>

   查看管理端token
   # docker swarm join-token -q manager

   工作节点加入集群
   # docker swarm join --token xxxxxxxx <Master-IP>

   查看集群
   # docker node ls
```
## Docker 服务管理
```
   服务创建
   # docker service create --replicas 3 -p 80:80 --name nginx nginx:latest
   --replicas 副本数
   -p 开放端口:容器端口
   --name 服务名称
   nginx:latest image:tag

   服务列表
   # docker service ls

   服务任务
   # docker service ps <service name>

   服务信息
   # docker service inspect <service name>

   服务日志
   # docker service logs <service name>

   服务伸缩
   # docker service scale <service name>=<num>

   服务删除
   # docker service rm <service name>

   服务更新
   # docker service update <service name>

   服务回滚
   # docker service rollback <service name>
```
   docker stack
   Docker层级关系中的最高一个层级 docker service create 一次只能部署一个服务，使用 docker-compose.yml 可以一次启动多个关联的服务。
```
   部署新stack或更新现有stack
   # docker stack deploy -c docker-compose.yml <stack-name>

   stack列表
   # docker stack ls

   stack任务
   # docker stack ps <stack-name>

   stack删除
   # docker stack rm <stack-name>

   stack服务列表
   # docker stack services
```
## docker stack 的 docker-compose.yaml
  Docker stack的yaml文件中有一个新的指令deploy，同时docker-compose的部分语法会不支持
如下：

    - buid
    - cgroup_parent
    - container_name
    - devices
    - tmpfs
    - external_links
    - links
    - network_mode
    - restart
    - security_opt
    - stop_signal
    - sysctls
    - userns_mode

-------

<未完待续...>
