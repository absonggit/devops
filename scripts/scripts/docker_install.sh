#!/bin/bash
# Description: install docker and docker-compose service
# date:
# Author:

# install docker service
yum -y install yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache
yum install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch.rpm
yum install -y docker-ce-17.03.2.ce-1.el7.centos

# add docker startup file
cat > /etc/systemd/system/docker.service << "EOF"
[Unit]
Description=Docker Application Container Engine
Documentation=http://docs.docker.com
After=network.target docker-storage-setup.service
Wants=docker-storage-setup.service

[Service]
Type=notify
Environment=GOTRACEBACK=crash
ExecReload=/bin/kill -s HUP $MAINPID
Delegate=yes
KillMode=process
ExecStart=/usr/bin/dockerd \
          $DOCKER_OPTS \
          $DOCKER_STORAGE_OPTIONS \
          $DOCKER_NETWORK_OPTIONS \
          $DOCKER_DNS_OPTIONS \
          $INSECURE_REGISTRY
LimitNOFILE=1048576
LimitNPROC=1048576
LimitCORE=infinity
TimeoutStartSec=1min
Restart=on-abnormal

[Install]
WantedBy=multi-user.target
EOF

# modify memory conf
mkdir /etc/docker
cat > /etc/docker/daemon.json << "EOF"
{
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF

mkdir -p /etc/systemd/system/docker.service.d/
cat > /etc/systemd/system/docker.service.d/docker-options.conf << "EOF"
[Service]
Environment="DOCKER_OPTS=--insecure-registry=10.254.0.0/16 --graph=/opt/docker --log-opt max-size=50m --log-opt max-file=5"
EOF

cat > /etc/systemd/system/docker.service.d/docker-dns.conf　<< "EOF"
[Service]
Environment="DOCKER_DNS_OPTIONS=\
    --dns 10.254.0.2 --dns 114.114.114.114  \
    --dns-search default.svc.cluster.local --dns-search svc.cluster.local  \
    --dns-opt ndots:2 --dns-opt timeout:2 --dns-opt attempts:2"
EOF

# startup docker
systemctl daemon-reload
systemctl start docker
systemctl enable docker

# install docker-compose service
curl -L https://github.com/docker/compose/releases/download/1.8.0/run.sh > /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

echo "--------------------------------------------------"
echo -e "\033[31m docker版本：\033[0m"
docker version
echo "--------------------------------------------------"
echo -e "\033[31m docker-compose版本：\033[0m"
docker-compose version
echo "--------------------------------------------------"
