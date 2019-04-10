| | 调度时 | 运行时 | docker参数 | 运行作用 |
| ------------------------- | :--: | :--: | ------------------- | ---------------------------------------- |
| resources.requests.cpu | ● | ● | cpuShares | CPU相对值，如果不配，且进程为单线程，能抢到80%-100%的单核CPU，多核的话能抢满所有的核 |
| resources.requests.memory | ● | ● | oomScoreAdj | 内存相对值，越高越不容易被杀死 |
| resources.limits.cpu | | ● | cpuQuota, cpuPeriod | CPU绝对值，运行时无论其他进程情况如何，都会控制在这个数量之内 |
| resources.limits.memory | | ● | memoryLimit | 内存绝对值，运行时控制在之内，超过后会进程会OOM挂掉 |


- request.cpu的坑
这个值，如果在单个机器上已经有容器配置了，例如配置为1，那么这个容器相对一个没配置cpu的容器的抢占CPU能力为1024:2，对不配置的容器而言差距太大。所以，我也不是很理解为啥k8s要把默认值minShares设置为2，而不是docker的1024。于是，部署pod到某些cpu已经资源不足的机器上，如果设置了这个值为1024呢，不一定能调度的上去，但是不设置呢，这个pod的资源又未必能保证。
- requests.memory的坑
这个值本身的坑还不算大，主要是参考文档3把容器分为Guaranteed, Burstable, Best-Effort，并且还不是显式的指定，而是看requests和limits是否有相同的项啥的，说实话，这个也很蛋疼

# kubernetes资源管理
## 计算资源管理
- 资源请求 Requests
    - 资源请求，表示容器希望被分配到的、可完全保证的资源量，Requests的值会提供给kubernetes调度器以便于优化基于资源请求的容器调度。

- 资源限制 Limits
    - 资源限制，是容器最多能使用到的资源量的上限，这个上限值会影响节点上发生资源竞争时的解决策略。

### Pod和容器的Requests和Limits
Pod中的每个容器都可以配置以下四个参数
- spec.container[].resources.requests.cpu
- spec.container[].resources.limits.cpu
- spec.container[].resources.requests.memory
- spec.container[].resources.limits.memory

> 1、Requests和Limits都是可选的，如果没设置那么会使用系统提供的默认值，这个默认值取决于集群的配置。

> 2、如果Requests没有配置，那么默认会被设置为Limits。

> 3、任何情况下Limits都应该设置大于或者等于Requests。

#### CPU
CPU的Requests和Limits是通过CPU数来度量的。CPU资源值支持最多三位小数：0.001 CPU core = 1m CPU(1 millicpu) 官方推荐 100m 这种形式

**CPU资源值是绝对值，而不是相对值：比如 0.1 CPU 不管是在单核或者多核机器上都是一样的，都严格等于 0.1 CPU core**

#### 内存
内存的Requests和Limits计量单位是字节数(Bytes)。内存值使用整数或者定点整数加上国际单位制来表示。国际单位制包括十进制的E、P、T、G、M、K、m，或二进制的Ei、Pi、Ti、Gi、Mi、Ki。

KiB与MiB是二进制表示的字节单位，KB与MB是十进制表示的字节单位。两种方式的区别如下：
- 1 KB (Kilobyte) = 1000 bytes =8000 bits
- 1 KiB (Kibibyte) = 2^10 bytes = 1024 bytes = 8192bits

### 基于Requests和Limits的Pod调度机制

### Requests和Limits的资源配置机制
当kubernetes启动Pod的一个容器时，它会将容器的Requests和Limits值转化为响应的容器启动参数传递给容器执行器(Docker或rkt)

## 资源的配置范围管理
将LimitRange应用到命名空间

## 资源的服务质量管理
用来衡量容器的重要程度、以便在资源不足的时候优先杀掉那些不太重要的容器

三个QoS等级：
- Buaranteed 完全可靠的
- Burstable 弹性波动、较可靠的
- Best-Effort 尽力而为、不太可靠的
