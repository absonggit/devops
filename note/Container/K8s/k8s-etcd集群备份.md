> 官方文档翻译：https://www.jianshu.com/p/c60c08effaaa
> 官方文档：https://github.com/coreos/etcd/blob/master/Documentation/op-guide/recovery.md


# 对于API 3备份与恢复方法
```
在使用 API 3 时需要使用环境变量 ETCDCTL_API 明确指定。
在命令行设置：
# export ETCDCTL_API=3

备份数据：
# etcdctl --endpoints localhost:2379 snapshot save snapshot.db

恢复：
# etcdctl snapshot restore snapshot.db --name m3 --data-dir=/home/etcd_data

恢复后的文件需要修改权限为 etcd:etcd
--name:重新指定一个数据目录，可以不指定，默认为 default.etcd
--data-dir：指定数据目录
建议使用时不指定 name 但指定 data-dir，并将 data-dir 对应于 etcd 服务中配置的 data-dir
etcd 集群都是至少 3 台机器，官方也说明了集群容错为 (N-1)/2，所以备份数据一般都是用不到，但是鉴上次 gitlab 出现的问题，对于备份数据也要非常重视。
```

```
# Snapshotting the keyspace
$ ETCDCTL_API=3 etcdctl --endpoints $ENDPOINT snapshot save snapshot.db

Restoring a cluster
To restore a cluster, all that is needed is a single snapshot "db" file. A cluster restore with etcdctl snapshot restore creates new etcd data directories; all members should restore using the same snapshot. Restoring overwrites some snapshot metadata (specifically, the member ID and cluster ID); the member loses its former identity. This metadata overwrite prevents the new member from inadvertently joining an existing cluster. Therefore in order to start a cluster from a snapshot, the restore must start a new logical cluster.

Snapshot integrity may be optionally verified at restore time. If the snapshot is taken with etcdctl snapshot save, it will have an integrity hash that is checked by etcdctl snapshot restore. If the snapshot is copied from the data directory, there is no integrity hash and it will only restore by using --skip-hash-check.

A restore initializes a new member of a new cluster, with a fresh cluster configuration using etcd's cluster configuration flags, but preserves the contents of the etcd keyspace. Continuing from the previous example, the following creates new etcd data directories (m1.etcd, m2.etcd, m3.etcd) for a three member cluster:

$ ETCDCTL_API=3 etcdctl snapshot restore snapshot.db \
  --name m1 \
  --initial-cluster m1=http://host1:2380,m2=http://host2:2380,m3=http://host3:2380 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-advertise-peer-urls http://host1:2380
$ ETCDCTL_API=3 etcdctl snapshot restore snapshot.db \
  --name m2 \
  --initial-cluster m1=http://host1:2380,m2=http://host2:2380,m3=http://host3:2380 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-advertise-peer-urls http://host2:2380
$ ETCDCTL_API=3 etcdctl snapshot restore snapshot.db \
  --name m3 \
  --initial-cluster m1=http://host1:2380,m2=http://host2:2380,m3=http://host3:2380 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-advertise-peer-urls http://host3:2380
Next, start etcd with the new data directories:

$ etcd \
  --name m1 \
  --listen-client-urls http://host1:2379 \
  --advertise-client-urls http://host1:2379 \
  --listen-peer-urls http://host1:2380 &
$ etcd \
  --name m2 \
  --listen-client-urls http://host2:2379 \
  --advertise-client-urls http://host2:2379 \
  --listen-peer-urls http://host2:2380 &
$ etcd \
  --name m3 \
  --listen-client-urls http://host3:2379 \
  --advertise-client-urls http://host3:2379 \
  --listen-peer-urls http://host3:2380 &

Now the restored etcd cluster should be available and serving the keyspace given by the snapshot.
Restoring a cluster from membership mis-reconfiguration with wrong URLs

Previously, etcd panics on membership mis-reconfiguration with wrong URLs (v3.2.15 or later returns error early in client-side before etcd server panic).

Recommended way is restore from snapshot. --force-new-cluster can be used to overwrite cluster membership while keeping existing application data, but is strongly discouraged because it will panic if other members from previous cluster are still alive. Make sure to save snapshot periodically.
```
