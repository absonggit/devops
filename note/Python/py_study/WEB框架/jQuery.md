# jQuery推荐版本以及对象间转换
## 推荐版本
1. 1.x 推荐1.x最新版本 兼容性好
2. 2.x
3. 3.x

## jQuery对象和Dom对象的转换
```javascript
jQuery('#i1')  ==  $('#i1')

jQuery对象[0] ==> Dom对象
$(Dom对象)  ==> jQuery对象
```
# jQuery查找元素
## 选择器
### 基本
id选择器
```javascript
<div id='i1'></div>

$('#i1')
```

class选择器
```javascript
<div class='i1'></div>

$('.i1')
```

标签选择器
```javascript
<div id='i1'></div>

$('div')
```

组合选择器
```javascript
<div id='i1'></div>
<a>123<a/>
<div id='i2'></div>

$('#i1,a,#i2')
```

属性选择器
```javascript
$('#i1 a:first')
```

### 层级
```javascript
$('#i1 a') //子子孙孙
$('#i1>a') //child
```

### 基本筛选器
```javascript
:first    //第一个
:not(selector)  //非
:eq(index)   //从0开始  等于索引值
:last   //最后一个
```

### 属性
```javascript
$('[name]')    //具有name属性的所有标签
$('[name="i1"]')    //具有name=i1的标签
```

### 表单对象属性
```javascript
:selected    //select下拉菜单属性
:checked    //checkbox是否选择
:enabled    //文本框为可写状态
:disabled    //文本框为禁用状态
```

### 示例 - 全选 反选 取消列表
```html
<body>
<input type="button" value="全选" onclick="allSelect()"/>
<input type="button" value="反选" onclick="reverseSelect()"/>
<input type="button" value="取消" onclick="cancelSelect()"/>

<table border="1px">
    <thead>
        <tr><td>选择</td><td>IP</td><td>PORT</td></tr>
    </thead>
    <tbody id="t123">
        <tr><td><input type="checkbox"/></td><td>1.1.1.1</td><td>80</td></tr>
        <tr><td><input type="checkbox"/></td><td>1.1.1.1</td><td>80</td></tr>
        <tr><td><input type="checkbox"/></td><td>1.1.1.1</td><td>80</td></tr>
        <tr><td><input type="checkbox"/></td><td>1.1.1.1</td><td>80</td></tr>
        <tr><td><input type="checkbox"/></td><td>1.1.1.1</td><td>80</td></tr>
    </tbody>
</table>

<script type="text/javascript" src="../static/jquery/jquery-1.11.3.min.js"></script>
<script>
    function allSelect() {
        $('#t123 :checkbox').prop('checked',true);
    }

    function cancelSelect() {
        $('#t123 :checkbox').prop('checked',false);
    }

    //jQuery方法实现1
    function reverseSelect() {
        $('#t123 :checkbox').each(function () {
            if($(this).prop('checked')){
                $(this).prop('checked',false);
            }else {
                $(this).prop('checked',true);
            }
        })
    }

    //jQuery方法实现2
    function reverseSelect() {
        $('#t123 :checkbox').each(function () {
            //this 代指当前循环的每一个元素
            console.log(this);
            //三元运算  条件？真值:假值
            var res = $(this).prop('checked')?false:true;
            $(this).prop('checked',res);
        })
    }

    //Dom方法实现
    function reverseSelect() {
        $('#t123 :checkbox').each(function () {
            if(this.checked){
                this.checked = false;
            }else {
                this.checked = true;
            }
        })
    }
</script>
</body>
```

## 筛选
### 过滤
```javascript
$('#i1').next()    //下一个
$('#i1').prev()    //上一个
$('#i1').parent()    //父亲
$('#i1').children()    //孩子
$('#i1').siblings()    //所有的兄弟

$('#i1').eq()
$('#i1').first()
$('#i1').last()
$('#i1').hasClass()
```

### 查找
```javascript
$('#i1').find(expr|obj|ele)    //子子孙孙中查找
$('#i1').nextAll()
$('#i1').nextUntil()
$('#i1').prevall()
$('#i1').prevUntil()
$('#i1').parents()
$('#i1').parentsUntil()
```

### 示例 - 菜单点击弹出 隐藏
```html
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .c1{
            background-color: #ffea10;
            text-align: center;
            height: 35px;
            line-height: 35px;
        }
        .c1:hover{
            background-color: #ec5c0bba;
        }
        .c2{
            background-color: #28a745;
            text-align: center;
            font-size: 10px;
            min-height: 80px;
            line-height: 80px;
        }
        .hide{
            display: none;
        }
    </style>
</head>
<body>
    <div style="border: 1px solid red;height: 500px;width: 200px;">
        <div class="item">
            <div class="c1">MENU</div>
            <div class="c2">CONTENT</div>
        </div>
        <div class="item">
            <div class="c1">MENU</div>
            <div class="c2 hide">CONTENT</div>
        </div>
        <div class="item">
            <div class="c1">MENU</div>
            <div class="c2 hide">CONTENT</div>
        </div>
        <div class="item">
            <div class="c1">MENU</div>
            <div class="c2 hide">CONTENT</div>
        </div>
    </div>

<script type="text/javascript" src="../static/jquery/jquery-3.2.1.js"></script>
<script>
    $('.c1').click(function () {
        //console.log(this);
        $(this).next().removeClass('hide');
        $(this).parent().siblings().find('.c2').addClass('hide');
    })
</script>
</body>
```

## 属性
### 属性
```javascript
$(...).attr('key','value')    //一个参数获取值、两个参数设置值
$(...).removeAttr('k')
$(...).prop('checked')
$(...).prop('checked',true/false)    //用于checkbox，radio，设置
```

### CSS类
```javascript
addClass(class|fn)
removeClass(class|fn)
toggleClass(class|fn[.sw])    //如果存在(不存在)就删除(添加)一个类
```

### HTML代码/文本/值
```javascript
$(this).text()    //获取文本内容 加参数为设置文本内容
$(this).html()    //获取html
$(this).val()    //获取form表单内容
```

### 示例：内容随菜单变化- 通过属性或者索引两种方法操作
```HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .hide{
            display: none;
        }
        .addColor{
            background-color: darkorange;
        }
        .menu{
            background-color: gray;
            height: 50px;
            line-height: 50px;
        }
        .menu .menu-item{
            float: left;
            border-right: 1px solid white;
            padding: 0 20px;
            font-size: 20px;
            cursor: pointer;    //鼠标悬变小手
        }
        .content{
            min-height: 300px;
            line-height: 300px;
            text-align: center;
            font-size: 100px;
        }
    </style>
</head>
<body>
<div style="width: 800px;margin: 0 auto;border: 1px solid red;">
    <div class="menu">
        <div class="menu-item" a="1">菜单一</div>
        <div class="menu-item" a="2">菜单二</div>
        <div class="menu-item" a="3">菜单三</div>
    </div>
    <div class="content">
        <div b="1">内容一</div>
        <div class="hide" b="2">内容二</div>
        <div class="hide" b="3">内容三</div>
    </div>
    <script src="../static/jquery/jquery-3.2.1.js"></script>
    <!--通过自定义属性的方法-->
    <script>
        $('.menu-item').click(function () {
            $(this).addClass('addColor').siblings().removeClass('addColor');
            var target = "[b='" + $(this).attr('a') + "']";
            $('.content').children(target).removeClass('hide').siblings().addClass('hide');
        });
    </script>

    <!--通过索引的方法-->
    <!--script>
    $('.menu-item').click(function () {
        $(this).addClass('addColor').siblings().removeClass('addColor');
        var i = $(this).index();
        $('.content').children().eq(i).removeClass('hide').siblings().addClass('hide');
    });
</script-->
</div>
</body>
</html>
```

## 文档处理
### 插入 删除
```javascript
//内部插入
append(conten|fn)    //最下边添加
prepend(conten|fn)    //最上边添加

//外部插入
after(content|fn)
before(content|fn)

//删除
remove([expr])    //删除标签及内容
empty([expr])    //删除内容

//复制
clone([Even[,deepEven]])
```

### 示例 增加 删除
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<input id="t1" type="text"/>
<input id="o1" type="button" value="插入"/>
<input id="o2" type="button" value="删除"/>
<input id="o3" type="button" value="复制"/>

<ol id="u1">
    <li>111</li>
    <li>222</li>
    <li>113331</li>
    <li>144411</li>
</ol>

<script src="../static/jquery/jquery-1.11.3.min.js"></script>
<script>
    $('#o1').click(function () {
        var v = $('#t1').val();
        var template = "<li>" + v + "</li>";
        $('#u1').append(template);
    });

    $('#o2').click(function () {
        var index = $('#t1').val();
        $('#u1 li').eq(index).remove();
    });
</script>
</body>
</html>
```

## CSS
### CSS
```
$(..).css('样式名称','样式值')
```

### 示例 点赞
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .container{
            padding: 50px;
            border: 1px solid darkgreen;
        }
        .item{
            position: relative;
            width: 40px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="item">
        <span>赞</span>
    </div>
</div>
<div class="container">
    <div class="item">
        <span>赞</span>
    </div>
</div>
<div class="container">
    <div class="item">
        <span>赞</span>
    </div>
</div>
<div class="container">
    <div class="item">
        <span>赞</span>
    </div>
</div>

<script src="../static/jquery/jquery-3.2.1.js"></script>
<script>
    $('.item').click(function () {
        addFavor(this);
    });

    function addFavor(self) {
        var fontSize = 15;
        var top = 0;
        var right = 0;
        var opacity = 1;

        var tag = document.createElement('span');
        $(tag).text('+1');
        $(tag).css('color','red');
        $(tag).css('position','absolute');
        $(tag).css('fontSize',fontSize + "px");
        $(tag).css('top',top + "px");
        $(tag).css('right',right + "px");
        $(tag).css('opacity',opacity);

        $(self).append(tag);

        var obj = setInterval(function () {
            fontSize = fontSize + 5;
            top = top - 5;
            right = right - 5;
            opacity = opacity - 0.1;

            $(tag).css('fontSize',fontSize + "px");
            $(tag).css('top',top + "px");
            $(tag).css('right',right + "px");
            $(tag).css('opacity',opacity);

            if(opacity < 0){
                clearInterval(obj);
                $(tag).remove();
            }
        },200);
    }
</script>
</body>
</html>
```

### 位置
```html
<body>
<div id="i1" style="width: 300px;height: 500px;overflow: auto;">
    <div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div>
    <div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div>
    <div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div>
    <div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div>
    <div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div><div>asdfas</div>
</div>

<script src="../static/jquery/jquery-3.2.1.js"></script>
<script>
    $(window).scrollTop();    //获取window窗口的滚动条
    $(window).scrollTop(200);    //设置window窗口的滚动条

    $('#i1').scrollTop();    //获取div窗口的滚动条
    $('#i1').scrollTop(0);    //设置div窗口的滚动条滚动到最上边

    $('#i1').offset();    //获取标签的水平、垂直坐标
    $('#i1').position();    //指定标签相对父标签标签的坐标
</script>
</body>
```

### 尺寸
```javascript
//获取标签的纯高度、包含边框的高度、包含外边距的高度、包含内边距的高度
height([val|fn])    
width([val|fn])
innerHeight()
innerWidth()
outerHeight([soptions])
outerWidth([options])
```

### 示例 鼠标移动标签

## 事件
$(..).click()

### 示例 提交表单验证
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .error{
            color: red;
        }
    </style>
</head>
<body>
<form id="f1" action="base8.html" method="post">
    <div><input name="i1" type="text"/></div>
    <div><input name="i2" type="password"/></div>
    <div><input name="i3" type="text"/></div>
    <div><input name="i4" type="text"/></div>
    <div><input name="i5" type="text"/></div>
    <input type="submit" value="提交"/>
</form>

<script src="../static/jquery/jquery-3.2.1.js"></script>
<script>
    $(':submit').click(function () {
        $('.error').remove();
        var flag = true;
        $('#f1').find("input[type='text'],input[type='password']").each(function () {
           var v =$(this).val();
           if(v.length <= 0){
               flag = false;
               var tag = document.createElement('span');
               tag.className = "error";
               tag.innerHTML = "必填选项";
               $(this).after(tag);
           }
        });
        return flag;
    });
</script>
</body>
</html>
```

## 扩展 extend
```javascript
$.extend({
  'newFunc':function(){
    return "111";
  }
})

$fn.extend({
  'newFunc':function(){
    return "111";
  }
})

$.newFunc()
$('.fn').newFunc()
```

避免扩展名冲突、用自执行函数封装
