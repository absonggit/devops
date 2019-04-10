# HTML基础篇
## HTML简介
### 什么是HTML？
HTML是用来描述网页的一种语言。
- HTML指的是超文本标记语言(Hyper Text Markup Language)
- HTML不是一种编程语言，而是一种标记语言(markup language)
- 标记语言是一套标记标签(markup tag)
- HTML使用标记标签来描述网页

### HTML标签
HTML标记标签通常被称为HTML标签(HTML tag)
- HTML标签是由尖括号包围的关键词，比如`<html>`
- HTML标签通常是成对出现的，比如`<b>`和`</b>`
- 标签对中的第一个标签是开始标签，第二个标签是结束标签
- 开始和结束标签也被称为开放标签和闭合标签

### HTML元素
- HTML标签和HTML元素通常都是描述同样的意思
- 严格讲一个HTML元素包含了开始标签与结束标签

### 通用声明以及中文编码
```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>title</title>
</head>
<body>
  <h1>第一个标题</h1>
  <p>第一个段落</p>
</body>
</html>

-  <!DOCTYPE html>声明为html5文档
- <html>元素是HTML页面的根元素
- <head>元素包含了文档的元(meta)数据
- <title>元素描述了文档的标题
- <body>元素包含了可见的页面内容
- <h1>元素定义了一个1级标题
- <P>元素定义了一个段落
```

# HTML表单
# HTML布局
## HTML5语义元素
| 语义元素 | 说明 |
| :---: | :---: |
| header | 定义文档或节的页眉 |
| nav | 定义导航链接的容器 |
| section | 定义文档中的节 |
| article | 定义独立的自包含文章 |
| aside | 定义内容之外的内容(比如侧栏) |
| footer | 定义文档或节的页脚 |
| details | 定义额外的细节 |
| summary | 定义 details 元素的标题 |

# HTML响应式Web设计
## 什么是响应式Web设计？
- RWD 指的是响应式Web设计(Responsive Web Design)
- RWD 能够以可变尺寸传递网页
- RWD对于平板和移动设备是必需的

## 创建响应式设计的两种方法
### 自己创建
```
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <style>
        .city {
            float: left;
            margin: 30px;
            padding: 35px;
            width: 300px;
            height: 300px;
            border: 1px solid black;
        }
    </style>
</head>
<body>
<h1>W3Schoo Demo</h1>
<h2>Resize this responsive page!</h2>
<br />

<div class="city" style="background-color: wheat">
    <h2>London</h2>
    <p>London is the capital city of England.</p>
    <p>It is the most populous city in the Uinited Kingdom,
        with a metropolitan area of over 13 million inhabitants.</p>
</div>

<div class="city" style="background-color: #5cb85c">
    <h2>Paris</h2>
    <p>Paris is the capital and most populous city of France</p>
</div>

<div class="city" style="background-color: #c9e2b3">
    <h2>Tokyo</h2>
    <p>Tokyo is the capital of Japan, the center of the Greater Tokyo Area,
    and the most populous metropolitan area in the world.</p>
</div>

</body>
</html>
```

### 使用现成的CSS框架
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
    href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <div class="jumbotron">
        <h1>W3School Demo</h1>
        <p>Resize this responsive page!</p>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-lg-4">
                <h2>London</h2>
                <p>London is the capital city of England.</p>
                <p>It is the most populous city in the Uinited Kingdom,
                    with a metropolitan area of over 13 million inhabitants.</p>
        </div>
        <div class="col-lg-4">
                <h2>Paris</h2>
                <p>Paris is the capital and most populous city of France</p>
        </div>
        <div class="col-lg-4">
                <h2>Tokyo</h2>
                <p>Tokyo is the capital of Japan, the center of the Greater Tokyo Area,
                    and the most populous metropolitan area in the world.</p>
        </div>
    </div>
</div>
</body>
</html>
```
# HTML内联框架
```
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<body>
<p>
    <a href="http://www.baidu.com" target="iframe_a">百度</a> |
    <a href="http://www.sina.com.cn" target="iframe_a">新浪</a> |
    <a href="https://github.com/" target="iframe_a">我的GigHub</a>
</p>
<iframe src="test_a.html" name="iframe_a" width="1000" height="800" frameborder="0"></iframe>
</body>
</html>
```
# HTML脚本
## HTML script元素
- script标签用于定义客户端脚本，比如JavaScript
- script元素即可包含脚本语句，也可通过src属性指向外部脚本文件
- 必需的type属性规定脚本的MIME类型
- JS最常用于图片操作、表单验证以及内容动态更新
```html
<html>
<body>
<script type="text/javascript">
document.write("<h1>Hello World!</h1>")
</script>
</body>
</html>
```

## noscript标签
- noscript标签提供无法使用脚本时的替代内容，比如在浏览器禁用脚本或者浏览器不支持客户端脚本时
- noscript元素可包含普通HTML页面的body元素中能够找到的所有元素
- 只有在浏览器不支持脚本或者禁用脚本时，才会显示noscript元素中的内容
```html
<!DOCTYPE html>
<html>
<body>

<script type="text/javascript">
document.write("Hello World!")
</script>
<noscript>Sorry, your browser does not support JavaScript!</noscript>
<p>不支持 JavaScript 的浏览器将显示 noscript 元素中的文本。</p>
</body>
</html>
```

## 如何应对老式的浏览器
如果浏览器压根没法识别script标签，那么script标签所包含的内容将以文本方式显示在页面上，为了避免这种情况发生，你应该将脚本隐藏在注释标签当中，那些老的浏览器(无法识别script标签的浏览器)将忽略这些注释，所以不会将标签的内容显示在页面上，而那些新的浏览器将读懂这些脚本并执行他们，几十代码被嵌套在注释标签内。
```html
<script type="text/javascript">
<!--
document.write("Hello World!")
//-->
</script>
```

# HTML头部
## head元素
- `<head>`元素是所有头部元素的容器。head元素可包含脚本、指示浏览器在何处可以找到样式表、提供元信息等等
- 以下标签都可以添加到head部分：title base link meta script style

## title元素
- `<title>`标签定义文档的标题，在所有HTML/XHTML文档中都是必须得
- title元素能够：
    - 定义浏览器工具栏中的标题
    - 提供页面被添加到收藏夹时显示的标题
    - 显示在搜索引擎结果中的页面标题

## base元素
- `<base>`标签为页面上的所有链接指定默认地址或默认目标(target),支持a、img、link、form标签中的URL
```html
<html>
<head>
  <base href="http://www.baidu.com/"/>
  <base target="_blank"/>
</head>
<body>
  <img src="1.jpg"/><br />
</body>
</html>
```
> 1.jpg实际打开的地址为 http://www.baidu.com/1.jpg 因为在base里已经定义了一个基准URL

## link元素
- `<link>`标签定义文档与外部资源之间的关系
- `<link>`标签最常用于连接样式表
```html
<head>
  <link rel="stylesheet" type="text/css" href="theme.css" />
</head>
```
## style元素
- `<style>`标签用于为HTML文档定义样式信息
```html
<html>
<head>
<style type="text/css">
h1 {color:red}
p {color:blue}
</style>
</head>
<body>
<h1>Header 1</h1>
<p>A paragraph.</p>
</body>
</html>
```
## meta元素
- 元数据(metadata)是关于数据的信息
- `<meta>`标签提供关于HTML文档的元数据。元数据不会显示在页面上，但是对于机器是可读的。
- `<meta>`元素被用于规定页面的描述、关键词、文档的作者、最后修改时间以及其他元素
- `<meta>`标签始终位于head元素中
- 元数据可用于浏览器(如何显示内容或重新加载页面)，搜索引擎(关键词)，或其他web服务。

### 针对搜索引擎的关键词
```html
下面的 meta 元素定义页面的描述：
<meta name="description" content="Free Web tutorials on HTML, CSS, XML" />

下面的 meta 元素定义页面的关键词：
<meta name="keywords" content="HTML, CSS, XML" />

name 和 content 属性的作用是描述页面的内容。
```

# HTML字符实体
HTML中的预留字符必须被替换为字符实体。

## HTML实体
- 在HTML中不能使用小于号(<)和大于号(>)，这是因为浏览器会误认为他们是标签
- 如果希望正确地显示预留字符，我们必须在HTMl源代码中使用字符实体
- eg: &entity_name 或者 &#entity_number
> 使用实体名而不是数字的好处是，名称易于记忆。不过坏处是浏览器也许并不支持所有的实体名称

## 不间断空格
- HTML中的常用字符实体是不间断空格
- 浏览器总会截短HTML页面中的空格

## HTML中有用的字符实体
**注释：实体名称对大小写敏感**
| 显示结果 | 描述 | 实体名称 | 实体编号 |
| :------ | :--- | :------ | :------- |
|  | 空格 | &ampnbsp; | &\#160; |
| < | 小于号 | &amplt; | &\#60; |
| > | 大于号 | &ampgt; | &\#62; |
| & | 和号 | &ampamp; | &\#38; |
| " | 引号 | &ampquot; | &\#34; |
| ' | 撇号 | &ampapos;(IE不支持) | &\#39; |
| ￠ | 分(cent) | &ampcent; | &\#162; |
| £ | 镑(pount) | &amppound; | &\#163; |
| ¥ | 元(yen) | &ampyen; | &\#165; |
| € | 欧元(euro) | &ampeuro; | &\#8364; |
| § | 小节 | &ampsect; | &\#167; |
| © | 版权(copyright) | &ampcopy; | &\#169; |
| ® | 注册商标 | &ampreg; | &\#174; |
| ™ | 商标 | &amptrade; | &\#8482; |
| × | 乘号 | &amptimes; | &\#215; |
| ÷	 | 除号 | &ampdivide; | &\#247; |
> 完整的访问：http://www.w3school.com.cn/tags/html_ref_entities.html
