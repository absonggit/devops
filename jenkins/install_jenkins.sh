#!/bin/bash

curl https://pkg.jenkins.io/redhat/jenkins.repo >> /etc/yum.repos.d/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
yum install java jenkins -y
sed -i 's/JENKINS_USER="jenkins"/JENKINS_USER="root"/g' /etc/sysconfig/jenkins
systectl restart jenkins
