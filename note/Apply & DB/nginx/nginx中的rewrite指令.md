# flag标记：
在server块下，会优先执行rewrite部分，然后才会去匹配location块
- server中的rewrite break和last没什么区别，都会去匹配location，所以没必要用last再发起新的请求，可以留空，不写last和break 那么流程就是依次执行这些rewrite
    - rewrite break 重写后，直接使用当前资源，不再执行location里余下的语句，完成本次请求，地址栏url不变
    - rewrite last url重写后，马上发起一个新的请求，再次进入server块，重试location匹配，超过10次匹配不到报500错误，地址栏url不变
    - rewrite redirect 返回302临时重定向，地址栏显示重定向后的url，爬虫不会更新url（因为是临时）
    - rewrite permanent 返回301永久重定向, 地址栏显示重定向后的url，爬虫更新url

使用last会对server标签重新发起请求；

如果location中rewrite后是对静态资源的请求，不需要再进行其他匹配，一般要使用break或不写，直接使用当前location中的数据源，完成本次请求；

如果location中rewrite后，还需要进行其他处理，如动态fastcgi请求(.php,.jsp)等，要用last继续发起新的请求，(根的location使用last比较好, 因为如果有.php等fastcgi请求还要继续处理)；

使用alias指定源：必须使用last；

if语句主要用来判断一些在rewrite语句中无法直接匹配的条件,比如检测文件存在与否,http header,cookie等；

# 正则表达式匹配优先级
location匹配规则及优先级
- = 严格匹配这个查询。如果找到，停止搜索。
- ^~ 匹配路径的前缀，如果找到，停止搜索。
-  ~ 为区分大小写的正则匹配
-  ~* 为不区分大小写匹配

**优先级： =, ^~, ~/~*, 无**


# break语句
放在server块rewrite语句前面，如果是直接请求某个真实存在的文件,则用break语句停止rewrite检查
```
if (-f $request_filename) {
break;
}
```
```
$args 此变量与请求行中的参数相等
$content_length 等于请求行的“Content_Length”的值。
$content_type 等同与请求头部的”Content_Type”的值
$document_root 等同于当前请求的root指令指定的值
$document_uri 与$uri一样
$host 与请求头部中“Host”行指定的值或是request到达的server的名字（没有Host行）一样
$limit_rate 允许限制的连接速率
$uri 等同于当前request中的URI，可不同于初始值，例如内部重定向时或使用index
$server_protocol 等同于request的协议，使用“HTTP/1.0”或“HTTP/1.1”
$server_port 请求到达的服务器的端口号
$server_name 请求到达的服务器名
$server_addr request到达的server的ip，一般获得此变量的值的目的是进行系统调用。为了避免系统调用，有必要在listen指令中指明ip，并使用bind参数。
$request_uri 含有参数的完整的初始URI
$request_method 等同于request的method，通常是“GET”或“POST”
$request_filename 当前请求的文件的路径名，由root或alias和URIrequest组合而成
$request_body_file
$remote_user 等同于用户名，由ngx_http_auth_basic_module认证
$remote_port 客户端port
$remote_addr 客户端ip
$query_string 与$args一样
```
