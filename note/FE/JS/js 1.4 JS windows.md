# JS Window
## Window 对象
- 所有的浏览器都支持 window 对象，它表示浏览器窗口。
- 所有JS全局对象、函数以及变量均自动成为 window 对象的成员。
- 全局变量是 window 对象的属性。
- 全局函数是 window 对象的方法。

## Window尺寸
浏览器窗口的尺寸(不包括工具栏和滚动条)
- windows.innerHeight - 浏览器窗口的内部高度
- windows.innerWidth - 浏览器窗口的内部宽度
```
<body onload="startTime()">
<p id="demo"></p>

<script>
    var w=window.innerWidth
    || document.documentElement.clientWidth
    || document.body.clientWidth;

    var h=window.innerHeight
    || document.documentElement.clientHeight
    || document.body.clientHeight;

    x=document.getElementById("demo");
    x.innerHTML="浏览器的内部窗口高度：" + w + ", 高度:" + h +"."
</script>
</body>

# 显示浏览器窗口的高度和宽度
```

## 其他Window方法
- window.ipen() 打开新窗口
- window.close() 关闭当前窗口
- window.moveTo() 移动当前窗口
- windows.resizeTo() 调整当前窗口的尺寸

# JS Screen
window.screen对象包含有关用户屏幕的信息

## Window screen
windows.scrren对象在编写时可以不使用window这个前缀
- screen.availWidth 可用的屏幕宽度
- screen.availHieght 可用的屏幕高度
```
<script>
    document.write("可用高度: " + screen.availHeight);
    document.write("可用宽度: " + screen.availWidth);
</script>
```

# JS Location
window.location对象用于获得当前页面的地址(URL)，并把浏览器重定向到新的页面

## Window location
window.location对象在编写时可不使用window这个前缀
- location.hostname 返回web主机的域名
- location.pathname 返回当前页面的路径和文件名
- location.port 返回web主机的端口
- location.protocol 返回所使用的web协议

```
<script>
    document.write(location.href + "</br>");
    document.write(location.pathname + "</br>");
    document.write(location.assign("http://www.baidu.com"));
</script>

# location.href 返回当前页面的整个URL
# location.pathname 返回URL的路径名
# location.assign 加载新的文档
```

# JS History
window.history对象包含浏览器的历史

## Window History
window.history对象在编写时可不使用window这个前缀
- history.back() 与在浏览器点击后退按钮相同
- history.forward() 与在浏览器中点击按钮向前相同
```
<head>
    <meta charset="utf-8"/>
    <script>
        function goBack() {
            window.history.back()
        }

        function goForward() {
            window.history.forward()
        }
    </script>
</head>
</body>
<input type="button" value="前一页" onclick="goForward()"/>
<input type="button" value="后一页" onclick="goBack()"/>
</body>
```

# JS navigator
window.navigator 对象包含有关访问者浏览器的信息

# JS PopupAlert
可以在JS中创建三种消息框：警告框 确认框 提示框
## 警告框
警告框经常用于确保用户可以得到某些信息，当警告框出现后，用户需要点击确认按钮才能继续进行操作
```
alert("文本" + "\n" + "文本")
```

## 确认框
- 确认框用于使用户可以验证或者接受某些信息。
- 当确认框出现后，用户需要点击确定或者取消按钮才能继续进行操作。
- 如果用户点击确认，那么返回值为 true。如果用户点击取消，那么返回值为 false。
```
confirm("文本")
```

##提示框
- 提示框经常用于提示用户在进入页面前输入某个值。
- 当提示框出现后，用户需要输入某个值，然后点击确认或取消按钮才能继续操纵。
- 如果用户点击确认，那么返回值为输入的值。如果用户点击取消，那么返回值为 null。
```
prompt("文本","默认值")
```

# JS Timing
通过使用JS我们可以在一个设定的时间间隔之后来执行代码，而不是在函数被调用后立即执行。我们称之为计时事件。

## 未来的某时执行代码 setTimeout()
- 语法
`var t=setTimeout(JS语句,毫秒)`

- 实例

## 取消 clearTimeout()
- 语法
`clearTimeout(setTimeout_variable)`

- 实例

# JS Cookies
## 什么是cookie
cookie 是存储于访问者的计算机中的变量。每当同一台计算机通过浏览器请求某个页面时，就会发送这个 cookie。你可以使用 JS 来创建和取回 cookie 的值

## 创建和存储cookie
