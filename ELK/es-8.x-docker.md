#### 节点说明

 | 内网IP        | 主机名          | 软件                | 系统 |
 | ------------- | ----------------- | ----------------------- | ----------------------- | 
 | 192.168.1.27  | es.node1 | ES | CentOS Stream release 9 |
 | 192.168.1.112 | es.node2 | ES | CentOS Stream release 9 |
 | 192.168.1.58  | es.node3 | ES |C entOS Stream release 9 |

----

<details>
<summary>初始化</summary>
 
```shell
dnf install -y docker podman-compose
mkdir -p /opt/es/{config,data,logs,plugins,certs}
chmod 777 -R /opt/es

```
- 下载
  - [:arrow_double_down: x-pack-core-7.6.0.jar](download/x-pack-core-7.6.0.jar)
  - [:arrow_double_down: x-pack-core-7.6.1.jar](download/x-pack-core-7.6.1.jar)
  - [:arrow_double_down: license.json](download/license.json)

</details>

----

<details>
<summary>生成证书</summary>
 
```shell
docker run --rm -it -v "/opt/es/certs":/usr/share/elasticsearch/config/certs docker.elastic.co/elasticsearch/elasticsearch:8.13.4 /bin/bash -c "elasticsearch-certutil ca --out /usr/share/elasticsearch/config/certs/elastic-stack-ca.p12 --pass ''"
docker run --rm -it -v "/opt/es/certs":/usr/share/elasticsearch/config/certs docker.elastic.co/elasticsearch/elasticsearch:8.13.4 /bin/bash -c "elasticsearch-certutil cert --ca /usr/share/elasticsearch/config/certs/elastic-stack-ca.p12 --ca-pass '' --out /usr/share/elasticsearch/config/certs/elastic-certificates.p12 --pass ''"
```

</details>

----

<details>
<summary>编辑配置elasticsearch.yml</summary>
 
```yaml
cluster.name: es
node.name: 192.168.1.27
node.roles: [data, master, remote_cluster_client, ingest]
network.host: 0.0.0.0
http.port: 9200
http.host: 0.0.0.0
http.cors.enabled: true
http.cors.allow-origin: "*"
discovery.seed_hosts: ["192.168.1.27", "192.168.1.112", "192.168.1.58"]
cluster.initial_master_nodes: ["192.168.1.27", "192.168.1.112", "192.168.1.58"] 
action.destructive_requires_name: true
xpack.security.enabled: false
```

</details>

----

<details>
<summary>编辑配置docker-compose.yml</summary>
 
```yaml
services:
  es-1:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.13.4
    container_name: es-1
    environment:
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms32g -Xmx32g" # 根据服务器的内存进行分配，最大不要超过32g
      - xpack.monitoring.collection.enabled=true
      - xpack.security.enabled=true
      - xpack.security.transport.ssl.enabled=true
      - xpack.security.transport.ssl.verification_mode=certificate
      - xpack.security.transport.ssl.keystore.path=/usr/share/elasticsearch/config/certs/elastic-certificates.p12
      - xpack.security.transport.ssl.truststore.path=/usr/share/elasticsearch/config/certs/elastic-certificates.p12
      - ELASTIC_PASSWORD=123456 # elastic 密码
    ulimits:
      memlock:
        soft: -1
        hard: -1
    ports:
      - 9200:9200
      - 9300:9300
    volumes:
      - ./config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml
      - ./data:/usr/share/elasticsearch/data
      - ./logs:/usr/share/elasticsearch/logs
      - ./plugins:/usr/share/elasticsearch/plugins
      - ./certs:/usr/share/elasticsearch/config/certs
      - ./x-pack-core-8.13.4.crack.jar:/usr/share/elasticsearch//modules/x-pack-core/x-pack-core-8.13.4.jar # 破解许可证包
    restart: always
    network_mode: host
```

</details>

----

<details>
<summary>启动并验证服务</summary>
 
```shell
docker compose up -d
curl elastic:123456@127.0.0.1:9200/_cat/health
1717574723 08:05:23 es green 3 3 80 40 0 0 0 0 - 100.0%
```

</details>

----

#### Kibana安装配置

<details>
<summary>安装elasticsearch</summary>
 
```shell
# 安装kibana
yum install kibana -y
systemctl enable kibana

# 修改配置
vim /etc/kibana/kibana.yml
server.port: 5601
server.host: "0.0.0.0"
elasticsearch.hosts:
  - "http://192.168.1.27:9200"
  - "http://192.168.1.112:9200"
  - "http://192.168.1.58:9200"
kibana.index: ".kibana"
i18n.locale: "zh-CN"

# 启动
systemctl start kibana.service
```

- [返回目录 :leftwards_arrow_with_hook:](#目录)

</details>

----

#### X-pack白金许可证破解

<details>
<summary>X-pack白金许可证破解</summary>
 
**ES配置**

```shell
# ES生成证书
/usr/share/elasticsearch/bin/elasticsearch-certutil ca
/usr/share/elasticsearch/bin/elasticsearch-certutil cert --ca elastic-stack-ca.p12

# 设置证书文件的权限
chgrp elasticsearch /usr/share/elasticsearch/elastic-certificates.p12 /usr/share/elasticsearch/elastic-stack-ca.p12

chmod 640 /usr/share/elasticsearch/elastic-certificates.p12 /usr/share/elasticsearch/elastic-stack-ca.p12

# 移动到ES配置目录，把证书文件复制到其他master节点并赋予相关的权限。
mv /usr/share/elasticsearch/elastic-* /etc/elasticsearch/

# 三台服务器都要操作
# ES增加配置
xpack.security.enabled: false
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: /etc/elasticsearch/elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: /etc/elasticsearch/elastic-certificates.p12

# 复制破解后的X-pack包到ES模块目录
cp /root/x-pack-core-7.6.0.jar /usr/share/elasticsearch/modules/x-pack-core/

# 重启整个ES集群
systemctl restart elasticsearch.service

# 上传许可证信息到集群
curl -XPUT -u elastic 'http://192.168.1.27:9200/_xpack/license' -H "Content-Type: application/json" -d @license.json

# 修改ES配置然后重启集群
xpack.security.enabled: true

# 生成用户密码
/usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto
PASSWORD apm_system = GP5ab69FQUZXBXXr5gG9
PASSWORD kibana = 1DKGjq2DX5sGlORgEVTQ
PASSWORD logstash_system = aGkcCh2gqNa9MOoeNbTO
PASSWORD beats_system = HxyjDTdvgrgH0iIIbUWH
PASSWORD remote_monitoring_user = VRI4kHYjmlVMI8CWFTDu
# elastic 是整个elk-stack 管理员账号密码
PASSWORD elastic = hD7uPvigYS3y6ceuQiFy 
```
- 下载
  - [:arrow_double_down: x-pack-core-7.6.0.jar](download/x-pack-core-7.6.0.jar)
  - [:arrow_double_down: x-pack-core-7.6.1.jar](download/x-pack-core-7.6.1.jar)
  - [:arrow_double_down: license.json](download/license.json)

```shell
# 验证许可证状态 active 表示激活， 过期时间 "expiry_date" : "2049-12-31T16:00:00.999Z"**
curl -XGET -u elastic:hD7uPvigYS3y6ceuQiFy http://192.168.1.27:9200/_license
```
```json
{
  "license" : {
    "status" : "active",
    "uid" : "537c5c48-c1dd-43ea-ab69-68d209d80c32",
    "type" : "platinum",
    "issue_date" : "2019-05-17T00:00:00.000Z",
    "issue_date_in_millis" : 1558051200000,
    "expiry_date" : "2049-12-31T16:00:00.999Z",
    "expiry_date_in_millis" : 2524579200999,
    "max_nodes" : 1000,
    "issued_to" : "pyker",
    "issuer" : "Web Form",
    "start_date_in_millis" : 1558051200000
  }
```

**Kibana配置**
```shell
# 配置kibana使用账密登录
vim /etc/kibana/kibana.yml
elasticsearch.username: "elastic"
elasticsearch.password: "hD7uPvigYS3y6ceuQiFy"

# 重启kibana 再次登录需要输入账号密码
systemctl restart kibana
```

![image-20200218165654489](./image/image-20200218165654489.png)


**成功登录后，查看证书状态**

![image-20200218165816837](./image/image-20200218165816837.png)

- [返回目录 :leftwards_arrow_with_hook:](#目录)

</details>


