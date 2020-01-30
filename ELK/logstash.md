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

### 测试
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

# 命令行的方式只做调试使用，一般采用logstash.conf配置文件的方式启动logstash。实例：
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
