# AJAX 基础
- Asynchronous JavaScript and XML（异步的 JavaScript 和 XML）
- AJAX 不是新的编程语言，而是一种使用现有标准的新方法
- AJAX 是与服务器交换数据并更新部分网页的艺术，在不重新加载整个页面的情况下

## AJAX 创建对象
- XMLHttpRequest对象是AJAX的基础
- 所有现代浏览器均支持 XMLHttpRequest 对象（IE5 和 IE6 使用 ActiveXObject）
```
variable=new XMLHttpRequest();
variable=new ActiveXObject();
```
- 检查浏览器是否支持XMLHttpRequest对象或者ActiveXObject
```
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="../static/jquery/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        function loadXMLDoc() {
            var xmlhttp;
            if (window.XMLHttpRequest) {
                // code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp=new XMLHttpRequest();
            }
            else {
                // code for IE6, IE5
                xmlhttp=new ActiveXObject();
            }
            xmlhttp.onreadystatechange=function() {
                if (xmlhttp.readyState==4 && xmlhttp.readyState==200) {
                    document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
                }
            }
            xmlhttp.open("GET","/ajax/demo/demo.get.asp",true);
            xmlhttp.send();
        }
    </script>
</head>
<body>
<h2>AJAX</h2>
<button type="button" onclick="loadXMLDoc()">请求数据</button>
<div id="myDiv"></div>
</body>
</html>

# 在onreadystatechange事件中，我们规定当服务器响应已做好被处理的准备时所执行的任务。
```

## AJAX 请求
XMLHttpRequest对象用于和服务器交换数据

### 向服务器发送请求
XMLHttpRequest对象的open()和send()方法
| 方法 | 请求 |
| :--- | :-- |
| open(method,url,async) | 规定请求的类型、URL 以及是否异步处理请求<br><br> method - 请求的类型(GET或POST);<br> url - 文件在服务器上的位置;<br> async - true(异步)或 false(同步);<br> |
| send(string) | 将请求发送到服务器<br><br> string - 仅用于POST请求;<br> |

### GET还是POST?
与POST相比，GET更简单也很快，并且在大部分情况下都能用。以下情况，使用POST请求：
- 无法使用缓存文件(更新服务器上的文件或数据库)
- 向服务器发送大量数据(POST没有数据量限制)
- 发送包含有未知字符的用户输入时，POST比GET更稳定也更可靠

## XHR 响应
如需获得来自服务器的相应，请使用XMLHttpRequest对象的responseText或responseXML属性
- responseText 获得字符串形式的相应数据
- responseXML 获得XML形式的相应数据

## XHR readyState
当请求被发送的服务器时，需要执行一些基于相应的任务。每当readyState改变时，就会触发onreadystatechange事件，readyState属性存有XMLHtteRequest的状态信息：
| 属性 | 描述 |
| :-- | :--- |
| onreadystatechange | 存储函数(或函数名)，每当readyState属性改变时，就会调用该函数 |
| readyState | 存有XMLHttpRequest的状态，从0刀4发生变化<br><br> 0:请求未初始化<br> 1:服务器连接已建立<br> 2:请求已接受<br> 3:请求处理中<br> 4:请求已完成，且相应已就绪 |
|status | 200:"OK"<br> 404:未找到页面 |
