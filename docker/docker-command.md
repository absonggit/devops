### 常用命令



1.生命周期管理

`docker run`,创建一个容器（一般写docker-compose.yml文件）

`docker start|stop|restart thai_nginx`,启动|停止|重启 thai_nginx容器

`docker kill thai_nginx`,杀掉hai_nginx容器

`docker rm thai_nginx`,删除thai_nginx容器



2.操作运维

`docker ps`,查看当前运行的容器,后面添加`-a`选项可以显示所有的容器

`docker inspect thai_nginx`,查看thai_nginx容器的元数据

`docker top thai_nginx`,查看thai_nginx容器中运行的进程信息

`docker logs -f -t --tail 100 nginx`,查看nginx容器log,`-f`循环读取,`-t`显示时间戳,`--tail 100`显示最新的100条

`docker logs --since="2018-10-17" --tail 10 nginx`,显示2018-10-17的最新10条日志


3.容器rootfs命令

`docker info`,查看容器信息

`docker image ls`,查看容器当前的镜像

`docker rmi reg.easydevops.net/nginx:crm-product`,删除镜像

`docker rmi $(docker images -f "dangling=true" -q)`,清理none镜像

`docker pull`,拉取镜像


4.进入容器

`sudo docker exec -it  nginx  /bin/sh`,进入nginx容器





