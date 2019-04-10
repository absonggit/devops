# 序列化与反序列化
## eval非标准方式实现
```
# 将字典作为字符串写入文件(序列化操作)
info = {
    "name": "alisa",
    "age": 22
}

with open("info", 'w') as f:
    f.write(str(info))

# 将文件中的字符串读出来专为字典(反序列化操作)
with open("info", 'r') as f:
    data = eval(f.read())

print(data["age"])
```

##　json方式实现
```
info = {
    "name": "alisa",
    "age": 22
}

import json
with open("info", 'w') as f:
    f.write(json.dumps(info))

with open("info", 'r') as f:
    data = json.loads(f.read())
print(data["age"])
```

## pickle方式实现
pickle只能在py中使用，不支持其他语言调用转换(pickle有自己特定的格式)
```
import pickle

with open("info", 'wb') as f:
    f.write(pickle.dumps(info))

with open("info", 'rb') as f:
    data = pickle.loads(f.read())

print(data["age"])
```
