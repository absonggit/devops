#!/bin/bash
# Description: make install redis
# Date: 2018/8/20
# Author: francis

redis_v="4.0.9"
install_dir="/data"

if [ ! -d "/data" ];then mkdir -p /data/package;fi
yum install -y wget gcc gcc-c++
#wget http://download.redis.io/releases/redis-4.0.9.tar.gz
tar zxvf ./package/redis-4.0.9.tar.gz -C ./package/
cd ./package/redis-4.0.9
make PREFIX=/data/redis install
mkdir /data/redis/etc
cp redis.conf /data/redis/etc/
mkdir /data/redis/var

# config environment variable
cat >> /etc/profile << 'EOF'

# redis
export PATH=/data/redis/bin:$PATH
EOF
source /etc/profile

cat > /data/redis/etc/redis.conf << 'EOF'
bind 0.0.0.0
protected-mode yes
port 6379
tcp-backlog 511
timeout 0
tcp-keepalive 300
daemonize no
supervised no
pidfile "/data/redis/var/redis_6379.pid"
loglevel notice
logfile "/data/redis/redis_6379.log"
databases 16
always-show-logo yes
save 900 1
save 300 10
save 60 10000
stop-writes-on-bgsave-error yes
rdbcompression yes
rdbchecksum yes
dbfilename "dump_6379.rdb"
dir "/data/redis"
masterauth "abc123456!"
slave-serve-stale-data yes
slave-read-only yes
repl-diskless-sync no
repl-diskless-sync-delay 5
repl-disable-tcp-nodelay no
slave-priority 100
requirepass "abc123456!"
lazyfree-lazy-eviction no
lazyfree-lazy-expire no
lazyfree-lazy-server-del no
slave-lazy-flush no
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
aof-load-truncated yes
aof-use-rdb-preamble no
lua-time-limit 5000
slowlog-log-slower-than 10000
slowlog-max-len 128
latency-monitor-threshold 0
notify-keyspace-events ""
hash-max-ziplist-entries 512
hash-max-ziplist-value 64
list-max-ziplist-size -2
list-compress-depth 0
set-max-intset-entries 512
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
hll-sparse-max-bytes 3000
activerehashing yes
client-output-buffer-limit normal 0 0 0
client-output-buffer-limit slave 256mb 64mb 60
client-output-buffer-limit pubsub 32mb 8mb 60
hz 10
aof-rewrite-incremental-fsync yes
# slaveof ip port
EOF

# add sentinel set.
mkdir ${install_dir}/redis/sentinel
cat >>  /data/redis/sentinel/sentinel.conf << "EOF"
bind 0.0.0.0
port 26379
daemonize yes
protected-mode no
loglevel notice
logfile "/data/redis/redis-sentinel.log"
sentinel monitor mymaster x.x.x.x 6379 2
sentinel down-after-milliseconds mymaster 3000
sentinel failover-timeout mymaster 180000
sentinel parallel-syncs mymaster 1
sentinel auth-pass mymaster password
EOF

# standalone need modify requirepass and masterauth password
# cluster need modify saveof ip and port

# add start script
cat >> /usr/lib/systemd/system/redis.service << "EOF"
[Unit]
Description=Redis Server
After=network.target

[Service]
ExecStart=/data/redis/bin/redis-server /data/redis/etc/redis.conf --daemonize no
ExecStop=/data/redis/bin/redis-cli -p 6379 shutdown
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# start redis
chmod +x /usr/lib/systemd/system/redis.service
systemctl daemon-reload
systemctl start redis.service
systemctl enable redis.service
echo
/data/redis/bin/redis-cli -v
echo

cat << EOF
+-----------------------------------------------------------------+
|             the redis has been installed successfully!          |
|  Redis-cluster and Redis-sentinel has been configured, please   |
|modify requirepass masterauth slaveof and start it manually.     |
|     $redis/bin/redis-sentinel $redis/sentinel/sentinel.conf     |
+-----------------------------------------------------------------+
EOF
