```
server {
  listen 80;
  server_name www.zabbix.com;

  index index.html index.htm index.php;
  root /data/zabbix_web;

  include enable-php.conf;

  access_log  /home/wwwlogs/zabbix_access.log;
}
```
