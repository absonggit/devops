#!/bin/bash
nginx_user="www"
nginx_install_dir="/data/nginx"
package_dir="./package/"
wwwroot_dir="/data/WebServer"
wwwlogs_dir="/data/WebLogs"
id -u ${nginx_user} >/dev/null 2>&1
[ $? -ne 0 ] && useradd -M -s /sbin/nologin ${nginx_user}
[ ! -d /data ] && mkdir -p  /data/package

  tar xzf ${package_dir}pcre-8.42.tar.gz
  tar xzf ${package_dir}nginx-1.14.0.tar.gz
  tar xzf ${package_dir}openssl-1.0.2p.tar.gz

  yum install -y gcc gcc-c++ zlib-devel
  cd nginx-1.14.0
  ./configure --prefix=${nginx_install_dir} --user=${nginx_user} --group=${nginx_user} --with-http_stub_status_module --with-http_v2_module --with-http_ssl_module --with-http_gzip_static_module --with-http_realip_module --with-http_flv_module --with-http_mp4_module --with-openssl=../openssl-1.0.2p --with-pcre=../pcre-8.42 --with-pcre-jit --with-ld-opt='-L jemalloc'
  make  && make install
  if [ -e "${nginx_install_dir}/conf/nginx.conf" ]; then
    echo "Nginx installed successfully!"
  fi
  
  cd ../
  [ -z "`grep ^'export PATH=' /etc/profile`" ] && echo "export PATH=${nginx_install_dir}/sbin:\$PATH" >> /etc/profile
  [ -n "`grep ^'export PATH=' /etc/profile`" -a -z "`grep ${nginx_install_dir} /etc/profile`" ] && sed -i "s@^export PATH=\(.*\)@export PATH=${nginx_install_dir}/sbin:\1@" /etc/profile
  . /etc/profile

  if [ -e /bin/systemctl ]; then
    /bin/cp ./conf/nginx/init.d/nginx.service /lib/systemd/system/
    sed -i "s@/usr/local/nginx@${nginx_install_dir}@g" /lib/systemd/system/nginx.service
    systemctl enable nginx
  else
   /bin/cp ./conf/nginx/init.d/Nginx-init-CentOS /etc/init.d/nginx; sed -i "s@/usr/local/nginx@${nginx_install_dir}@g" /etc/init.d/nginx; chkconfig 0--add nginx; chkconfig nginx on;

  fi

  mv ${nginx_install_dir}/conf/nginx.conf{,_bk}
  /bin/cp ./conf/nginx/nginx.conf ${nginx_install_dir}/conf/nginx.conf

cat > ${nginx_install_dir}/conf/proxy.conf << EOF
proxy_connect_timeout 300s;
proxy_send_timeout 900;
proxy_read_timeout 900;
proxy_buffer_size 32k;
proxy_buffers 4 64k;
proxy_busy_buffers_size 128k;
proxy_redirect off;
proxy_hide_header Vary;
proxy_set_header Accept-Encoding '';
proxy_set_header Referer \$http_referer;
proxy_set_header Cookie \$http_cookie;
proxy_set_header Host \$host;
proxy_set_header X-Real-IP \$remote_addr;
proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto \$scheme;
EOF
  mkdir -p ${nginx_install_dir}/conf/vhost
  cat > ${nginx_install_dir}/conf/vhost/default.conf << EOF
server {
    listen 80;
    server_name _;
    access_log /data/wwwlogs/access_nginx.log combined;
    root /data/wwwroot/default;
    index index.html index.htm index.php;
    #error_page 404 /404.html;
    #error_page 502 /502.html;
    location /nginx_status {
      stub_status on;
      access_log off;
      allow 127.0.0.1;
    deny all;
    }
    location ~ [^/]\.php(/|$) {
      #fastcgi_pass remote_php_ip:9000;
      fastcgi_pass unix:/dev/shm/php-cgi.sock;
      fastcgi_index index.php;
      include fastcgi.conf;
    }
    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|flv|mp4|ico)$ {
      expires 30d;
      access_log off;
    }
    location ~ .*\.(js|css)?$ {
      expires 7d;
      access_log off;
    }
    location ~ /\.ht {
      deny all;
  }
}
EOF
  sed -i "s@/data/wwwroot/default@${wwwroot_dir}/default@" ${nginx_install_dir}/conf/vhost/default.conf
  sed -i "s@/data/wwwlogs@${wwwlogs_dir}@g" ${nginx_install_dir}/conf/vhost/default.conf
  sed -i "s@^user www www@user ${nginx_user} ${nginx_user}@" ${nginx_install_dir}/conf/vhost/default.conf
  mkdir -p ${wwwlogs_dir}/default ${wwwroot_dir}
  systemctl start nginx
