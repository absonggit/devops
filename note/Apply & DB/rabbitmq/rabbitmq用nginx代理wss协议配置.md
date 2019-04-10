```
######################## rabbitmq ############################
server {
  listen 443;
  server_name www.rabbitmq.com;
  index index.html index.htm index.php;

  #error_page 404 /404.html;
  #error_page 502 /502.html;

  ssl on;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2 SSLv3;
  ssl_certificate /cert/tls.crt;
  ssl_certificate_key /cert/tls.key;

  location /websocket {
    proxy_pass http://localhost:15674;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    }

  #access_log /data/nginx/logs/access_nginx.log combined;
  }
  ```

> 前端仍然用"wss://www.rabbitmq.com/websocket"访问
