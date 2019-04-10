```
server {
    charset utf-8;
    listen 80;
    server_name www.jenkins.com;

    client_max_body_size 1000M;
    location / {
        proxy_pass       http://1.1.1.1:8080;
        proxy_redirect   off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Host $server_name;
        }
    }
```
