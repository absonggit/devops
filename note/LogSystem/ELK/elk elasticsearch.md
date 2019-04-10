### 简介
ElasticSearch是一个基于Lucene的搜索服务器。它提供了一个分布式多用户能力的全文搜索引擎，基于RESTful web接口。Elasticsearch是用Java开发的，并作为Apache许可条款下的开放源码发布，是当前流行的企业级搜索引擎。设计用于云计算中，能够达到实时搜索，稳定，可靠，快速，安装使用方便。

### ES概念
- cluster 代表一个集群，集群中有多个节点，其中有一个为主节点，这个主节点是可以通过选举产生的，主从节点是对于集群内部来说的。es的一个概念就是去中心化，字面上理解就是无中心节点，这是对于集群外部来说的，因为从外部来看es集群，在逻辑上是个整体，你与任何一个节点的通信和与整个es集群通信是等价的。

- shards 代表索引分片，es可以把一个完整的索引分成多个分片，这样的好处是可以把一个大的索引拆分成多个，分布到不同的节点上。构成分布式搜索。分片的数量只能在索引创建前指定，并且索引创建后不能更改。

- replicas 代表索引副本，es可以设置多个索引的副本，副本的作用一是提高系统的容错性，当某个节点某个分片损坏或丢失时可以从副本中恢复。二是提高es的查询效率，es会自动对搜索请求进行负载均衡。

- recovery 代表数据恢复或叫数据重新分布，es在有节点加入或退出时会根据机器的负载对索引分片进行重新分配，挂掉的节点重新启动时也会进行数据恢复。

 - river 代表es的一个数据源，也是其它存储方式（如：数据库）同步数据到es的一个方法。它是以插件方式存在的一个es服务，通过读取river中的数据并把它索引到es中，官方的river有couchDB的，RabbitMQ的，Twitter的，Wikipedia的。

- gateway 代表es索引快照的存储方式，es默认是先把索引存放到内存中，当内存满了时再持久化到本地硬盘。gateway对索引快照进行存储，当这个es集群关闭再重新启动时就会从gateway中读取索引备份数据。es支持多种类型的gateway，有本地文件系统（默认），分布式文件系统，Hadoop的HDFS和amazon的s3云存储服务。

- discovery.zen代表es的自动发现节点机制，es是一个基于p2p的系统，它先通过广播寻找存在的节点，再通过多播协议来进行节点之间的通信，同时也支持点对点的交互。

- Transport 代表es内部节点或集群与客户端的交互方式，默认内部是使用tcp协议进行交互，同时它支持http协议（json格式）、thrift、servlet、memcached、zeroMQ等的传输协议（通过插件方式集成）。
修改配置文件

            cd /opt/elasticsearch5/config
            vi elasticsearch.yml
            es1配置文件如下：
                cluster.name: es-cluster    #集群名，不同名称代表不同集群
                node.name: es1    #节点名称，自定义
                path.data: /opt/elasticsearch5/es/data    #数据路径
                path.logs: /opt/elasticsearch5/es/logs    #日志路径
                bootstrap.memory_lock: false    #关闭锁内存
                network.host: 172.16.81.133    #绑定IP地址
                http.port: 9200    #绑定端口
                discovery.zen.ping.unicast.hosts: ["es1", "es2"]    #集群列表，类型数组，可以是IP或域名
                discovery.zen.minimum_master_nodes: 2    #节点数不能超过节点总数量
                http.cors.enabled: true    #开启http网络节点发现
                http.cors.allow-origin: "*"    #允许所有同网段节点发现
            es2配置文件如下：
                cluster.name: es-cluster    #集群名，不同名称代表不同集群
                node.name: es2    #节点名称，自定义
                path.data: /opt/elasticsearch5/es/data    #数据路径
                path.logs: /opt/elasticsearch5/es/logs    #日志路径
                bootstrap.memory_lock: false    #关闭锁内存
                network.host: 172.16.81.134    #绑定IP地址
                http.port: 9200    #绑定端口
                discovery.zen.ping.unicast.hosts: ["es1", "es2"]    #集群列表，类型数组，可以是IP或域名
                discovery.zen.minimum_master_nodes: 2    #节点数不能超过节点总数量
                http.cors.enabled: true    #开启http网络节点发现
                http.cors.allow-origin: "*"    #允许所有同网段节点发现
