发生此状况的原因：HTTPS 是以安全为目标的 HTTP 通道，所以在 HTTPS 承载的页面上不允许出现 http 请求，一旦出现就是提示或报错：


报错内容如下：
Mixed Content: The page at 'https://domain.com/w/a?id=074ac65d-70db-422d-a6d6-a534b0f410a4' was loaded over HTTPS, but requested an insecure image 'http://img.domain.com/images/2016/5/3/2016/058c5085-21b0-4b1d-bb64-23a119905c84_cf0d97ab-bbdf-4e25-bc5b-868bdfb581df.jpg'. This content should also be served over HTTPS.

解决方法：
方法一：CSP设置upgrade-insecure-requests，将http请求替换成https请求
在2015年4月份W3C就出了一个Upgrade Insecure Requests 的草案，他的作用就是让浏览器自动升级请求。
在我们服务器的响应头中加入：
```
server {
 ...  
add_header Content-Security-Policy upgrade-insecure-requests;
 ...
}
```

我们的页面是 https 的，而这个页面中包含了大量的 http 资源（图片、iframe等），页面一旦发现存在上述响应头，会在加载 http 资源时自动替换成 https 请求。

方法二、页面中加入 meta 头（此设置需要chrome43.0+支持）：
```
<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests" />
```
