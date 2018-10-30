#!/bin/bash
ping -c www.baidu.com &> /dev/null
[ $? -ne 0 ] && {
echo "无法连接外网,请检查网络"
exit
}

echo "[Info] 时间同步"
ntpdate 0.centos.pool.ntp.org &>/dev/null

echo "[Info] 安装依赖包"
yum install gcc wget zlib zlib-devel openssl openssl-devel -y

echo "[Info] 下载openssh源码包"
wget http://mirror.internode.on.net/pub/OpenBSD/OpenSSH/portable/openssh-7.9p1.tar.gz

echo "[Info] 解压openssh源码包"

tar xvf openssh-7.9p1.tar.gz -C /opt/

echo "[Info] 编译安装openssh"

cd /opt/openssh-7.9p1
./configure && make && make install

echo "[Info] 备份默认启动脚本，复制源码包提供的启动脚本"
mv /etc/init.d/sshd{,.bak}
cp contrib/redhat/sshd.init /etc/init.d/sshd
chown root.root /etc/init.d/sshd

echo "[Info] 添加开机启动"
chkconfig --add sshd
chkconfig sshd on
echo "[Info] sshd更新为:"
echo "`/usr/local/bin/ssh -V`"
read -p "[Info] 服务器重启生效，是否现在重启y/n:" ops
[ $ops == "y" ] && reboot || echo "稍后请手动重启服务器。"
