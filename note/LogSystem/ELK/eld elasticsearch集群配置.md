# 系统版本及系统设置
## 版本
elasticsearch-6.1.2.tar.gz
kibana-6.1.2-linux-x86_64.tar.gz

## 系统设置
```
$ vim /etc/security/limits.conf
* soft nofile 65536
* hard nofile 65536
* soft nproc 2048
* hard nproc 4096

$ vim /etc/sysctl.conf
vm.max_map_count = 262144
net.ipv6.conf.all.disable_ipv6 = 1
$ sysctl -p
$ ulimit -n 65536
```

## 安装配置
```
$ mkdir -p /home/elasticsearch/data
$ mkdir -p /home/elasticsearch/logs
$ chown -R elasticsearch:elasticsearch /home/elasticsearch/

$ vim /etc/elasticsearch/jvm.options    //内存的一半
-Xms2g
-Xmx2g

$ cd /etc/elasticsearch/
$ mv elasticsearch.yml bak_leasticsearch.yml
$ vim elasticsearch.yml

-------------------------------------------------------------------
cluster.name: es-cluster
node.name: node-1
node.master: false
node.data: true
path.data: /home/elk/es/node1/data
path.logs: /home/elk/es/node1/logs
network.host: 69.172.86.130
http.port: 9200
transport.tcp.port: 9300
http.cors.enabled: true
http.cors.allow-origin: "*"
discovery.zen.ping.unicast.hosts: ["69.172.86.130", "113.10.193.68", "113.10.193.68:9301", "113.10.193.68:9302", "113.10.193.68:9303", "113.10.193.68:9304"]
node.max_local_storage_nodes: 6
#discovery.zen.minimummasternodes: 2
#discovery.zen.ping.timeout: 5s

#x-pack
#xpack.graph.enabled   
#xpack.ml.enabled      
#xpack.monitoring.enabled
#xpack.reporting.enabled  
#xpack.security.enabled   
#xpack.watcher.enabled   
#action.auto_create_index: .security,.security-6,.monitoring*,.watches,.triggered_watches,.watcher-history*,.ml*,ule_web_36-*
-------------------------------------------------------------------

$ systemctl start elasticsearch.service
$ systemctl enable elasticsearch.service

$ tail -f /home/elasticsearch/logs/es-cluster.log
```

## 查看启动端口
$ ss -anlt
State      Recv-Q Send-Q    Local Address:Port                   Peer Address:Port              

LISTEN     0      128      ::ffff:192.168.153.212:9200                             :::*                  
LISTEN     0      128      ::ffff:192.168.153.212:9300                             :::*                  


# 检查结果
## 验证集群结果
```
$ curl -XGET http://192.168.153.211:9200/_cluster/health?pretty
{
  "cluster_name" : "es-cluster",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 3,
  "number_of_data_nodes" : 3,
  "active_primary_shards" : 0,
  "active_shards" : 0,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}

$ curl -s '69.172.86.130:9200/_cat/allocation?v'  查看节点磁盘使用率
$ curl -X GET 'http://69.172.86.130:9200/_cluster/health?pretty'  查看集群信息

## 检查集群健康状态
$ curl 'http://69.172.86.130:9200/_cat/health?v'
epoch      timestamp cluster    status node.total node.data shards pri relo init unassign pending_tasks max_task_wait_time active_shards_percent
1516695488 16:18:08  es-cluster green           3         3      0   0    0    0        0             0                  -                100.0%


## 检查集群的节点
curl 'http://69.172.86.130:9200/_cat/nodes?v'
ip              heap.percent ram.percent cpu load_1m load_5m load_15m node.role master name
192.168.153.212           25          93   0    0.01    0.04     0.12 mdi       -      node-2
192.168.153.213           23          93   1    0.03    0.29     0.52 mdi       -      node-3
192.168.153.211           28          93   1    0.02    0.12     0.21 mdi       *      node-1

## 显示所有的index状态
$ curl 'http://69.172.86.130:9200/_cat/indices?v'
health status index uuid pri rep docs.count docs.deleted store.size pri.store.size
```

> https://www.jianshu.com/p/149a8da90bbc

> http://blog.csdn.net/weizg/article/details/78961024
