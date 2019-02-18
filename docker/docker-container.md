##  **容器操作**

容器是 Docker 又一核心概念，简单的说，容器是独立运行的一个或一组应用，以及它们的运行态环境。对应的，虚拟机可以理解为模拟运行的一整套操作系统（提供了运行态环境和其他系统环境）和跑在上面的应用。

###  新建并启动容器

可以直接使用docker run指令

 

| Usage:	docker run [OPTIONS] IMAGE [COMMAND] [ARG...]      |
| ------------------------------------------------------------ |
| 检查本地是否存在指定的镜像，不存在就从公有仓库下载
| 利用镜像创建并启动一个容器
| 分配一个文件系统，并在只读的镜像层外面挂载一层可读写层
|从宿主主机配置的网桥接口中桥接一个虚拟接口到容器中去
|从地址池配置一个 ip 地址给容器
|执行用户指定的应用程序
|执行完毕后容器被终止 |
| 例：docker run  --name  new1   nginx:1.1                 --name  定义容器名字 |

 

###  启动已经创建的容器

docker container start

 

###  终止容器

我们可以直接使用stop在终止容器

docker container stop

 

###  查看容器

我们container  ls -a  来查看所有的容器

```

[root@localhost ~]# docker  container ls -a
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS                     PORTS                
NAMES75957d3dda83   nginx:1.1           "nginx -g 'daemon of…"   About a minute ago   Up About a minute          0.0.0.0:80->80/tcp   webserver1
f91ceb483377        nginx:1.1           "nginx -g 'daemon of…"   2 minutes ago        Exited (0) 2 minutes ago                        webserver 

 ```

###  进入容器

我们使用exec 来进入镜像

docker exec 后边主要使用 -i -t 参数。

只用 -i 参数时，由于没有分配伪终端，界面没有我们熟悉的 Linux 命令提示符，但命令执行结果仍然可以返回。

当 -i -t 参数一起使用时，则可以看到我们熟悉的 Linux 命令提示符。

```

[root@localhost ~]# docker  exec -it  webserver1 /bin/sh 
# ls
bin    etc    lib    mnt    root   sbin   sys    usrdev    home   media  proc   run    srv    tmp    var 

 ```

###  删除容器

docker container rm
```
[root@localhost ~]# docker  rm  webserver webserver 
```
 

清理所有处于终止状态的容器，慎用。

docker container prune

 

