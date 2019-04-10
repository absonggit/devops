# XHTML简介
**XHTML是以XML格式编写的HTML**
## 什么是XHTML？
- XHTML指的是可扩展超文本标记语言
- XHTML与HTML4.01几乎是相同的
- XHTML是更严格更纯净的HTML版本
- XHTML是以XML应用的方式定义的HTML
- XHTML是2001年1月发布的W3C推荐标准
- XHTML得到所有主流浏览器的支持

## XHTML与HTML的区别
### 文档结构
- XHTML DOCTYPE是强制性的
- `<html>`中的XML namespace 属性是强制性的
- `<html>`、`<head>`、`<title>`以及`<body>`也是强制性的

### 元素语法
- XHTML元素必须正确嵌套
- XHTML元素必须始终关闭
- XHTML元素必须小写
- XHTML文档必须有一个根元素

### 属性语法
- XHTML属性必须使用小写
- XHTML属性值必须用引号包围
- XHTML属性最小化也是禁止的

### !DOCTYPE .... 是强制性的
XHTML文档必须进行XHTML文档类型声明、`<html>`、`<head>`、`<title>`、`<body>`元素也必须存在，并且必须使用`<html>`中的xmlns属性为文档规定xml命名空间
```XHTML
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Title of document</title>
</head>
<body>
......
</body>
</html>
```

### 如何从 HTML 转换到 XHTML
- 向每张页面的第一行添加 XHTML <!DOCTYPE>
- 向每张页面的 html 元素添加 xmlns 属性
- 把所有元素名改为小写
- 关闭所有空元素
- 把所有属性名改为小写
- 为所有属性值加引号
