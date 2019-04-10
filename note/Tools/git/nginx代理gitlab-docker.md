# docker-compose gitlab
```
version: '2'
services:
  gitlab:
    image: 'gitlab/gitlab-ce:latest'
    container_name: gitlab
    restart: always
    hostname: 'git.9anback.com'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://git.9anback.com'
        # Add any other gitlab.rb configuration here, each on its own line
    ports:
      - "20080:80"
    volumes:
      - '/data/gitlab/config:/etc/gitlab'
      - '/data/gitlab/logs:/var/log/gitlab'
      - '/data/gitlab/data:/var/opt/gitlab'
```

# nginx代理
```
# gitlab
server {
    charset utf-8;
    listen 80;
    server_name git.9anback.com;
    client_max_body_size 1000M;

    #location ~ .*\.(js|css|png)$ {
    #    proxy_pass  https://127.0.0.1:20080;
    #    }    

    location / {
        proxy_redirect   off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Host $server_name;
        proxy_pass       http://127.0.0.1:20080;
        index index.html index.htm;
        }
    }
```

>> https://www.jianshu.com/p/aa307ee95442
