# CSS中的(. #)区别
```html
body{
       font-family: Arial,sans-serif;
       color: #333333;
       line-height: 1.166;        
       margin: 0px;
       padding: 0px;
}

#masthead{
       margin: 0;
       padding: 10px 0px;
       border-bottom: 1px solid #cccccc;
       width: 100%;
}

.feature img{
       float: left;
       padding: 0px 10px 0px 0px;
       margin: 0 5px 5px 0;
}  
```
- #对应id
- .对应class
- 不加对应html 标签

## Class与ID的区别  
- 一个Class是用来根据用户定义的标准对一个或多个元素进行定义的。打个比较恰当的比方就是剧本：一个Class可以定义剧本中每个人物的故事线，你可以通过CSS，Javascript等来使用这个类。因此你可以在一个页面上使用class="Frodo" ，class="Gandalf"，class="Aragorn"来区分不同的故事线。还有一点非常重要的是你可以在一个文档中使用任意次数的Class。  
　　  
- 至于ID，通常用于定义页面上一个仅出现一次的标记。在对页面排版进行结构化布局时（比如说通常一个页面都是由一个页眉，一个报头，一个内容区域和一个页脚等组成），一般使用ID比较理想，因为一个ID在一个文档中只能被使用一次。而这些元素在同一页面中很少会出现大于一次的情况。  
　　  
- 归纳成一句话就是：Class可以反复使用而ID在一个页面中仅能被使用一次。有可能在很大部分浏览器中反复使用同一个ID不会出现问题，但在标准上这绝对是错误的使用，而且很可能导致某些浏览器的显示问题。
　　  
- 在实际应用的时候，Class可能对文字的排版等比较有用，而ID则对宏观布局和设计放置各种元素较有用。  
　　  
## Margin与Padding的区别  
- 两者都是代替表格最重要的作用->分割块的好方法
- 区别在于Margin是不同的Tag间互相隔离的距离而Padding是同一元素中不同内容分割使用，这在表格中最看得清楚。尤其是当对一个区域加载了背景样式之后，Padding下的内容背景色会发生改变，而Margin则不会有所改变
