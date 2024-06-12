#### 节点说明

 | 内网IP        | 主机名          | 软件                | 系统 |
 | ------------- | ----------------- | ----------------------- | ----------------------- | 
 | 192.168.1.27  | es.node1 | ES 8.13.4 | CentOS Stream release 9 |
 | 192.168.1.112 | es.node2 | ES 8.13.4 | CentOS Stream release 9 |
 | 192.168.1.58  | es.node3 | ES 8.13.4 | CentOS Stream release 9 |

----

<details>
<summary>初始化</summary>
 
```shell
dnf install -y docker podman-compose
mkdir -p /opt/es/{config,data,logs,plugins,certs}
chmod 777 -R /opt/es

```
- 下载
  - 这里做好了8.13.4的x-pack破解包，版本不一样可以自己制作对应版本的。请看 [附录](#附录)
  - [:arrow_double_down: x-pack-core-8.13.4.crack.jar](download/x-pack-core-8.13.4.crack.jar)
  - [:arrow_double_down: platinum_license.json](download/platinum_license.json)

</details>

----

<details>
<summary>生成证书</summary>
 
```shell
docker run --rm -it -v "/opt/es/certs":/usr/share/elasticsearch/config/certs docker.elastic.co/elasticsearch/elasticsearch:8.13.4 /bin/bash -c "elasticsearch-certutil ca --out /usr/share/elasticsearch/config/certs/elastic-stack-ca.p12 --pass ''"
docker run --rm -it -v "/opt/es/certs":/usr/share/elasticsearch/config/certs docker.elastic.co/elasticsearch/elasticsearch:8.13.4 /bin/bash -c "elasticsearch-certutil cert --ca /usr/share/elasticsearch/config/certs/elastic-stack-ca.p12 --ca-pass '' --out /usr/share/elasticsearch/config/certs/elastic-certificates.p12 --pass ''"
```

</details>

----

<details>
<summary>编辑配置elasticsearch.yml</summary>
 
```yaml
cluster.name: es
node.name: 192.168.1.27
node.roles: [data, master, remote_cluster_client, ingest]
network.host: 0.0.0.0
http.port: 9200
http.host: 0.0.0.0
http.cors.enabled: true
http.cors.allow-origin: "*"
discovery.seed_hosts: ["192.168.1.27", "192.168.1.112", "192.168.1.58"]
cluster.initial_master_nodes: ["192.168.1.27", "192.168.1.112", "192.168.1.58"] 
action.destructive_requires_name: true
xpack.security.enabled: false
```

</details>

----

<details>
<summary>编辑配置docker-compose.yml</summary>
 
```yaml
services:
  es-1:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.13.4
    container_name: es-1
    environment:
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms32g -Xmx32g" # 根据服务器的内存进行分配，最大不要超过32g
      - xpack.monitoring.collection.enabled=true
      - xpack.security.enabled=true
      - xpack.security.transport.ssl.enabled=true
      - xpack.security.transport.ssl.verification_mode=certificate
      - xpack.security.transport.ssl.keystore.path=/usr/share/elasticsearch/config/certs/elastic-certificates.p12
      - xpack.security.transport.ssl.truststore.path=/usr/share/elasticsearch/config/certs/elastic-certificates.p12
      - ELASTIC_PASSWORD=123456 # elastic 密码
    ulimits:
      memlock:
        soft: -1
        hard: -1
    ports:
      - 9200:9200
      - 9300:9300
    volumes:
      - ./config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml
      - ./data:/usr/share/elasticsearch/data
      - ./logs:/usr/share/elasticsearch/logs
      - ./plugins:/usr/share/elasticsearch/plugins
      - ./certs:/usr/share/elasticsearch/config/certs
      - ./x-pack-core-8.13.4.crack.jar:/usr/share/elasticsearch//modules/x-pack-core/x-pack-core-8.13.4.jar # 破解许可证包
    restart: always
    network_mode: host
```

</details>

----

<details>
<summary>启动服务</summary>
 
```shell
# 启动容器
docker compose up -d
# 查看服务状态
curl elastic:123456@127.0.0.1:9200/_cat/health
```

----

</details>

----

<details>
<summary>激活许可证</summary>
 
```shell
# 提交许可证
curl  -XPUT -u elastic:123456 127.0.0.1:9200/_license -H "Content-Type: application/json" -d @platinum_license.json
# 重新创建容器
docker compose up -d --force-recreate
# 查看许可证信息
curl -u elastic:123456 127.0.0.1:9200/_license
```

</details>

----
#### 附录
<details>
<summary>制作破解包</summary>
 
```shell
# 安装ES和JDK
dnf install -y https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.13.4-x86_64.rpm
dnf install -y java-17-openjdk java-17-openjdk-devel
# 下载x-pack源码文件
curl -o LicenseVerifier.java -s  https://raw.githubusercontent.com/elastic/elasticsearch/v8.13.4/x-pack/plugin/core/src/main/java/org/elasticsearch/license/LicenseVerifier.java
curl -o XPackBuild.java -s https://raw.githubusercontent.com/elastic/elasticsearch/v8.13.4/x-pack/plugin/core/src/main/java/org/elasticsearch/xpack/core/XPackBuild.java
```

#### 修改 LicenseVerifier.java 以下内容

```java
    public static boolean verifyLicense(final License license, PublicKey publicKey) {
        byte[] signedContent = null;
        byte[] publicKeyFingerprint = null;
        try {
            byte[] signatureBytes = Base64.getDecoder().decode(license.signature());
            ByteBuffer byteBuffer = ByteBuffer.wrap(signatureBytes);
            @SuppressWarnings("unused")
            int version = byteBuffer.getInt();
            int magicLen = byteBuffer.getInt();
            byte[] magic = new byte[magicLen];
            byteBuffer.get(magic);
            int hashLen = byteBuffer.getInt();
            publicKeyFingerprint = new byte[hashLen];
            byteBuffer.get(publicKeyFingerprint);
            int signedContentLen = byteBuffer.getInt();
            signedContent = new byte[signedContentLen];
            byteBuffer.get(signedContent);
            XContentBuilder contentBuilder = XContentFactory.contentBuilder(XContentType.JSON);
            license.toXContent(contentBuilder, new ToXContent.MapParams(Collections.singletonMap(License.LICENSE_SPEC_VIEW_MODE, "true")));
            Signature rsa = Signature.getInstance("SHA512withRSA");
            rsa.initVerify(publicKey);
            BytesRefIterator iterator = BytesReference.bytes(contentBuilder).iterator();
            BytesRef ref;
            while ((ref = iterator.next()) != null) {
                rsa.update(ref.bytes, ref.offset, ref.length);
            }
            boolean verifyResult = rsa.verify(signedContent);
            if (verifyResult == false) {
                logger.warn(
                    () -> format(
                        "License with uid [%s] failed signature verification with the public key with sha256 [%s].",
                        license.uid(),
                        PUBLIC_KEY_DIGEST_HEX_STRING
                    )
                );
            }
            return verifyResult;
        } catch (IOException | NoSuchAlgorithmException | SignatureException | InvalidKeyException e) {
            throw new IllegalStateException(e);
        } finally {
            if (signedContent != null) {
                Arrays.fill(signedContent, (byte) 0);
            }
        }
    }
```

#### 为

```java
    public static boolean verifyLicense(final License license, PublicKey publicKey) {
        return true;
    }
```

##### 修改 XPackBuild.java 以下内容

```java
        Path path = getElasticsearchCodebase();
        if (path.toString().endsWith(".jar")) {
            try (JarInputStream jar = new JarInputStream(Files.newInputStream(path))) {
                Manifest manifest = jar.getManifest();
                shortHash = manifest.getMainAttributes().getValue("Change");
                date = manifest.getMainAttributes().getValue("Build-Date");
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        } else {
            // not running from a jar (unit tests, IDE)
            shortHash = "Unknown";
            date = "Unknown";
        }

        CURRENT = new XPackBuild(shortHash, date);
```
#### 为

```java
        Path path = getElasticsearchCodebase();
        shortHash = "Unknown";
        date = "Unknown";
        CURRENT = new XPackBuild(shortHash, date);
  
```

```shell
# 编译代码
javac -cp "/usr/share/elasticsearch/lib/*:/usr/share/elasticsearch/modules/x-pack-core/*" LicenseVerifier.java
javac -cp "/usr/share/elasticsearch/lib/*:/usr/share/elasticsearch/modules/x-pack-core/*" XPackBuild.java
# 复制解压包
cp /usr/share/elasticsearch/modules/x-pack-core/x-pack-core-8.13.4.jar x-pack-core-8.13.4.jar
unzip x-pack-core-8.13.4.jar -d ./x-pack-core-8.13.4
# 复制编译后的文件
cp LicenseVerifier.class ./x-pack-core-8.13.4/org/elasticsearch/license/
cp XPackBuild.class ./x-pack-core-8.13.4/org/elasticsearch/xpack/core/
# 打包
jar -cvf x-pack-core-8.13.4.crack.jar -C x-pack-core-8.13.4/ .
```

</details>
