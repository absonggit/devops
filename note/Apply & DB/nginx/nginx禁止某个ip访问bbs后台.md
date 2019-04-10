```
location ~ .*admin.* {
    allow 1.1.1.1;
    allow 2.2.2.2;
    deny all;

    location ~ .*\.php?$ {
        allow 1.1.1.1;
        allow 2.2.2.2;
        deny all;

        #fastcgi_pass 127.0.0.1:9000;
        fastcgi_pass  unix:/dev/shm/php-cgi.sock;
        fastcgi_index index.php;
        fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;
        include fastcgi.conf;
        client_max_body_size 100m;
        }
    }

location ~ .*\.php?$ {
    #fastcgi_pass remote_php_ip:9000;
    fastcgi_pass unix:/dev/shm/php-cgi.sock;
    fastcgi_index index.php;
    fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;
    include fastcgi.conf;
    }
```
