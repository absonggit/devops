1. 需求:
域名下面有多台服务器，现针对某个地区做测试，让某个地区的ip用户只访问某一台服务器，单独做测试，如果没问题，全部更新；有问题则影响较小，及时发现问题解决问题；

2. 解决方案：
- 使用nginx的模块，在前端负载均衡转发的机器上，配置匹配规则；
- nginx配置vhost里面，域名下面location段，增加一段代码
- 如果$remote_addr 匹配到ip的话，转发到abc_test_server；

```
server {
    listen       80;
    server_name  abc.com.cn;
    access_log /dev/null;
    error_log  /data/logs/error.log;

    location / {

    proxy_set_header   Host             $host;
    proxy_set_header   X-Real-IP        $remote_addr;
    proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
           if ($remote_addr ~ "202.96.134.100")
              {
                       proxy_pass http://abc_test_server;
                       break;
               }
    proxy_pass http://abc_server;
    }
}

------------------------------------------------------------------------------

负载均衡配置也需要增加一段

#abc_test only
upstream abc_test_server {
    server   192.168.20.10:80;

}

#abc.com.cn
upstream abc_server {
    server   192.168.20.11:80;
    server   192.168.20.12:80;
    server   192.168.20.13:80;
}
```
