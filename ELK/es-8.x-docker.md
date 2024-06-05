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
  - [:arrow_double_down: x-pack-core-8.13.4.crack.jar](download/x-pack-core-8.13.4.crack.jar)
  - [:arrow_double_down: platinum_license.json](download/platinum_license.json)

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
<summary>启动服务</summary>
 
```shell
# 启动容器
docker compose up -d
# 查看服务状态
curl elastic:123456@127.0.0.1:9200/_cat/health
```

----

</details>

----

<details>
<summary>激活许可证</summary>
 
```shell
# 提交许可证
curl  -XPUT -u elastic:123456 127.0.0.1:9200/_license -H "Content-Type: application/json" -d @platinum_license.json
# 重新创建容器
docker compose up -d --force-recreate
# 查看许可证信息
curl -u elastic:123456 127.0.0.1:9200/_license
```

</details>
