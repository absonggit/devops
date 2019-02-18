##  **镜像管理**

在之前的介绍中，我们知道镜像是 Docker 的三大组件之一。Docker 运行容器前需要本地存在对应的镜像，如果本地不存在该镜像，Docker 会从镜像仓库下载该镜像。

###  拉取镜像

docker pull [选项] [Docker Registry 地址[:端口号]/]仓库名[:标签]

```
例：
1. 从dockerhub 上拉取 docker  pull   nginx:latest   (默认不输入版本号拉取的就是latest版本)
2. 从其他网站网上拉取docker pull quay.io/coreos/flannel:latest   
```

###  列出镜像

docker image ls

 

 
```
$ docker image ls

REPOSITORY（仓库名）  TAG（标签）        IMAGE ID（镜像 ID） CREATED （创建时间）  SIZE（空间）

redis                latest              5f515359c7f8        5 days ago          183 MB

nginx                latest              05a60462f8ba        5 days ago          181 MB

mongo                3.2                 fe9198c04d62        5 days ago          342 MB

ubuntu               16.04               f753707788c5        4 weeks ago         127 MB

ubuntu               latest              f753707788c5        4 weeks ago         127 MB

 
```
 

 

###  生成新镜像

可以使用commit指令

镜像是容器的基础，每次执行 docker run 的时候都会指定哪个镜像作为容器运行的基础。

我们以定制一个 Web 服务器为例子，下面就是跑了 命名为webserver的容器，映射了80端口到本机，  使用nginx的镜像

docker run --name webserver   --rm  -d -p 80:80 nginx

这是我们可以本机自己也监听了80端口，访问一下

```
[root@localhost ~]# curl 127.0.0.1
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>  
```
当我们不喜欢这个页面使用。我们可以对这个进行修改，打包。

```
[root@localhost ~]#docker exec -it webserver  /bin/sh/ 
#echo "hello world"  >   /usr/share/nginx/html/index.html
```
 

此时容器不能关闭，在另一个窗口对容器进行打包。-a 写作者信息  -p暂停容器，防止制作的时候被修改。

```
[root@localhost ~]# docker commit  -a 'test <test@123.com>'  -p   webserver   nginx:1.1                                                     

```                            

停止前面的容器，使用新的镜像运行新的容器。

docker run --name webserver   --rm  -d -p 80:80 nginx:1.1

 再次访问本机
```
[root@localhost ~]# curl 127.0.0.1
hello world 
```
 

 

 

###  删除镜像

可以使用 rm  指令
```
[root@localhost bin]# docker  images
REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
nginx                    1.1                 ff230052e924        30 hours ago        17.4MB
webserver                1.1                 053491f826e0        30 hours ago        17.4MB
[root@localhost bin]# docker image rm   webserver:1.1
Untagged: webserver:1.1
Deleted: sha256:053491f826e073dc4b8df5edb037fec3cfac8438163bc38db377e00a83e34d15
Deleted: sha256:2953346c3dbb007235280140732b2c98678fc51df0a1b1df4c5c719b5e32dc47
[root@localhost bin]# docker  images
REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
nginx                    1.1                 ff230052e924        30 hours ago        17.4MB

```
