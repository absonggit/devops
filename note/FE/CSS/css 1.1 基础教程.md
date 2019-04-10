# CSS基础教程
## CSS简介
### CSS概述
- CSS指层叠样式表(Cascading Style Sheets)
- 样式定义如何显示HTML元素
- 样式通常存储在样式表中
- 外部样式表可以极大提高工作效率
- 外部样式表通常存储在CSS文件中
- 多个样式定义可层叠为一个

### 多重样式表层叠次序
1. 浏览器缺省设置
2. 内部样式表
3. 内部样式表(位于`<head>`标签内部)
4. 内联样式(在html元素内部)

## CSS基础语法
### CSS语法
CSS规则由两个主要的部分构成：选择器，以及一条或多条声明
```
selector {declaration1; decalaration2; ... declarationN}
```
- 选择器通常是您需要改变样式的HTML元素
- 每条声明由一个属性和一个值组成
- 属性(property)是您希望设置样式的样式属性(style attribute)。每一个属性有一个值。属性和值被冒号分开。
```
selector {property: value}
```
- eg: 将h1元素内的文字颜色定义为红色，同时将字体大小设置为14像素
```
h1 {color: red; font-size: 14px;}
h1 是选择器，color和font-size是属性，red和14px是值
```

## CSS高级语法
### 选择器的分组
可以对选择器进行分组，这样，被分组的选择器就可以分享相同的声明。用逗号将需要分组的选择器分开。
```
h1,h2,h3,h4,h5,h6 {
  color: green;
}
```

### 继承及其问题
子元素从父元素继承属性，通过CSS继承，子元素将继承最高级元素所拥有的属性(例如h1继承body的属性)

## CSS派生器选择
**通过依据元素在其位置的上下文关系来定义样式，你可以使标记更加简洁**

## CSS id选择器
- **id选择器可以为标有特定id的HTML元素指定特定的样式，id选择器以“#”来定义**
```
#red {color: red;}
#green h1 {color: green;}

<p id="red">这个段落是红色</p>
<h1 id="green">这个标题是绿色</h1>
```

- **在现代布局中，id选择器常常用于建立派生选择器**

- **一个id选择器作为派生选择器可以被使用多次**
```
#sidebar p {
	font-style: italic;
	text-align: right;
	margin-top: 0.5em;
	}

#sidebar h2 {
	font-size: 1em;
	font-weight: normal;
	font-style: italic;
	margin: 0;
	line-height: 1.5;
	text-align: right;
	}
```

- **id选择器即使不被用来创建派生选择器，它也可以独立发挥作用**
```
#sidebar {
	border: 1px dotted #000;
	padding: 10px;
	}
```

## CSS类选择器
- **在CSS中，类选择器用一个点号显示**
```
.center {text-align: center;}
```

- **和id一样，类选择器也可以被用作派生选择器**
```
.fancy td {
	color: #f60;
	background: #666;
	}
```

- **元素也可以基于他们的类而被选择**
```
td.fancy {
	color: #f60;
	background: #666;
	}
```

## CSS属性选择器
- 对带有指定属性的HTML元素设置样式(可以为拥有指定属性的HTML元素设置样式，而不仅限于class和id属性)
- 属性选择器
```
[title] {
  color: red;
}

# 为带有title属性的所有元素设置样式
```
- 属性和值选择器
```
[title=W3School] {
  border:5px solid blue;
}
# 为title=W3School的所有元素设置样式
```

- 属性和值选择器 - 多个值
```
[title~=hello] { color:red; }
# 为包含指定值的title属性的所有元素设置样式，适用于用空格分割的属性值

[lang|=en] { color:red; }
# 为带有包含指定值的lang属性的所有元素设置样式，适用于由连字符分隔的属性值
```

- 设置表单的样式
```
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
    input[type="text"] {
        width: 150px;
        display: block;
        margin-bottom: 10px;
        background-color: wheat;
        font-family: Verdana, Arial;
    }

    input[type="button"] {
        width: 120px;
        margin-left: 35px;
        display: block;
        font-family: Verdana, Arial;
    }
</style>
</head>
<body>
<form name="input" action="" method="get">
    <input type="text" name="Name" value="Bill" size="20" />
    <input type="text" name="Name" value="Gates" size="20" />
    <input type="button" value="Example Button" />
</form>
</body>
</html>
```

## CSS创建样式表的三种方法
### 外部样式表
当样式需要应用于很多页面时，外部样式表将是理想的选择。
```
<head>
<link rel="stylesheet" type="text/css" href="mystyle.css" />
</head>

# rel属性规定当前文档与被链接文档之间的关系  styleshee：文档的外部样式表
```

### 内部样式表
当单个文档需要特殊的样式时，就应该使用内部样式表。
```
<head>
<style type="text/css">
  hr {color: sienna;}
  p {margin-left: 20px;}
  body {background-image: url("images/back40.gif");}
</style>
</head>
```

###　内联样式
由于要将表现和内容混杂在一起，内联样式会损失掉样式表的许多优势。
```
<p style="color: sienna; margin-left: 20px">
This is a paragraph
</p>
```

### 多种样式
如果某些属性在不同的样式表中被同样的选择器定义，那么属性值将从更具体的样式表中被继承过来，内联样式>内部样式>外部样式
