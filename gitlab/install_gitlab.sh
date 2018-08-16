#!/usr/bin/env bash
yum install -y curl policycoreutils-python openssh-server postfix
systemctl enable postfix
systemctl start postfix
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
yum install -y gitlab-ce
gitlab-ctl reconfigure
gitlab-ctl restart
