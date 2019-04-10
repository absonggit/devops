# JSON简介
## 什么是json?
JSON使用JS语法来描述数据对象，但是JSON仍然独立于语言和平台，JSON解析器和JSON库支持许多不同的编程语言
- JSON 指的是JS对象表示法
- JSON 是轻量级的文本数据交换格式
- JSON 独立于语言
- JSON 具有自我描述性 更易理解

## 和XML的区别
- 类似XML
    - JSON 是纯文本
    - JSON 具有"自我描述性"(人类可读)
    - JSON 具有层级结构(值中存在值)
    - JSON 可通过JS进行解析
    - JSON 数据可使用AJAX进行传输

- 相比XML的不同之处
    - 没有结束标签
    - 更短
    - 读写的速度更快
    - 能够使用内建的JS eval()方法进行解析
    - 使用数组
    - 不使用保留字

## 为什么使用JSON?
- 使用XML
    - 读取XML文档
    - 使用XML DOM来循环遍历文档
    - 读取值并存储在变量中

- 使用JSON
    - 读取JSON字符串
    - 用eval()处理JSON字符串

# JSON语法
JSON语法是JS语法的子集

## JSON语法规则
- 数据在名称/值对中
- 数据由逗号分隔
- 花括号保存对象
- 方括号保存数组

- JSON 名称/值对
```
"firstName" : "John"
```

- JSON值可以是
    - 数字(整数或浮点型)
    - 字符串(在双括号中)
    - 逻辑值(true或false)
    - 数组(在方括号中)
    - 对象(在花括号中)
    - null

# JSON使用
## 把JSON文本转换为JS对象
JSON最常见的用法之一、是从WEB服务器上读取JSON数据(作为文本或作为HttpRequest)，将JSON数据转换为JS对象，看然后在网页中使用该数据

```
var txt = '{ "employees" : [' +
'{ "firstName":"Bill" , "lastName":"Gates" },' +
'{ "firstName":"George" , "lastName":"Bush" },' +
'{ "firstName":"Thomas" , "lastName":"Carter" } ]}';

var obj = eval("(" + txt + ")");

# eval()函数使用的是JS编译器，可解析JSON文本，然后生成JS对象，必须把文本包围在括号中，这样才能避免语法错误
```

## JSON解析器
**eval()函数可编译并执行任何JS代码、这样就隐藏了一个潜在的安全问题**，使用JS解析器将JSON转换为JS对象是更安全的做法，JS解析器只能识别JSON文本，而不会编译脚本
```
<body>
<h2>通过 JSON 字符串来创建对象</h3>
<p>
First Name: <span id="fname"></span><br />
Last Name: <span id="lname"></span><br />
</p>
<script type="text/javascript">
var txt = '{"employees":[' +
'{"firstName":"Bill","lastName":"Gates" },' +
'{"firstName":"George","lastName":"Bush" },' +
'{"firstName":"Thomas","lastName":"Carter" }]}';

obj = JSON.parse(txt);

document.getElementById("fname").innerHTML=obj.employees[1].firstName
document.getElementById("lname").innerHTML=obj.employees[1].lastName
</script>
</body>
```
