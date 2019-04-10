# DOM 简介
通过HTML DOM，可访问JavaScript THML文档的所有元素

## HTML DOM(文档对象模型)
- 当网页被加载时，浏览器会创建页面的文档对象模型(Document Object Model)
- HTML DOM模型被构造为对象的树
- 通过可编程的对象模型，JS获得了足够的能力来创建动态的HTML。
    -  JavaScript 能够改变页面中的所有 HTML 元素
    -  JavaScript 能够改变页面中的所有 HTML 属性
    -  JavaScript 能够改变页面中的所有 CSS 样式
    -  JavaScript 能够对页面中的所有事件做出反应

## 查找HTML元素
- 通过id找到HTML元素
```
查找id="intro"元素；

var x=document.getElementById("info");
```

- 通过标签名找到HTML元素
```
查找 id="main" 的元素，然后查找 "main" 中的所有 <p> 元素

var x=document.getElementById("main");
var y=x.getElementsByTagName("p");
```
- 通过类名找到HTML元素

# DOM HTML
HTML DOM允许JS改变HTML元素的内容
## 改变HTML输出流 document.write()
```
<script>
  document.write(Date());
</script>

# 输出中国标准时间
# 不要在文档加载之后使用document.write()，会覆盖文档
```

## 改变HTML内容 innerHTML属性
```
<body>
<p id="demo">Hello World!</p>

<script>
  document.getElementById("demo").innerHTML="New text!";
</script>
</body>

--------------------------------------------------------

<body>
<p id="demo">Hello World!</p>

<script>
    element=document.getElementById("demo");
    element.innerHTML="New Text"
</script>
</body>

# 两种办法均可
```

## 改变HTML属性 attribute属性
```
<body>
<img id="image" src="../static/images/logo.png"/>

<script>
    document.getElementById("image").src="../static/images/bg_1.gif";
</script>
</body>
</html>

# 改变src属性
```

# DOM CSS
HTML DOM允许JS改变HTML元素的样式

##  改变HTML样式
`document.getElementById(id).style.property=new style;`

- 示例1
```
<body>
<p id="p2">Hello World</p>
<script>
    document.getElementById("p2").style.color="purple";
</script>
</body>

# 改变p元素的颜色样式
```

- 示例2
```
<body>
<p id="p2">Hello World</p>
<button type="button" onclick="document.getElementById('p2').style.color='red'">
    Click
</button>
</body>
```

# DOM 事件
HTML DOm使JS有能力对HTML时间做出反应

## 对事件做出反应
- 当用户点击鼠标时
- 当网页已加载时
- 当图像已加载时
- 当鼠标移动到元素上时
- 当输入字段被改变时
- 当提交HTML表单时
- 当用户触发按键时

```
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
<script>
    function changetext(id) {
        id.innerHTML="谢谢";
    }
</script>
</head>
<body>

<h1 onclick="changetext(this)">请点击文本</h1>
</body>
</html>

# 从事件处理器调用一个函数 也可以直接写this.innerHTML="谢谢"
```

## HTML事件属性
如需向HTML元素分配事件，可以使用事件属性

## 使用HTML DOm来分配事件
```
<body>
<button id="myBtn">点击这里</button>

<script>
    document.getElementById("myBtn").onclick=function(){displayDate()};
    function displayDate() {
        document.getElementById("demo").innerHTML=Date();
    }
</script>

<p id="demo"></p>
</body>
```
## 事件实例
### onload和onunload事件
- onload和onunload事件会在用户进入或离开页面时被触发
- onload事件可用于检测访问者的浏览器类型和浏览器版本，并基于这些信息来加载网页的正确版本
- onload和onunload事件可用于处理cookie
```
<body onload="checkCookies()">
<script>
    function checkCookies() {
        if (navigator.cookieEnabled==true) {
            alert("已启用cookie");
        }
        else {
            alert("未启用cookie");
        }
    }
</script>
</body>

# 进入页面提示框提示是否已开启cookie
```

### onchage事件
onchage事件常结合对输入字段的验证来使用
```
<head>
    <meta charset="utf-8"/>
    <script>
    function myFunction() {
        var x=document.getElementById("fname");
        x.value= x.value.toUpperCase();
    }
    </script>
</head>
<body>
请输入英文字符<input type="text" id="fname" onchange="myFunction()"/>
</body>

# 当用户输入字段的内容时，会调用upperCase()函数将小写转换为大写
```

### onmouseover和onmouseout事件
onmouseover和onmouseout事件可用于在用户的鼠标移至HTML元素上方或移出元素时触发函数
```
<body>
<div onmouseover="mOver(this)" onmouseout="mOut(this)" style="background-color: green; width: 120px; height: 20px; padding: 40px; color: #FFFFFF">
    鼠标移到上面
</div>

<script>
    function mOver(obj) {
        obj.innerHTML="谢谢!";
    }
    function mOut(obj) {
        obj.innerHTML="鼠标移到上面";
    }
</script>
</body>
```

### onmousedown、onmouserup以及onclick事件
onmousedown, onmouseup 以及 onclick 构成了鼠标点击事件的所有部分。首先当点击鼠标按钮时，会触发 onmousedown 事件，当释放鼠标按钮时，会触发 onmouseup 事件，最后，当完成鼠标点击时，会触发 onclick 事件。
```
<body>
<div onmousedown="mDown(this)" onmouseup="mUp(this)" style="background-color: green; width: 90px; height: 20px; padding: 40px; font-size: 12px; color: #FFFFFF">
    请点击这里
</div>

<script>
    function mDown(obj) {
        obj.style.backgroundColor="#1EC5E5";
        obj.innerHTML="请释放鼠标按钮!";
    }
    function mUp(obj) {
        obj.style.backgroundColor="green";
        obj.innerHTML="请按下鼠标按钮";
    }
</script>
</body>
```

# DOM 节点
添加和删除节点(HTML元素)
## 创建新的HTML元素
如需向HTML DOm添加新元素，首先创建该元素(元素节点)，然后向一个已存在的元素追加该元素
```
<body>
<div id="div1">
    <p id="p1">这是一个段落</p>
    <p id="p2">这是另一个段落</p>
</div>

<script>
    var para=document.createElement("p");   //创建新的<p>元素
    var node=document.createTextNode("这是新段落");  //如需向<p>元素添加文本，必须先创建文本节点
    para.appendChild(node); //向<p>元素追加节点

    var element=document.getElementById("div1");    //找到一个已有元素
    element.appendChild(para);  ////向已有元素追加新元素
</script>
</body>
```

## 删除已有的HTML元素
如需删除 HTML 元素，您必须首先获得该元素的父元素
```
<body>
<div id="div1">
    <p id="p1">这是一个段落</p>
    <p id="p2">这是另一个段落</p>
</div>

<script>
    var parent=document.getElementById("div1");
    var child=document.getElementById("p1");
    parent.removeChild(child);
</script>
</body>
```
