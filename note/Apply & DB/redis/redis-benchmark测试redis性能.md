
redis 自己提供了一个性能测试工具redis-benchmark. redis-benchmark可以模拟N个机器，同时发送M个请求。

```
用法：redis-benchmark [-h ] [-p ] [-c ] [-n [-k ]

-h <hostname>      Server hostname (default 127.0.0.1)
-p <port>          Server port (default 6379)
-s <socket>        Server socket (overrides host and port)
-c <clients>       Number of parallel connections (default 50) 并发客户端数
-n <requests>      Total number of requests (default 10000)  请求数量
-d <size>          Data size of SET/GET value in bytes (default 2) set 数据大小
-k <boolean>       1=keep alive 0=reconnect (default 1) 是否采用keep alive模式
-r <keyspacelen>   Use random keys for SET/GET/INCR, random values for SADD
  Using this option the benchmark will get/set keys
  in the form mykey_rand:000000012456 instead of constant
  keys, the <keyspacelen> argument determines the max
  number of values for the random number. For instance
  if set to 10 only rand:000000000000 - rand:000000000009
  range will be allowed.
-P <numreq>        Pipeline <numreq> requests. Default 1 (no pipeline). 是否采用Pipeline模式请求，默认不采用
-q                 Quiet. Just show query/sec values 仅仅显示查询时间
--csv              Output in CSV format  导出为CSV格式
-l                 Loop. Run the tests forever 循环测试
-t <tests>         Only run the comma separated list of tests. The test
                    names are the same as the ones produced as output.
-I                 Idle mode. Just open N idle connections and wait.
```

常用的办法
```
redis-benchmark -q -n 1000
PING_INLINE: 20408.16 requests per second
PING_BULK: 25000.00 requests per second
SET: 18181.82 requests per second
GET: 21739.13 requests per second
INCR: 27027.03 requests per second
LPUSH: 27027.03 requests per second
LPOP: 27027.03 requests per second
SADD: 27027.03 requests per second
SPOP: 22222.22 requests per second
LPUSH (needed to benchmark LRANGE): 27777.78 requests per second
LRANGE_100 (first 100 elements): 10989.01 requests per second
LRANGE_300 (first 300 elements): 5434.78 requests per second
LRANGE_500 (first 450 elements): 4444.44 requests per second
LRANGE_600 (first 600 elements): 3164.56 requests per second
MSET (10 keys): 18518.52 requests per second
可以看出在我的笔记本上，redis每秒可以处理上万条请求。
```

如果要显示详细资料的方式
```
redis-benchmark -n 1000

redis-benchmark -n 1000
====== PING_INLINE ======
  1000 requests completed in 0.04 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

7.30% <= 1 milliseconds
85.80% <= 2 milliseconds
95.10% <= 4 milliseconds
96.90% <= 5 milliseconds
100.00% <= 5 milliseconds
23255.81 requests per second

====== PING_BULK ======
  1000 requests completed in 0.05 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

11.30% <= 1 milliseconds
77.00% <= 2 milliseconds
92.10% <= 3 milliseconds
95.10% <= 5 milliseconds
100.00% <= 5 milliseconds
22222.22 requests per second

====== SET ======
  1000 requests completed in 0.04 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

11.20% <= 1 milliseconds
88.40% <= 2 milliseconds
93.30% <= 3 milliseconds
94.00% <= 4 milliseconds
94.60% <= 5 milliseconds
98.20% <= 6 milliseconds
98.60% <= 8 milliseconds
100.00% <= 8 milliseconds
22727.27 requests per second

====== GET ======
  1000 requests completed in 0.04 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

6.30% <= 1 milliseconds
86.00% <= 2 milliseconds
100.00% <= 2 milliseconds
25641.03 requests per second

====== INCR ======
  1000 requests completed in 0.05 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

7.30% <= 1 milliseconds
77.30% <= 2 milliseconds
83.40% <= 3 milliseconds
95.10% <= 6 milliseconds
98.20% <= 7 milliseconds
100.00% <= 7 milliseconds
20408.16 requests per second

====== LPUSH ======
  1000 requests completed in 0.04 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

10.00% <= 1 milliseconds
75.00% <= 2 milliseconds
97.20% <= 3 milliseconds
100.00% <= 3 milliseconds
23809.52 requests per second

====== LPOP ======
  1000 requests completed in 0.05 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

7.00% <= 1 milliseconds
79.30% <= 2 milliseconds
88.50% <= 3 milliseconds
90.60% <= 4 milliseconds
97.40% <= 5 milliseconds
100.00% <= 5 milliseconds
21276.60 requests per second

====== SADD ======
  1000 requests completed in 0.04 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

11.10% <= 1 milliseconds
83.40% <= 2 milliseconds
91.70% <= 3 milliseconds
97.80% <= 4 milliseconds
99.60% <= 5 milliseconds
100.00% <= 5 milliseconds
23809.52 requests per second

====== SPOP ======
  1000 requests completed in 0.04 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

7.90% <= 1 milliseconds
77.90% <= 2 milliseconds
90.60% <= 3 milliseconds
95.10% <= 5 milliseconds
100.00% <= 5 milliseconds
23255.81 requests per second

====== LPUSH (needed to benchmark LRANGE) ======
  1000 requests completed in 0.04 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

10.10% <= 1 milliseconds
95.40% <= 4 milliseconds
97.60% <= 6 milliseconds
100.00% <= 6 milliseconds
22727.27 requests per second

====== LRANGE_100 (first 100 elements) ======
  1000 requests completed in 0.09 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

1.20% <= 1 milliseconds
10.00% <= 2 milliseconds
50.90% <= 3 milliseconds
87.90% <= 4 milliseconds
99.60% <= 5 milliseconds
100.00% <= 5 milliseconds
10869.57 requests per second

====== LRANGE_300 (first 300 elements) ======
  1000 requests completed in 0.18 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

0.90% <= 1 milliseconds
6.70% <= 2 milliseconds
13.70% <= 3 milliseconds
26.40% <= 4 milliseconds
41.00% <= 5 milliseconds
60.20% <= 6 milliseconds
76.40% <= 7 milliseconds
88.20% <= 8 milliseconds
95.80% <= 9 milliseconds
98.50% <= 10 milliseconds
99.60% <= 11 milliseconds
100.00% <= 11 milliseconds
5494.51 requests per second

====== LRANGE_500 (first 450 elements) ======
  1000 requests completed in 0.24 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

0.10% <= 1 milliseconds
1.90% <= 2 milliseconds
5.60% <= 3 milliseconds
13.10% <= 4 milliseconds
26.80% <= 5 milliseconds
40.00% <= 6 milliseconds
53.90% <= 7 milliseconds
63.60% <= 8 milliseconds
74.70% <= 9 milliseconds
82.90% <= 10 milliseconds
90.00% <= 11 milliseconds
95.90% <= 12 milliseconds
99.30% <= 13 milliseconds
99.80% <= 14 milliseconds
100.00% <= 14 milliseconds
4132.23 requests per second

====== LRANGE_600 (first 600 elements) ======
  1000 requests completed in 0.28 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

0.10% <= 1 milliseconds
0.40% <= 2 milliseconds
2.30% <= 3 milliseconds
9.10% <= 4 milliseconds
20.90% <= 5 milliseconds
32.50% <= 6 milliseconds
42.70% <= 7 milliseconds
56.10% <= 8 milliseconds
69.20% <= 9 milliseconds
83.10% <= 10 milliseconds
90.40% <= 11 milliseconds
95.90% <= 12 milliseconds
97.00% <= 13 milliseconds
97.70% <= 14 milliseconds
97.90% <= 15 milliseconds
98.20% <= 16 milliseconds
98.60% <= 17 milliseconds
98.90% <= 18 milliseconds
99.30% <= 19 milliseconds
99.60% <= 20 milliseconds
100.00% <= 21 milliseconds
3558.72 requests per second

====== MSET (10 keys) ======
  1000 requests completed in 0.06 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1

5.60% <= 1 milliseconds
47.20% <= 2 milliseconds
89.40% <= 3 milliseconds
95.80% <= 8 milliseconds
95.90% <= 10 milliseconds
99.50% <= 11 milliseconds
100.00% <= 11 milliseconds
16666.67 requests per second
```
很多时候，我们在局域网会调用redis，比如我有10台机器，可能同时产生大量的数据，然后这些数据同时存储在1台redis上。那么我们可以分别在10台机器上测试
redis-benchmark -h 192.168.1.124 -p 6379 -n 100000
