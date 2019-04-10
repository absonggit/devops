# 线上脚本简述
| 脚本名称 | 是否可用 | 脚本说明 |
| :------ | :------- | :------ |
| jdk_install.sh | √  | jdk安装 |
| jumpserver_install.sh | √ | jumpserver客户端初始化 |
| nginx_install.sh | √ | nginx安装 |
| rabbitmq_install.sh | × | 组件加载部分没有完善 |
| redis_install.sh | √ | redis4.0.9安装 |
| sys_init.sh | √ | 新系统初始化脚本 |
| tomcat_install.sh | √ | tomcat8安装 |
| zabbix_install.sh | √ | zabbix客户端安装 |
| docker_install.sh | √ | docker docker-compose安装 |

# 安装注意事项
## 安装路径
- 统一在根下、也就是online-script下运行./install.sh
- 如果运行指定脚本，同样在online-script下运行./scripts/xx.sh

## 安装格式报错解决
```
# windows下的代码和linux语法格式报错
# $'\r': 未找到命令
# 未预期的符号 `$'{\r'' 附近有语法错误

$ yum install -y dos2unix
$ dos2unix xx.sh
```
