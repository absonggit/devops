https://yq.aliyun.com/articles/601389
# 安装部分
## 安装Erlang

### 安装依赖
```
$ yum install -y gcc gcc-c++ glibc-devel make ncurses-devel openssl-devel autoconf java-1.8.0-openjdk-devel xmlto
```

### 增加rabbitmq的yum源
```
$ cat >> /etc/yum.repos.d/rabbitmq-erlang.repo << "EOF"
[rabbitmq-erlang]
name=rabbitmq-erlang
baseurl=https://dl.bintray.com/rabbitmq/rpm/erlang/20/el/7
gpgcheck=1
gpgkey=https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc
repo_gpgcheck=0
enabled=1
EOF
```

### 安装erlang
RabbitMQ是基于Erlang的，所以首先必须配置Erlang环境.
```
$ yum install -y erlang

# 进入erlang命令行表示成功
$ erl
```

## 安装socat
```
$ yum install -y socat
```

## 下载rabbitmq并安装启动
### 下载编译好的源码
```
$ wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.5/rabbitmq-server-generic-unix-3.7.5.tar.xz
$ tar xf rabbitmq-server-generic-unix-3.7.5.tar.xz
$ vim /etc/profile
export PATH=$PATH:/data/rabbitmq/sbin
$ source /etc/profile
```

### 启动rabbitmq
```
$ rabbitmq-server -detached   静默启动 默认监听端口5672、25672
$ rabbitmqctl status   查看启动状态
$ rabbitmqctl stop   停止服务
```

### rabbitmqctl status详解
```
服务器状态： rabbitmqctlstatus

队列信息：rabbitmqctllist_queues [-p vhostpath] [queueinfoitem ...]
Queueinfoitem可以为：name，durable，auto_delete，arguments，messages_ready，
messages_unacknowledged，messages，consumers，memory

Exchange信息：rabbitmqctl list_exchanges [-p vhostpath] [exchangeinfoitem ...]
Exchangeinfoitem有：name，type，durable，auto_delete，internal，arguments.

Binding信息：rabbitmqctl list_bindings [-p vhostpath] [bindinginfoitem ...]
Bindinginfoitem有：source_name，source_kind，destination_name，destination_kind，routing_key，arguments

Connection信息：rabbitmqctllist_connections [connectioninfoitem ...]
Connectioninfoitem有：recv_oct，recv_cnt，send_oct，send_cnt，send_pend等。

Channel信息：rabbitmqctl list_channels [channelinfoitem ...]
Channelinfoitem有consumer_count，messages_unacknowledged，messages_uncommitted
，acks_uncommitted，messages_unconfirmed，prefetch_count，client_flow_blocked
```

```
获取队列信息：rabbitmqctl list_queues[-p vhostpath] [queueinfoitem ...]
Queueinfoitem可以为：name，durable，auto_delete，arguments，messages_ready，messages_unacknowledged，messages，consumers，memory。

获取Exchange信息：rabbitmqctllist_exchanges[-p vhostpath] [exchangeinfoitem ...]
Exchangeinfoitem有：name，type，durable，auto_delete，internal，arguments。

获取Binding信息：rabbitmqctllist_bindings[-p vhostpath] [bindinginfoitem ...]       
Bindinginfoitem有：source_name，source_kind，destination_name，destination_kind，routing_key，arguments。

获取Connection信息：rabbitmqctllist_connections [connectioninfoitem ...]
Connectioninfoitem有：recv_oct，recv_cnt，send_oct，send_cnt，send_pend等。

获取Channel信息：rabbitmqctl  list_channels[channelinfoitem ...]
Channelinfoitem有consumer_count，messages_unacknowledged，messages_uncommitted，acks_uncommitted，messages_unconfirmed，prefetch_count，client_flow_blocked。
```

### 配置常用插件
- 手动启动指定插件
```
$ mkdir /etc/rabbitmq 如果没有此目录要手工创建
$ rabbitmq-plugins enable rabbitmq_management  启动网页管理插件、默认guest guest
$ rabbitmq-plugins disable xxx   停止某个插件
$ rabbitmq-plugins list  查看启用插件列表
```

- 修改配置文件启动指定插件
enabled_plugins,设置允许的插件列表
```
cat >> $rabbitmq/etc/rabbitmq/enabled_plugins << "EOF"
[rabbitmq_management,rabbitmq_stomp,rabbitmq_web_stomp].
```

### 修改常用配置文件
rabbitmq.conf,设置rabbitmq的运行参数
```
vim $rabbitmq/etc/rabbitmq/rabbitmq.conf
loopback_users.guest = false
listeners.tcp.default = 5672
hipe_compile = false
# disk_free_limit = 1G
management.listener.port = 15672
management.listener.ssl = false
#default_vhost = /
#default_user = test
#default_pass = test123
default_user_tags.administrator = true
default_permissions.configure = .*
default_permissions.read = .*
default_permissions.write = .*
```

### 修改日志目录
rabbitmq-env.conf rabbitmq的环境参数配置
```
$ vim /etc/rabbitmq/rabbitmq-env.conf
#!/bin/bash  
RABBITMQ_LOG_BASE=/data/logs/rabbitmq/  
RABBITMQ_MNESIA_BASE=/data/rabbitmq/mnesia  
```

# 扩展部分
## 进入退出erlang
```
$ erl 进入ErlangShell

退出ErlangShell的方法
命令方式1：执行init:stop().   
命令方式2：执行halt().
快捷键方式1：Control+C然后选a
快捷键方式2：Control+G然后按q
```

## 用户角色
### RabbitMQ的用户角色分类：
- none
    - 不能访问 management plugin

- management
    - 用户可以通过AMQP做的任何事外加：
    - 列出自己可以通过AMQP登入的virtual hosts  
    - 查看自己的virtual hosts中的queues, exchanges 和 bindings
    - 查看和关闭自己的channels 和 connections
    - 查看有关自己的virtual hosts的“全局”的统计信息，包含其他用户在这些virtual hosts中的活动。

- policymaker
    - management可以做的任何事外加：
    - 查看、创建和删除自己的virtual hosts所属的policies和parameters

- monitoring  
    - management可以做的任何事外加：
    - 列出所有virtual hosts，包括他们不能登录的virtual hosts
    - 查看其他用户的connections和channels
    - 查看节点级别的数据如clustering和memory使用情况
    - 查看真正的关于所有virtual hosts的全局的统计信息

- administrator  
    - policymaker和monitoring可以做的任何事外加:
    - 创建和删除virtual hosts
    - 查看、创建和删除users
    - 查看创建和删除permissions
    - 关闭其他用户的connections

### 常用命令
```
$ rabbitmqctl add_user user_name user_pwd 创建用户user_name
  eg：rabbitmqctl add_user admin 123456
$ rabbitmqctl delete_user xxx  删除用户
$ rabbimqctl change_password {username} {newpassword} 修改用户密码
$ rabbitmqctl set_user_tags {username} {tag ...}  设置用户角色
  eg: rabbitmqctl set_user_tags admin administrator
$ rabbitmqctl add_user user_name user_proj user_pwd 创建只能访问指定vhosts的用户、默认用户guset、默认vhost "/"
$ rabbitmqctl list_users 查看已存在的用户及角色
$ rabbitmqctl set_permissions -p /vhost1  user_admin '.*' '.*' '.*' 设置权限
Conf：一个正则表达式match哪些配置资源能够被该用户访问。
Write：一个正则表达式match哪些配置资源能够被该用户读。
Read：一个正则表达式match哪些配置资源能够被该用户访问。
$ rabbitmqctl clear_permissions  [-p VHostPath]  User 清除用户权限
$ rabbitmqctl list_user_permissions user_admin 查看指定用户权限
$ rabbitmqctl list_permissions -p /vhost1  查看vhost的权限
$ rabbitmqctl add_vhost xxx   新建vhost
$ rabbitmqctl delete_vhost xxx  删除vhost
$ rabbitmqctl reset 清除所有队列
$ rabbitmqctl list_queues  查看所有队列信息
```

用户仅能对其所能访问的virtual hosts中的资源进行操作。这里的资源指的是virtual hosts中的exchanges、queues等，操作包括对资源进行配置、写、读。配置权限可创建、删除、资源并修改资源的行为，写权限可向资源发送消息，读权限从资源获取消息。比如：
- exchange和queue的declare与delete分别需要exchange和queue上的配置权限
- exchange的bind与unbind需要exchange的读写权限
- queue的bind与unbind需要queue写权限exchange的读权限
- 发消息(publish)需exchange的写权限
- 获取或清除(get、consume、purge)消息需queue的读权限

对何种资源具有配置、写、读的权限通过正则表达式来匹配，具体命令如下：
```
set_permissions [-p <vhostpath>] <user> <conf> <write> <read>

其中，<conf> <write> <read>的位置分别用正则表达式来匹配特定的资源
如'^(amq\.gen.*|amq\.default)$'可以匹配server生成的和默认的exchange'^$'不匹配任何资源

# 需要注意的是RabbitMQ会缓存每个connection或channel的权限验证结果、因此权限发生变化后需要重连才能生效。
```

> 配置中文解释：https://blog.csdn.net/Super_RD/article/details/70327712

> 官方配置文档：https://www.rabbitmq.com/configure.html

> 官方配置模板: https://github.com/rabbitmq/rabbitmq-server/blob/master/docs/rabbitmq.conf.example

> https://www.jianshu.com/p/61a90fba1d2a
