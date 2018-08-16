#!/bin/bash
yum install -y curl policycoreutils-python openssh-server postfix
systemctl enable postfix
systemctl start postfix
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash
yum install -y gitlab-ee
gitlab-ctl reconfigure
gitlab-ctl restart
