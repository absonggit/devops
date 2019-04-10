# JS 实现
## JS 使用
- HTML中的脚本必须位于`<script>`与`</script>`标签之间。
- 脚本可被放置在HTML页面的`<body>`和`</body>`部分中。

## JS 输出
### 操作HTML元素
如需从JavaScript访问某个HTML元素，可以使用document.getElementById(id)方法，前提使用"id"属性来标识HTML元素

1. 通过指定的id来访问HTML元素，并改变其内容
```
<!DOCTYPE html>
<html>
<body>
<h1>我的第一张网页</h1>
<p id="demo">我的第一个段落</p>
<script>
document.getElementById("demo").innerHTML="我的第一段 JavaScript";
</script>
</body>
</html>
```

2. 直接写到文档输出
```
<!DOCTYPE html>
<html>
<body>
<h1>我的第一张网页</h1>
<script>
document.write("<p>我的第一段 JavaScript</p>");
</script>
</body>
</html>
```
> document.write()仅仅向文档输出写内容。

> 如果文档已完成加载后执行document.write，整个HTML页面将被覆盖。

## JS 语句
- 分号 每条语句的结尾用于分割JS语句，结束语句的分号为可选
- 代码执行顺序 按照编写顺序逐行执行每条语句
- 代码块 以左花括号开始，右花括号结束，块的作用是使语句一起执行，JS函数式典型的代码块
- 大小写 JS对大小写是敏感的
- 空格 JS会忽略多余空格、所以可以添加空格来提高可读性
- 代码拆分 反斜杠用来对代码进行换行

## JS 注释
- 单行注释用双斜线 "//"
- 多行注释 以斜线星号开始，星号斜线结束
```
document.write("TEST") //注释内容
// document.write("TEST")
/*
注释
代码块
*/
```

## JS 变量
### JS 声明变量
- 变量必须以字母开头
- 变量也能以$和_开头(不推荐)
- 变量名称对大小写敏感
```
<script>
    var x = 10;
    var x;
    var y = 21;
    var z = x + y;
    var v; //声明一个空变量

    document.write(x + "</br>");
    document.write(y + "</br>");
    document.write("<body>x+y=</body>"+ z);
</script>

// 如果重新声明变量 没有赋值、变量没有影响
```
### 一条语句 多个变量
```
var name="w", age=18, job="CEO";

var name="w",
age=18,
job="CEO";
```
## JS 数据类型
- 字符串
- 数字
- 布尔 true/false
- 数组
```
var cars=new Array();
cars[0]="Audi";
cars[1]="BMW";
cars[2]="Volvo";

var cars=new Array("Audi","BMW","Volvo")

var cars=["Audi","BMW","Volvo"]
# 三种方法均可
```
- 对象
    - 对象由花括号分隔。在括号内部，对象的属性以名称和值对的形式(name: value)来定义。属性由逗号分隔
    - `var person={firstname:"bill", lastname:"Gates", id:5566};`
    - 对象属性有两种寻址方式：
        - name=person.lastname;
        - name=person["lastname"]

- Undefined 和 Null
    - undefined这个值表示变量不含有值
    - 可以通过将变量的值设置为null来清空变量

- 声明变量类型
    - 声明新变量时，可以使用关键词"new"来声明其类型
    - JS变量均为对象，当声明一个变量时，就创建了一个新的对象
```
var carname=new String;
var x=      new Number;
var y=      new Boolean;
var cars=   new Array;
var person= new Object;
```

## JS 对象
- JS中的所有事物都是对象：字符串、数字、数组、日期等等
- 在JS中，对象是拥有属性和方法的

## 属性和方法
- 属性是与对象相关的值
- 方法是能够在对象上执行的动作

## 创建JS对象
```
person = new Object();
person.firstname="Bill";
person.lastname="Gates";
person.age=56;
person.eyecolor="blue";

# 创建person对象、并添加了四个属性
```

# JS 函数
函数是由事件驱动的或者当它被调用时执行的可重复使用的代码块

## JS函数语法
函数就是包裹在花括号中的代码块，前面使用关键词function:
```
function functionName {
  CodeBlock
}
```

## 调用带参数的函数
- 在调用函数时，可以向其传递值，这些值被称为参数。 `myFunction(argument1,argument2)`
- 在声明函数时，把参数作为变量声明 function myFunction(var1,var2)

## 带有返回值的函数
- 有时，我们会希望函数值返回调用它的地方，通过return实现，使用return语句时，函数会停止执行并返回指定值
- 如果仅希望退出函数，也可使用return语句。返回值是可选的。
```
function myFunction() {
  var x=5;
  return x;
}
```

## 局部JS变量
- 在函数内部声明的变量(使用var)是局部变量，所以只能在函数内部访问；
- 可以在不同函数中使用名称相同的局部变量；
- 只要函数运行完毕，本地变量就会被删除

## 全局JS变量
在函数外声明的变量时全局变量，网页上所有的脚本和函数都可以访问它

## JS变量的生存期
- JS变量的生命期从它们被声明的时间开始
- 局部变量会在函数运行以后被删除
- 全局变量会在页面关闭后被删除

## 向未声明的JS变量来分配值
如果您把值赋给尚未声明的变量，该变量将被自动作为全局变量声明

# JS运算符
## JS算数运算符
算数运算符用于执行变量与/或值之间的算数运算 y=5
| 运算符 | 描述 | 例子	| 结果 |
| :----- | :-- | :--- | :-- |
| +	| 加	| x=y+2	| x=7 |
| -	| 减	| x=y-2	| x=3 |
| *	| 乘	| x=y*2	| x=10 |
| /	| 除	| x=y/2	| x=2.5 |
| %	| 求余数 (保留整数)	| x=y%2	| x=1 |
| ++	| 累加	| x=++y	| x=6 |
| --	| 递减	| x=--y	| x=4 |

## JS赋值运算符
赋值运算符用于给JS变量赋值 x=10 y=5
| 运算符	| 例子	| 等价于	| 结果 |
| :---- | :---- | :---- | :---- |
| =	| x=y	 	| | x=5 |
| +=	| x+=y	| x=x+y	| x=15 |
| -=	| x-=y	| x=x-y	| x=5 |
| *=	| x*=y	| x=x*y	| x=50 |
| /=	| x/=y	| x=x/y	| x=2 |
| %=	| x%=y	| x=x%y	| x=0 |

## 用于字符串的运算符 +
- + 运算符用于把文本值或字符串变量加起来
- 如果数字与字符串相加，结果会变成字符串

## 比较运算符
比较运算符在逻辑语句中使用，以测定变量或值是否相等 x=5
| 运算符	| 描述	| 例子 |
| :---- | :---- | :--- |
| ==	| 等于	| x==8 为 false |
| !=	| 不等于	| x!=8 为 true |
| ===	| 全等（值和类型）	| x===5 为 true；x==="5" 为 false |
| >	| 大于	| x>8 为 false |
| <	| 小于	| x<8 为 true |
| >=	| 大于或等于	| x>=8 为 false |
| <=	| 小于或等于	| x<=8 为 true |

## 逻辑运算符
逻辑运算符用于测定变量或值之间的逻辑 &&(and) ||(or) ！(not)

## 条件运算符
- 语法 variablename=(condition)?value1:value2
- 例子
```
greeting=(visitor=="PRES")?"Dear President ":"Dear";
# 如果变量visitor中的值是"PRES"，则向变量greeting赋值"Dear President"，否则赋值"Dear"
```

# JS 条件语句
## 判断语句
### if语句
- 只有当指定条件为true时，该语句才会执行代码
- 语法：
```
if (条件) {
  只有当条件为true时执行的代码
}
```

### if...else语句
- 只有当指定条件为true时，该语句才会执行代码，在条件为false是执行其他代码
- 语法:
```
if (条件) {
  当条件为true时执行的代码
}
else {
  当条件不为true时执行的代码
}
```
- 例子:
```
function myFunctionFive() {
    var x;
    var time = new Date().getHours();
    if (time < 10) {
        x = "Good day!";
    }
    else {
        x = "Good morning!";
    }
    document.getElementById("demo").innerHTML = x;
    document.getElementById("times").innerHTML = time;
}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>链接</title>
    <script src="../static/js/T1.js"></script>
</head>
<body>
    <p>如果时间早于20:00，会获得问候</p>
    <button onclick="myFunctionFive()">点击这里</button>
    <p id="demo"></p>
    <p id="times"></p>
</body>
</html>
```

### if...else if...else语句
- 使用 if....else if...else 语句来选择多个代码块之一来执行。
- 语法:
```
if (条件1) {
  当条件1为true时执行的代码
}
else if (条件2) {
  当条件2为true时执行的代码
}
else {
  当条件1和条件2都不为true时执行的代码
}
```

## switch
- switch语句用来选择要执行的多个代码块之一
- 语法：
```
switch (n) {
  case 1:
    执行代码块 1
    break;
  case 2:
    执行代码块 2
    break;
  default:
    n 与 case 1 和 case 2 不同时执行的代码
}

# 工作原理：首先设置表达式n（通常是一个变量）。随后表达式的值会与结构中的每个case值做比较，如果存在匹配，则与该case关联的代码块会被执行，请使用break来阻止代码自动地向下一个case运行。如果都不匹配则执行default相关的代码块。
```
- 例子:
```
function myFunctionSix() {
    var x;
    var d=new Date().getDate();
    switch (d) {
        case 1:
            x = "Today it's Monday.";
            break;
        case 2:
            x = "Today it's Tuesday.";
            break;
        case 3:
            x = "Today it's Wednesday.";
            break;
        default:
            x = "NO 123!"
    }
    document.getElementById("demo").innerHTML=x;
    document.getElementById("week").innerHTML=d;
}
```
## 循环语句
### for循环语句
#### JS支持不同类型的循环
    - for 循环代码块一定的次数
    - for/in 循环遍历对象的属性
    - while 当指定的条件为true时循环指定的代码块
    - do/while 同样指定条件为true时循环指定的代码块

#### for循环语法
```
for (语句1; 语句2; 语句3) {
  执行的代码块
}

# 语句1 在循环(代码块)开始前执行
# 语句2 定义运行循环(代码块)的条件
# 语句3 再循环(代码块)已被执行之后执行
```

#### for循环例子
```
cars
var i=2,len=cars.length;
for (; i<len; i++) {
  document.write(cars[i] + "</br>");
}

# 语句1如果已经定义，可以省略，同样语句3如果在循环内部有相应代码，也可以省略
```

#### for/in循环
JS for/in语句循环遍历对象的属性
```
var person={fname:"John",lname:"Doe",age:25};

for (x in person) {
    txt=txt + person[x];
  }
```
### while语句
只要指定条件为true，循环就可以一直执行代码

#### while循环
While 循环会在指定条件为真时循环执行代码块。

- 语法：
```
while (条件) {
  代码块
}
```

- 实例
```
while (i<5) {
  x = x + "The number is " + i + "</br>";
  i++;
}
```

#### do/while循环
do/while 循环是 while 循环的变体。该循环会执行一次代码块，在检查条件是否为真之前，然后如果条件为真的话，就会重复这个循环。

- 语法:
```
do {
  代码块
}
while （条件);
```

- 实例:
```
do {
  x = x + "The number is " + i + "</br>";
  i++;
}
while (i<5);
```

## break和continue语句
- break 用于跳出循环
- continue 中断循环中的迭代

## JS 测试和捕捉错误
- try 语句测试代码块的错误
- catch 语句处理错误 try catch成对出现
- throw 语句创建自定义错误

- 语法
```
try {
  //这里运行代码 throw exception
}
catch(err) {
  //在这里处理错误
}
```

- 实例1
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>链接</title>
    <script src="../static/js/T1.js"></script>
    <script>
        var txt="";
        function message() {
            try {
                addlert("Welcome guest!");
            }
            catch(err) {
                txt="There was an error on this page.\n\n";
                txt+="Error description: " + err.message + "\n\n";
                txt+="Click ok to continue.";
                alert(txt);
            }
        }
    </script>
</head>
<body>
<input type="button" value="View message" onclick="message()">
</body>
</html>
```

- 实例2
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>链接</title>
</head>
<body>
<script>
    function myFunction() {
        try {
            var x = document.getElementById("demo").value;
            if (x == "") throw "值为空";
            if (isNaN(x)) throw "不是数字";
            if (x > 10) throw "太大";
            if (x < 5) throw "太小";
            if (x > 5 && x < 10) throw "完美！"
        }
        catch(err) {
            var y = document.getElementById("mess");
            y.innerHTML = "错误：" + err;
        }
    }
</script>

<h1>JavaScript TEST</h1>
<p>请输入5到10之间的数字：</p>
<input id="demo" type="text" />
<button type="button" onclick="myFunction()">测试输入值</button>
<p id="mess"></p>
</body>
</html>
```

## JS 表单验证
JS可用来在数据被送往服务器前对HTML表单中的这些输入数据进行验证
