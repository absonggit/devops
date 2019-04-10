# Usage:ansible <host-pattern> [options]
## host-pattern
##  Pattern：
可以直接指定某一机器地址或hosts中的组名：`192.168.1.4   group1`

同时指定多个组或者多个ip使用:分割：`group1:group2   192.168.1.*   192.168.1.1:192.168.2.2`

用all或者*表示全部：`all   *   192.168.1.*`

用!表示非：`group1:!group2`   #表示在g1分组中，但是不在g2中的hosts

用&表示交集部分： `webservers:&dbservers`  #表示在webservers分组中，同时也在dbservers分组中的hosts:w

可以指定分组的下标或切片(超过范围则无法匹配)：`v1[0]   v1[0:100]`

也可以用~开头来使用正则： `~(web|db).*\.example\.com   ~v\d`

需要注意的是如果用的是zsh，有这些类似于*，!，[等这些特殊符号需要用单引号包裹。

## Options:
`-m MODULE_NAME,--module-name=MODULE_NAME`            //要执行的模块，默认为command
```
ansible all -m command = ansible all -m(默认为command)
```

`-a MODULE_ARGS,--args=MODULE_ARGS` //模块的参数
```
ansible all -m command -a 'df -h'(-a后边引号内、可以写任意命令)
```

`-u REMOTE_USER,--user=REMOTE_USER` //ssh连接的用户名，默认用root，ansible.cfg 中可以配置

`-k,--ask-pass`//提示输入ssh登录密码，当使用密码验证登录的时候用

`-s,--sudo`//sudo运行

`-U SUDO_USER,--sudo-user=SUDO_USER` //sudo到哪个用户，默认为root

`-K,--ask-sudo-pass` //提示输入sudo密码，当不是NOPASSWD模式时使用

`-B SECONDS,--background=SECONDS `             //runasynchronously,failingafterXseconds(default=N/A)

`-P POLL_INTERVAL,--poll=POLL_INTERVAL`          //setthepollintervalifusing-B(default=15)

`-C,--check` //只是测试一下会改变什么内容，不会真正去执行

`-c CONNECTION` //连接类型(default=smart)

`-f FORKS,--forks=FORKS`              //fork多少个进程并发处理，默认5

`-i INVENTORY,--inventory-file=INVENTORY` //指定hosts文件路径，默认default=/etc/ansible/hosts

`-l SUBSET,--limit=SUBSET`              //指定一个pattern，对<host_pattern>已经匹配的主机中再过滤一次

`--list-hosts`              //只打印有哪些主机会执行这个playbook文件，不是实际执行该playboo

`-M MODULE_PATH,--module-path=MODULE_PATH`             //要执行的模块的路径，默认为/usr/share/ansible/

`-o,--one-line`              //压缩输出，摘要输出

`--private-key=PRIVATE_KEY_FILE`              //私钥路径

`-T TIMEOUT,--timeout=TIMEOUT`              //ssh连接超时时间，默认10秒

`-t TREE,--tree=TREE`             //日志输出到该目录，日志文件名会以主机名命名

`-v,--verbose`             //verbose mode(-vvv for more,-vvvv to enable connection debugging)
