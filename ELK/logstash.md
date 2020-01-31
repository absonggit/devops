## Logstash 介绍 
> Logstash 是开源的服务器端数据处理管道，能够同时从多个来源采集数据，转换数据，然后将数据发送到您最喜欢的“存储库”中。

## 下载安装
> 官方提供了二进制压缩包、apt、yum、brew以及docker的多种安装方式。Logstash需要Java 8或Java 11。使用官方的Oracle发行版或开源发行版(如OpenJDK)。
> 建议使用官方提供的仓库来安装
<details>
<summary>Debian平台</summary>
       
```bash
# 下载及安装公开签署密匙
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# 在Debian上安装apt-transport-https包
sudo apt-get install apt-transport-https

# 将存储库定义保存到/etc/apt/sources.list.d/elastic-7.x.list
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

# 更新存储库并安装logstash
sudo apt-get update && sudo apt-get install logstash
```
</details>

<details>
<summary>Redhat平台</summary>
       
```bash
# 下载及安装公开签署密匙
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# 在/etc/yum.repos.d/中添加以下内容。保存至以*.repo*后缀的文件中的，例如logstash.repo
[logstash-7.x]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md

# 安装logstash
sudo yum install logstash
```
</details>

## 测试
```bash
# 启动logstash进程
bin/logstash -e 'input{stdin{}}output{stdout{codec=>rubydebug}}'

# 提示 [Api Webserver] agent - Successfully started Logstash API endpoint {:port=>9600} 后等待输入，敲入 Hello World，返回结果如下：
{
       "message" => "Hello World",
      "@version" => "1",
    "@timestamp" => 2020-01-13T08:39:06.110Z,
          "host" => "localhost.localdomain"
}

# 命令行的方式不是很方便，一般采用logstash.conf配置文件的方式启动logstash。实例：
input {
    stdin {}
}
output {
    stdout {
        codec => rubydebug {}
    }
}

# 指定配置文件启动logstash
bin/logstash -f logstash.conf
```
### 解释
> Logstash像管道一样，**输入**（就像cat命令）数据，然后处理**过滤**（就像awk之类的命令）数据，最后**输出**（就像tee命令）到其他地方。
> Logstash使用不同的线程来实现的。 **输入**是<xx；过滤是|xx；输出>xx。数据在线程之间以**事件**的形式流传。
> Logstash会给事件添加一些额外信息：
> - @timestamp 用来标记事件发生的时间
> - host 标记事件发生在哪里
> - message 标记事件的内容

## 配置语法
1. 区域
Logstash用{}来定义区域。区域内可以包括插件区域定义，一个区域内可以定义多个插件。插件区域内定义键值对设置。
```ruby
input {
    stdin {}
    syslog {}
}
```
2. 数据类型
Logstash支持的数据类型：
    - bool
      - debug => true
    - string
      - host => "hostname"
    - number
      - port => 514
    - array
      - match => ["datetime", "UNIX", "ISO8601"]
    - hash
      options => {
          key1 => "value1",
          key1 => "value1"
      }
3. 字段引用
在Logstash配置中使用字段的值，只需把字段的名字写在中括号[]里就行了，对于嵌套字段，只要把每层的字段名写在[]里就可以了。
[geoip][location][0]
Logstash支持变量内插，在字符串里使用字段引用
"the longitude is %{[geoip][location][0]}"
4. 条件判断
操作符：
``` ruby
  # ==, !=, <, >, <=, >=
  # =~, !~
  # in, not in
  # and, or ,nand, xor
  # !()
  
if "test" not in [tags] {
} else if [status] !~ /^2\d\d and [url] == "/noc.gif" {
} else{
}
```
## 命令行参数
1. -e
 > - 执行Logstash的参数，默认值是input{stdin{}}output{stdout{}}
2. -f或--config
 > - 指定配置文件来运行Logstash进程
3. -t或--configtest
 > - 测试Logstash配置文件语法是否能正常解析。
4. -l或--log
 > - Logstash的日志，可以输出到指定文件中。
5. -w或--pipeline-workers
 > - filter和output的pipeline线程数量，默认是CPU核数。
6. -b或--pipeline-batch-size
 > - 每个pipeline线程，在执行具体的filter和output函数之前，最多累积日志的条数，默认125条。越大性能越好，JVM内存消耗也就越多。
7. -u或--pipeline-batch-delay
 > - 每个pipeline线程，在打包批量日志时，最多等待几毫秒，默认是5ms
8. -P或--pluginpath
 > - 加载插件
9. --verbose
 > - 输出一定的调试日志
10. --debug
 > - 输出更多的调试日志
## 插件管理
```bash
bin/logstash-plugin --help
用法:
    bin/logstash-plugin [选项] 子命令 [参数] ...

子命令:
    list                          列出所有安装的Logstash插件
    install                       安装Logstash插件
    remove                        删除Logstash插件
    update                        更新一个插件
    prepare-offline-pack          创建用于离线安装的指定插件的存档
```
 
<details>
<summary>输入插件</summary>
       
1. 标准输入
```ruby
# 标准输入
input {
    stdin {
        add_field => {}  # 增加字段
        codec => "plain" # 无格式
        tags => ["add"]  # 打标签，方便插件进行数据处理
        type => "std"    # 标记事件类型
    }
}
```
2. 文件输入
```ruby
# .sincedb 数据库文件，用来跟踪被监听日志文件的inode,major number,minor number和pos。
input {
    file {
        path => ["/var/log/*.log"]      # 文件路径
        type => "system"                # 标记事件类型
        start_position => "beginning"   # 从文件起始,没有设置默认是从文件结尾
        discover_interval => 15         # 间隔多久检查一次被监听路径下是否有新文件，默认15秒
        exclude => ["/var/log/message"] # 排除指定文件的监听
        sincedb_path => "~/.sincedb"    # sincedb数据库文件的位置，默认是用户家目录下
        sincedb_write_interval => 15    # 每隔多久写一次sincedb文件，默认15秒
        stat_interval => 1              # 间隔多久检查一次监听文件的状态（是否有更新），默认是1秒
        close_older => 3600             # 监听中的文件，在设置的时间内没有更新内容，就关闭监听文件的句柄，默认3600秒
        ignore_older => 86400           # 检查文件列表的时候，如果一个文件的最后修改时间超过这个值，就忽略这个文件，默认是86400秒
    }
}
# 注意事项
# 1) 如果导入原数据到Elasticsearch的话，还需要filter/date插件来修改默认的"@timestamp"字段值。
# 2) filewatch只支持文件的绝对路径。
# 3) 路径递归，仅支持/path/to/**/*.log，用**表示递归全部子目录。
# 4) start_position仅在该文件从未被监听过的时候起作用。如果sincedb文件中已经有了该文件的inode记录，那么将会从这个pos开始读取数据。如果将sincedb_path定义为/dev/null,则每次重启自动从头开始读取数据。
# 5) Windows平台上没有inode的概念，因此使用file监听文件是不靠谱的。推荐使用nxlog作为收集端。
```
3. TCP输入
```ruby
input {
    tcp {
        port => 8888
        mode => "server"
        ssl_enable => false
    }
}
# 配合nc命令导入数据
nc 127.0.0.1 8888 < olddata
```
4. syslog输入
```ruby
# 把logstash配置成一个syslog服务器来接收数据，建议走TCP协议来传输数据
input {
    syslog {
        port => "514"
    }
}
```
5. http_poller抓取
```ruby
input {
    http_poller {
        urls => {
            0 => {
                method => get
                url => "http://localhost:80/status/format/json"
                headers => {
                    Accept => "application/json"
                }
                auth => {
                    user => "user"
                    password => "password"
                }
            }
            1 => {
            method => get
                url => "http://localhost:81/status/format/json"
                headers => {
                    Accept => "application/json"
                }
                auth => {
                    user => "user"
                    password => "password"
                }
            }
        }
    request_timeout => 60
    interval => 60
    codec => "json"
    }
}
# 每60秒获得一次数据，并重置计数。
```
</details>

### 编解码配置
Logstash执行流程是`input | decode | filter | encode | output`的数据流。
1. JSON编解码
为降低logstash过滤器的CPU负载消耗，会将日志定义为JSON格式。
ngixn为例：
```bash
log_format json '{"@timestamp":"$time_iso8601",'
               '"@version":"1",'
               '"host":"$server_addr",'
               '"client":"$remote_addr",'
               '"size":$body_bytes_sent,'
               '"responsetime":$request_time,'
               '"domain":"$host",'
               '"url":"$uri",'
               '"status":"$status"}';
access_log /var/log/nginx/access.log_json json;
#注意，$body_bytes_sent和$request_time是数值类型，因此没有双引号。
```
```ruby
input {
    file {
        path => "/var/log/nginx/access.log_json"
        codec => "json"
    }
}
output {
    stdout {
        codec => rubydebug {}
    }
}

# logstash输出如下
{
            "size" => 5,
          "domain" => "127.0.0.1",
      "@timestamp" => 2020-01-13T12:28:16.000Z,
          "status" => "200",
        "@version" => "1",
          "client" => "127.0.0.1",
             "url" => "/index.html",
            "path" => "/var/log/nginx/access.log_json",
            "host" => "127.0.0.1",
    "responsetime" => 0.0
}

# 如果nginx作为代理服务器，有些变量可能不会一直是数字，比如$upstream_response_time,可能是“-”字符串，这样会导致数据输入验证报异常。
# 日志格式统一记录为字符串格式即可，然后再用filter/mutate插件来变更相关字段的值类型即可。
```
2. 多行事件编码

3. 网络流编码
4. collectd输入
### 过滤器配置
1. date时间处理
2. grok正则捕获
3. dissect解析
4. GeoIP地址查询
5. JSON编解码
6. key-value切分
7. metrics数值统计
8. mutate数据修改
9. Ruby处理
10. split拆分事件
11. 交叉日志合并
### 输出插件
1. 输出到Elasticsearch
2. 发送Email
3. 调用系统命令执行
4. 保存成文件
5. 报警发送到Nagios
6. stasd
7. 标准输出stdout
8. TCP发送数据
9. 输出到HDFS
