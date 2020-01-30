# Logstash 介绍 
> Logstash 是开源的服务器端数据处理管道，能够同时从多个来源采集数据，转换数据，然后将数据发送到您最喜欢的“存储库”中。
## 下载安装
> 官方提供了二进制压缩包、apt、yum、brew以及docker的多种安装方式。Logstash需要Java 8或Java 11。使用官方的Oracle发行版或开源发行版(如OpenJDK)。
> 建议使用官方提供的仓库来安装
### Debian平台
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
### Redhat平台
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
