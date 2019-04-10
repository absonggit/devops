https://www.gitlab.com.cn/installation/#centos-7

# 安装gitlab
```
1. install and config necessary dependencies
# On CentOS 7 (and RedHat/Oracle/Scientific Linux 7), the commands below will also open HTTP and SSH access in the system firewall.

sudo yum install -y curl policycoreutils-python openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd
sudo firewall-cmd --permanent --add-service=http
sudo systemctl reload firewalld

# Next, install Postfix to send notification emails. If you want to use another solution to send emails please skip this step and configure an external SMTP server after GitLab has been installed.

sudo yum install postfix
sudo systemctl enable postfix
sudo systemctl start postfix

2. Add the GitLab package repository and install the package
# Add the GitLab package repository.

curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash

# Next, install the GitLab package. Change `http://gitlab.example.com` to the URL at which you want to access your GitLab instance. Installation will automatically configure and start GitLab at that URL. HTTPS requires additional configuration after installation.

sudo EXTERNAL_URL="http://gitlab.example.com" yum install -y gitlab-ee
sudo EXTERNAL_URL="http://192.168.153.220" yum install -y gitlab-ee

* After installing the modified configuration file in /etc/gitlab/gitlab.rb

3. Browse to the hostname and login
```

# 启动gitlab
```
gitlab-ctl reconfigure
gitlab-ctl start/stop/restart/status/tail
```

# issue
```
访问的时候报错：502 Whoops, GitLab is taking too much time to respond
解决办法：
1. gitlab要求内存最小2G mmp...
2. 检查端口占用默认前端80 后端8080、如果端口没起来、更换端口(端口启动非常慢 非常慢 非常慢  尼玛币、gitlab-ctl start后等一会才会启动端口，可以查看日志gitlab-ctl tail)
3. 更改过后一定要 gitlab-ctl reconfigure 重新生成配置文件

# 更改配置文件端口(两个端口)
vim /etc/gitlab/gitlab.rb
gitlab_workhorse['auth_backend'] = "http://localhost:8383"
unicorn['port'] = 8383

# nginx配置文件以及更新后的gitlab配置文件
/var/opt/gitlab/nginx/conf/gitlab-http.conf
/var/opt/gitlab/gitlab-rails/etc/unicorn.rb
```

> gitlab常用命令：https://www.cnblogs.com/luweiwei/p/4866930.html
> http://www.ruanyifeng.com/blog/2014/06/git_remote.html
> https://blog.zengrong.net/post/1746.html
