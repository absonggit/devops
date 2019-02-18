 
### 介绍

docker-compose是docker的一种编排服务，可以让用户在集群中部署分布式应用。

### 安装
```
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/bin/docker-compose
chmod 755 /usr/bin/docker-compose
```

### 使用
`docker-compose -f docker-compose-file.yml  up -d`

`-f`:使用指定的compose模板文件   
`-d`：后台启动

### compose-file 常用配置
以线上配置为例:
```
version: '2'
services:
  nginx:
    container_name: nginx
    image: nginx:stable-alpine
    restart: always
    environment:
      TZ: "Asia/Shanghai"
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - '../nginx/nginx.conf:/etc/nginx/nginx.conf'
      - '../nginx/conf.d:/etc/nginx/conf.d'
      - '/home/data/logs/nginx/:/var/log/nginx/'
```

`version`:语法使用版本2   
`services`:创建一个应用   
`nginx`:自定义名称，这里标注为服务名   
`container_name`:容器的名称   
`image`:使用的镜像   
`restart`:重启策略为始终重启   
`environment`:环境变量，这里设置了时区   
`ports`:端口映射   
`volumes`:挂载点

