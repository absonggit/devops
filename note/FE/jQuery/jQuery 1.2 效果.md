# jQuery 隐藏/显示
## 隐藏/显示HTML元素 hide() 和 show()
### 语法
```
$(selectior).hide(speed,callback);
$(selectior).show(speed,callback);

# 可选的speed参数规定隐藏/显示的进度，可以取值:"slow","fast"或毫秒
# 可选的callback参数是隐藏或显示完成后所执行的函数名称
```

### 实例
```
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <script src="../static/js/jquery-3.2.1.slim.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#hide").click(function() {
                $("p").hide();
            });
            $("#show").click(function(){
                $("p").show();
            });
        });
    </script>
</head>
</body>
<p id="p1">如果点击"隐藏按钮"，就会隐藏</p>
<button id="hide" type="button">隐藏</button>
<button id="show" type="button">显示</button>
</body>
</html>
```

## 切换hide()和show()方法
### 语法
`$(selector).toggle(speed,callback)`

### 实例
```
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <script src="../static/js/jquery-3.2.1.slim.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $("button").click(function() {
                $("p").toggle(1000);
            });
        });
    </script>
</head>
</body>
<button type="button">切换</button>
<p id="p1">如果点击"隐藏按钮"，就会隐藏</p>
<p id="p2">如果点击"隐藏按钮"，就会隐藏</p>
<p id="p3">如果点击"隐藏按钮"，就会隐藏</p>
</body>
</html>
```

# jQuery 淡入淡出
## 淡入效果 dadeIn()
语法：`$(selector).fadIn(speed,callback);`
```
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <script src="../static/js/jquery-1.11.3.min.js"></script>
    <script>
        $(document).ready(function(){
            $("button").click(function(){
                $("#div1").fadeIn("fast");
                $("#div2").fadeIn("slow");
                $("#div3").fadeIn(3000);
            });
        });
    </script>
</head>
</body>
<p>演示带有不同参数的fadeIn()方法。</p>
<button>点击这里，使三个矩形淡入</button>
<br><br>
<div id="div1" style="width: 80px;height: 80px;display: none;background-color: red;"></div>
<br>
<div id="div2" style="width: 80px;height: 80px;display: none;background-color: green;"></div>
<br>
<div id="div3" style="width: 80px;height: 80px;display: none;background-color: blue;"></div>
</body>
</html>
```
## 淡出效果 fadeOut()
语法：`$(selector).fadeOut(speed.callback);`
```
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <script src="../static/js/jquery-1.11.3.min.js"></script>
    <script>
        $(document).ready(function(){
            $("button").click(function(){
                $("#div1").fadeOut();
                $("#div2").fadeOut("slow");
                $("#div3").fadeOut(3000);
            });
        });
    </script>
</head>
</body>
<p>演示带有不同参数的fadeIn()方法。</p>
<button>点击这里，使三个矩形淡出</button>
<br><br>
<div id="div1" style="width: 80px;height: 80px;background-color: red;"></div>
<br>
<div id="div2" style="width: 80px;height: 80px;background-color: green;"></div>
<br>
<div id="div3" style="width: 80px;height: 80px;background-color: blue;"></div>
</body>
</html>
```

## 切换效果 fadeToggle()
语法：`$(selector).fadeToggle(speed,callback);`
```
<head>
    <meta charset="utf-8"/>
    <script src="../static/js/jquery-1.11.3.min.js"></script>
    <script>
        $(document).ready(function(){
            $("button").click(function(){
                $("#div1").fadeToggle(3000);
                $("#div2").fadeToggle("slow");
                $("#div3").fadeToggle(3000);
            });
        });
    </script>
</head>
```

## 渐变效果 fadeTo()
语法：`$(selector).fadeTo(speed,opacity,callback);`
```
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <script src="../static/js/jquery-1.11.3.min.js"></script>
    <script>
        $(document).ready(function(){
            $("button").click(function(){
                $("#div1").fadeTo(3000,0.15);
                $("#div2").fadeTo("slow",0.4);
                $("#div3").fadeTo(3000,0.07);
            });
        });
    </script>
</head>
</body>
<p>演示带有不同参数的fadeTo()方法。</p>
<button>点击这里，使三个矩形不透明</button>
<br><br>
<div id="div1" style="width: 80px;height: 80px;background-color: red;"></div>
<br>
<div id="div2" style="width: 80px;height: 80px;background-color: green;"></div>
<br>
<div id="div3" style="width: 80px;height: 80px;background-color: blue;"></div>
</body>
</html>

# speed 必须参数 "slow","fast"或者毫秒
# apacity参数为淡入淡出效果设置不透明度(值介于0和1之间)
```

# jQuery 滑动
## 向下滑动元素 slideDown()
语法：`$(selector).slideDown(speed,callback);`
```
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <script src="../static/jQuery/jquery-3.2.1.js"></script>
    <script>
        $(document).ready(function(){
            $(".flip").click(function(){
                $(".panel").slideDown(3000);
            });
        });
    </script>

    <style type="text/css">
        div.panel,p.flip {
            margin: 0px;
            padding: 10px;
            text-align: center;
            background: #E5EECC;
            border: solid 1px #C3C3C3;
        }
        div.panel {
            height: 120px;
            display: none;
        }
    </style>
</head>
</body>
<div class="panel">
    <p>W3School - 领先的 Web 技术教程站点</p>
    <p>在 W3School，你可以找到你所需要的所有网站建设教程。</p>
</div>
<p class="flip">请点击这里</p>
</body>
</html>
```

## 向上滑动元素 slideUp()
语法：`$(selector).slideUp(speed,callback);`

## 滑动上下切换 slideToggle()
语法：`$(selector).slideToggle(speed,callback);`

# jQuery 动画
## 动画 animate()
语法：`$(selector).animate({params},speed,callback)`
- params参数定义形成动画的CSS属性
- speed参数规定效果的时长
- callback参数是动画完成后所执行的函数名称
> 默认，所有HTML元素都有一个静态位置，且无法移动。所有要对位置进行操作，需要把position的属性设置为relative、fixed或absolute。

```
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <script src="../static/jQuery/jquery-3.2.1.js"></script>
    <script>
        $(document).ready(function(){
                $("button").click(function(){
                    $("div").animate({
                        left:'250px',
                        opacity:'0.5',
                        height:'150px',
                        width:'150px',
                    });
            });
        });
    </script>
</head>
</body>
<p><button>开始动画</button></p>
<div style="background: #98BF21;height: 100px;width: 100px;position: absolute;"></div>
</body>
</html>
```
## 操作多个属性 animate()
当使用animate()时，必须使用Camel标记法书写所有的属性名，比如paddingLeft而不是padding-left。同事色彩动画并不包括在核心jQuery库中，如果需要生成颜色动画，必须从 jQuery.com下载 Color Animations插件。

## 使用相对值
定义相对值(改值相对于元素的当前值)。需要在值的前面加上 =+ 或 -+
```
$("button").click(function(){
  $("div").animate({
    left:'250px',
    height:'+=150px',
    width:'+=150px'
  });
});
```

## 使用预定义的值
把属性的动画值设置为"hide"、"show"或"toggle"
```
$("button").click(function(){
  $("div").animate({
    height:'toggle'
  });
});
```

## 使用队列功能
默认地，jQuery提供对动画的队列功能。这以为这可以创建多个animate()，jQuery会创建包含这些方法调用的"内部"队列，然后逐一运行这些animate调用。
```
示例1：

<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <script src="../static/jQuery/jquery-3.2.1.js"
            integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
            crossorigin="anonymous"></script>
    <script>
        $(document).ready(function(){
                $("button").click(function(){
                var div=$("div");
                    div.animate({height:'300px',opacity:'0.4'},"slow");
                    div.animate({width:'300px',opacity:'0.8'},"slow");
                    div.animate({height:'100px',opacity:'0.4'},"slow");
                    div.animate({width:'100px',opacity:'0.8'},"slow");
            });
        });
    </script>
</head>
</body>
<p><button>开始动画</button></p>
<div style="background: purple;height: 100px;width: 100px;position: absolute;"></div>
</body>
</html>
```

# jQuery stop()
stop()方法用于停止动画或效果，在他们完成之前。

## 语法
`$(selector).stop(stopAll,goToEnd);`
- stopAll参数规定是否应该清除动画队列，默认是false，即停止活动的动画，允许任何排入队列的动画向后执行。
- goToEnd参数规定是否立即完成当前动画。默认是false
- stop()默认会清楚在被选元素上指定的当前动画

## 示例
```
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <script src="../static/jQuery/jquery-3.2.1.js"></script>
    <script>
        $(document).ready(function(){
            $("#flip").click(function(){
                $("#panel").slideToggle(5000);
            });
            $("#stop").click(function () {
                $("#panel").stop();
            })
        });
    </script>

    <style type="text/css">
        #panel,#flip {
            padding: 5px;
            text-align: center;
            background-color: #E5EECC;
            border: solid 1px #C3C3C3;
        }
        #panel{
            padding: 400px;
            display: none;
        }
    </style>
</head>
</body>

<button id="stop">停止滑动</button>
<div id="flip">滑动面板</div>
<div id="panel">Hello Word!</div>

</body>
</html>
```

# jQuery Callback()
由于JS语句是逐一执行的，动画之后的语句可能产生错误或页面冲突，为了避免这个情况，可以以参数的形式添加callback参数。

## 语法
```
$(selector).hide(speed,callback)

# callback蚕食是一个在hide操作完成后被执行的函数
```

# jQuery Chaining()
通过jQuery，可以把动作/方法链接起来。Chaining允许我们在一条语句中允许多个jQuery方法(在相同的元素上)

- 示例1
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="../static/jquery/jquery-3.2.1.js"></script>
    <script>
        $(document).ready(function(){
            $("button").click(function(){
                $('#p1').css("color","red")
                        .slideUp(2000)
                        .slideDown(2000);
            });
        });
    </script>
</head>
<body>
<p id="p1">jQuery效果！</p>
<button>点击这里</button>
</body>
</html>

# jQuery 会抛掉多余的空格，并按照一行长代码来执行上面的代码行。
```
