
## Docker JVM 优化方案
1. Dockerfile中添加JAVA_OPTS环境变量
    - 这种方式在dockerfile写入到镜像中，不灵活。
    ```bash
    ENV JAVA_OPTS="-XX:PermSize=1024m -XX:MaxPermSize=512m"
    ```
2. 容器启动时指定JAVA_OPTS环境变量
    - docker run 方式

    ```bash
    docker run --rm -e JAVA_OPTS='-Xmx1g' tomcat
    ```
    - docker-compose 方式
    ```yml
    environment:
      - JVM_OPTS=-Xmx12g -Xms12g -XX:MaxPermSize=1024m
    ```
    - kubernetes 方式
    ```yml
    spec:
      containers:
      - env:
        - name: JENKINS_OPTS
          value: --prefix=
        - name: JAVA_OPTS
          value: -Djava.awt.headless=true -Xmx200m -Dcom.sun.management.jmxremote=-Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false
    ```

3. 升级java

> JVM的应用程序容器化部署，可以为应用程序提供一致的开发、部署环境以及零耦合的环境隔离。目前的JVM在Linux容器内运行事务并不那么简单。因此，为了优化一些问题，Java 9和10做了很多非常必要的改进。

- 堆（Heap）大小

> 默认情况下，在64位的服务器中，JVM通常将最大堆大小设定为物理内存的1/4。而在容器化环境中，这确实没有什么意义，因为你通常拥有很多可以运行多个JVM的大内存的服务器。如果你在不同的容器中运行10个JVM，并且每个JVM最终都使用了1/4的RAM，那么你将面临过度使用机器RAM的窘境，并且有可能最终导致虚拟内存耗尽

> 这还会抵消容器的另一项重要优势，即构建及测试的容器镜像必然能够在生产环境中拥有同样的运行效果。在较小的物理主机上的镜像环境中，一个容器可以很容易地正常工作，但在生产环境较大的主机上可能会因为超出容器的任何内存限制而被内核杀死。

> 对此有各种解决方法，例如包括一个JAVA_OPTIONS环境变量，可以从容器外部设置堆大小（或-XX：MaxRam）。但是，这会让事情变得混乱，因为你需要多次复制关于容器限制的信息——一次在容器中，一次为JVM。当然，你也可以编写JVM启动脚本，从proc文件系统中提取正确的内存限制。但都不会让你优雅的解决问题。
> 在Linux上隔离容器的主要机制是通过控制组（CGroups），这些机制允许（除其他外）限制资源到一组进程。使用Java 10，JVM将读取容器CGroup中的内存限制和使用情况，并使用它来初始化最大内存，从而消除对这些变通办法中的任何一种的需求。

- 可用的CPU

> 默认情况下，Docker容器可以无限制地访问系统上的所有CPU。将利用率限制在一定比例的CPU time（使用CPU份额）或系统的各个CPU范围（使用cpusets）是可能的也是常见的。

> 不幸的是，与堆大小一样，Java 8中的JVM大多不知道用于限制容器内CPU利用率的各种机制。这可能会导致在具有多个内核的大型物理主机上出现问题，因为在容器内运行的所有JVM都会假定它们可以访问比实际更多的CPU。这样做的结果是，JVM的许多部分将根据可用的处理器进行自适应大小调整，例如具有并行性和并发性的JIT编译器线程和ForkJoin池，其大小将错误调整，从而产生的线程数量大于他们所期望的数量并且这可能会导致过多的上下文切换以及生产中糟糕的性能。许多第三方实用程序，库和应用程序也使用Runtime.availableProcessors()方法来调整自己的线程池或展现类似的行为。

> 从Java 8u131和Java 9开始，JVM可以理解和利用cpusets来确定可用处理器的大小，而Java 10则支持CPU共享。

- 从host连接

> Attach API允许从另一个JVM程式访问JVM。它对于读取目标JVM的环境状态非常有用，并且在JVM代理中动态加载可以执行额外的监控，分析或诊断任务。由于连接机制与进程名称空间的交互方式，目前无法将主机上的JVM附加到在Docker容器内运行的JVM。

> 主流操作系统上的所有进程都有唯一的标识符PID。Linux还具有PID命名空间的概念，其中不同命名空间中的两个进程可以共享相同的PID。命名空间也可以嵌套，这个功能用来隔离容器内的进程。

> 连接机制的复杂性在于容器内部的JVM当前没有在容器外的PID概念。Java 10通过容器内的JVM在根名称空间中找到它的PID并使用它来监视JVM，据此来修复此问题。
