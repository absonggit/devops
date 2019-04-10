# 用于序列化的两个模块 json pickle
- json，用于字符串 和 python数据类型间进行转换
    - Json模块提供了四个功能：dumps、dump、loads、load
- pickle，用于python特有的类型 和 python的数据类型间进行转换
    - pickle模块提供了四个功能：dumps、dump、loads、load

```
import json

# json.dumps 将数据通过特殊的形式转换为所有程序语言都识别的字符串
j_str = json.dumps(data)
print(j_str)

# json.dump 将数据通过特殊的形式转换为所有语言都识别的字符串，并写入文件
with open("file", w) as f:
  f.dump(data, f)
```

```
import pickle

data = {'k1': 123, 'k2': 'hello'}

# pickle.dumps 将数据通过特殊的形式转换为只有python语言识别的字符串
p_str = pickle.dumps(date)
print(p_str)

# pickle.dump 将数据通过特殊的形式转换为只有Python语言识别的字符串，并写入文件
with open("file", w) as f:
  pickle.dump(data, f)
```

# shelve 模块
shelve模块是一个简单的k,v将内存数据通过文件持久化的模块，可以持久化任何pickle可支持的python数据格式
```
import shelve

d = shelve.open("file") #打开一个文件

name = ["alex", "rain", "test"]
d["test"] = name #持久化列表或者字典
d.close()
```

# xml 模块
xml是实现不同语言或程序之间进行数据交换的协议，跟json差不多，但json使用起来更简单
- test.xml
```xml
<?xml version="1.0"?>
<data>
    <country name="Liechtenstein">
        <rank updated="yes">2</rank>
        <year>2008</year>
        <gdppc>141100</gdppc>
        <neighbor name="Austria" direction="E"/>
        <neighbor name="Switzerland" direction="W"/>
    </country>
    <country name="Singapore">
        <rank updated="yes">5</rank>
        <year>2011</year>
        <gdppc>59900</gdppc>
        <neighbor name="Malaysia" direction="N"/>
    </country>
    <country name="Panama">
        <rank updated="yes">69</rank>
        <year>2011</year>
        <gdppc>13600</gdppc>
        <neighbor name="Costa Rica" direction="W"/>
        <neighbor name="Colombia" direction="E"/>
    </country>
</data>
```

- xml协议在每个语言都是支持的，py中操作xml示例
```python
import xml.etree.ElementTree as ET
tree = ET.parse("test.xml")
root = tree.getroot()
print(root.tag)

# 遍历xml文档
for child in root:
    print(child.tag, child.attrib)
    for i in child:
        print(i.tag, i.text, i.attrib)

# 只遍历year节点
for node in root.iter('year'):
    print(node.tag, node.text)

# 修改
for node in root.iter('year'):
    new_year = int(node.text) + 1
    node.text = str(new_year)  #修改内容
    node.set("updated", "year") #增加一个新的属性
tree.write("test.xml")

# 删除一个node
for country in root.findall('country'):
    rank = int(country,find('rank').text)
    if rank > 50:
        root.remove(country)
tree.write("new_test.xml")

# 新建xml
import xml.etree.ElementTree as ET


new_xml = ET.Element("namelist")
name = ET.SubElement(new_xml,"name",attrib={"enrolled":"yes"})
age = ET.SubElement(name,"age",attrib={"checked":"no"})
sex = ET.SubElement(name,"sex")
sex.text = '33'
name2 = ET.SubElement(new_xml,"name",attrib={"enrolled":"no"})
age = ET.SubElement(name2,"age")
age.text = '19'

et = ET.ElementTree(new_xml) #生成文档对象
et.write("test.xml", encoding="utf-8",xml_declaration=True)

ET.dump(new_xml) #打印生成的格式
```
