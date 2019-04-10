###　简介
Logstash是一款轻量级的日志搜集处理框架，可以方便的把分散的、多样化的日志搜集起来，并进行自定义的处理，然后传输到指定的位置，比如某个服务器或者文件。

### 工作原理
- Logstash使用管道方式进行日志的搜集处理和输出。有点类似*NIX系统的管道命令 xxx | ccc | ddd，xxx执行完了会执行ccc，然后执行ddd。

- 在logstash中、包括了三个阶段: 输入input ---> 处理filter(非必须) ---> 输出output



```
input {
  redis {
    data_type => "list"
    key => "hk_nw_ufa_web_39"
    host => "192.168.86.130"
    password => "1maegvxQxgA6vdgn"
    port => 6379

    # 开启读取redis数据的线程数，根据接收节点的接收速度来设置，如果输入过快，接收速度不够，则会出现丢数据的情况。
    threads => 5
    codec => "json"
  }
}

input {
  redis {
    data_type => "list"
    key => "tw_yc_ufa_web_101"
    host => "192.168.86.130"
    password => "1maegvxQxgA6vdgn"
    port => 6379
    threads => 5
    codec => "json"
  }
}

filter {
}

output {
    if [type] == "ufa_web_39" {
        elasticsearch {
            hosts => "192.168.86.130:9200"
            index => "ufa_web_39-%{+YYYYMMdd}"

            # 控制logstash向Elasticsearch批量发送数据，100条发一次
            flush_size => 100

            # 控制logstash多长时间向Elasticsearch发送一次数据，默认为1秒。根据以上配置积攒数据未达到100条，10秒钟也发送。
            idle_flush_time => 10

            # 建议设置为1或2。
            workers => 1
        }
    }
        stdout { codec => rubydebug }

    if [type] == "ufa_web_62" {
        elasticsearch {
            hosts => "192.168.86.130:9200"
            index => "ufa_web_62-%{+YYYYMMdd}"
            flush_size => 100
            idle_flush_time => 10
            workers => 1
        }
    }
    stdout { codec => rubydebug }
}
```
