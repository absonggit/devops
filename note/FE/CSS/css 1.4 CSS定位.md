# CSS定位
CSS定位(Positioning)属性允许对元素进行定位

## CSS定位概述
### CSS定位和浮动
CSS为定位和浮动提供了一些属性，利用这些属性，可以建立列式布局，将布局的一部分与另一部分重叠，还可以完成多年来通常使用多个表格才能完成的任务。

### CSS position属性
通过以下四种不同的属性，可以选择不同类型的定位，这些会影响元素框生成的方式。
- static 元素框正常生成，块级元素生成一个矩形框，作为文档流的一部分，行内元素则会创建一个或多个行框，置于其父元素中。
- relative ['rɛlətɪv] 元素框相对于正常位置偏移某个距离。元素仍保持定位前的形状，它原本所占的空间扔保留。
- absolute ['æbsəluːt] 元素框指定距离页面顶部和左侧的绝对位置，元素框从文档流完全删除，并相对于其它包含块定位。元素原先所占的空间会关闭，就好像元素原来不存在一样。元素定位后生成一个块级框。而不论原来它在正常流中生成何种类型的框。
- fixed [fɪkst] 元素框的表现类似于将position设置为obsolute。不过其包含块是视窗本身。

### CSS定位属性
| 属性 | 描述 |
| :--- | :-- |
| position | 把元素防止到一个静态的、相对的、绝对的、或固定的位置中 |
| top | 定义了一个定位元素的上外边距距边界与其包含块上边界之间的偏移 |
| right | 定义了定位元素右外边距距边界与其包含块上边界之间的偏移 |
| bottom | 定义了定位元素下外边距距边界与其包含块上边界之间的偏移 |
| left | 定义了定位元素左外边距距边界与其包含块上边界之间的偏移 |
| overflow | 设置当元素的内容溢出其区域时发生的事情 |
| clip | 设置元素的形状。元素被剪入这个形状中，然后显示出来 |
| vertical-align | 设置元素的垂直对齐方式 |
| z-index | 设置元素的堆叠顺序 |

## CSS相对定位
如果对一个元素进行相对定位，它将出现在它所在的位置上。然后通过设置垂直或水平位置，让这个元素"相对于"它的起点进行移动。**在使用相对定位时，无论是否进行移动，元素仍然占据原来的空间。因此移动元素会导致它覆盖其它框**
```
#box_relative {
  position: relative;
  left: 20px;
  top: 20px;
}
```

## CSS绝对定位
绝对定位使元素的位置与文档流无关，因此不占据空间，这一点与相对定位不同，相对定位实际上被看做普通流定位模型的一部分，因为元素的位置相对于它在普通流中的位置。**绝对定位是"相对于"最近的已定位祖先元素，如果不存在已定位的祖先元素，那么"相对于"最初的包含快(画布或HTML元素)**
```
#box_relative {
  position: absolute;
  left: 30px;
  top: 20px;
}
```

## CSS浮动
**浮动的框可以向左或向右移动，知道它的边缘碰到包含框或另一个浮动框的边框为止。由于浮动框不在文档的普通流中，所以文档的普通流中的边框表现得就像浮动框不存在一样**

### CSS浮动属性  float
### 行框和清理 clear
clear属性值 left right both none 表示框的哪些边不应该挨着浮动框
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>链接</title>
    <style type="text/css">
        .news {
            background-color: gray;
            border: solid 1px black;
            float: left;
        }

        .news img {
            float: left;
        }

        .news p {
            float: right;
        }
    </style>
</head>
<body>
    <div class="news">
        <img src="logo.png" />
        <p>
          some text
        </p>
    </div>
</body>
</html>
```

#### 创建水平菜单
```
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>TEST</title>
    <style type="text/css">
        ul {
            float: left;
            width: 100%;
            padding: 0px;
            margin: 0px;
            list-style-type: none;
        }

        a {
            float: left;
            width: 7em;
            text-decoration: none;
            color: white;
            background-color: purple;
            padding: 0.2em 0.5em;
            border-right: 1px solid white;
        }

        a:hover {
            background-color: #FF3300;
        }

        li {
            display: inline;
            text-align: center;
        }
    </style>
</head>
<body>
    <ul>
        <li><a href="#">Link one</a> </li>
        <li><a href="#">Link two</a> </li>
        <li><a href="#">Link three</a> </li>
        <li><a href="#">Link four</a> </li>
        <li><a href="#">Link five</a> </li>
    </ul>
</body>
</html>
```

#### 创建无表格的首页

#### 清楚元素的侧面
