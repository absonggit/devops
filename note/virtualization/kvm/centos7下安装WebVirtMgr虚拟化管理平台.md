KVM是centos下面的虚拟机，是一个比较好用的一种虚拟化技术，但是通常来说服务器跑Centos很少会安装图形界面，使用命令来管理虚拟机也是比较麻烦的，所以有一种web的虚拟化管理平台就很方便了。

# 安装webvirmgr
## 安装依赖包
```
$ yum -y install git python-pip libvirt-python libxml2-python python-websockify python-devel
$ pip install numpy
```

## 下载程序代码并初始化
### 下载程序代码webvirtmgr
```
$ git clone git://github.com/retspen/webvirtmgr.git
$ mv webvirtmgr/ /var/www/    //移动到/var/www目录
$ cd /var/www/webvirtmgr/
$ pip install -r requirements.txt
```

### 安装依赖
初始化数据库，配置管理用户
```
$ ./manage.py syncdb
WARNING:root:No local_settings file found.
Creating tables ...
Creating table auth_permission
Creating table auth_group_permissions
Creating table auth_group
Creating table auth_user_groups
Creating table auth_user_user_permissions
Creating table auth_user
Creating table django_content_type
Creating table django_session
Creating table django_site
Creating table servers_compute
Creating table instance_instance
Creating table create_flavor

You just installed Django's auth system, which means you don't have any superusers defined.
Would you like to create one now? (yes/no): yes
Username (leave blank to use 'root'): root    #管理账号
Email address:
Password:   #管理密码
Password (again):
Superuser created successfully.
Installing custom SQL ...
Installing indexes ...
Installed 6 object(s) from 1 fixture(s)

下一步，选yes

[root@localhost webvirtmgr]# ./manage.py collectstatic
WARNING:root:No local_settings file found.

You have requested to collect static files at the destination
location as specified in your settings.

This will overwrite existing files!
Are you sure you want to do this?

Type 'yes' to continue, or 'no' to cancel: yes
Copying '/var/www/webvirtmgr/webvirtmgr/static/css/bootstrap-multiselect.css'
Copying '/var/www/webvirtmgr/webvirtmgr/static/css/bootstrap.min.css'
Copying '/var/www/webvirtmgr/webvirtmgr/static/css/signin.css'
Copying '/var/www/webvirtmgr/webvirtmgr/static/css/table-sort.css'
Copying '/var/www/webvirtmgr/webvirtmgr/static/css/webvirtmgr.css'
Copying '/var/www/webvirtmgr/webvirtmgr/static/fonts/glyphicons-halflings-regular.eot'
Copying '/var/www/webvirtmgr/webvirtmgr/static/fonts/glyphicons-halflings-regular.svg'
Copying '/var/www/webvirtmgr/webvirtmgr/static/fonts/glyphicons-halflings-regular.ttf'
Copying '/var/www/webvirtmgr/webvirtmgr/static/fonts/glyphicons-halflings-regular.woff'
Copying '/var/www/webvirtmgr/webvirtmgr/static/img/asc.gif'

添加额外管理用户，选做
[root@localhost webvirtmgr]# ./manage.py createsuperuser
```

## 配置nginx，安装nginx过程略
配置虚拟主机站点，配置如下
```
server {
    listen 80 default_server;

    server_name $hostname;
    access_log /var/log/nginx/webvirtmgr_access_log;

    location /static/ {
        root /var/www/webvirtmgr/webvirtmgr;
        expires max;
    }

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-for $proxy_add_x_forwarded_for;
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_connect_timeout 600;
        proxy_read_timeout 600;
        proxy_send_timeout 600;
        client_max_body_size 1024M;
    }
}
```
systemctl restart nginx

## 启动webvirtmgr程序和webvirtmgr-console
```
$ nohup /usr/bin/python /var/www/webvirtmgr/manage.py run_gunicorn 127.0.0.1:8000 &
$ nohup /usr/bin/python /var/www/webvirtmgr/console/webvirtmgr-console &
```

## 配置防火墙
```
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=6080/tcp
firewall-cmd  --permanent  --add-port=5900/tcp
firewall-cmd  --permanent  --add-port=5901/tcp
#控制台端口，可以多开放几个5900起

firewall-cmd --reload
```

# webvirtmgr管理部分
## 登陆上去，需要添加被管理主机
这里是空的，我们要添加被管理的KVM主机是本机，只要做ssh免密码登陆即可
```
[root@localhost ~]# ssh-keygen -t rsa
[root@localhost ~]# ssh-copy-id 本机IP
```

## 天机链接、tcp用户密码或者ssh秘钥

# other
```
#kvm被管理端配置
vi /etc/sysconfig/libvirtd  #取消以下字段的注释
LLIBVIRTD_CONFIG=/etc/libvirt/libvirtd.conf
LIBVIRTD_ARGS="--listen"

vi /etc/libvirt/libvirtd.conf  #取消以下字段的注释并修改
listen_tls = 0
listen_tcp = 1
tcp_port = "16509"
listen_addr = "0.0.0.0"
auth_tcp = "none"
systemctl restart  libvirtd.service    

#設置ssh免密登錄
 1. vi /etc/ssh/sshd_config
    RSAAuthentication yes   #新版本ssh可能不需要配置此項
　　PubkeyAuthentication yes
　　AuthorizedKeysFile      .ssh/authorized_keys
 2.重啟sshd服務:systemctl restart sshd
 3.生成證書公私鑰
    ssh-keygen -t dsa -P ‘‘ -f ~/.ssh/id_dsa
    cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
 4.chmod 600 ~/.ssh/authorized_keys

 #免密登錄遠程服務器
  cat ~/.ssh/id_rsa.pub | ssh 遠程用戶名@遠程服務器ip ‘cat - >> ~/.ssh/authorized_keys‘
  ```
