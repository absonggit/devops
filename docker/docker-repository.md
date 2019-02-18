##  自建仓库

有时候使用 Docker Hub 这样的公共仓库可能不方便，用户可以创建一个本地仓库供私人使用。
我们这边有2台机器，分别做仓库源和客户端。

```
  Node1	Docker 客户端
  Node2	Docker 仓库 
```


Node2 仓库操作
```
[root@node2 ~]# yum install -y  docker-registry
[root@node2 ~]# cat  /etc/docker-distribution/registry/config.yml
version: 0.1
log:
  fields:
    service: registry
storage:
    cache:
        layerinfo: inmemory
    filesystem:
        rootdirectory: /var/lib/registry   
http:
addr: :5000                       默认是启动5000端口的
[root@node2 ~]# systemctl  start     docker-distribution 
```


Node1
```
[root@node1 ~]#docker  tag  mtest:1.1  node2.com:5000/mtest:1.1
[root@node1 docker]# pwd
/etc/docker
[root@node1 docker]# cat /etc/docker/daemon.json
{
    "insecure-registries":["node2.com:5000"]
}
[root@node1 ~]vim /lib/systemd/system/docker.service
# ExecStart后面添加仓库地址
ExecStart=/usr/bin/dockerd --insecure-registry http://私人仓库.com
[root@node1 docker]# systemctl restart  docker
[root@node1 docker]# docker push node2.com:5000/mtest:1.1

```
