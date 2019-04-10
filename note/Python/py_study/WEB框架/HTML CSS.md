# HTML文档
## Doctype
（document type definition，文档类型定义）是一系列的语法规则， 用来定义XML或(X)HTML的文件类型。浏览器会使用它来判断文档类型， 决定使用何种协议来解析，以及切换浏览器模式。

## head标签
### Meta (metadata information)
1. 页面编码(告诉浏览器是什么编码)
```html
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
```

2. 刷新和跳转
```html
<meta http-equiv="Refresh" content="20"/>
<meta http-equiv="Refresh" content="5; Url=http://www.baidu.com"/>
```

3. 关键词
```html
<meta name="keywords" content="星际2，色色，游戏，暴力"/>
```

4. 描述信息
```html
<meta name="descirption" content="详细描述信息"/>
```

5. X-UA-Compatible
```html
<!--兼容IE各版本-->
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
```

### Title

### Link
1. icon
```html
<!--定义标签栏小图标-->
<link rel="shortcut icon" href="image/favicon.ico"/>

<!--引入css文件-->
<link rel="stylesheet" href="../static/css/define.css"/>
```

### Style

### Script

# 常用标签
## body标签
### 特殊符号(nbsp gt lt)
```html
http://tool.chinaz.com/Tools/htmlchar.aspx
空格 - &nbsp;
大于 - &gt;
小于 - &lt;
```

### 段落(p br span)
标签分为：块级标签 h1-6、p、div，行内标签(内联标签) span
- p标签：段落 加大加粗
- br标签：换行 段落和段落之间有间距
- span标签：白板 没什么特性
- div标签：白板 没什么特性

### 表单、按钮(form input)
```html
<form action="http://xxx.com" method="get/post" enctype="multipart/form-data">
  <input type="text" name="user" value="default user"/>
  <input type="password" name="pwd" value="default pwd"/>

  <!--单选框-->
  <span>男</span><input type="radio" name="gender" value="1"/>
  <span>女</span><input type="radio" name="gender" value="2" checked="checked"/>
  <!--相同name就可以实现单选、value传送不同属性 ?user=f&pwd=1&gender=1-->
  <!--checked默认值-->

  <!--多选框-->
  <span>RED</span><input type="checkbox" name="color" value="1" />
  <span>GREEN</span><input type="checkbox" name="color" value="1" />
  <span>PINK</span><input type="checkbox" name="color" value="1" checked="checked" />
  <span>PURPLE</span><input type="checkbox" name="color" value="1" checked="checked" />
  <!--相同name区分不同多选框、value传送不同属性、后台获取到的是一个列表-->

  <!--文件上传-->
  <input type="file" value="提交"/>
  <!--文件上传依赖form标签的enctype="multipart/form-data属性-->


  <!--多行文本-->
  <textarea name="t_area">Default content</textarea>

  <!--下拉菜单-->
  <select name="province" multiple="multiple" size="10">
      <optgroup label="辽宁省">
          <option value="shenyang">沈阳</option>
          <option value="dalian">大连</option>
      </optgroup>
      <optgroup label="四川省">
          <option value="chengdu" selected="selected">成都</option>
          <option value="leshan">乐山</option>
      </optgroup>
      <optgroup label="江西">
          <option value="nanchang">南昌</option>
          <option value="jiujiang">九江</option>
      </optgroup>
  </select>
  <!--multiple="multiple"属性实现多选 optgroup实现分组 selected实现默认选项 size显示大小-->

  <input type="button" value="登录1" />
  <input type="submit" value="登录2" />
  <input type="reset" value="重置"/>
</form>
```

### 链接、锚点(a)
```html
<!--链接跳转-->
<a href="http://www.baidu.com" target="_blank">百度</a>

<!--锚点(页内跳转)-->
<a href="#i1">第一章</a>
<a href="#i2">第二章</a>
<a href="#i3">第三章</a>
<a href="#i4">第四章</a>
<div id="i1" style="height: 600px;">第一章内容</div>
<div id="i2" style="height: 600px;">第二章内容</div>
<div id="i3" style="height: 600px;">第三章内容</div>
<div id="i4" style="height: 600px;">第四章内容</div>
```

### 图片(img)
```html
<!--图片-->
<img src="../static/images/bg_2.jpg" style="height: 300px; width: 300px" title="背景图片" alt="图片丢失">
<!--title属性(鼠标悬停说明)，alt(图片不显示的时候显示信息)-->
```

### 列表(ul-li ol-li dl-dt、dd)
```html
<!--列表1-->
<ul>
    <li>第一行</li>
    <li>第二行</li>
    <li>第三行</li>
    <li>第四行</li>
</ul>


<br/><br/>
<!--列表2-->
<ol>
    <li>第一行</li>
    <li>第二行</li>
    <li>第三行</li>
    <li>第四行</li>
</ol>

<!--列表3-->
<dl>
    <dt>TTT</dt>
    <dd>DDD</dd>
    <dd>DDD</dd>
    <dt>TTT</dt>
    <dd>DDD</dd>
    <dd>DDD</dd>
</dl>
<!--dt(标题),dd(内容)-->
```

### 表格(table tr td)
```html
<!--表格-->
<table border="1" style="text-align: center">
    <thead>
        <tr>
            <th>表头1</th>
            <th>表头2</th>
            <th>表头3</th>
            <th>表头4</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>内容</td>
            <td>内容</td>
            <td colspan="2">内容</td>
        </tr>
        <tr>
            <td rowspan="2">内容</td>
            <td>内容</td>
            <td>内容</td>
            <td>内容</td>
        </tr>
        <tr>
            <td>内容</td>
            <td>内容</td>
            <td>内容</td>
        </tr>
    </tbody>
</table>
<!--th(表头),tr(行),td(列),rowspan(合并列),colspan(合并行)-->
```

### 光标 特殊边框(lable fieldset)
```html
<fieldset>
    <legend>登录</legend>
    <label for="username">用户名：</label>
    <input type="text" id="username" name="user"/>
    <br/>
    <label for="password">密&nbsp;&nbsp;&nbsp;码：</label>
    <input type="password" id="password" name="pwd"/>
</fieldset>
<!--label(关联文字使得关联的标签获取光标),fieldset(特殊边框)-->
```

# CSS
- 在标签设置style属性
- 写在head里，style标签中写样式

## 选择器
### id选择器
```html
<head>
<style>
    #i1 {
        background-color: #2459a2;
        height: 50px;
}
</style>
</head>

<body>
<div id="i1">111</div>
</body>
<!--引用的时候使用id、并且只能是引用一次-->
```

### class选择器
```html
<head>
    <style>
        .i1 {
            background-color: #2459a2;
            height: 50px;
    }
  </style>
</head>

<body>
    <div class="i1">111</div>
    <span class="i1">222</span>
    <div class="i1">333</div>
</body>
<!--引用的时候使用class、可以引用多次-->
```

### 标签选择器
```html
<head>
    <style>
        div {
            background-color: #2459a2;
            height: 50px;
        }
    </style>
</head>

<body>
    <div>111</div>
</body>
<!--所有未指定classs、id的全部div默认使用此样式-->
```

### 关联选择器(层级选择器) 空格
    ```html
    <sytle>
      .c1 .c2 div a apan {
        ...
      }
    </style>

    or

    <sytle>
      span div {
        ...
      }
    </style>
    ```

### 组合选择器 逗号
    ```html
    <style>
      #i1, #i2, #i3 {
        ...
      }
    </style>
    <div id="i1">111</div>
    <div id="i2">222</div>
    <div id="i3">333</div>

    or

    <style>
      .i1, .i2, .i3 {
        ...
      }
    </style>
    <div class="i1">111</div>
    <div class="i2">222</div>
    <div class="i3">333</div>
    ```

### 属性选择器
```html
<style>
    input[type="test"]{
        ...
    }
</style>
<input type="test"/>
```

**《选择器优先级：标签上的style有限，然后按照编写顺序，就近原则》**

## 注释
```html;
<!--CSS用一下方式注释信息-->
/* */
```

## 边框 border
```html
<body>
    <span sytle="border: 5px solid/dotted green;    边框宽度 类型 颜色
    background-color: red;    背景色
    height: 10px;    高度
    width: 50%;    宽度
    font-size: 30px;    字体大小
    font-weight: 600;    字体加粗
    text-align: center;    文本水平居中
    line-height: 48px;    文本垂直居中
    color: purple;    字体颜色
    ">test_content</span>
</body>
```

## 浮动 float
让标签浮动，块级别标签可以堆叠
```html
<body style="margin: 0 auto;">
    <div style="background-color: red;height: 50px;width: 20%;float: left;"></div>
    <div style="background-cloor: black;height: 50px;width: 80%;float: left;"></div>
    <div sytle="clear: both;"></div>    外边边框随着里边边框扩大
</body>
```

## display
```html
<body style="margin: 0 auto;">
    <div style="background-color: red;display: inline">111</div>
    <div style="background-color: red;display: none">111</div>
    <span style="background-color: green;display: block;">222</span>
    <span style="background-color: green;display: inline-block;">222</span>
</body>
<!--dosplay: inline block inline-block none(none 作用是让标签不生效)-->
```
**行内标签默认无法设置高度、宽度、外边框内边框，块级标签可以，但是display: inline-block可以让行内标签具有块级标签的特性**<br/>
**margin 0 auto 0表示上下间距为0 auto表示左右自动**

## 边距 padding margin
- 外边距：margin
- 内边距：padding --->自身发生变化

## 定位 position
### 固定位置 fixed
固定在页面的某个位置、不随下拉滚动条滚动
```html
<body>
    <div style="background-color: green;height: 20px;width: 60px;position: fixed;bottom: 20px;right: 20px;">
        返回顶部
    </div>
    <div style="background-color: gray;height: 3000px;">
        背景
    </div>
</body>
```

### 相对位置 relative absolute
relative和absolute配合使用、相对于固定在div的某个位置
```html
<body>
    <div style="position: relative;height: 300px;width: 500px;border: 1px solid red;margin: 0 auto;">
        <div style="position: absolute;top: 0;left: 0;height: 20px;width: 50px;background-color: green;"></div>
    </div>
    <div style="position: relative;height: 300px;width: 500px;border: 1px solid red;margin: 0 auto;">
        <div style="position: absolute;top: 0;right: -50;height: 20px;width: 50px;background-color: green;"></div>
    </div>
    <div style="position: relative;height: 300px;width: 500px;border: 1px solid red;margin: 0 auto;">
        <div style="position: absolute;bottom: 0;left: 0;height: 20px;width: 50px;background-color: green;"></div>
    </div>
</body>
```

### 遮罩效果 opacity z-index
- z-index 显示层级 数字越大级别越高
- opacity 设置遮罩透明度 0-1之间
- **遮罩效果必须定义position的上下左右四个属性、缺一不可**
```html
<body>
    <div style="z-index: 10;background-color: white;height: 200px;width: 300px;position: fixed;top: 50%;left: 50%;border: 1px solid red;margin-top: -100px;margin-left: -300px;">
        <form style="text-align: center;line-height: 100px;">
            <span>用户名：</span><input type="text"/><br/>
            <span>密码：</span><input type="password"/>
        </form>
    </div>

    <div style="background-color: #a8a514;height: 1000px;line-height: 1000px;text-align: center;font-size: 100px">
        网站主页面
    </div>

    <div style="z-index:9;background-color: gray;position: fixed;top: 0;right: 0;bottom: 0;left: 0;text-align: center;opacity: 0.8;font-size: 75px;">
        第二层遮罩
    </div>
</body>
```
**第三层弹出框、必须写在第一层和第二层上面，否则没有效果**

## 图片溢出处理 oveflow
- hidden 超出部分隐藏
- auto 超出部分弹出滚动条
```html
<body>
    <div style="height: 300px;width: 300px;overflow: hidden;">
        <img src="../static/images/bg_1.gif">
    </div>
    <div style="height: 300px;width: 300px;overflow: auto;">
        <img src="../static/images/bg_1.gif">
    </div>
</body>
```

## 鼠标悬停 hover
当鼠标移动到当前标签时，此CSS才生效
```html
<head>
<style>
.pg_header .menu:hover {
     background-color: tomato;
     color: springgreen;
 }
</style>
</head>
<body>
<div class="pg_header">
 <div class="w">
     <a class="logo" href="#">LOGO</a>
     <a class="menu" href="#">菜单一</a>
     <a class="menu" href="#">菜单二</a>
     <a class="menu" href="#">菜单三</a>
     <a class="menu" href="#">菜单四</a>
     <a class="menu" href="#">菜单五</a>
 </div>
</div>
<div class="pg_body">正文</div>
</body>
```

## 背景 background
- background-repeat: repeat-x;
- background-repeat: repeat-y;
- background-repeat: no-repeat;
- background-position-y: 10px;
- background-position-x: 10px;
```html
<body>
    <div style="height: 200px"></div>
    <div style="background: #f8f8f8 url(../static/images/icon_18_118.png) 0 -80px no-repeat;
    height: 60px;
    width: 20px;">
    </div>
</body>

<!--可简写为  background: url position-x position-y no-repeat-->
```

### 用户密码登录框小图标示例
```HTML
<!--用户密码登录框、内含分层小图标-->
<body>
    <div style="background-color: black;height: 300px;width: 500px;">
        <div style="height: 30px;width: 250px;position: relative;">
            <input  style="height: 30px;width: 220px;padding-right: 30px;" type="text"/>
            <span style="position: absolute;top: 10px;right: 0px;background: url(../static/images/i_name.jpg);height: 16px;width: 16px;display: inline-block;"></span>
        </div>
        <div style="height: 30px;width: 250px;position: relative;">
            <input  style="height: 30px;width: 220px;padding-right: 30px;" type="password"/>
            <span style="position: absolute;top: 10px;right: 0px;background: url(../static/images/i_pwd.jpg);height: 16px;width: 16px;display: inline-block;"></span>
        </div>
    </div>
</body>
```
