问题描述：kubelet delete pod之后总处于Terminating，无法移除解决

```
kubectl delete po <your-pod-name> -n <name-space> --force --grace-period=0

--force 表示强制删除
--grace-period=0 grace-period表示过渡存活期，默认30s，在删除POD之前允许POD慢慢终止其上的容器进程，从而优雅退出，0表示立即终止POD
```
