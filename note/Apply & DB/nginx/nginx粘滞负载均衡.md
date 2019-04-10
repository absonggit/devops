# nginx sticky其他语法:
```
sticky [name=route] [domain=.foo.bar] [path=/] [expires=1h] [hash=index|md5|sha1] [no_fallback]
```
- name: 可以为任何的string字符,默认是route
- path：哪些路径对启用sticky,例如path/test,那么只有test这个目录才会使用sticky做负载均衡
- domain：哪些域名下可以使用这个cookie
- expires：cookie过期时间，默认浏览器关闭就过期，也就是会话方式。
- no_fallbackup：如果设置了这个，cookie对应的服务器宕机了，那么将会返回502（bad gateway 或者 proxy error），建议不启用

# nginx sticky expires用法:
```
upstream cluster_test {
     sticky expires=1h;
     server 192.168.100.209:80;
     server 192.168.100.225:80;
}

upstream cluster_test {
     sticky expires=1h;
     server 192.168.100.209:80;
     server 192.168.100.225:80;
}
```
