# 创建备份
```
$ gitlab-rake gitlab:backup:create

# 执行完备份命令后会在/var/opt/gitlab/backups目录下生成备份后的文件，如1500809139_2017_07_23_gitlab_backup.tar。1500809139是一个时间戳，从1970年1月1日0时到当前时间的秒数。这个压缩包包含Gitlab所有数据（例如：管理员、普通账户以及仓库等等）。
```

# 从备份恢复
**必须备份/etc/gitlab/gitlab.rb以及相关文件(SSL证书等)**

## 拷贝备份文件
拷贝备份文件到/var/opt/gitlab/backups下

## 停止数据连接
```
$ gitlab-ctl stop unicorn
$ gitlab-ctl stop sidekiq
```

## 恢复数据
```
$ gitlab-rake gitlab:backup:restore
# 默认备份恢复、backups目录下只有一个备份文件

$ gitlab-rake gitlab:backup:restore BACKUP=1500809139
# 从指定时间戳恢复备份、backups目录下有多个备份文件
```

# 启动gialb
```
$ gitlab-ctl start
$ gitlab-ctl reconfigure
```

## 修改默认备份目录
```
$ vim /etc/gitlab/gitlab.rb
gitlab_rails['backup_path'] = '/home/backup'

# 修改后要gitlab-ctl reconfigure重新加载配置文件
```

# 问题与解决
## 安装指定版本gitlab-ce
```
$ curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
$ sudo apt-get install gitlab-ce=8.16.6-ce.0
```

## 重装后访问页面出现500或502
```
在恢复数据时，提示版本不匹配，卸载、指定版本重装后出现500或502错误，网上搜索了很多方法，都不解决问题，最终发现是卸载不彻底引起，完整的卸载方法为：

sudo gitlab-ctl stop
sudo apt-get --purge remove gitlab-ce
sudo rm -r /var/opt/gitlab
sudo rm -r /opt/gitlab
sudo rm -r /etc/gitlab
```

## 修改主机域名
```
sudo vi /etc/gitlab/gitlab.rb
external_url '你的网址'
```
