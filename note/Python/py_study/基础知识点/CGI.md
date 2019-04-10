CGI(Common Gageway Interface，通用网关接口)，可以让一个客户端，从网页浏览器向执行在网络服务器上的程序请求数据。CGI描述了服务器和请求处理程序之间传输数据的一种标准。

HTTP头部
CGI程序中HTTP头部经常使用的信息：
头                      描述
Content-type          请求的与实体对应的MIME信息。例如：Content-type:text/html
Expires: Date         响应过期的日期和时间
Location: URL         用来重定向接收方到非请求URL的位置来完成请求或标识新的资源
Lsat-modifild: Date   请求资源的最后修改时间
Content-lenght: N     请求的内容长度
Set-Cookie: String    设置的Http Cookie

CGI环境变量
所有的CGI程序都接收以下的环境变量，这些变量在CGI程序中发挥了重要的作用：
变量名	                  描述
CONTENT_TYPE	       这个环境变量的值指示所传递来的信息的MIME类型。目前，环境变量CONTENT_TYPE一般都是：application/x-www-form-urlencoded,他表示数据来自于HTML表单。

CONTENT_LENGTH	     如果服务器与CGI程序信息的传递方式是POST，这个环境变量即使从标准输入STDIN中可以读到的有效数据的字节数。这个环境变量在读取所输入的数据时必须使用。

HTTP_COOKIE	         客户机内的 COOKIE 内容。

HTTP_USER_AGENT	     提供包含了版本数或其他专有数据的客户浏览器信息。

PATH_INFO	           这个环境变量的值表示紧接在CGI程序名之后的其他路径信息。它常常作为CGI程序的参数出现。

QUERY_STRING	       如果服务器与CGI程序信息的传递方式是GET，这个环境变量的值即使所传递的信息。这个信息经跟在CGI程序名的后面，两者中间用一个问号'?'分隔。

REMOTE_ADDR	         这个环境变量的值是发送请求的客户机的IP地址，例如上面的192.168.1.67。这个值总是存在的。而且它是Web客户机需要提供给Web服务器的唯一标识，可以在CGI程序中用它来区分不同的Web客户机。

REMOTE_HOST	         这个环境变量的值包含发送CGI请求的客户机的主机名。如果不支持你想查询，则无需定义此环境变量。

REQUEST_METHOD	     提供脚本被调用的方法。对于使用 HTTP/1.0 协议的脚本，仅 GET 和 POST 有意义。

SCRIPT_FILENAME	     CGI脚本的完整路径

SCRIPT_NAME	         CGI脚本的的名称

SERVER_NAME	         这是你的 WEB 服务器的主机名、别名或IP地址。

SERVER_SOFTWARE	     这个环境变量的值包含了调用CGI程序的HTTP服务器的名称和版本号。例如，上面的值为Apache/2.2.14(Unix)

GET和POST方法
# 浏览器客户端通过两种方法想服务器传递信息，这两种方式就是GET和POST方法。

使用GET方法传输数据
GET方法发送编码后的用户信息到服务端，数据信息包含在请求页面的URL上，以"?"号分割，如下所示：
http://www.test.com/cgi-bin/hello.py?key1=value1&key2=value2
有关GET请求的其他一些注释；
. GET请求可被缓存
. GET请求保留在浏览器历史记录中
. GET请求可被收藏为书签
. GET请求不应在处理敏感数据时使用
. GET请求有长度限制
. GET请求之应当用于取回数据

 使用POST方法传输数据
 使用POST方法向服务器传输数据时更安全可靠，通常用来传递敏感信息和用户密码等数据。
