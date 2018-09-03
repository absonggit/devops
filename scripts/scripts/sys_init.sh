#!/bin/bash
#Description：New system initialization operation.
#Date： 
#Author：

function run_status() {
  #return statu after operation.

  if [ $1 -ne "0" ];then
    echo -e "\033[31m.............................................NO \033[0m"
  else
    echo -e "\033[32m.............................................OK \033[0m"
  fi
}

function modify_login() {
  #aws clound,change port、password and root login.

  echo -e "\033[33m [执行操作] 开启ROOT密码登录、修改SSH端口为6263......\033[0m"
  sed -i "s/#Port 6263/Port 6263/g" /etc/ssh/sshd_config
  sed -i "s/#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config
  sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
}

function set_socket() {
  #set to Maximum number of connections.

  echo -e "\033[33m [执行操作] 设置进程最大连接数......\033[0m"
  cat << EOF > /etc/security/limits.conf
*    soft    nofile  65535
*    hard    nofile  65535
*    soft    nproc 65535
*    hard    nproc 65535
EOF
}

function disable_ipv6() {
  #disable ipv6

  echo -e "\033[33m [执行操作] 禁用IPV6......\033[0m"
  [ -z "`grep 'fs.file-max' /etc/sysctl.conf`" ] && cat >> /etc/sysctl.conf << EOF
fs.file-max=65535
net.ipv6.conf.all.disable_ipv6 = 1
EOF
  sysctl -p
}

function set_iptables() {
  #close selinux and firewalld.service,install iptables.service and configuration.

  echo -e "\033[33m [执行操作] 关闭selinux......\033[0m"
  sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
  setenforce 0

  echo -e "\033[33m [执行操作] 关闭firewalld.service......\033[0m"
  systemctl stop firewalld.service
  systemctl disable firewalld.service

  echo -e "\033[33m [执行操作] 安装iptables.service并配置......\033[0m"
  yum install -y iptables iptables-services

  cat > /etc/sysconfig/iptables << "EOF"
# Firewall configuration written by system-config-securitylevel
# Manual customization of this file is not recommended.
*filter
:INPUT DROP [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:syn-flood - [0:0]
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# 各办公室ssh
-A INPUT -s 122.49.220.230 -p tcp -m state --state NEW -m tcp --dport 6263 -j ACCEPT
-A INPUT -s 203.177.51.166 -p tcp -m state --state NEW -m tcp --dport 6263 -j ACCEPT
-A INPUT -s 122.55.238.222 -p tcp -m state --state NEW -m tcp --dport 6263 -j ACCEPT

# jenkins jumpserver gitlab rsync lsyncd
-A INPUT -s 27.111.239.84 -p tcp -m state --state NEW -m tcp --dport 6263 -j ACCEPT
-A INPUT -s 27.111.239.84 -p tcp -m state --state NEW -m tcp --dport 10050 -j ACCEPT
-A INPUT -s 27.111.239.73 -p tcp -m state --state NEW -m tcp --dport 6263 -j ACCEPT

-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
EOF
  systemctl stop iptables
}

function ins_package() {
  # install base package.

  echo -e "\033[033m [执行操作] 安装基础包以及常用工具......\033[0m"
  yum install -y deltarpm gcc gcc-c++ make cmake autoconf libjpeg libjpeg-devel
  yum install -y libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel
  yum install -y zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel
  yum install -y ncurses ncurses-devel libaio readline-devel curl
  yum install -y curl-devel e2fsprogs e2fsprogs-devel krb5-devel libidn libidn-devel
  yum install -y openssl openssl-devel libxslt-devel libicu-devel libevent-devel libtool
  yum install -y libtool-ltdl bison gd-devel vim-enhanced pcre-devel zip unzip ntpdate
  yum install -y sysstat patch bc expect rsync git lsof
  yum install -y  install -y bind-utils vim wget lsof gcc gcc-c++ iftop vim openssl
  yum install -y lsof iftop net-tools ntpupdate
}

function set_timezone {
  # set to Shanghai time zone,increase time synchronization.

  echo -e "\033[033m [执行操作] 设置系统时区以及时间同步......\033[0m"
  /bin/cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
  yum -y install ntpdate
  ntpdate  0.centos.pool.ntp.org
  echo "*/10 * * * * /usr/sbin/ntpdate time-a.nist.gov > /dev/null 2>&1" >> /var/spool/cron/root
  chmod 600 /var/spool/cron/root
  hwclock -w
  timedatectl set-timezone Asia/Shanghai
}

#Check operation systemc and execution related function.
sys_type=`cat /etc/redhat-release |awk -F " " '{print $1}'`
if [ ${sys_type} = "CentOS" ];then
  echo -e "\n\033[33m ** 操作系统为CentOS **\033[0m"
  set_socket
  disable_ipv6
  set_iptables
  ins_package
  set_timezone
elif [ ${sys_type} = "Red" ];then
  echo -e "\033[33m ** 操作系统为RedHat ** \033[0m";echo
  set_socket
  disable_ipv6
  modify_login
  set_iptables
  ins_package
  set_timezone
else
  echo -e "\033[31m无法获取正确的操作系统\033[0m";echo
  exit
fi

cat << EOF
+-----------------------------------------------------------------+
|      重要提示：防火墙规则已经配置，检查配置后，请自行启动~      |
+-----------------------------------------------------------------+
EOF

read -p "配置生效需要重启系统【y/n】：" confirm
if [ ${confirm} = "y" -o ${confirm} = "Y" ];then
  echo -e "\033[033m [执行操作] 重启操作系统......\033[0m"
  #reboot
else
  echo -e "\033[033m [执行操作] 程序退出......\033[0m"
  exit;
fi
