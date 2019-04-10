# docker-compose.yaml
```
version: '2'
services:
  nginx:
    container_name: nginx
    build: nginx
    #restart: always
    ports:
      - 80:80
    links:
      - gitlab

  gitlab:
    image: 'gitlab/gitlab-ce:latest'
    container_name: gitlab
    restart: always
    hostname: 'git.9anback.com'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://git.9anback.com'
        # Add any other gitlab.rb configuration here, each on its own line
    volumes:
      - '/data/gitlab/config:/etc/gitlab'
      - '/data/gitlab/logs:/var/log/gitlab'
      - '/data/gitlab/data:/var/opt/gitlab'

```

# nginx-dockerfile conf
```
FROM nginx:stable
RUN rm /etc/nginx/conf.d/default.conf
ADD nginx.conf /etc/nginx/conf.d/
```

```
# Configuration for the server
server {
    charset utf-8;
    listen 80;
    server_name git.9anback.com;
    client_max_body_size 1000M;
    location / {
        proxy_pass       http://gitlab:80;
        proxy_redirect   off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Host $server_name;
        }
    }

#server {
#    charset utf-8;
#    listen 80;
#    server_name reg.9anback.com;
#    client_max_body_size 1000M;
#    location / {
#        proxy_pass       http://reg:5000;
#        proxy_redirect   off;
#        proxy_set_header Host $host;
#        proxy_set_header X-Real-IP $remote_addr;
#        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#        proxy_set_header X-Forwarded-Host $server_name;
#        }
#    }

server {
    listen 80;
    server_name _;
    return 404;
    }
```
