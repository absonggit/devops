### 1. 安装awx
#### step 1. clone repo
``` bash
git clone https://github.com/ansible/awx.git
```
#### step 2. 准备工作
安装 Ansible
``` bash
# yum install -y epel-release
# yum install ansible -y
```

安装 Docker docker-compose
``` bash
# yum install -y yum-utils
# yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# yum install docker-ce -y
# systemctl enable docker
# systemctl start docker

# yum install -y python-pip
# pip install --upgrade pip
# pip install docker-compose
```

安装 Node 6.x LTS version and NPM 3.x LTS
``` bash
wget https://nodejs.org/dist/v8.11.3/node-v8.11.3-linux-x64.tar.xz
tar Jxvf node-v8.11.3-linux-x64.tar.xz
mv node-v8.11.3-linux-x64/ /usr/local/node

echo "export PATH=$PATH:/usr/local/node/bin" > /etc/profile.d/node.sh
source /etc/profile

npm -v
5.6.0

node -v
v8.11.3
```

#### step 3. install awx base on docker-compose
在awx目录中有一个installer目录，
``` bash
# 默认情况下 installer/inventory 文件会把awx安装在本地，如果需要安装到其他机器，可以修改 installer/install.yml
cd awx/

cd /root/awx/installer
ansible-playbook -i inventory install.yml

http://192.168.230.130/
admin/password

admin/GSMCpassword666

docker ps
CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                                                 NAMES
83b789355ce9        ansible/awx_task:latest      "/tini -- /bin/sh -c…"   2 minutes ago       Up 2 minutes        8052/tcp                                              awx_task
04d8601b2180        ansible/awx_web:latest       "/tini -- /bin/sh -c…"   16 minutes ago      Up 16 minutes       0.0.0.0:80->8052/tcp                                  awx_web
11ca113fbb06        memcached:alpine             "docker-entrypoint.s…"   24 minutes ago      Up 24 minutes       11211/tcp                                             memcached
f8550eeff8c2        ansible/awx_rabbitmq:3.7.4   "docker-entrypoint.s…"   25 minutes ago      Up 25 minutes       4369/tcp, 5671-5672/tcp, 15671-15672/tcp, 25672/tcp   rabbitmq
0874fb6e43e5        postgres:9.6                 "docker-entrypoint.s…"   About an hour ago   Up About an hour    5432/tcp                                              postgres
```
sudo docker stop $( sudo docker ps -q)
停止
 docker stop $( docker ps -q)
删除
 docker rm $(docker ps -aq)

进入容器
> 如果install的时候卡住就手动下载一下postgres、rabbitmq、memcached、awx_task、awx_web这些镜像就不会卡住了

> 默认情况，inventory中是安装awx到localhost中，如果需要修改，可以参照[awx 官方安装教程](https://github.com/ansible/awx/blob/devel/INSTALL.md)
inventory中还有其他的变量可以修改，例如，是否更换默认的postgres为其他的数据库，以及搭建awx在什么平台上（k8s、openshift、docker原生、docker compose）
查看容器日志
sudo docker logs -f -t --tail 300 d6656b028699
 61.238.74.36
  61.238.74.36
  220.241.124.136  61.238.74.36  172.23.2.36


  Error starting project 500 Server Error: Internal Server Error (\"Failed to Setup IP tables: Unable to enable SKIP DNAT


  重启一下docker服务就好了
