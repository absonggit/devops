```
upstream test {
    server 1.1.1.1:8080 weight=10 max_fails=2 fail_timeout=20s;
    server 2.2.2.2:8080  weight=10 max_fails=2 fail_timeout=20s;
    }
```
```
    server {
      listen 443;
      server_name www.test.com;

      ssl on;
      ssl_protocols TLSv1 TLSv1.1 TLSv1.2 SSLv3;
      ssl_certificate /data/nginx/conf/cert/tls.crt;
      ssl_certificate_key /data/nginx/conf/cert/tls.key;

      location / {
        index index.jsp index.htm index.html;
        proxy_pass http://test;
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_headers_hash_max_size 51200;
        proxy_headers_hash_bucket_size 6400;
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $http_x_forwarded_for;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }

      access_log /data/WebLogs/access_nginx.log main;
    }
```
