# CSS 高级
## CSS 对齐
### 对齐块元素
#### 使用margin属性水平对齐
```
.center
{
margin-left:auto;
margin-right:auto;
width:70%;
background-color:#b0e0e6;
}

# 如果宽度是100%，则对齐没有效果
```

#### 使用position属性进行左和右对齐
```
.right
{
position:absolute;
right:0px;
width:300px;
background-color:#b0e0e6;
}

# 绝对定位元素会被从正常流中删除，并且能够交叠元素
```

#### 使用float属性来进行左和右对齐
```
.right
{
float:right;
width:300px;
background-color:#b0e0e6;
}
```

## CSS 尺寸
CSS尺寸属性允许你控制元素的高度和宽度。同样允许增加行间距

## CSS 分类

## CSS 导航栏
### 水平导航栏
### 垂直导航栏

## CSS 图片库
```
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>TEST</title>
    <style type="text/css">
        div.img {
            margin: 3px;
            border: 1px solid #BEBEBE;
            height: auto;
            float: left;
            text-align: center;
        }

        div.img img {
            display: inline;
            margin: 3px;
            border: 1px solid #BEBEBE;
        }

        div.img a:hover img {
            border: 1px solid #333333;
        }

        div.desc {
            text-align: center;
            font-weight: normal;
            width: 150px;
            font-size: 12px;
            margin: 10px 5px 10px 5px;
        }
    </style>
</head>
<body>
    <div class="img">
        <a target="_self" href="#">
            <img src="logo.png" alt="Ballade" width="160" height="160" />
        </a>
        <div class="desc">可爱小鲸鱼</div>
    </div>

    <div class="img">
        <a target="_self" href="#">
            <img src="logo.png" alt="Ballade" width="160" height="160" />
        </a>
        <div class="desc">可爱小鲸鱼</div>
    </div>

    <div class="img">
        <a target="_self" href="#">
            <img src="logo.png" alt="Ballade" width="160" height="160" />
        </a>
        <div class="desc">可爱小鲸鱼</div>
    </div>

    <div class="img">
        <a target="_self" href="#">
            <img src="logo.png" alt="Ballade" width="160" height="160" />
        </a>
        <div class="desc">可爱小鲸鱼</div>
    </div>
</body>
</html>
```
## CSS 图片透明
## CSS 媒介类型
