```
server {
    listen 80;
    #server_name test01.zb984.com;
    include vhost/servername/bev;
    root /home/webserver/html/bev;
    access_log  /data/wwwlogs/bev.log  main;

    location / {
        index index.html;
        try_files $uri $uri/ /index.html;
        }

    location /mobile {
        try_files $uri $uri/ /mobile/index.html;
        }

    location ~ .*.(php|jsp)$ {
        proxy_pass  http://localhost:2666;
        proxy_set_header Host $host;  
        proxy_headers_hash_max_size 51200;
        proxy_headers_hash_bucket_size 6400;
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $http_x_forwarded_for;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
}
```

> https://www.cnblogs.com/tugenhua0707/p/8127466.html
