# 模块介绍
官网模块：http://docs.ansible.com/ansible/modules_by_category.html

模块按功能分类为：云模块、命令模块、数据库模块、文件模块、资产模块、消息模块、监控模块、网络模块、通知模块、包管理模块、源码控制模块、系统模块、单元模块、web设施模块、windows模块

```
$ ansible-doc -l         //查看模块列表
$ ansible-doc -s module         //查看某个模块的参数
$ ansible-doc help module         //查看模块的更详细信息
```

当命令执行时间比较长时，也可以放到后台执行，使用-B、-P参数，如下：
```
ansible all -m async_status -a "jid=123456789" #检查任务的状态
ansible all -B 1800 -P 60 -a "/usr/bin/long_running_operation --do-stuff"         
#后台执行命令最大时间是1800s即30分钟，-P 每60s检查下状态，默认15s
```

## command 模块 - 命令行模块（ansible默认模式）

不支持shell变量和管道符等；通过-a跟上要执行的命令可以直接执行，不过命令里如果有带有如下字符部分则执行不成功 “ "<", ">", "|", "&"
- creates：一个文件名，当该文件存在，则该命令不执行
- free_form：要执行的linux指令
- chdir：在执行指令之前，先切换到该指定的目录
- removes：一个文件名，当该文件不存在，则该选项不执行
- executable：切换shell来执行指令，该执行路径必须是一个绝对路径
示例如下：
```
ansible all -m command -a "df -h"
ansible all -B 1800 -P 60 -a "df -h"     
```

## shell 模块 - 命令行模块

用法和command一样、区别是通过/bin/sh执行命令、就像在本机执行一样


## raw 模块 - 命令行模块
用法和shell一样、不同的是raw模块是直接用ssh模块进行执行，通常用在客户机还没有python环境的时候。


## script 模块 - 命令行模块

将管理端的shell 在被管理主机上执行，其原理是先将shell 复制到远程主机，再在远程主机上执行，原理类似于raw模块


## ping模块（无参数）
测试主机是否ping通


## copy 模块
实现主控端向目标主机拷贝文件，类似于scp的功能复制文件到远程主机，copy模块包含如下选项：
- backup：在覆盖之前将原文件备份，备份文件包含时间信息。有两个选项：yes|no
- content：用于替代"src",可以直接设定指定文件的值
dest：必选项。要将源文件复制到的远程主机的绝对路径，如果源文件是一个目录，那么该路径也必须是个目录
- directory_mode：递归的设定目录的权限，默认为系统默认权限
- force：如果目标主机包含该文件，但内容不同，如果设置为yes，则强制覆盖，如果
为no，则只有当目标主机的目标位置不存在该文件时，才复制。默认为yes
others：所有的file模块里的选项都可以在这里使用
- src：要复制到远程主机的文件在本地的地址，可以是绝对路径，也可以是相对路径。如果路径是一个目录，它将递归复制。在这种情况下，如果路径使用"/"来结尾，则只复制目录里的内容，如果没有使用"/"来结尾，则包含目录在内的整个内容全部复制，类似于rsync。
- validate ：The validation command to run before copying into place.
The path to the file tovalidate is passed in via '%s' which must be
present as in the visudo example below.
示例如下：
```
ansible test -m copy -a "src=/srv/myfiles/foo.conf dest=/etc/foo.conf owner=foo group=foo mode=0644"
ansible test -m copy -a "src=/mine/ntp.conf dest=/etc/ntp.conf owner=root group=root mode=644 backup=yes"
ansible test -m copy -a "src=/mine/sudoers dest=/etc/sudoers validate='visudo -cf %s'"
```

## file 模块
file 模块称之为文件属性模块，主要用于远程主机上的文件操作，file模块包含如下选项：
- force：需要在两种情况下强制创建软链接，一种是源文件不存在但之后会建立的情况下；另一种是目标软链接已存在,需要先取消之前的软链，然后创建新的软链，有两个选项：yes|no
- mode：定义文件/目录的权限
- group：定义文件/目录的属组
- owner：定义文件/目录的属主
- recurse：递归的设置文件的属性，只对目录有效
- path：必选项，定义文件/目录的路径
- src：要被链接的源文件的路径，只应用于state=link的情况
- dest：被链接到的路径，只应用于state=link的情况
- state：
- directory：如果目录不存在，创建目录
- link：创建软链接
- file：即使文件不存在，也不会被创建R
- hard：创建硬链接
- touch：如果文件不存在，则会创建一个新的文件，如果文件或目录已存在，则更新其最后修改时间
- absent：删除目录、文件或者取消链接文件
使用示例：
```
ansible test -m file -a "src=/etc/fstab dest=/tmp/fstab state=link"            //创建文件
ansible web -m file -a "dest=/tmp/zhao/b.txt mode=600 owner=deploy group=root"           //定义文件路径 权限 属主 属组
ansible web -m file -a "dest=/tmp/yong mode=755 owner=deploy group=sa state=directory"           //创建目录
```

## setup 模块
主要用于获取主机信息，在playbooks里经常会用到的一个参数gather_facts就与该模块相关。setup模块下经常使用的一个参数是filter参数，如下：
- `ansible all -m setup`
- `ansible all -m setup --tree`   搜集系统信息并以主机名为文件名保存在当前目录
- `ansible 10.212.52.252 -m setup -a 'filter=ansible_*_mb'`    查看主机内存信息
- `ansible 10.212.52.252 -m setup -a 'filter=ansible_eth[0-2]'`    查看接口为eth0-2的网卡信息
- `ansible all -m setup --tree /tmp/facts`   将所有主机的信息输入到/tmp/facts目录下，每台主机的信息输入到主机名文件中（/etc/ansible/hosts里的主机名）
- `ansible webservers -m setup -a "filter=ansible_local"`   在控制节点获取自定义的信息：

关闭facts，如果你确信不需要主机的任何facts信息，而且对远程节点主机都了解的很清楚，那么可以将其关闭。远程操作节点较多的时候，关闭facts会提升ansible的性能。
只需要在play中设置如下：
```
- hosts: whatever
gather_facts: no 或
gather_facts: false #推荐用这个
```

## cron 模块
用于管理计划任务包含如下选项：
- backup：对远程主机上的原任务计划内容修改之前做备份
- cron_file：如果指定该选项，则用该文件替换远程主机上的cron.d目录下的用户的任务计划
- day：日`（1-31，*，*/2,……）`
- hour：小时`（0-23，*，*/2，……）`
- minute：分钟`（0-59，*，*/2，……）`
- month：月`（1-12，*，*/2，……）`
- weekday：周`（0-7，*，……）`
- job：要执行的任务，依赖于state=present
- name：该任务的描述
- special_time：指定什么时候执行，参数：reboot,yearly,annually,monthly,weekly,daily,hourly
- state：确认该任务计划是创建还是删除
- user：以哪个用户的身份执行
使用示例：
```
ansible test -m cron -a 'name="a job for reboot" special_time=reboot job="/some/job.sh"'
ansible test -m cron -a 'name="yum autoupdate" weekday="2" minute=0 hour=12 user="root
ansible test -m cron -a 'backup="True" name="test" minute="0" hour="5,2" job="ls -alh > /dev/null"'
ansilbe test -m cron -a 'cron_file=ansible_yum-autoupdate state=absent'
ansible test -m cron -a 'name="custom job" minute=*/2 hour=* day=* month=* weekday=*job="/usr/sbin/ntpdate 192.168.1.1"'
```

## synchronize 模块
使用rsync同步文件，其参数如下：
- archive: 归档，相当于同时开启recursive(递归)、links、perms、times、owner、group、-D选项都为yes ，默认该项为开启
- checksum: 跳过检测sum值，默认关闭
- compress:是否开启压缩
- copy_links：复制链接文件，默认为no ，注意后面还有一个links参数
- delete: 删除不存在的文件，默认no
- dest：目录路径
- dest_port：默认目录主机上的端口 ，默认是22，走的ssh协议
- dirs：传速目录不进行递归，默认为no，即进行目录递归
- rsync_opts：rsync参数部分
- set_remote_user：主要用于/etc/ansible/hosts中定义或默认使用的用户与rsync使用的用户不同的情况
- mode: push或pull 模块，push模的话，一般用于从本机向远程主机上传文件，pull 模式用于从远程主机上取文件
使用示例：
```
src=some/relative/path dest=/some/absolute/path rsync_path="sudo rsync"
src=some/relative/path dest=/some/absolute/path archive=no links=yes
src=some/relative/path dest=/some/absolute/path checksum=yes times=no
src=/tmp/helloworld dest=/var/www/helloword rsync_opts=--no-motd,--exclude=.git mode=pull
```

## filesystem 模块
在块设备上创建文件系统，选项：
- dev：目标块设备
- fstype：文件系统的类型
- force：在一个已有文件系统 的设备上强制创建
- opts：传递给mkfs命令的选项
使用示例：
```
ansible test -m filesystem -a 'fstype=ext2 dev=/dev/sdb1 force=yes'
ansible test -m filesystem -a 'fstype=ext4 dev=/dev/sdb1 opts="-cc"'
ansible test -m filesystem 'fstype=ext4 force=yes opts=-F dev=/dev/loop0'
```

## mount 模块
配置挂载点，选项：
- dump
- fstype：必选项，挂载文件的类型
- name：必选项，挂载点
- opts：传递给mount命令的参数
- src：必选项，要挂载的文件
- state：必选项
- present：只处理fstab中的配置
- absent：删除挂载点
- mounted：自动创建挂载点并挂载之
- umounted：卸载
使用示例：
```
name=/mnt/dvd src=/dev/sr0 fstype=iso9660 opts=ro state=present
name=/srv/disk src='LABEL=SOME_LABEL' state=present
name=/home src='UUID=b3e48f45-f933-4c8e-a700-22a159ec9077' opts=noatime state=present
ansible test -a 'dd if=/dev/zero of=/disk.img bs=4k count=1024'
ansible test -a 'losetup /dev/loop0 /disk.img'
ansible test -m mount 'name=/mnt src=/dev/loop0 fstype=ext4 state=mounted opts=rw'
```

## get_rul 模块
该模块主要用于从http、ftp、https服务器上下载文件（类似于wget），主要有如下选项：
- sha256sum：下载完成后进行sha256 check；
- timeout：下载超时时间，默认10s
- url：下载的URL
- url_password、url_username：主要用于需要用户名密码进行验证的情况
- use_proxy：是使用代理，代理需事先在环境变更中定义
使用示例：
```
get_url: url=http://example.com/path/file.conf dest=/etc/foo.conf mode=0440
get_url: url=http://example.com/path/file.conf dest=/etc/foo.conf
sha256sum=b5bb9d8014a0f9b1d61e21e796d78dccdf1352f23cd32812f4850b878ae4944c
```

## unarchive 模块
用于解压文件，模块包含如下选项：
- copy：在解压文件之前，是否先将文件复制到远程主机，默认为yes。若为no，则要求目标主机上压缩包必须存在。
- creates：指定一个文件名，当该文件存在时，则解压指令不执行
- dest：远程主机上的一个路径，即文件解压的路径
- grop：解压后的目录或文件的属组
- list_files：如果为yes，则会列出压缩包里的文件，默认为no，2.0版本新增的选项
- mode：解决后文件的权限
- src：如果copy为yes，则需要指定压缩文件的源路径
- owner：解压后文件或目录的属主
示例如下：
```
- unarchive: src=foo.tgz dest=/var/lib/foo
- unarchive: src=/tmp/foo.zip dest=/usr/local/bin copy=no
- unarchive: src=https://example.com/example.zip dest=/usr/local/bin copy=no
```

## lineinfile 模块
主要用来改变一个单行的文件，如果你想改变多行，就用copy或template模块
- line：插入/替换到文件中，默认插入到最后一行
- regexp：正则表达式查找在文件的每一行。
- owner： 命名文件目录的用户
- state: 当前行是否应该存在，absent删除该行，默认present存在
- group： 命名文件目录的组
- backup: 对文件进行操作前是否先备份，默认是No
EXAMPLES:
```
- lineinfile: dest=/etc/selinux/config regexp=^SELINUX= line=SELINUX=enforcing #替换selinux该行
- lineinfile: dest=/etc/sudoers state=absent regexp="^%wheel backup=yes" #删除匹配到的正则表达式的行，先备份文件再删除
- lineinfile: dest=/etc/hosts regexp='^127\.0\.0\.1' line='127.0.0.1 localhost' owner=root group=root mo #更改匹配到的行并给文件用户和组root权限
# Fully quoted because of the ': ' on the line. See the Gotchas in the YAML docs. #在最后一行插入内容
- lineinfile: "dest=/etc/sudoers line='%wheel ALL=(ALL) NOPASSWD: ALL'"
```

## template 模块
根据官方的翻译是： template 使用了 Jinjia2 格式作为文件模板，进行文档内变量的替换的模块。他的每次使用都会被 ansible 标记为 changed 状态。

## stat 模块
获取远程文件状态信息，包含atime、ctime、mtime、md5、uid、gid等
```
ansible web -m stat -a "path=/tmp/zhao/a.txt"
```

## 管理软件模块 yum
apt 、yum模块分别用于管理ubuntu系列和redhat系列系统软件包，使用yum包管理器来管理软件包，其选项有：
- config_file：yum的配置文件
- disable_gpg_check：关闭gpg_check
- disablerepo：不启用某个源
- enablerepo：启用某个源
- name：要进行操作的软件包的名字，也可以传递一个url或者一个本地的rpm包的路径
- state：状态（present，absent，latest）
示例如下：
```
ansible web -m yum -a "name=nginx state=present"         //安装nginx软件包
ansible web -m yum -a "name=nginx-1.6.2 state=present"         //安装包到一个特定的版本
ansible web -m yum -a "name=php55w enablerepo= remi state=present"         //指定某个源仓库安装某软件包
ansible web -m yum -a "name=nginx state=latest"         //更新一个软件包是最新版本
ansible web -m yum -a "name=nginx state=absent"         //卸载一个软件
```

## User 模块
user模块是请求的是useradd, userdel, usermod
- home：指定用户的家目录，需要与createhome配合使用
- groups：指定用户的属组
- uid：指定用的uid
- password：指定用户的密码
- name：指定用户名
- createhome：是否创建家目录 yes|no
- system：是否为系统用户
- remove：当state=absent时，remove=yes则表示连同家目录一起删除，等价于userdel -r
- state：是创建还是删除
- shell：指定用户的shell环境
使用示例：
```
user: name=johnd comment="John Doe" uid=1040 group=admin
user: name=james shell=/bin/bash groups=admins,developers append=yes user: name=johnd
state=absent remove=yes
user: name=james18 shell=/bin/zsh groups=developers expires=1422403387
user: name=test generate_ssh_key=yes ssh_key_bits=2048 ssh_key_file=.ssh/id_rsa #生成密钥时，只会生成公钥文件和私钥文件，和直接使用ssh-keygen指令效果相同，不会生成authorized_keys文件。
注：指定password参数时，不能使用明文密码，因为后面这一串密码会被直接传送到被管理主机的/etc/shadow文件中，所以需要先将密码字符串进行加密处理。然后将得到的字符串放到password中即可。
echo "123456" | openssl passwd -1 -salt $(< /dev/urandom tr -dc '[:alnum:]' | head -c 32) -stdin
$1$4P4PlFuE$ur9ObJiT5iHNrb9QnjaIB0
#使用上面的密码创建用户
ansible all -m user -a 'name=foo password="$1$4P4PlFuE$ur9ObJiT5iHNrb9QnjaIB0"'
不同的发行版默认使用的加密方式可能会有区别，具体可以查看/etc/login.defs文件确认，centos 6.5版本使用的是SHA512加密算法。
```

## Group 模块
goup模块请求的是groupadd, groupdel，groupmod 三个指令 使用同user模块


## service 模块
用于管理服务，该模块包含如下选项：
- arguments：给命令行提供一些选项
- enabled：是否开机启动 yes|no
- name：必选项，服务名称
- pattern：定义一个模式，如果通过status指令来查看服务的状态时，没有响应，就会通过ps指令在进程中根据该模式进行查找，如果匹配到，则认为该服务依然在运行
- runlevel：运行级别
- sleep：如果执行了restarted，在则stop和start之间沉睡几秒钟
- state：对当前服务执行启动，停止、重启、重新加载等操作（started,stopped,restarted,reloaded）
使用示例：
```
ansible test -m service -a "name=httpd state=started enabled=yes"
asnible test -m service -a "name=foo pattern=/usr/bin/foo state=started"
ansible test -m service -a "name=network state=restarted args=eth0"
```

## unarchive 模块
用于解压文件，模块包含如下选项：
- copy：在解压文件之前，是否先将文件复制到远程主机，默认为yes。若为no，则要求目标主机上压缩包必须存在。
- creates：指定一个文件名，当该文件存在时，则解压指令不执行
- dest：远程主机上的一个路径，即文件解压的路径
- grop：解压后的目录或文件的属组
- list_files：如果为yes，则会列出压缩包里的文件，默认为no，2.0版本新增的选项
- mode：解决后文件的权限
- src：如果copy为yes，则需要指定压缩文件的源路径
- owner：解压后文件或目录的属主
示例如下：
```
- unarchive: src=foo.tgz dest=/var/lib/foo
- unarchive: src=/tmp/foo.zip dest=/usr/local/bin copy=no
- unarchive: src=https://example.com/example.zip dest=/usr/local/bin copy=no
```

## debug 模块
用于调试：
- msg：打印自定义消息 默认“Hello Word!”
- var： 调试的变量名
实例如下：
```
tasks:
- name 显示当前用户
  command: id -un
  register: login
  - debug: var=login
```

## register 模块
和command模块一起使用、将command的结果复制给变量,实例如下：
```
tasks:
- name 显示当前用户
  command: id -un
  register: login
  - debug: msg="Logged in as user {{  login.stdout }}"


TASK [debug] *******************************************************************
ok: [h2] => {
    "msg": "Logged in as user root"
}
ok: [h1] => {
    "msg": "Logged in as user root"
}
ok: [h3] => {
    "msg": "Logged in as user root"
```

## ignore_errors 模块

忽略错误、如果发生错误tasks继续执行

示例如下：
tasks:
- name 显示当前用户
  command: id -un
  register: login
  ignore_errors: True
 - debug: msg="Logged in as user {{  login.stdout }}"


## git 模块
  ignore_erro



## pip 模块
  ignore_erro



## svn 模块
  ignore_erro



## templates 模块
和copy类似 不需要指定src、默认$ansible/ansible/playbook/roles/templates
