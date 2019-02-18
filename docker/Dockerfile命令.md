# Dockerfile

#### 注意
> Dockerfile 文件命名一定要是“Dockerfile”注意大小写

### FROM 使用的基础镜像

##### 格式：
- FROM  <使用的基础镜像名>
- 如：

```
FROM centos  #若本机没有该镜像会自动去pull下来
```

### RUN 需要运行的命令

##### 格式：
- RUN   <"可执行文件", "参数1", "参数2"> #如果命令太长可以通过“\” 换行
- 如：

```
RUN touch /home/1.test
RUN echo 'hahhahahahah'  > /home/1.test
```

### COPY 复制本机文件

##### 格式：
- COPY <源路径>......<目标路径>
- 如：

```
COPY 1.test /tmp/
COPY 1* /tmp/
```

### ADD 添加本机文件

##### 格式：
- ADD <源路径>......<目标路径>
- 如：

```
ADD URL /tmp/  #当源路径是一个URL，docker会去尝试下载。（与COPY的区别之一）
```

### WORKDIR  等于linux“cd”

##### 格式：
- WORKDIR <路径>
- 如：

```
WORKDIR /a    #所有的WORKDIR都会在“当前目录”下操作，如果没有文件夹会自动创建
WORKDIR b
WORKDIR c
RUN pwd
/a/b/c
```

### VOLUME 挂载卷、挂载主机目录

##### 格式：
- VOLUME <挂载路径>
- 如：

```
VOLUME /data
```

### EXPOSE 指定端口

##### 格式：
- EXPOSE <对外端口>
- 如：

```
 EXPOSE "80"  #只是声明，并不会因为此配置而打开端口
```

### CMD 指定容器启动后做的操作

##### 格式：
- CDM <服务可执行文件>
- 如：

```
CDM  "nginx"
```
- 注：docker和虚拟机不同，容器内没有后台服务的概念，其启动程序就是容器应用进程，容器就是为了主进程而存在的，主进程退出，容器就失去了存在的意义，从而退出，其它辅助进程不是它需要关心的东西。如“systemctl start nginx.service”它的主进程实际是sh，在普通的虚拟机上这样做是没有问题的。但是在docker上面就需要主进程是你需要的那个服务。
