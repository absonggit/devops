#!/bin/bash
echo "FTP User Create"
read -p "Enter a user name:" ftp_user

yum list installed expect &> /dev/null
[ $? -ne 0 ] && yum install -y expect &> /dev/null
ftp_pw="$(mkpasswd -l 18)"

useradd -d /home/source/$ftp_user -s /sbin/nologin $ftp_user
echo $ftp_pw | passwd --stdin $ftp_user &> /dev/null

cat >> /etc/vsftpd/chroot_list << EOF
$ftp_user
EOF

echo "FTPuser: $ftp_user"
echo "FTPpassword: $ftp_pw"
echo "自行修改nginx虚拟主机配置,如下：

server
    {
        listen 80;
        listen 443 ssl;
        server_name file.heychat.org;
        ssl_certificate ssl/STAR.heychat.org.crt;
        ssl_certificate_key ssl/STAR.heychat.org.key;
        root /home/source/heychat;
        #access_log  /home/wwwlogs/9an_access.log;
    }"
