# 简介
- ysncd 实际上是lua语言封装了inotify和rsync工具，采用了Linux内核（2.6.13及以后）里的inotify触发机制，然后通过rsync去差异同步，达到实时的效果。
- 最亮的特性：完美解决了inotify+rsync海量文件同步带来的文件频繁发送文件列表的问题 —— 通过时间延迟或累计触发事件次数实现。
- 它的配置方式很简单，lua本身就是一种配置语言，可读性非常强。
- lsyncd也有多种工作模式可以选择，本地目录cp，本地目录rsync，远程目录rsyncssh。
- 实现简单高效的本地目录同步备份（网络存储挂载也当作本地目录），一个命令搞定。

# 安装所需软件
A向B单向同步、那么A需要安装lsyncd，B需要安装rsync，双向都需要安装。
```
# 安装rsync
$ yum -y install rsync
$ rsyncd --daemon  #经测试 不需要启动次步骤
# rsync  version 3.1.2

# 安装lsyncd
$ yum install -y lua lua-devel #lsyncd依赖
$ yum -y install lsyncd
$ lsyncd -nodaemon /etc/lsyncd.conf
$ systemctl start lsyncd
$ systemctl enable lsyncd
# lsyncd Version: 2.2.2
```

# 启动报错
```
Error: Terminating since out of inotify watches.
Consider increasing /proc/sys/fs/inotify/max_user_watches

报错原因：inotify监听数默认8192、超过了最大上限数量
报错解决：sysctl fs.inotify.max_user_watches=999999
# 修改最大上限、重启linux后仍然有效
```

# 配置lsyncd
```
$ vim /etc/lsyncd.conf
settings {
    logfile = "/tmp/lsyncd.log",
    statusFile ="/tmp/lsyncd.status",
    insist = true,
    statusInterval = 10
    }

sync {
    default.rsyncssh,
    source = "/data/BACKUP/git_js_73",
    host = "root@172.16.9.10",
    targetdir = "/data/BACKUP/git_js_73",
    -- excludeFrom = "/etc/rsyncd.d/rsync_exclude.lst",
    rsync = {
        binary = "/usr/bin/rsync",
        archive = true,
        compress = true,
        verbose = true
        },
    ssh = {
        port = 6599
        }
}
```

# 配置文件详解
```
- settings 全局变量设置
    - logfile 定义日志文件
    - statusFile 定义状态文件
    - nodaemon = true 不启用守护模式(默认配置)
    - statusInterval = 10 将lsyncd的状态写入statusFile的间隔时间(默认10秒)
    - inotifyMode 指定inotify监控的事件，CloseWrite(默认)、Modify、CloseWrite or Modify
    - maxProcesses rsync同步进程的最大个数
    - maxDelays 累计多少监控事件激活一次同步、即便delay延迟时间还未到
- sync 定义同步参数
    - default.rsync 指定以什么模式运行rsync、rsyncssh、direct三种模式
        - rsync 本地目录间同步、使用rsync、也可以达到使用ssh形式的远程rsync效果，或daemon方式连接远程rsyncd进程；
        - direct 本地目录间同步，使用cp、rm等命令完成差异文件备份
        - rsyncssh 同步到远程主机目录，rsync的ssh模式，需要使用key来认证
    - host 同步的主机地址
    - srouce 同步的源目录，使用绝对路径
    - target 定义的目的地址
        - /tmp/dest 本地目录同步，可用于direct和rsync模式
        - 127.1.1.1:/tmp/dest 同步到远程服务器目录，可用于rsync和rsyncssh模式
        - 127.1.1.1::module 同步到远程服务器目录，用于rsync模式
    - targetdir 定义的目的地址
    - init = false 只同步进城启动后发生改动事件的文件、原有目录即便有差异也不会同步，默认为true
    - delay 累计事件，等待rsync同步延时时间，默认15秒(最大累计到1000个不可合并的事件)，也就是15秒内监控目录下发生的改动，会累计到一次rsync同步，避免过于频繁的同步(可合并的意思是15秒内两次修改了同一文件，最后只同步最新的文件)
    - excludeFrom 排除选项，后面指定排除的列表文件，如果是简单的排除可以使用exclude = LIST，排除规则写法与原生rsync有点不同，更为简单 如下：
        - 匹配路径下的文本，例如：/bin/foo/bar 匹配foo
        - 以/开头，从头开始匹配全部
        - 以/结尾，匹配监控路径的末尾
        - ? 匹配任何字符，但不包括/
        - * 匹配0或多个字符，但不包括/
        - ** 匹配0或多个字符，可以是/
    - delete = true 允许target与source同步删除 false禁止同步删除 此外还有startup、running值
    - rsync 上边两个excludeFrom和delete可以配置在这里
        - binary rsync命令变量
        - archive 存档
        - bwlimit 限速，单位kb/s
        - compress 压缩传输默认为true
        - verbose 详细日志
        - password_file 指定rsync密码文件
        - perms 默认保留文件权限
        - -- # 其它rsync的命令选项
        - _extra = {"--bwlimit=2000", "--password-file=/etc/rsyncd_work.pass"},
        - -- # 指定使用ssh方式进行rsync的ssh选项
        - --rsh = "/usr/bin/ssh -p 22 -o StrictHostKeyChecking=no"
        - 其他选项
    - ssh ssh相关配置
        - binary ssh命令变量
        - identifyfile = "path"
        - port 指定ssh端口
        - -- # options是ssh的-o选项指定的参数
        - --options = {"RhostsRSAAuthentication no", "PasswordAuthentication no"},
        - -- # _extra跟 rsync的_extra一样
        - _extra = {"--bwlimit=2000"}
```

# 线上示例
```
----
-- User configuration file for lsyncd.
--
-- Simple example for default rsync, but executing moves through on the target.
--
-- For more examples, see /usr/share/doc/lsyncd*/examples/
--
-- sync{default.rsyncssh, source="/var/www/html", host="localhost", targetdir="/tmp/htmlcopy/"}

settings {
    logfile = "/tmp/lsyncd.log",
    statusFile = "/tmp/lsyncd.status",
    nodaemon = true,
    statusInterval = 10,
    inotifyMode = CloseWrite
    }

sync {
    default.rsyncssh,
    source = "/data/BACKUP/git_js_73",
    host = "root@172.1.1.1",
    targetdir = "/data/BACKUP/git_js_73",
    delay = 1,
    exclude = { '/data/BACKUP/git_js_73/test/*', '*.txt', '*.jpg' },
    delete = true,
    rsync = {
        binary = "/usr/bin/rsync",
        archive = true,
        compress = true,
        verbose = true
        },
    ssh = {
        port = 6599
        }
    }
```

# 网上配置案例
```
settings {
    logfile ="/usr/local/lsyncd-2.1.5/var/lsyncd.log",
    statusFile ="/usr/local/lsyncd-2.1.5/var/lsyncd.status",
    inotifyMode = "CloseWrite",
    maxProcesses = 8,
    }


-- I. 本地目录同步，direct：cp/rm/mv。 适用：500+万文件，变动不大
sync {
    default.direct,
    source    = "/tmp/src",
    target    = "/tmp/dest",
    delay = 1
    maxProcesses = 1
    }

-- II. 本地目录同步，rsync模式：rsync
sync {
    default.rsync,
    source    = "/tmp/src",
    target    = "/tmp/dest1",
    excludeFrom = "/etc/rsyncd.d/rsync_exclude.lst",
    rsync     = {
        binary = "/usr/bin/rsync",
        archive = true,
        compress = true,
        bwlimit   = 2000
        }
    }

-- III. 远程目录同步，rsync模式 + rsyncd daemon
sync {
    default.rsync,
    source    = "/tmp/src",
    target    = "syncuser@172.29.88.223::module1",
    delete="running",
    exclude = { ".*", ".tmp" },
    delay = 30,
    init = false,
    rsync     = {
        binary = "/usr/bin/rsync",
        archive = true,
        compress = true,
        verbose   = true,
        password_file = "/etc/rsyncd.d/rsync.pwd",
        _extra    = {"--bwlimit=200"}
        }
    }

-- IV. 远程目录同步，rsync模式 + ssh shell
sync {
    default.rsync,
    source    = "/tmp/src",
    target    = "172.29.88.223:/tmp/dest",
    -- target    = "root@172.29.88.223:/remote/dest",
    -- 上面target，注意如果是普通用户，必须拥有写权限
    maxDelays = 5,
    delay = 30,
    -- init = true,
    rsync     = {
        binary = "/usr/bin/rsync",
        archive = true,
        compress = true,
        bwlimit   = 2000
        -- rsh = "/usr/bin/ssh -p 22 -o StrictHostKeyChecking=no"
        -- 如果要指定其它端口，请用上面的rsh
        }
    }

-- V. 远程目录同步，rsync模式 + rsyncssh，效果与上面相同
sync {
    default.rsyncssh,
    source    = "/tmp/src2",
    host      = "172.29.88.223",
    targetdir = "/remote/dir",
    excludeFrom = "/etc/rsyncd.d/rsync_exclude.lst",
    -- maxDelays = 5,
    delay = 0,
    -- init = false,
    rsync    = {
        binary = "/usr/bin/rsync",
        archive = true,
        compress = true,
        verbose   = true,
        _extra = {"--bwlimit=2000"},
        },
    ssh      = {
        port  =  1234
        }
    }
```

# 扩展部分
## yum安装文件结构
| 路径 | 说明 |
| :--- | :-- |
| /etc/lsyncd.conf	| 主配置文件 |
| /etc/sysconfig/lsyncd	| init环境变量和启动选项配置文件 |
| /etc/logrotate.d/lsyncd	| 日志滚动配置文件 |
| /usr/share/doc/lsyncd-*/examples/	| 目录下有lsyncd.conf配置例子 |
| /etc/init.d/lsyncd	| lsyncd的init启动脚本 |
| /usr/bin/lsyncd	| lsyncd命令路径 |
| /var/run/lsyncd/	| 可放lsyncd.pid的目录 |
| /var/log/lsyncd/	| 默认的日志目录 |

## 事件的应用
### 事件的写法
```
-- # bash是自定义的事件名
bash = {
    --# 可选项，覆盖上级配置:
    delay = 5,
    maxProcesses = 3,
    -- # 事件动作处理流程：
    onCreate = "cp -r ^sourcePathname ^targetPathname",
    onModify = "cp -r ^sourcePathname ^targetPathname",
    onDelete = "rm -rf ^targetPathname",
    onMove   = "mv ^o.targetPathname ^d.targetPathname",
    onStartup = '[[ if [ "$(ls -A ^source)" ]; then cp -r ^source* ^target; fi]]',
}
-- # 应用方式
--sync{bash, source="/path/to/src", target="/path/to/trg/"}
```

### action说明
```
action	description
onAttrib	文件属性变化时触发。
onCreate	文件或目录被创建时触发。
onModify	文件被修改时触发。
onDelete	文件或目录被删除时触发。
onMove	文件或目录被移动时触发。
onStartup	lsyncd程序启动时触发。
```

### 可用变量
```
^source          # source目录的绝对路径
^target	         # target目录的绝对路径
^path            # 监测的目录相对路径，末尾有斜杠。
^pathname        # 监测的目录相对路径，末尾没有斜杠。
^sourcePath	     # 监测source的目录(带/)或文件的路径。
^sourcePathname  # 监测source的目录(不带/)或文件的路径。
^targetPath      # 监测targetPathname的目录(带/)或文件的路径。
^targetPathname  # 监测targetPathname的目录(不带/)或文件的路径。

```

> --开头表示注释

> rsyncOps={"-avz","--delete"}这样的写法在2.1以上版本已经不支持。

> lsyncd.conf可以有多个sync，各自的source，各自的target，各自的模式，互不影响。
