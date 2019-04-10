# 生成证书
```
openssl genrsa -out ca-key.pem 4096

openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem

openssl genrsa -out server-key.pem 4096

openssl req -subj "/CN=DockerDaemon" -sha256 -new -key server-key.pem -out server.csr

echo subjectAltName = IP:127.0.0.1,IP:192.168.153.212,IP:192.168.153.213 >> extfile.cnf

echo extendedKeyUsage = serverAuth >> extfile.cnf

openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem   -CAcreateserial -out server-cert.pem -extfile extfile.cnf

openssl genrsa -out key.pem 4096

openssl req -subj '/CN=client' -new -key key.pem -out client.csr

echo extendedKeyUsage = clientAuth > extfile-client.cnf

openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem   -CAcreateserial -out cert.pem -extfile extfile-client.cnf

rm -v client.csr server.csr extfile.cnf extfile-client.cnf

chmod -v 0400 ca-key.pem key.pem server-key.pem

chmod -v 0444 ca.pem server-cert.pem cert.pem
```

# 配置docker启动参数
```
$ vim /etc/systemd/system/docker.service.d/docker-options.conf

#portainer机器docker-options配置
dockerd --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem -H=0.0.0.0:2376 -H=unix:///var/run/docker.sock

#节点docker-options配置同上

$ systemctl daemon-reload
$ systemctl restart docker
```

# 增加节点
```
选择TLS认证--->TLS with client verification only--->cert.pem key.pem--->添加完成
```

>> https://blog.csdn.net/ghostcloud2016/article/details/51539837
