```
server {
  listen 443;
  server_name www.test.com;
  index index.html index.htm index.php;
  root /data/WebServer/homepage;

  add_header Content-Security-Policy upgrade-insecure-requests;

  ssl on;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2 SSLv3;
  ssl_certificate /data/nginx/conf/cert/let.crt;
  ssl_certificate_key /data/nginx/conf/cert/let.key;

  location / {
    add_header 'Access-Control-Allow-Origin' '*';
    try_files $uri $uri/ /index.html;
    }

  location ~* /api/ {
    proxy_pass  https://www.abc.com;
    #proxy_set_header Host $host;
    #proxy_headers_hash_max_size 51200;
    #proxy_headers_hash_bucket_size 6400;
    #proxy_set_header X-Real-IP  $remote_addr;
    #proxy_set_header X-Forwarded-For $http_x_forwarded_for;
    #proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|flv|mp4|ico)$ {
      root /data/WebServer/homepage;
      error_page 405 =200 $request_uri;
      expires 30d;
      access_log off;
      }

    location ~ .*\.(js|css)?$ {
      root /data/WebServer/homepage;
      error_page 405 =200 $request_uri;
      expires 7d;
      access_log off;
      }

    access_log /data/WebLogs/homepage.log combined;
  }
```
