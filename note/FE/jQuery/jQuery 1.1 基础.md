# jQuery 简介
jQuery库可以通过一行简单的标记被添加到网页中，jQuery是一个JS函数库

## jQuery库特性
- HTML元素选取
- HTML元素操作
- CSS操作
- HTML事件函数
- JS特效和动画
- HTML DOM遍历和修改
- AJAX
- Utilities

# jQuery 安装
## 在页面中添加jQuery库
jQuery库位于一个JS文件中，其中包含了所有的jQuery函数
```
<head>
<script type="text/javascript" src="jquery.js"></script>
</head>
```

## 下载jQuery
下载地址：http://jquery.com/download/#Download_jQuery

## 库的替代
Google和Microsoft对jQuery的支持都很好
- 使用Google的CDN
```
<head>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs
/jquery/1.4.0/jquery.min.js"></script>
</head>
```

- 使用Microsoft的CDN
```
<head>
<script type="text/javascript" src="http://ajax.microsoft.com/ajax/jquery
/jquery-1.4.min.js"></script>
</head>
```

# jQuery 语法
jQuery语法视为HTML元素的选取编制的，可以对元素执行某些操作

## 基础语法：
`$(selector).action()`
- 美元符号定义jQuery
- 选择符(selector)"查询"和"查找"HTML元素
- jQuery的action()执行对元素的操作

## 语法实例
- $(this).hide   隐藏当前元素
- $("p").hide   隐藏所有段落
- $(".test").hide()   隐藏所有class="test"的所有元素
- $("#test").hide()   隐藏所有id="test"的元素

## 文档就绪函数
```
$(document).ready(function() {
  --- jQuery functions go here ---
  })

# jQuery函数位于一个document.read函数中，是为了防止文档在完全加载之前运行jQuery函数
```

# jQuery 选择器
选择器允许您对元素组或单个元素进行操作

## jQuery 选择器
- jQuery元素选择器和属性选择器允许您通过标签名、属性名或内容对HTML元素进行选择
- 选择器允许您对HTML元素组成或单个元素进行操作
- 在HTML DOM术语中：选择器允许您对DOM元素组或单个DOM节点进行操作

## jQuery 元素选择器
jQuery使用CSS选择器来选取HTML元素
- $("p")选取p元素
- $("p.intro")选取所有 class="intro"的p元素
- $("p#demo")选取所有 id="demo"的p元素

## jQuery 属性选择器
jQuery使用 x Path 表达式来选择带有给定属性的元素
- $("[href]")选取所有带有href属性的元素
- $("[here='#']")选取所有带有href值等于"#"的元素
- $("[href!='#']")选取所有带有href值不等于"#"的元素
- $("[href$='.jpg']")选取所有href值以".jpg"结尾的元素

## jQuery CSS选择器
jQuery CSS 选择器可用于改变 HTML 元素的 CSS 属性。
- `$("p").css("background-color","red");`

# jQuery 事件
## jQuery 事件函数
- jQuery 事件处理方法是 jQuery 中的核心函数。
- 事件处理程序指的是当 HTML 中发生某些事件时所调用的方法。术语由事件“触发”（或“激发”）经常会被使用。
- 通常会把 jQuery 代码放到 <head>部分的事件处理方法中：
```
<html>
<head>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
  $("button").click(function(){
    $("p").hide();
  });
});
</script>
</head>

<body>
<h2>This is a heading</h2>
<p>This is a paragraph.</p>
<p>This is another paragraph.</p>
<button>Click me</button>
</body>

</html>
```

## jQuery 名称冲突
- jQuery 使用 $ 符号作为 jQuery 的简介方式。
- 某些其他 JavaScript 库中的函数（比如 Prototype）同样使用 $ 符号。
- jQuery 使用名为 noConflict() 的方法来解决该问题。
`var jq=jQuery.noConflict()`

## jQuery 代码原则
- 把所有 jQuery 代码置于事件处理函数中
- 把所有事件处理函数置于文档就绪事件处理器中
- 把 jQuery 代码置于单独的 .js 文件中
- 如果存在名称冲突，则重命名 jQuery 库
