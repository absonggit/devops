# CSS样式
## CSS背景
### 背景色与背景图像
```
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>TEST</title>
    <style type="text/css">
        body {background-image: url("../static/images/bg_1.gif");}
        p.flower {background-image: url("../static/images/bg_2.jpg"); padding: 40px;}
        a.radio {background-color: #3e8f3e; padding: 20px;}
    </style>
</head>
<body>
    <p class="flower">第二个背景<a href="#" class="radio">超链接背景色</a> </p>
</body>
</html>
```

### 背景重复
```
body
  {
  background-image: url(/i/eg_bg_03.gif);
  background-repeat: repeat-y;
  }
# background-repeat属性：属性值no-repleat 不允许在任何方向平铺；repeat-x 允许水平平铺；repeat-y 允许垂直平铺
```

### 背景定位
- background-position属性改变图像在背景中的位置，属性值可以是关键字、百分数值或者长度值。
```
body {
    background-image: url("../static/images/logo.png");
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: center left;
}
# background-attachment属性设置为“fixed”，position属性才生效。不知道为什么？？？
```

#### 关键字
center、top、bottom、left、right，这些关键字可以按任意顺序出现，但是不能超过两个关键字，一个水平方向，一个垂直方向，如果只出现一个关键字，则认为另一个关键字是center。

#### 百分数值
background-position的默认是只0% 0%，在功能上相当于 top left.

#### 长度值
长度值是指元素内边距区左上角的偏移。偏移点是图像的左上角(background-position: 50px 100px 图像左上角向右50px 向下100px)

### 背景关联
- background-attachment默认的属性是scroll(背景随着文档滚动)，设置为fixed(固定背景)

## CSS文本
### 缩进文本 text-indent属性
把web页面上的段落的第一行缩进，这是一种最常用的文本格式化效果。text-indent属性可以为所有块级元素应用，但无法将该属性应用于行内元素以及图像元素，如果想实现行内元素的第一行缩进，可以使用左内边距或外边距实现。
- 正常缩进
```
p {text-indent: 5em;}
```

- 使用负值 实现悬挂缩进
```
p {text-indent: -1cm; padding-left: 2cm; padding-right: 2cm;}
```

- 使用百分比值
- 继承 text-indent属性可以继承

### 水平对齐 text-align
text-align是一个基本的属性，它会影响一个元素中的文本行相互之间的对齐方式
- 属性值：left、right、center、justify(两端对齐)

### 字间隔 word-spacing
word-spacing属性可以改变字(单词)之间的标准间隔。word-spacing属性接受正长度值和负长度值
- 字 定义为由空白字符包围的一个字符串
- 单词 定义为由空白字符包围的一个字符串
```
p.spread {word-spacing: 30px;}
p.tight {word-spacing: -0.5em;}

<p class="spread">
This is a paragraph. The spaces between words will be increased.
</p>

<p class="tight">
This is a paragraph. The spaces between words will be decreased.
</p>
```

### 字母间隔 letter-spacing
letter-spacing与word-spacing的区别在于，字母间隔修改的是字符或字母之间的间隔。

### 字符转换 text-transform
- none 默认值 对文本不做任何改动
- uppercase 全部大写
- lowercase 全部小写
- capitalize 每个单词首字母大写

### 文本装饰 text-decoration
- none 关闭原本应用到一个元素上的所有装饰
- underline
- overline
- line-through
- blink
> text-decoration的属性值只会替换不会累计(相同元素的属性值只取交叉值，不会取累加值)

### 处理空白符 white-space
white-space属性会影响到用户代理对源文档中的空格、换行和tab字符的处理。
- normal 默认值 会把所有空白符合并为一个空格 同时忽略元素中的换行
- pre 类似于HTML的pre元素一样；空白符 换行符不会忽略。
- nowrap 防止元素中的文本换行，除非使用</ br>元素。类似于<td nowrap>讲一个表格单元格设置为不能换行。
- pre-wrap 保留空白符序列，但是文本行会正常地换行
- pre-line 合并空白符序列，保留换行符

| 值 | 空白符 | 换行符 | 自动换行 |
| :-- | :---- | :----- | :------ |
| pre-line | 合并 | 保留 | 允许 |
| normal | 合并 | 忽略 | 允许 |
| nowrap | 合并 | 忽略 | 不允许 |
| pre | 保留 | 保留 | 不允许 |
| pre-wrap | 保留 | 保留 | 允许 |

### 文字方向 direction
direction属性有两个值：ltr和rtl 默认是ltr 显示从左到右的文本
> 对于行内元素，只有当unicode-bidi属性设置为embed或bidi-override时才会应用direction属性

### CSS文本属性
| 属性 | 描述 |
| :-- | :--- |
| color | 设置文本颜色 |
| direction | 设置文本方向 |
| line-height | 设置行高 |
| letter-spacing | 设置字符间距 |
| text-align | 对齐元素中的文本 |
| text-decoration | 向文本添加修饰 |
| text-indent | 缩进元素中文本的首行 |
| text-shadow | 设置文本阴影。CSS2包含改属性，但是CSS1没有该属性 |
| text-transform | 控制元素中的字母 |
| unicode-bidi | 设置文本方向 |
| white-space | 设置元素中空白的处理方式 |
| word-sapcing | 设置字间距 |

## CSS字体
在CSS中，有两种不同类型的字体系列名称；
- 通用字体系列 - 拥有相似外观的字体系统组合(比如"Serif"或"Monospace")
- 特定字体系列 - 具体的字体系列(比如"Times"或"Courier")

### 指定字体系列 font-family
```
body {font-family: Georgia, serif;}
# 身产中会指定特定字体和通用字体，如果特定字体没有安装，那么就使用通用字体
```

### 使用引号 - 多字体
```
p {font-family: Times, TimesNR, 'New Century schoolbook' Georgia, 'New York';}
# 单引号双引号都可以
```

### 字体风格 font-style
- normal - 文本正常显示
- italic - 文本斜体显示
- oblique - 文本倾斜显示

### 字体变形 font-variant
font-variant属性可以设定小型大写字母(小型大写字母既不是小写字母也不是大写字母)

### 字体加粗 font-weight
font-weight设置文本的粗细
- 使用bold关键字可以将文本设置为粗体
- 关键字100-900为字体制定了9级加粗(100最细，900最粗，400等于normal，70等于bold)
- bolder lighter 浏览器会设置比继承值更粗、更细的一个字体加粗、细

### 字体大小 font-size
font-size设置文本的大小
- font-size可以是绝对值或相对值
    - 绝对值：
        - 将文本设置为指定的大小
        - 不允许用户在所有浏览器中改变文本大小(不利于可用性)
        - 绝对大小在确定了输出的物理尺寸时很有用
    - 相对值：
        - 相对于周围的元素来设置大小
        - 允许用户在浏览器改变文本大小
> 如果没有规定字体大小，普通文本默认大小是16px

#### 使用像素来设置字体大小
```
h1 {font-size: 60px;}
h2 {font-size: 50px;}
```

#### 使用em来设置字体大小
为了避免在IE中无法调整文本，推荐使用em单位代替pixels，1em等于当前尺寸，在设置字体大小事，em的值会相对父元素的字体大小改变

#### 结合使用百分比和em
```
body {font-size: 100%;}
h1 {font-size: 3.75em;}
h2 {font-size: 2.75em;}
```
### CSS字体属性
| 属性 | 描述 |
| :--- | :-- |
| font | 简写属性。作用是把所有针对字体的属性设置在一个声明中|
| font-family | 设置字体系列 |
| font-size | 设置字体的尺寸 |
| font-stype | 设置字体风格 |
| font-variant | 以小型大写字体或者正常字体显示文本 |
| font-weight | 设置字体的粗细 |

## CSS链接
### 链接的四种状态(顺序固定不可随意写)
- a:link - 普通的、未被访问的链接
- a:visited - 用户已访问的链接
- a:hover - 鼠标指针位于链接的上方
- a:active - 链接被点击的时刻

### 常见的链接样式
#### 文本装饰
text-decoration属性大多数用于去掉链接中的下划线
```
a:link {text-decoration:none;}
a:visited {text-decoration:none;}
a:hover {text-decoration:underline;}
a:active {text-decoration:underline;}
```
#### 背景色
background-color属性规定链接的背景色
```
a:link {background-color:#B2FF99;}
a:visited {background-color:#FFFF85;}
a:hover {background-color:#FF704D;}
a:active {background-color:#FF704D;}
```

### 实例应用
#### 向链接添加不同的样式
```
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>TEST</title>
    <style type="text/css">
        body {
{#            background-image: url("../static/images/logo.png");#}
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: 50% 20%;
        }
        a.one:link {color: #ff0000;}
        a.one:visited {color: #0000ff;}
        a.one:hover {color: #ffcc00;}

        a.two:link {color: #ff0000;}
        a.two:visited {color: #0000ff;}
        a.two:hover {font-size: 150%;}
        a.two:active {color: blueviolet;}

        a.three:link {color: #ff0000;}
        a.three:visited {color: #0000ff}
        a.three:hover {background-color: #66ff66;}

        a.four:link {color: #ff0000;}
        a.four:visited {color: #0000ff;}
        a.four:hover {font-family: "微软雅黑 Light";}

        a.five:link {color: #ff0000; text-decoration: none;}
        a.five:visited {color: #0000ff; text-decoration: none;}
        a.five:hover {text-decoration: underline;}
    </style>
</head>
<body>
    <p><a class="one" href="#" target="_parent">这个链接改变颜色</a> </p>
    <p><a class="two" href="#" target="_parent">这个链接改变字体大小</a> </p>
    <p><a class="three" href="#" target="_parent">这个链接改变背景色</a> </p>
    <p><a class="four" href="#" target="_parent">这个链接改变字体</a> </p>
    <p><a class="five" href="#" target="_parent">这个链接改变文本装饰</a> </p>
</body>
</html>
```
#### 结合不用CSS属性，把链接显示为方框
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>链接</title>
    <style type="text/css">
        a:link, a:visited {
            display: block;
            font-weight: bold;
            font-size: 14px;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            color: #FFFFFF;
            background-color: #98BF21;
            width: 120px;
            text-align: center;
            padding: 4px;
            text-decoration: none;
        }

        a:hover, a:active {
            background-color: #7A991A;
        }
    </style>
</head>
<body>

<a href="#" target="_self">菜单1</a>
<a href="#" target="_self">菜单2</a>

</body>
</html>
```

## CSS列表
### 列表类型 list-style-type
```
ul {list-style-type: square}
```

### 列表项图像 list-style-image
```
ul li {list-style-image: url(xxx.gif)}
```
### 列表标志位置 list-style-position

## CSS表格
### 表格边框
### 折叠边框
```
<head>
    <meta charset="UTF-8">
    <title>链接</title>
    <style type="text/css">
        table, th, td {
            border-collapse: collapse;
            border: 1px solid blue;
        }
    </style>
</head>
<body>

<table>
    <tr>
        <th>FirstName</th>
        <th>LastName</th>
    </tr>
    <tr>
        <td>Bill</td>
        <td>Gates</td>
    </tr>
    <tr>
        <td>Steven</td>
        <td>Jobs</td>
    </tr>
</table>

</body>
```
### 表格宽度和高度 width height
### 表格文本对齐 text-align vertical-align
- text-align 设置水平对齐方式
- vertical-align 设置垂直对齐方式

### 表格内边距 padding
### 表格颜色 background-color color
### CSS Table属性
| 属性 | 描述 |
| :--- | :-- |
| border-collapse | 设置是否把表格边框合并为单一边框 |
| border-spacing | 设置分隔单元格边框的距离 |
| caption-side | 设置表格标题的位置 |
| empty-cells | 设置是否显示表格中的空单元格 |
| table-layout | 设置显示单元、行和列的算法 |

## CSS轮廓
### 在元素周围画线 outline
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>链接</title>
    <style type="text/css">
        p {
            border: red solid thin;
            outline: blue dotted thick;
        }
    </style>
</head>
<body>
    <p><b>注释：</b>测试文本测试文本测试文本测试文本测试文本测试文本</p>
</body>
</html>
```
### 设置轮廓的颜色 outline-color

### 设置轮廓的样式 outline-style
### 设置轮廓的宽度 outline-width
