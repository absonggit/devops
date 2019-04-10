# HTML5
## HTML5简介
### 什么是HTML5？
- HTML5是最新的HTML标准
- HTML5是专门为承载丰富的web内容而设计的，并且无需额外的插件
- HTML5拥有新的语义、图形以及多媒体元素
- HTML5提供的新元素和新的API简化了web应用程序的搭建
- HTML5是跨平台的，被设计为在不同类型的硬件(PC、平板、手机、电视机等)之上运行

### HTML5中的新内容
```HTML
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Title of the document</title>
</head>

<body>
Content of the document......
</body>

</html>
```
> HTML5中默认的字符编码是UTF-8

### HTML5 - 新特性
- 新的语义元素，比如header,footer,article,andsection
- 新的表单控件，比如数字、日期、时间、日历和滑块
- 强大的图像支持(借由canvas和svg)
- 强大的多媒体支持(借由video和audio)
- 强大的新API，比如用本地存储取代cookie

### HTML5 - 被删元素
以下HTML4.01元素已从HTML5中删除：
```
<acronym>
<applet>
<basefont>
<big>
<center>
<dir>
<font>
<frame>
<frameset>
<noframes>
<strike>
<tt>
```

## HTML5支持
### HTML5浏览器支持
所有现在浏览器都支持HTML5，此外所有浏览器无论新旧，都会自动把未识别元素当做行内元素来处理

### 把HTML5元素定义为块级元素
- HTML5定义了八个新的语义HTML元素。所有都是块级元素。
- 您可以把CSS display属性设置为block，以确保老式浏览器中正确的行为：
```
header, section, footer, aside, nav, main, article, figure {
  display: block;
}
```

### 向HTML添加新元素
```HTML
<!DOCTYPE html>
<html>
<head>
  <title>Creating an HTML Element</title>
  <script>document.createElement("myHero")</script>
  <style>
  myHero {
    display: block;
    background-color: #ddd;
    padding: 50px;
    font-size: 30px;
  }
  </style>
</head>
<body>
<h1>My First Heading</h1>
<p>My first paragraph.</p>
<myHero>My First Hero</myHero>
</body>
</html>
```

## HTML5元素
### 新的语义/结构元素
```
  标签                  描述
<article>	       定义文档内的文章
<aside>	         定义页面内容之外的内容
<bdi>	           定义与其他文本不同的文本方向
<details>	       定义用户可查看或隐藏的额外细节
<dialog>	        定义对话框或窗口
<figcaption>	    定义 <figure> 元素的标题
<figure>	        定义自包含内容，比如图示、图表、照片、代码清单等等
<footer>	        定义文档或节的页脚
<header>	        定义文档或节的页眉
<main>	          定义文档的主内容
<mark>	          定义重要或强调的内容
<menuitem>	      定义用户能够从弹出菜单调用的命令/菜单项目
<meter>	         定义已知范围（尺度）内的标量测量
<nav>	           定义文档内的导航链接
<progress>	      定义任务进度
<rp>	            定义在不支持 ruby 注释的浏览器中显示什么
<rt>	            定义关于字符的解释/发音（用于东亚字体
<ruby>	          定义 ruby 注释（用于东亚字体
<section>	       定义文档中的节
<summary>	       定义 <details> 元素的可见标题
<time>	          定义日期/时间
<wbr>	           定义可能的折行（line-break
```

### 新的表单元素
```
  标签	           描述
<datalist>	 定义输入控件的预定义选项。
<keygen>	   定义键对生成器字段（用于表单）。
<output>	   定义计算结果。
```

### 新的输入类型
```
新的输入类型	    新的输入属性
color               autocomplete
date                autofocus
datetime            form
datetime-local      formaction
email               formenctype
month               formmethod
number              formnovalidate
range               formtarget
search              height 和 width
tel                 list
time                min 和 max
url                 multiple
week                pattern (regexp)
                    placeholder
                    required
                    step
```

### HTML5 图像
```
标签	           描述
<canvas>	 定义使用 JavaScript 的图像绘制。
<svg>	    定义使用 SVG 的图像绘制。
```
### 新的媒介元素
```
标签	       描述
<audio>	  定义声音或音乐内容。
<embed>	  定义外部应用程序的容器（比如插件）。
<source>	 定义 <video> 和 <audio> 的来源。
<track>	  定义 <video> 和 <audio> 的轨道。
<video>	  定义视频或影片内容。
```

## HTML5语义
### 什么是语义元素？
语义元素清楚地向浏览器和开发者描述其意义
- 非语义元素的例子：`<div>`和`<span>` - 无法提供关于其内容的信息
- 语义元素的例子：`<from>`、`<table>`以及`<img>` - 清晰地定义其内容

### article、section与div之间的差异
- `<article>`元素被定义为相关元素的完整的自包含模块
- `<section>` 元素被定义为相关元素的块
-  `<div>`元素被定义为子元素的块
>可以理解为article包含section，section包含div

## HTML5样式指南和代码约定
1. 请使用正确的文档类型
`<!DOCTYPE html>`

2. 请使用小写元素名
    - HTML5允许在元素名中使用混合大小写字母
    - 我们推荐使用小写元素名：

3. 关闭所有HTML元素
    - 在HTML5中，您不必关闭所有元素(例如`<p>`元素)
    - 我们建议关闭所有的HTML元素

4. 关闭空的HTML元素
    - 在 HTML5 中，关闭空元素是可选的。
    - 我们建议关闭所有空的HTML元素

5. 使用小写属性名
    - HTML允许大小写混合的属性名
    - 我们建议使用小写属性名

6. 属性值加引号
    - HTML5 允许不加引号的属性值
    - 我们推荐属性值加引号
        - 如果属性值包含值，则必须使用引号
        - 混合样式绝对不好
        - 加引号的值更易阅读

7. 必需的属性
    - 请始终对图像使用alt属性，当图像无法显示时该属性很重要
    - 请始终定义图像尺寸。这样做会减少闪烁，因为浏览器会在图像加载之前为图像预留空间
    - `<img src="html5.gif" alt="HTML5" style="width:128px;height:128px">`

8. 空格和等号
    - 等号两边的空格是合法的
    - 但是精简空格更易阅读

9. 避免长代码行
    - 当使用HTML编辑器时，通过左右滚动来阅读HTML代码很不方便
    - 请尽量避免代码行超过80个字符

10. 空行和缩进
    - 请勿毫无理由的增加空行
    - 为了提高可读性，请增加空行来分隔大型或逻辑代码块
    - 为了提高可读性，请增加两个空格的缩进。请勿使用TAB

11. 省略html和body元素
    - 在HTML5标准中，能够省略`<html>`和`<body>`标签
    - 我们不推荐省略`<html>`和`<body>`标签

12. 省略head
    - 在HTML5标准中，`<head>`标签也能够被省略
    - 默认地，浏览器会把`<body>`之前的所有元素添加到默认的`<head>`元素
    - 通过省略`<head>`标签，能够降低HTML的复杂性

13. 元数据
    - `<title>`元素在HTML5中是必需的，请尽可能制作有意义的标题
    - 为了确保恰当的解释，以及正确的搜索引擎搜索，在文档中对语言和字符编码的定义越早越好

      ```HTML
      <!DOCTYPE html>
      <html lang="en-US">
      <head>
        <meta charset="UTF-8">
        <title>HTML5 Syntax and Coding Style</title>
      </head>
      ```

14. HTML注释
    - 短注释应该在单行中书写，并在`<!--`之后增加一个空格，在`-->`之前增加一个空格
    - 长注释，跨越多行，应该通过`<!--`和`-->`在独立的行中书写
    - 长注释更容易观察，如果他们被缩进两个空格的话

15. 样式表
    - 请使用简单的语法来链接样式表(type属性不是必需的)

      ```
      <link rel="stylesheet" href="styles.css">
      ```
    - 短规则可以压缩为一行

      ```
      p.into {font-family:"Verdana"; font-size:16em;}
      ```
    - 长规则应该分位多行

      ```
      body {
        background-color: lightgrey;
        font-family: "Arial Black", Helvetica, sans-serif;
        font-size: 16em;
        color: black;
      }
      ```
        - 开括号与选择器位于同一行
        - 在开括号之前用一个空格
        - 使用两个字符缩进
        - 在每个属性与其值之间使用冒号加一个空格
        - 在每个逗号或分号之后使用空格
        - 在每个属性值对(包括最后一个)之后使用分号
        - 只在值包含空格时使用引号来包围值
        - 把闭括号放在新的一行，之前不用空格
        - 避免每行超过80个字符

16. 在HTML中加载JavaScript
    - 请使用简单的语法来加载外部脚本(type属性不是必需的)

      ```
      <script src="myscript.js">
      ```

17. 通过JavaScript访问HTML元素
    - 使用不整洁的HTML样式的后果，是可能会导致JavaScript错误
    - 如果可能，请在HTML中使用与JavaScript相同的命名约定

18. 使用小写文件名
    - 大多数web服务器(Apache，unix)对文件名的大小写敏感
    - 不能以image.jpg访问IMAGE.jpg
    - 其他web服务器(微软，IIS)对大小写不敏感

19. 文件扩展名
    - HTML文件名应该使用扩展名.html(而不是.htm)
    - CSS文件应该使用扩展名.css
    - JavaScript文件应该使用扩展名.js

# HTML图形
## HTML图形
### canvas 元素用于在网页上绘制图形
#### 什么是Canvas?
- HTML5的canvas元素使用JavaScript在网页上绘制图像
- 画布是一个矩形区域，可以控制其每一像素
- canvas拥有多种绘制路径、举行、原型、字符以及添加图像的方法

#### 创建canvas元素
```HTML
<canvas id="myCanvas" width="200" height="100"></canvas>
```

### 通过 JavaScript 来绘制
canvas元素本身是没有绘图能力的，所有的绘制工作必须在JavaScript内部完成
```JavaScript
<script type="text/javascript">
var c=document.getElementById("myCanvas");
var cxt=c.getContext("2d");
cxt.fillStyle="#FF0000";
cxt.fillRect(0,0,150,75);
</script>
```
## HTML5 SVG
### 什么是SVG
- SVG 指可伸缩矢量图形 (Scalable Vector Graphics)
- SVG 用于定义用于网络的基于矢量的图形
- SVG 使用 XML 格式定义图形
- SVG 图像在放大或改变尺寸的情况下其图形质量不会有损失
- SVG 是万维网联盟的标准

### SVG的优势
与其他图像格式相比（比如 JPEG 和 GIF），使用 SVG 的优势在于：
- SVG 图像可通过文本编辑器来创建和修改
- SVG 图像可被搜索、索引、脚本化或压缩
- SVG 是可伸缩的
- SVG 图像可在任何的分辨率下被高质量地打印
- SVG 可在图像质量不下降的情况下被放大

### 把SVG直接嵌入HTML图像
在 HTML5 中，您能够将 SVG 元素直接嵌入 HTML 页面中：
```html
<!DOCTYPE html>
<html>
<body>
<svg xmlns="http://www.w3.org/2000/svg" version="1.1" height="190">
   <polygon points="100,10 40,180 190,60 10,60 160,180"
   style="fill:red;stroke:blue;stroke-width:3;fill-rule:evenodd;" />
</svg>
</body>
</html>
```
## HTML5画布 vs SVG
### SVG
- SVG 是一种使用 XML 描述 2D 图形的语言。
- SVG 基于 XML，这意味着 SVG DOM 中的每个元素都是可用的。您可以为某个元素附加 JavaScript 事件处理器。
- 在 SVG 中，每个被绘制的图形均被视为对象。如果 SVG 对象的属性发生变化，那么浏览器能够自动重现图形。

### Canvas
- Canvas 通过 JavaScript 来绘制 2D 图形。
- Canvas 是逐像素进行渲染的。
- 在 canvas 中，一旦图形被绘制完成，它就不会继续得到浏览器的关注。如果其位置发生变化，那么整个场景也需要重新绘制，包括任何或许已被图形覆盖的对象。

### Canvas 与 SVG 的比较
下表列出了 canvas 与 SVG 之间的一些不同之处。
- Canvas
    - 依赖分辨率
    - 不支持事件处理器
    - 弱的文本渲染能力
    - 能够以 .png 或 .jpg 格式保存结果图像
    - 最适合图像密集型的游戏，其中的许多对象会被频繁重绘

- SVG
    - 不依赖分辨率
    - 支持事件处理器
    - 最适合带有大型渲染区域的应用程序（比如谷歌地图）
    - 复杂度高会减慢渲染速度（任何过度使用 DOM 的应用都不快）
    - 不适合游戏应用

# HTML媒体
- WAVE是因特网上最受欢迎的无压缩音乐格式，所有浏览器都支持。
- MP3是最新的压缩录制音乐格式。MP3已经成为数字音乐的代名词

## HTML对象
### HTML插件
- 辅助应用程序是可由浏览器启动的程序。辅助应用程序也叫插件
- 辅助程序可用于播放音频和视频(以及其他)。辅助程序是使用`<object>`标签来加载的
- 使用辅助程序播放视频和音频的一个优势是，您能够允许用户来控制部分或全部播放设置
- 大多数辅助应用程序允许对音量设置和播放功能的手工控制

## 在HTML中播放视频的几种方式
### 使用QuickTime来播放Wave音频
## HTML音频
## HTML视频

# HTML API
## HTML 地理定位
## HTML Web存储
## HTML 应用缓存
## HTML Web Workers
## HTML SSE
