# JS概述
## JS代码存在形式
- head中
```html
<script>
    alert(警告);
</script>

<script type="text/text/javascript">
    alert(警告)；
</script>
```
- 文件
```html
<script src="js文件路径"></script>
<!--JS代码需要放在<body>标签内部最下方-->
```

## 注释
- 单行注释 //
- 多行注释 `/* */`

## 变量
```javascript
name = 'alex'    默认全局变量
var name = 'alex'    声明局部变量
```

# 基本数据类型
## 数字
```javascript
age = '18';
i = parseInt(age);
i = parseFloat(age);

a = 'alex';
a.charAt(1);    索引位置
a.substring(1,3);    起始位置到结束位置
a.length;    获取当前字符串长度

<script>
    function f1() {
      console.log("在IE控制台输出次内容");
    }
    // 创建一个定时器,2秒钟执行一次f1()函数
    setInterval("f1()", 2000)
</script>
```
```javascript
//JS实现滚屏效果
<script>
    function f1() {
        //根据ID获取指定标签的内容、并赋值给局部变量
        var tag = document.getElementById("i1");
        //获取标签内部的内容
        var content = tag.innerText;

        //取出第一个字、并拼接到最后的位置
        var f = content.charAt(0);
        var l = content.substring(1, content.length);
        var new_content = l + f;

        //重新赋值内容给指定标签
        tag.innerText = new_content;
    }

    //每0.2秒执行一次f1函数
    setInterval("f1()", 200)
</script>
```

## 字符串
```
obj.length                           计算长度
obj.trim()                           移除两边空白
obj.trimLeft()                       移除左侧空白
obj.trimRight()                      移除右侧空白
obj.charAt(n)                        返回字符串中的第n个字符
obj.concat(value, ...)               拼接
obj.indexOf(substring,start)         子序列位置(从前到后)
obj.lastIndexOf(substring,start)     子序列位置(从后到钱)
obj.substring(from, to)              根据索引获取子序列
obj.slice(start, end)                切片
obj.toLowerCase()                    大写
obj.toUpperCase()                    小写
obj.split(delimiter, limit)          分割
obj.search(regexp)                   从头开始匹配，返回匹配成功的第一个位置(g无效)
obj.match(regexp)                    全局搜索，如果正则中有g表示找到全部，否则只找到第一个。
obj.replace(regexp, replacement)     替换，正则中有g则替换所有，否则只替换第一个匹配项，
                                     $数字：匹配的第n个组内容；
                                     $&：当前匹配的内容；
                                     $`：位于匹配子串左侧的文本；
                                     $'：位于匹配子串右侧的文本
                                     $$：直接量$符号
```

## 布尔
true false(小写)

## 数组
等同于python的列表
```
obj.length          数组的大小

obj.push(ele)       尾部追加元素
obj.pop()           尾部获取一个元素
obj.unshift(ele)    头部插入元素
obj.shift()         头部移除元素
obj.splice(start, deleteCount, value, ...)  插入、删除或替换数组的元素
                    obj.splice(n,0,val) 指定位置插入元素
                    obj.splice(n,1,val) 指定位置替换元素
                    obj.splice(n,1)     指定位置删除元素
obj.slice( )        切片
obj.reverse( )      反转
obj.join(sep)       将数组元素连接起来以构建一个字符串
obj.concat(val,..)  连接数组
obj.sort( )         对数组元素进行排序
```

## 字典
等同于python的字典、获取方式也一样

# 条件语句
```javascript
//第一种
if(条件){

}else if(条件){

}else if(条件){

}else{

}


//第二种
switch (expression) {
  case expression:

    break;
  default:

}

== 值相等
=== 值和类型都相等
```

# for循环
```javascript
//第一种循环方式、循环的元素是索引
a  = [11,22,33,44,55]
for(var item in a){
    console.log(a[item]);
}

a = {'k1':'v1','k2':'v2','k3':'v3'}
for(var item in a){
    console.log(a[item]);
}

//第二种循环方式
for(var i=0; i<10; i++){
  console.log(i);
}

a  = [11,22,33,44,55]
for(var i=0; i<a.length; i++){
    console.log(a[i]);
}

//第三种循环方式
while(条件){

}
```

# 函数
## 普通函数
```javascript
function func_name(){
    ...
    return arg+1
}
var result = fun(1)
console.log(result)
```

## 匿名函数
```javascript
setInterval(function(){
  consile.log(123);
}),5000)
```

## 自执行函数
创建函数并且自动执行
```javascript
(function(arg){
    console.log(arg);
})(1)
```

# Dom
## 找到标签
### 直接选择器
```
document.getElementById('id')             根据ID获取一个标签
document.getElementsByName('name')        根据name属性获取标签集合
document.getElementsByTagName('div')      根据标签名获取标签集合
document.getElementsByClassName('div')    根据class属性获取标签集合
```

### 间接选择器
```
parentNode          // 父节点
childNodes          // 所有子节点
firstChild          // 第一个子节点
lastChild           // 最后一个子节点
nextSibling         // 下一个兄弟节点
previousSibling     // 上一个兄弟节点

parentElement           // 父节点标签元素
children                // 所有子标签
firstElementChild       // 第一个子标签元素
lastElementChild        // 最后一个子标签元素
nextElementtSibling     // 下一个兄弟标签元素
previousElementSibling  // 上一个兄弟标签元素
```

## 操作标签
### 文件内容操作
- innerText 仅是文本内容
- innerHTML 全内容(包括html代码)
- obj.value 获取或者设置 标签中的值
    - input value获取当前标签中的值
    - select 获取选中的value的值
        - obj.selectedIndex   select标签特有的 获取下拉索引值
    - textarea value获取当前标签中的值

####示例1　获取表单内容
```javascript
<body>
<div id="i1">测试id内容</div>
<a>标签1</a>
<a>标签2</a>
<a>标签3</a>

<script>
    //通过标签id获取内容并进行修改
    var tag_id = document.getElementById('i1');
    tag_id.innerText = "new content";

    //通过标签获取内容列表、循环列表修改每一个标签内容
    var tag_name = document.getElementsByTagName('a');
    for ( var i=0; i<tag_name.length; i++){tag_name[i].innerText = 666}
</script>
</body>
```

####示例2 表单默认内容 鼠标效果
```html
<body>
<div style="width: 600px;margin-top: 50px;margin-left: 600px;">
    <input id="i1" onfocus="Focus()" onblur="Blur()" type="text" value="请输入关键字"/>
    <input id="i1" type="text" placeholder="请输入关键字"/>
</div>
<script>
    function Focus() {
        var tag = document.getElementById('i1');
        if(tag.value = "请输入关键字"){
            tag.value = "";
        }
    }

    function Blur() {
        var tag = document.getElementById('i1');
        if(tag.value = "0") {
            tag.value = "请输入关键字";
        }
    }

</script>
</body>
```

### 样式操作 className
- className
- classList
    - classList.add
    - classList.remove
- obj.style.color = "red" or obj.fontSize = "16px"

```
tag.className = "" 直接添加class样式名
tag.classList.add('样式名')    添加指定样式
tag.classList.remove('样式名')    删除指定样式

<div onclick = 'func_name()'>点击</div>
<script>
    function func_name(){
      pass
    }
</script>
```

### 属性操作及创建标签
#### 属性操作
- obj.setAttribute('key','value')   自定义属性
- obj.removeAttribute('value')   删除属性
- obj.attributes    获取全部属性

#### 创建标签 并添加到HTML中
1. 字符串形式 insertAdjacentHTML(beforeBegin)
    1. beforeBegin
    2. afterBegin
    3. beforeEnd
    4. afterEnd
2. 对象的方式 appendChild()

```html
<body>
<input type="button" onclick="AddEle1()" value="+"/>
<input type="button" onclick="AddEle2()" value="+"/>
<div id="i1">
    <p><input type="text"/></p>
</div>
<script>
    function AddEle1() {
        var ele = "<p><input type='text'/></p>";
        document.getElementById('i1').insertAdjacentHTML("beforeEnd", ele);
    }
    function AddEle2() {
        var ele = document.createElement('input');
        ele.setAttribute('type','text');
        ele.style.color = 'pink';
        var p = document.createElement('p');
        p.appendChild(ele);
        document.getElementById('i1').appendChild(p);
    }
</script>
</body>
```

### 提交表单
任何标签都可以提交表单
```html
<body>
<form id="f1" action="http://www.baidu.com">
    <input type="text"/>
    <input type="submit"/>

    <a onclick="submitForm();">提交</a>
</form>
<script>
    function submitForm() {
        document.getElementById('f1').submit();
    }
</script>
</body>
```

### 终端打印 弹窗 刷新 获取URL 定时器
```javascript
console.log('content');   //像浏览器Console终端输出
alert("context");    //窗口弹窗
var info = confirm("content");    //窗口弹窗、确定(info=true)取消(info=false)
location.href    //获取当前url 或者设置 location.href = "http://www.a.com/"
location.href = location.href or location.reload()    //页面刷新
var obj = setInterval(function(){},3000)    //定时器
clearInterval(obj);    //清除定时器
var obj = setTimeout(function(){},3000)；    //定时器3秒钟之后只执行一次
clearTimeout(obj);    //清除定时器
```

### 模态对话框示例
```html
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="../static/css/define.css"/>
    <script type="text/javascript" src="../static/js/T1.js"></script>
</head>
<body>
<div>
    <p><input onclick="showModel()" type="button" value="增加"/></p>
    <table class="pg_table_server">
        <tr>
            <th>主机名</th>
            <th>端口号</th>
        </tr>
        <tr>
            <td>1.1.1.2</td>
            <td>91</td>
        </tr>
            <td>1.1.1.3</td>
            <td>92</td>
        <tr>
            <td>1.1.1.4</td>
            <td>93</td>
        </tr>
        <tr>
            <td>1.1.1.5</td>
            <td>94</td>
        </tr>
    </table>
</div>
<!--遮罩层-->
<div id="pop" class="pg_shade show_hide"></div>

<!--弹出框-->
<div id="hid" class="pg_popup show_hide">
    <div class="popup_input">
        <p><span>主机名：</span><input type="text"/></p>
        <p><span>端口号：</span><input type="text"/></p>
        <p><input onclick="hideModel()" type="button" value="取消"/><input type="button" value="确定"/></p>
    </div>
</div>
</body>
```
```
//css
.pg_table_server {
    background-color: #dad2d2;
    text-align: center
}

.pg_shade {
    background-color: pink;
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    opacity: 0.6;
    z-index: 9;
}

.pg_popup {
    background-color: #1acba8;
    height: 300px;
    width: 500px;
    position: absolute;
    left: 50%;
    z-index: 10;
    margin-left: -250px;
}

.show_hide {
    display: none;
}

.pg_popup .popup_input {
    text-align: center;
    margin-top: 100px;
}
```
```javascript
//js
function showModel() {
    document.getElementById('pop').classList.remove('show_hide');
    document.getElementById('hid').classList.remove('show_hide');
}
function hideModel() {
    document.getElementById('hid').classList.add('show_hide');
    document.getElementById('pop').classList.add('show_hide');
}
```

### 全选 反选 取消 checked
```html
<body>
<div>
    <p>
        <input onclick="SelectAll()" type="button" value="全选"/>
        <input onclick="ReverseAll()" type="button" value="反选"/>
        <input onclick="CancelAll()" type="button" value="取消"/>
    </p>
</div>
<div>
    <table>
        <thead>
            <tr>
                <th>选择</th>
                <th>主机名</th>
                <th>端口号</th>
            </tr>
        </thead>
        <tbody  id="table_select">
            <tr>
                <td>
                    <input type="checkbox"/>
                </td>
                <td>1.1.1.2</td>
                <td>91</td>
            </tr>
                <td>
                    <input type="checkbox"/>
                </td>
                <td>1.1.1.3</td>
                <td>92</td>
            <tr>
                <td>
                    <input type="checkbox"/>
                </td>
                <td>1.1.1.4</td>
                <td>93</td>
            </tr>
            <tr>
                <td>
                    <input type="checkbox"/>
                </td>
                <td>1.1.1.5</td>
                <td>94</td>
            </tr>
                <td>
                    <input type="checkbox"/>
                </td>
                <td>1.1.1.6</td>
                <td>95</td>
            </tr>
        </tbody>
    </table>
</div>
</body>
```
```javascript
function SelectAll() {
    var tab_result = document.getElementById('table_select');
    var tr_list = tab_result.children;
    for(var i=0; i<tr_list.length; i++){
        var current_tr = tr_list[i];
        var checkbox = current_tr.children[0].children[0];
        checkbox.checked = true;
    }
}

function ReverseAll() {
    var tab_result = document.getElementById('table_select');
    var tr_list = tab_result.children;
    for(var i=0; i<tr_list.length; i++){
        var current_tr = tr_list[i];
        var checkbox = current_tr.children[0].children[0];
        if(checkbox.checked == true){
            checkbox.checked = false;
        }else {
            checkbox.checked = true;
        }
    }
}

function CancelAll() {
    var tab_result = document.getElementById('table_select');
    var tr_list = tab_result.children;
    for(var i=0; i<tr_list.length; i++){
        var current_tr = tr_list[i];
        var checkbox = current_tr.children[0].children[0];
        checkbox.checked = false;
    }
}
```

### 菜单栏弹出、隐藏
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="../static/css/define.css"/>
    <script type="text/javascript" src="../static/js/T1.js"></script>
</head>
<body>
<div style="height: 50px;"></div>
<div style="width: 100px;">
    <div class="item">
        <div id="i1" onclick="ShowHide('i1')" class="header">菜单1</div>
        <div class="content">
            <div>内容</div>
            <div>内容</div>
            <div>内容</div>
        </div>
    </div>
    <div class="item">
        <div id="i2" onclick="ShowHide('i2')" class="header">菜单2</div>
        <div class="content hide">
            <div>内容</div>
            <div>内容</div>
            <div>内容</div>
        </div>
    </div>
    <div class="item">
        <div id="i3" onclick="ShowHide('i3')" class="header">菜单3</div>
        <div class="content hide">
            <div>内容</div>
            <div>内容</div>
            <div>内容</div>
        </div>
    </div>
    <div class="item">
        <div id="i4" onclick="ShowHide('i4')" class="header">菜单4</div>
        <div class="content hide">
            <div>内容</div>
            <div>内容</div>
            <div>内容</div>
        </div>
    </div>
</div>
</body>
</html>
```
```
//CSS
.header {
    background-color: dodgerblue;
    height: 30px;
    color: white;
    line-height: 30px;
    text-align: center;
}

.header:hover{
    background-color: red;
    color: black;
    font-weight: 600;
}

.hide {
    display: none;
}

.content {
    text-align: center;
    background-color: #e5d109;
}
```

```javascript
//JS
function ShowHide(menu_id) {
    var current_header = document.getElementById(menu_id);
    var item_list = current_header.parentElement.parentElement.children;
    for(var i=0;i<item_list.length;i++){
        var current_item = item_list[i];
        var current_menu = current_item.children[1];
        //console.log(current_menu);
        current_menu.classList.add('hide');
    }
    current_header.nextElementSibling.classList.remove('hide');
}
```

## 常用事件
- onclick
- onblur
- onfocus
- onmouseover
- onmouseout

### 绑定事件的两种方式
1. 直接标签绑定
2. 先获取Dom对象，然后在进行绑定

### 行为 样式 结构相分离的页面示例
js css html分离
```html
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
    #i1 {
        background-color: green;
        height: 300px;
        width: 400px;
        text-align: center;
        line-height: 300px;
    }
</style>
</head>
<body>
<div id="i1">
    测试
</div>
<script>
    var myDiv = document.getElementById('i1');
    myDiv.onclick = function () {
        console.log("test");
    }
</script>
</body>
```

### dom2 表格循环变色 示例
```html
<body>
<table style="width: 300px;text-align: center;">
    <tr><td>1</td><td>2</td><td>3</td></tr>
    <tr><td>1</td><td>2</td><td>3</td></tr>
    <tr><td>1</td><td>2</td><td>3</td></tr>
</table>
<script>
    var myTrs = document.getElementsByTagName('tr');
    var len = myTrs.length;
    for(var i=0;i<len;i++){
        myTrs[i].onmouseover = function () {
            //this 代指当前触发事件的标签
            this.style.backgroundColor = 'green';
        }

        myTrs[i].onmouseout = function () {
            this.style.backgroundColor = '';
        }
    }
</script>
</body>
```

## JS词法分析
```javascript
<script>
    function t1(age){
      console.log(age);
      var age = 27;
      console.log(age);
      function age(){}
      console.log(age);
    }
t1(3);
</script>

active object ---> AO
1. 形式参数
2. 局部变量
3. 函数声明表达式

1. 形式参数
AO.age = undefined
AO.age = 3
2. 局部变量
AO.age = undefined
3. 函数声明表达式
4. AO.age = function()
```

# JS序列化及转义
```javascript
//序列化
JSON.stringify()    将对象转换为字符串
JSON.parse()    将字符串转换为对象类型

l1 = [11,22,33,44,55]
var s1 = JSON.stringify(l1);
var l2 = JSON.parse(s1);

//转义 通过JS在客户端保存url到cookie时、需要对数据做转义才能允许保存
decodeURI( )                   URl中未转义的字符
decodeURIComponent( )          URI组件中的未转义字符
encodeURI( )                   URI中的转义字符
encodeURIComponent( )          转义URI组件中的字符
escape( )                      对字符串转义
unescape( )                    给转义字符串解码
URIError                       由URl的编码和解码方法抛出
```

# eval
```javascript
eval(表达式/代码块)
```
```python
eval(表达式)
exec(代码块)
```

# 时间
```javascript
var d = new Date()
d.get    获取相关时间
d.set    设置相关时间
```

# 作用域
- 其他语言：以代码块作为作用域
- python:：以函数作为作用域
- JS：
    - 以函数作为作用域(let关键字除外)
    - 函数的作用域在函数未被调用之前就已经创建
    - 函数的作用域存在作用域链，并且也是在被调用之前创建(嵌套函数--->作用域链)

      ```javascript
      xo = "aaaa";
      function func() {
          var xo = "bbbb";
          function inner() {
      		var xo = "cccc";
              console.log(xo);
          }
          return inner;
      }

      var ret = func()
      ret()
      ```
    - 函数内局部变量 声明提前

      ```javascript
      //实例一
      function func(){
  	     console.log(xxoo);
      }
      func();

      Uncaught ReferenceError: xxoo is not defined
      at func (<anonymous>:2:14)
      at <anonymous>:5:1

      //实例二
      function func(){
    	   console.log(xxoo);  //生成作用域链的同时，找到内部所有的局部变量、var xxoo; 但是没有先赋值、所以执行结果为undefined;
    	   var xxoo = "111";
      }
      func();

      undefined
      ```

# JS面向对象
```javascript
function foo(){
    var xo = "Julia"
}
foo()


function foo(n){
    this.name = n  //this 类似于python类的 self
}
var obj = new foo("Julia"); //创建对象时使用 new 函数()即创建了对象

//原型
function Foo(n){
    this.name = n;
}
# Foo的原型
Foo.prototype = {
    'sayName': function(){
        console.log(this.name)
    }
}

obj1 = new Foo(''we)
obj1.sayName
```
