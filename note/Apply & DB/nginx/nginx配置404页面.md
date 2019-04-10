“@” 前缀 Named Location 使用

REFER:  http://wiki.nginx.org/HttpCoreModule#error_page

假设配置如下：
```
server {
    listen       9090;
    server_name  localhost;

    location  / {
      root   html;
      index  index.html index.htm;
      allow all;
    }

    #error_page 404 http://www.baidu.com # 直接这样是不允许的

    error_page 404 = @fallback;
    location @fallback {
      proxy_pass http://www.baidu.com;
    }}
```
上述配置文件的意思是：如果请求的 URI 存在，则本 nginx 返回对应的页面；如果不存在，则把请求代理到baidu.com 上去做个弥补（注： nginx 当发现 URI 对应的页面不存在， HTTP_StatusCode 会是 404 ，此时error_page 404 指令能捕获它）。
