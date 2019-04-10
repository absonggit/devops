# jQuery  获取
## 获取内容
- text()  设置或返回所选元素的文本内容
- html()  设置或返回所选元素的内容
- val() 设置或返回表单字段的值
- attr() 获取属性值
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="../static/jquery/jquery-3.2.1.js"></script>
    <script>
        $(document).ready(function(){
            $("#btn1").click(function(){
                alert("Text: " + $("#test1").text());
            });
            $("#btn2").click(function(){
                alert("HTML: " + $("#test1").html());
            });
            $("#btn3").click(function(){
                alert("value：" + $("#test2").val());
            });
            $("#btn4").click(function(){
                alert("显示HREF：" + $("#test3").attr("href"));
            });
        });
    </script>
</head>
<body>
<p id="test1">这是段落中<b>粗体</b>文本</p>
<p>姓名：<input type="text" id="test2" value="米老鼠"/></p>
<p><a id="test3" href="http://www.baidu.com" target="_blank">百度链接</a></p>

<button id="btn1">显示文本</button>
<button id="btn2">显示HTML</button>
<button id="btn3">显示值</button>
<button id="btn4">显示HREF</button>
</body>
</html>
```

# jQuery  设置

# jQuery  添加
- append() 在被选元素的结尾插入内容
- prepend() 在备选元素的开头插入内容
- after() 在备选元素之后插入内容
- before() 在被选元素之前插入内容

# jQuery  删除
- remove() 删除备选元素(及其子元素)
- empty() 从被选元素中删除子元素

# jQuery  CSS类
- addClass() 向被选元素添加一个或多个类
- removeClass() 从备选元素删除一个或多个类
- toggleClass() 从备选元素进行添加/删除类的切换操作
- css() 设置或返回样式属性

# jQuery  尺寸
- width()
- height()
- innerWidth()
- innerHeight()
- outerWidth()
- outerHeight()
