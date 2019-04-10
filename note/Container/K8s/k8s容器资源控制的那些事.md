# Pod资源控制的来源，调度时和运行时
```
apiVersion: v1
kind: Pod
metadata:
name: frontend
spec:
containers:
- name: db
image: mysql
resources:
  requests:
    memory: "64Mi"
    cpu: "250m"
  limits:
    memory: "128Mi"
    cpu: "500m"
- name: wp
image: wordpress
resources:
  requests:
    memory: "64Mi"
    cpu: "250m"
  limits:
    memory: "128Mi"
    cpu: "500m"
```

- k8s对容器资源控制的配置是在pod.spec.containers[].resources下面，又分为requests和limits。也就是说，虽然k8s的基本调度单元是pod，但控制资源还是在容器这个层面上。那么request和limit有什么区别呢？

- k8s中的Pod，除了显式写明pod.spec.Nodename的之外，一般是经历这样的过程

    ```
    Pod(被创建，写入etcd)  --> 调度器watch到pod.spec.nodeName --> 节点上的kubelet watch到属于自己，创建容器并运行。
    ```

- 看调度器中的这段代码 和 这段代码
    ```
    func GetResourceRequest(pod *v1.Pod) *schedulercache.Resource {
    result := schedulercache.Resource{}
    for _, container := range pod.Spec.Containers {
        for rName, rQuantity := range container.Resources.Requests {
    ...

    ...
    factory.RegisterPriorityFunction2("MostRequestedPriority", priorities.MostRequestedPriorityMap, nil, 1)
    }
    ```

我们可以得出第一个结论：

**调度时仅仅使用了requests，而没有使用limits。而在运行的时候两者都使用了**

| | 调度时 | 运行时 |
| ---------------------------------------- | :--: | :--: |
| spec.containers[].resources.requests.cpu | ● | ● |
| spec.containers[].resources.requests.memory | ● | ● |
| spec.containers[].resources.limits.cpu | | ● |
| spec.containers[].resources.limits.memory | | ● |

其中request还有nvidiaGPU啥的，也不写了，调度时如果这几个值是0，还会在计算优先级时赋一个值，也不写了。总之，今天这篇文章更关心运行时是怎么跑的，不关心调度时。

而在运行时，这些参数的整体发挥作用的途径如下:
```
k8s ---> docker ---> linux cgroup
```

最后由操作系统内核来控制这些进程的资源限制

# 运行时的换算k8s->docker

还是首先贴代码，这段代码的信息量比较大
```
func (m *kubeGenericRuntimeManager) generateLinuxContainerConfig(container *v1.Container, pod *v1.Pod, uid *int64, username string) *runtimeapi.LinuxContainerConfig {
lc := &runtimeapi.LinuxContainerConfig{
    Resources:       &runtimeapi.LinuxContainerResources{},
    SecurityContext: m.determineEffectiveSecurityContext(pod, container, uid, username),
}

// set linux container resources
var cpuShares int64
cpuRequest := container.Resources.Requests.Cpu()
cpuLimit := container.Resources.Limits.Cpu()
memoryLimit := container.Resources.Limits.Memory().Value()
oomScoreAdj := int64(qos.GetContainerOOMScoreAdjust(pod, container,
    int64(m.machineInfo.MemoryCapacity)))
// If request is not specified, but limit is, we want request to default to limit.
// API server does this for new containers, but we repeat this logic in Kubelet
// for containers running on existing Kubernetes clusters.
if cpuRequest.IsZero() && !cpuLimit.IsZero() {
    cpuShares = milliCPUToShares(cpuLimit.MilliValue())
} else {
    // if cpuRequest.Amount is nil, then milliCPUToShares will return the minimal number
    // of CPU shares.
    cpuShares = milliCPUToShares(cpuRequest.MilliValue())
}
lc.Resources.CpuShares = cpuShares
if memoryLimit != 0 {
    lc.Resources.MemoryLimitInBytes = memoryLimit
}
// Set OOM score of the container based on qos policy. Processes in lower-priority pods should
// be killed first if the system runs out of memory.
lc.Resources.OomScoreAdj = oomScoreAdj

if m.cpuCFSQuota {
    // if cpuLimit.Amount is nil, then the appropriate default value is returned
    // to allow full usage of cpu resource.
    cpuQuota, cpuPeriod := milliCPUToQuota(cpuLimit.MilliValue())
    lc.Resources.CpuQuota = cpuQuota
    lc.Resources.CpuPeriod = cpuPeriod
}

return lc
}
```

以及这段
```
func milliCPUToShares(milliCPU int64) int64 {
if milliCPU == 0 {
    // Return 2 here to really match kernel default for zero milliCPU.
    return minShares
}
// Conceptually (milliCPU / milliCPUToCPU) * sharesPerCPU, but factored to improve rounding.
shares := (milliCPU * sharesPerCPU) / milliCPUToCPU
if shares < minShares {
    return minShares
}
return shares
}

// milliCPUToQuota converts milliCPU to CFS quota and period values
func milliCPUToQuota(milliCPU int64) (quota int64, period int64) {
// CFS quota is measured in two values:
//  - cfs_period_us=100ms (the amount of time to measure usage across)
//  - cfs_quota=20ms (the amount of cpu time allowed to be used across a period)
// so in the above example, you are limited to 20% of a single CPU
// for multi-cpu environments, you just scale equivalent amounts
if milliCPU == 0 {
    return
}

// we set the period to 100ms by default
period = quotaPeriod

// we then convert your milliCPU to a value normalized over a period
quota = (milliCPU * quotaPeriod) / milliCPUToCPU

// quota needs to be a minimum of 1ms.
if quota < minQuotaPeriod {
    quota = minQuotaPeriod
}

return
}
```

继续用一张表来描述里面的关系

| docker参数 | 处理过程 |
| ------------------- | ---------------------------------------- |
| cpuShares | 如果requests.cpu为0且limits.cpu非0，以limits.cpu为转换输入值，否则从request.cpu为转换输入值。转换算法为：如果转换输入值为0，则设置为minShares == 2， 否则为*1024/100 |
| oomScoreAdj | 使用了一个非常复杂的算法把容器分为三类，详见参考文档3，按优先级降序为：Guaranteed, Burstable, Best-Effort，和request.memory负相关，这个值越为负数越不容易被杀死 |
| cpuQuota, cpuPeriod | 由limits.cpu 转换而来，默认cpuQuota为100ms，而cpuPeriod为limits.cpu的核数 * 100ms，这是一个硬限制 |
| memoryLimit | == limits.memory |

# docker中这几个值的含义

那么，当k8s把这一堆内存CPU的值输出到docker之后，docker对这些值的解释是怎么样的呢？
```
docker help run | grep cpu

      --cpu-percent int             CPU percent (Windows only)
  --cpu-period int              Limit CPU CFS (Completely Fair Scheduler) period
  --cpu-quota int               Limit CPU CFS (Completely Fair Scheduler) quota
-c, --cpu-shares int              CPU shares (relative weight)
  --cpuset-cpus string          CPUs in which to allow execution (0-3, 0,1)
  --cpuset-mems string          MEMs in which to allow execution (0-3, 0,1)
docker help run | grep oom

      --oom-kill-disable            Disable OOM Killer
  --oom-score-adj int           Tune host's OOM preferences (-1000 to 1000)
docker help run | grep memory

      --kernel-memory string        Kernel memory limit
-m, --memory string               Memory limit
  --memory-reservation string   Memory soft limit
  --memory-swap string          Swap limit equal to memory plus swap: '-1' to enable unlimited swap
  --memory-swappiness int       Tune container memory swappiness (0 to 100) (default -1)
```

比较杂，所以分几个关键的值来说，下面这部分内容我是从这个博客复制过来的，写的很详细，当然，原始出处还是docker的官方文档

同时，对于一个正在运行的容器可以使用`docker inspect`看出来
```
docker inspect c8dcd083baba | grep Cpu

            "CpuShares": 1024,
        "CpuPeriod": 0,
        "CpuQuota": 0,
        "CpusetCpus": "",
        "CpusetMems": "",
        "CpuCount": 0,
        "CpuPercent": 0,
```

## CPU share constraint: `-c` or `--cpu-shares`

默认所有的容器对于 CPU 的利用占比都是一样的，-c 或者 --cpu-shares 可以设置 CPU 利用率权重，默认为 1024，可以设置权重为 2 或者更高(单个 CPU 为 1024，两个为 2048，以此类推)。如果设置选项为 0，则系统会忽略该选项并且使用默认值 1024。通过以上设置，只会在 CPU 密集(繁忙)型运行进程时体现出来。当一个 container 空闲时，其它容器都是可以占用 CPU 的。cpu-shares 值为一个相对值，实际 CPU 利用率则取决于系统上运行容器的数量。

假如一个 1core 的主机运行 3 个 container，其中一个 cpu-shares 设置为 1024，而其它 cpu-shares 被设置成 512。当 3 个容器中的进程尝试使用 100% CPU 的时候「尝试使用 100% CPU 很重要，此时才可以体现设置值」，则设置 1024 的容器会占用 50% 的 CPU 时间。如果又添加一个 cpu-shares 为 1024 的 container，那么两个设置为 1024 的容器 CPU 利用占比为 33%，而另外两个则为 16.5%。简单的算法就是，所有设置的值相加，每个容器的占比就是 CPU 的利用率，如果只有一个容器，那么此时它无论设置 512 或者 1024，CPU 利用率都将是 100%。当然，如果主机是 3core，运行 3 个容器，两个 cpu-shares 设置为 512，一个设置为 1024，则此时每个 container 都能占用其中一个 CPU 为 100%。

测试主机「4core」当只有 1 个 container 时，可以使用任意的 CPU：
```
➜  ~ docker run -it --rm --cpu-shares 512 ubuntu-stress:latest /bin/bash
root@4eb961147ba6:/# stress -c 4
stress: info: [17] dispatching hogs: 4 cpu, 0 io, 0 vm, 0 hdd
➜  ~ docker stats 4eb961147ba6
CONTAINER           CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O
4eb961147ba6        398.05%             741.4 kB / 8.297 GB   0.01%               4.88 kB /
```

## CPU period constraint: `--cpu-period` & `--cpu-quota`

默认的 CPU CFS「Completely Fair Scheduler」period 是 100ms。我们可以通过 --cpu-period 值限制容器的 CPU 使用。一般 `--cpu-period` 配合 `--cpu-quota` 一起使用。

设置 cpu-period 为 100ms，cpu-quota 为 200ms，表示最多可以使用 2 个 cpu，如下测试：
```
➜  ~ docker run -it --rm --cpu-period=100000 --cpu-quota=200000 ubuntu-stress:latest /bin/bash
root@6b89f2bda5cd:/# stress -c 4    # stress 测试使用 4 个 cpu
stress: info: [17] dispatching hogs: 4 cpu, 0 io, 0 vm, 0 hdd
➜  ~ docker stats 6b89f2bda5cd      # stats 显示当前容器 CPU 使用率不超过 200%
CONTAINER           CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O
6b89f2bda5cd        200.68%             745.5 kB / 8.297 GB   0.01%               4.771 kB / 648 B    0 B / 0 B
```

通过以上测试可以得知，`--cpu-period` 结合 `--cpu-quota` 配置是固定的，无论 CPU 是闲还是繁忙，如上配置，容器最多只能使用 2 个 CPU 到 100%。
CFS documentation on bandwidth limiting

## --oom-score-adj

oom-score-adj是一个参数，用于在系统内存OOM时优先杀哪个，负数的分数最不容易会被抹杀，而正数的分数最容易会被抹杀，这和无限恐怖里面完全不一样啊，哈哈哈

可以看到在k8s的代码中，几个不同类型的container的分数如下
```
const (
// PodInfraOOMAdj is very docker specific. For arbitrary runtime, it may not make
// sense to set sandbox level oom score, e.g. a sandbox could only be a namespace
// without a process.
// TODO: Handle infra container oom score adj in a runtime agnostic way.
PodInfraOOMAdj        int = -998
KubeletOOMScoreAdj    int = -999
DockerOOMScoreAdj     int = -999
KubeProxyOOMScoreAdj  int = -999
guaranteedOOMScoreAdj int = -998
besteffortOOMScoreAdj int = 1000
)
```

可见guarantee的容器最后才会被杀，而besteffort最先被杀。

## --cpu-shares的实测

为了尝试一下k8s里面对cpu-share默认值设为2的实际效果，写了一个脚本
```
cat cpu.sh
function aa {
x=0
while [ True ];do
x=$x+1
done;
}
```

复制到容器内并跑起来，容器基于busybox镜像
```
docker run --cpu-shares=2 run_out_cpu /bin/sh /cpu.sh

top - 15:41:23 up 57 days, 22:51,  3 users,  load average: 4.66, 7.50, 6.16
Tasks: 396 total,   2 running, 394 sleeping,   0 stopped,   0 zombie
%Cpu(s): 12.2 us,  0.4 sy,  0.0 ni, 87.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem:   8154312 total,  7923816 used,   230496 free,   278512 buffers
KiB Swap:  3905532 total,    39060 used,  3866472 free.  6525112 cached Mem
PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                39986 root      20   0    1472    364    188 R  99.6  0.0   1:10.02 sh                  2098 root      20   0  116456   8948   1864 S   0.7  0.1  67:16.83 acc-snf            
```

可以看到，当--cpu-shares设置为2时，使用了单个CPU的100%，接下来，另外不使用容器，只在宿主机上跑一个独立的脚本
```
cat cpu8.sh

function aa {
x=0
while [ True ];do
x=$x+1
done;
}

aa &
aa &
aa &
aa &
aa &
aa &
aa &
aa &
```

这台机器有8核，所以需要起8个进程去跑满

于是，此时的top为：
```
top - 15:44:30 up 57 days, 22:54,  3 users,  load average: 4.21, 5.23, 5.47
Tasks: 404 total,  10 running, 394 sleeping,   0 stopped,   0 zombie
%Cpu(s): 82.6 us, 16.9 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.1 hi,  0.0 si,  0.5 st
KiB Mem:   8154312 total,  7932176 used,   222136 free,   278536 buffers
KiB Swap:  3905532 total,    39060 used,  3866472 free.  6525116 cached Mem

PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                40374 root      20   0   15112   1376    496 R 100.0  0.0   0:28.67 bash   
40373 root      20   0   15244   1380    496 R  99.9  0.0   0:28.92 bash                40376 root      20   0   15240   1376    496 R  99.9  0.0   0:28.80 bash                  40375 root      20   0   15240   1376    496 R  99.6  0.0   0:13.15 bash                 40379 root      20   0   15240   1376    496 R  99.6  0.0   0:28.75 bash                  40378 root      20   0   15240   1376    496 R  99.3  0.0   0:28.79 bash                 40380 root      20   0   15116   1380    496 R  98.9  0.0   0:28.84 bash                  39986 root      20   0    1696    460    188 R  89.0  0.0   4:13.48 sh                    40377 root      20   0   15240   1376    496 R  12.0  0.0   0:19.27 bash  
```

可以看到，其中使用容器跑的sh这个进程，占用88%左右的CPU，如果把--cpu-share设置为512
```
top - 15:50:25 up 57 days, 23:00,  3 users,  load average: 8.93, 7.86, 6.60
Tasks: 407 total,  10 running, 397 sleeping,   0 stopped,   0 zombie
%Cpu(s): 80.2 us, 16.5 sy,  0.0 ni,  2.8 id,  0.0 wa,  0.0 hi,  0.0 si,  0.4 st
KiB Mem:   8154312 total,  7951320 used,   202992 free,   278748 buffers
KiB Swap:  3905532 total,    39060 used,  3866472 free.  6525176 cached Mem

PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND              41012 root      20   0    1316    328    188 R 100.0  0.0   0:07.89 sh                 40376 root      20   0   17928   4084    496 R  89.0  0.1   5:46.70 bash               40374 root      20   0   17928   4084    496 R  88.6  0.1   6:21.40 bash                  40380 root      20   0   17420   3300    496 R  87.3  0.0   6:23.22 bash                  40375 root      20   0   17928   4084    496 R  86.7  0.1   6:07.00 bash                 40377 root      20   0   17928   3556    496 R  85.3  0.0   5:51.28 bash                 40373 root      20   0   17932   4088    496 R  81.7  0.1   6:22.83 bash                  40379 root      20   0   17928   3296    496 R  81.0  0.0   2:16.05 bash                  40378 root      20   0   17928   4084    496 R  75.7  0.1   6:21.70 bash
```

就能占据100%的CPU，不受宿主机上常规吃CPU进程的影响。

# 总结

感谢你读完这篇又长又啰嗦的文档，仅仅是为了说明4个参数在k8s里面的使用，总结一下：

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

> 转自：http://www.dockone.io/article/2509
