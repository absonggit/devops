# hashlib 模块
用于加密相关的操作，3.X里代替了MD5模块和sha模块，主要提供SHA1,SHA224,SHA256,SHA384,SHA512，MD5算法

```
import hashlib

m = hashlib.md5()
m.update(b"Hello")
print(m.hexdigest())

s1 = hashlib.sha256()
s1.update(b"Hello")
print(s1.hexdigest())
```

# hmac 模块
内部对key和内容在进行处理然后在加密(双层加密)
```
import hmac

h = hmac.new("天王盖地虎,宝塔镇河妖".encode(encoding="utf-8"))
print(h.digest())
print(h.hexdigest())
```
