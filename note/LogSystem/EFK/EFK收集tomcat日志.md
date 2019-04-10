#
TCP input
<source> @type forward port 24224 </source>

HTTP input
<source> @type http port 8888 </source>


如果一开始不想为td-agent的正则匹配所纠结，或者日志不方便直接用td-agent进行解析，则可以使用如下的配置，把整个日志都收集起来，然后交给storm等进行具体的处理即可，配置如下
<source>
@type tail
format /^(?<all>.*)$/ path /usr/local/tomcat7/logs/access_*.log pos_file /var/log/td-agent/waf.log.pos tag test.waf </source> 或者直接把format设为none，这样output会为json，key为message，value则为一整行的内容，当然key也是可以自定义的，添加下messagekey mymessage即可


<source>
  @type tail
  path /root/tomcat/logs/catalina.out
  pos_file /var/log/td-agent/catalina.out.pos
  tag tomcat.access
  format /^(?<>.*)$/
  #format apache
  #format format /^(?<host>[^ ]*) [^ ]* (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+) ((?<path>[^ ]*) +(?<http>[^ ]*))?" (?<code>[^ ]*) (?<size>[^ ]*)(?: "(?<referer>[^\"]*)" "(?<agent>[^\"]*)")?$/
  #time_format %d/%b/%Y:%H:%M:%S %z
</source>

<match tomcat.access>
  host 127.0.0.1
  @type elasticsearch
  logstash_format true
  flush_interval 1s
  #include_tag_key true
  #tag_key mapred
</match>


UI
fluentd提供了一个UI，可以很方便进行管理
如果你通过上述方式安装的，那默认就已经安装了td-agent-ui，直接执行td-agent-ui start即可
如果没有安装，则通过如下命令进行安装： gem install -V fluentd-ui 访问http://172.16.154.235:9292 即可，用户名为admin，密码为changeme
