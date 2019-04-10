```
$ mkdir -P /home/elk
$ cd /home/elk
$ wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.5.1-linux-x86_64.tar.gz
$ tar zxf filebeat-5.5.1-linux-x86_64.tar.gz
$ mv filebeat-5.5.1-linux-x86_64 filebeat
$ cd filebeat
$ cat << EOF > filebeat.yml
filebeat.prospectors:
- input_type: log
  paths:
    - /home/webserver/ule_web/logs/catalina.out
  document_type: "ule_web_36"
  fields:
    log_source: "hk_nw_ule_web_36"

  # paths: 监控文件位置；document_type和log_source为识别不同日志和产品标签
  # document_type:  产品名称_类别_服务器IP尾数
  # log_source：gitlab上定义的机房名称_产品名称_类别_服务器IP尾数

  encoding: plain
  tail_files: true
  scan_frequency: 1s
  close_older: 1h
  max_bytes: 10485760

  #multiline:
    #pattern: ^\[
    #negate: false
    #max_lines: 500
    #timeout: 5s

output.redis:
  enabled: true
  hosts: ["69.172.86.130"]
  prot: 6379
  password: "1maegvxQxgA6vdgn"
  dataytpe: list
  key: "%{[fields.log_source]}"
  #db: 0

loggging:
  to_syslog: true
EOF
$ nohup ./filebeat -e -c filebeat.yml > /dev/null 2>&1 &
```
