# Tomcat报错缓存
- Tomcat 警告：consider increasing the maximum size of the cache
- tomcat8以上对resource采取了cache，而默认的大小是10M。解决的办法很简单，就是在context.xml中调大缓存。
```
<Resources cachingAllowed="true" cacheMaxSize="100000" />
```
