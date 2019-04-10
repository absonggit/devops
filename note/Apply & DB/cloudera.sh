1. 虚拟机实例 (8个实例)
CentOS7 3U 12G
/     250GB
boot  200M
swap  8G
/opt  500G

2. 网络配置
外网可用IP：69.172.86.202-230
掩码：255.255.255.0
网关：69.172.86.30
内网可用IP：192.168.86.202-230
掩码：255.255.255.0

# 网卡配置
sudo vi /etc/udev/rules.d/70-persistent-net.rules

# hosts 配置
$ sudo vi /etc/hosts
192.168.86.202 cloudera-manager.nnti.com
192.168.86.203 master01.nnti.com
192.168.86.204 master02.nnti.com
192.168.86.205 master03.nnti.com
192.168.86.206 slave001.nnti.com
192.168.86.207 slave002.nnti.com
192.168.86.208 slave003.nnti.com
192.168.86.209 slave004.nnti.com
192.168.86.230 bigdata.nnti.com

3. 系统环境配置
* 安装 openssh-client
* 安装sudo, 新建hdfs用户，并授权sudo 的root权限

# sudo 配置
$ sudo vi /etc/sudoers
Defaults    requiretty

Defaults   !visiblepw

Defaults    always_set_home
Defaults    env_reset
Defaults    env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR LS_COLORS"
Defaults    env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"
Defaults    env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"
Defaults    env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"
Defaults    env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"

Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin

root ALL=(ALL)  ALL
hadoop ALL=(root)  NOPASSWD: ALL

4. 系统名称配置
cloudera-manager.nnti.com
master01.nnti.com
master02.nnti.com
master03.nnti.com
slave001.nnti.com
slave002.nnti.com
slave003.nnti.com
slave004.nnti.com


6. Cloudera 安装
cloudera-manager express 6.0.x(使用最新)
chmod u+x cloudera-manager-installer.bin

cloudera-manager express

https://www.cloudera.com/downloads/manager/6-0-0.html
chmod u+x cloudera-manager-installer.bin
./ cloudera-manager-installer.bin

```
vim /etc/sysctl.conf
vm.swappiness = 10
sysctl -p

vim /etc/rc.local
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo never > /sys/kernel/mm/transparent_hugepage/enabled
# 执行后加入在开机启动

useradd hdfs
useradd hadoop
usermod -a -G hadoop hdfs

yum install python-pip
pip install --upgrade psycopg2
pip install psycopg2==2.7.5 --ignore-installed
```

> http://blog.51cto.com/pizibaidu/2174297
