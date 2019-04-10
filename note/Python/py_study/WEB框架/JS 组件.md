# EasyUI

# jQueryUI

# BootStrap
## 响应式布局
@media
```html
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .c1{
            background-color: green;
            height: 50px;
        }

        @media (min-width: 600px) {
            .c2{
                background-color: red;
            }
        }
    </style>
</head>
<body>
<div class="c1 c2"></div>
</body>
```

## 图标、字体
@font-face

## 基本操作
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="../static/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" href="../static/bootstrap-3.3.7-dist/css/bootstrap-theme.css">
    <style>
        .css1{
          font-weight: 200; !important; //!important 可以覆盖任何css样式，优先级最高
        }
    </style>
</head>
<body>
<script src="../static/jquery/jquery-3.2.1.js"></script>
<script src="../static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</body>
</html>
```

### 轮播图 - bxslider
https://bxslider.com/
