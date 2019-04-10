#!/bin/bash

[ $(id -u) -ne 0 ] && {
	echo "Execute the script using root!"
	exit
}
ftp_user=ftpuser
ftp_dir=/data/ftp_home
ftp_pw=123456
yum install -y epel-release
yum install -y nginx vsftpd

\mv /etc/nginx/nginx.conf{,.bak}
cat > /etc/nginx/nginx.conf << EOF
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

    stream {
        # 添加socket转发的代理
        upstream bss_num_socket {
        hash \$remote_addr consistent;
        # 转发的目的地址和端口
        server 127.0.0.1:21 weight=5 max_fails=3 fail_timeout=30s;
    }

    # 提供转发的服务，即访问localhost:21，会跳转至代理bss_num_socket指定的转发地址
    server {
       listen 80;
       proxy_connect_timeout 1s;
       proxy_timeout 3s;
       proxy_pass bss_num_socket;
    }
}
http {
    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;
}
EOF
cat > /etc/vsftpd/vsftpd.conf << EOF
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
xferlog_std_format=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd/chroot_list
listen=YES
listen_ipv6=NO
pam_service_name=vsftpd
userlist_enable=YES
tcp_wrappers=YES
local_root=/data/
pasv_min_port=30000
pasv_max_port=30000
port_enable=no
EOF
[ -d $ftp_dir ] || {
	mkdir -p $ftp_dir
	chmod 777 $ftp_dir
}
useradd -d $ftp_dir -s /sbin/nologin $ftp_user
echo $ftp_pw | passwd --stdin $ftp_user &> /dev/null
cat > /etc/vsftpd/chroot_list << EOF
$ftp_user
EOF
systemctl restart vsftpd
systemctl restart nginx
netstat -ntlup | egrep "nginx|vsftpd"
