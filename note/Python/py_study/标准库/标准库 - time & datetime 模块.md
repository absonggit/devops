# 时间模块
## time
import time

1. 获取时间戳
```
time.time()
```

2. 时间睡眠
```
time.sleep()
```

3. 时间戳转换UTC时区元组格式时间
```
time.gmtime()

eg:
time.gmtime(12325432123)
time.struct_time(tm_year=2360, tm_mon=7, tm_mday=30, tm_hour=11, tm_min=8, tm_sec=43, tm_wday=5, tm_yday=212, tm_isdst=0)
```

4. 时间戳转换local时区元组格式时间
```
time.localtime()

time.struct_time(tm_year=2017, tm_mon=9, tm_mday=28, tm_hour=15, tm_min=56, tm_sec=34, tm_wday=3, tm_yday=271, tm_isdst=0)

UTC：世界标准时间  在中国为UTC+8 DST：夏令时
```

5. 元组时间转换为格式化的字符串时间
```
time.strftime()

x = time.localtime()
timeformat = "%Y-%m-%d %X"
timecurrent = time.strftime(time_format, x)

%Y 年  %m 月  %d 日  %H 小时  %M 分  %S 秒
```

```
python time模块
import time
 time模块提供各种操作时间的函数
  说明：一般有两种表示时间的方式:
       第一种是时间戳的方式(相对于1970.1.1 00:00:00以秒计算的偏移量),时间戳是惟一的
       第二种以数组的形式表示即(struct_time),共有九个元素，分别表示，同一个时间戳的struct_time会因为时区不同而不同

strftime(...)
  strftime(format[, tuple]) -> string
  将指定的struct_time(默认为当前时间)，根据指定的格式化字符串输出
  python中时间日期格式化符号：
  %y 两位数的年份表示（00-99）
  %Y 四位数的年份表示（000-9999）
  %m 月份（01-12）
  %d 月内中的一天（0-31）
  %H 24小时制小时数（0-23）
  %I 12小时制小时数（01-12）
  %M 分钟数（00=59）
  %S 秒（00-59）

  %a 本地简化星期名称
  %A 本地完整星期名称
  %b 本地简化的月份名称
  %B 本地完整的月份名称
  %c 本地相应的日期表示和时间表示
  %j 年内的一天（001-366）
  %p 本地A.M.或P.M.的等价符
  %U 一年中的星期数（00-53）星期天为星期的开始
  %w 星期（0-6），星期天为星期的开始
  %W 一年中的星期数（00-53）星期一为星期的开始
  %x 本地相应的日期表示
  %X 本地相应的时间表示
  %Z 当前时区的名称
  %% %号本身
```

6. 格式化的字符串时间转换为元组时间
```
time.strptime()

x = time.strftime("%Y-%m-%d %H-%M-%S")
print(time.strptime(x, "%Y-%m-%d %H-%M-%S"))

time.struct_time(tm_year=2017, tm_mon=9, tm_mday=28, tm_hour=16, tm_min=57, tm_sec=12, tm_wday=3, tm_yday=271, tm_isdst=-1)
```

6. 元组格式时间转换为简化时间
```
time.asctime()

%a 简化星期
%b 简化月份

time.asctime()
'Thu Sep 28 17:11:28 2017'
```

7. 时间戳转换为简化时间
```
time.ctime()
'Thu Sep 28 17:14:16 2017'
```

## datatime
import datetime

1. 获取当前时间、
```
datetime.datetime.now()
```

2. 时间计算
```
# 当前时间+3天
print(datetime.datetime.now() + datetime.timedelta(3))

# 当前时间-3天
print(datetime.datetime.now() + datetime.timedelta(-3))

# 当前时间+3小时 分钟
print(datetime.datetime.now() + datetime.timedelta(hours=3))  # minutes
```

3. 时间修改
```
c_time = datetime.datetime.now()
print(c_time.replace(minute=3, hour=2))
```
