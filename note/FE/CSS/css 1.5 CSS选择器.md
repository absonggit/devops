# CSS 选择器
## CSS 元素选择器
最常见的CSS选择器是元素选择器，在W3C标准中又称为类型选择器。也是最基本的选择器。eg: p h1 em a ...

## CSS 选择器分组
### 选择器分组
```
h1, h2, p, b {color: gray;}
```

### 通配符选择器
```
* {color: gray;}
```

### 声明分组
```
h1 {font: 28px Verdana; color: white; background: black;}
```

## CSS 类选择器
- 类选择器允许以一种独立于文档元素的方式来指定样式
- 类选择器可以单独使用，也可以与其他元素结合使用
- 类选择器引用class属性的值，以"."开头
> 只有适当地标记文档后，才能使用这些选择器，所以使用这两种选择器通常需要先做一些构想和计划。要应用样式而不考虑具体设计的原色，最常用的方法就是使用类选择器。

```
.important {color: red;}

<p class="important">TEST</P>
```

## CSS ID选择器详解
- ID选择器允许以一种独立于文档元素的方式来指定样式。
- ID选择器引用id属性中的值，以"#"开头
```
#important {color: pink;}

<p id="important">TEST</p>
```
## CSS 属性选择器
属性选择器可以根据元素的属性值来选择元素。
```
a[href] [title] {color: red;}
<a href="#" title="test">TEST</a>
# 根据属性来匹配

h1[title="具体属性"] {color: purple;}
<h1 title="具体属性">TEST</h1>
# 根据具体属性值来匹配

p[class~="important"] {color: pink;}
<p class="important warning">This is a paragraph.</a>
# 根据部分属性值来匹配 需要加上"~"号

子串匹配属性选择器
[abc^="def"]	选择 abc 属性值以 "def" 开头的所有元素
[abc$="def"]	选择 abc 属性值以 "def" 结尾的所有元素
[abc*="def"]	选择 abc 属性值中包含子串 "def" 的所有元素

特定属性选择器
*[lang|="en"] {color: red;}
# 选择lang属性等于 en 或以 en- 开头的所有元素
```

## CSS 后代选择器
后代选择器又称为包含选择器。后代选择器可以选择作为某元素后代的元素
```
h1 em {color: red;}

<h1>This is a <em>important</em> heading.</h1>
<p>This is a <em>important</em> paragraph.</p>
# 以空格做为分隔符 h1 em
```

## CSS 子元素选择器
 与后代选择器相比，子元素选择器只能选择作为某元素子元素的元素。
 ```
 h1 > em {color: red;}

 <h1>This is a <em>important</em> heading.</h1>
 <p>This is a <em>important</em> paragraph.</p>
 # 以">"做为分隔符 h1 > em
 ```

## CSS 相邻兄弟选择器
相邻兄弟选择器可选择紧接在另一元素后的元素，且二者有相同父元素。
```
h1 + p {margin-top:50px;}

<body>
<h1>This is a heading.</h1>
<p>This is paragraph.</p>
<p>This is paragraph.</p>
</body>
```
## CSS 伪类
伪类用于向某些选择器添加特殊的效果

### 语法
- 伪类的语法
    - selector ： peseudo-class {property: value}
- CSS类也可与伪类搭配使用
    - selector.class : peseudo-class {property: value}

### 锚伪类
在支持CSS浏览器中，链接状态可以以不同方式显示
- a:link {color: #FF0000;}       # 未访问的链接
- a:visited {color: #00FF00;}    # 已访问的链接
- a:hover {color: #FF00FF;}      # 鼠标悬停链接
- a:active {color: #0000FF;}     # 选定的链接
> 在CSS定义中，a:hover必须放在 a:link a:visited才生效，a:active放在a:hover后

### 伪类与CSS类
```
a.red : visited {color: #FF0000}

<a class="red" href="css_syntax.asp">CSS Syntax</a>
```

### :first-child伪类
```
<div>
<p>These are the necessary steps:</p>
<ul>
<li>Intert Key</li>
<li>Turn key <strong>clockwise</strong></li>
<li>Push accelerator</li>
</ul>
<p>Do <em>not</em> push the brake at the same time as the accelerator.</p>
</div>

p:first-child {font-weight: bold;}
li:first-child {text-transform:uppercase;}
# 仅应用在每一个
```
## CSS 伪元素
CSS伪元素用于向某些选择器设置特殊效果

### 语法
- 伪元素的语法
    - selector:pseudo-element {property:value;}
- CSS类也可以与伪元素配合使用
    - selector.class:pseudo-element {property:value;}

### :first-line伪元素
"first-line"伪元素用于向文本的首行设置特殊样式
```
p:first-line
  {
  color:#ff0000;
  font-variant:small-caps;
  }

# 根据"first-line"伪元素中的样式对p元素的第一行文本进行格式化
# "first-line"伪元素只能用于块元素
```
