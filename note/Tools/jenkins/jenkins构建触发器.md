构建触发器
一、Jenkins内置的trigger插件
```
Build after other projects are built    构建上游项目之后继续构建其他下游项目
Trigger only if build is stable    只有构建稳定才触发
Trigger even if the build is unstable    即使构建不稳定也触发
Trigger even if the build fails    即使构建失败也触发
build after other projects are built
可以设置多个依赖的jobs，当任意一个依赖的jobs成功后启动此build。  多个依赖的jobs间使用,隔开
Trigger builds remotely (e.g., from scripts)
在Authentication Token中指定TOKEN_NAME，然后可以通过接JENKINS_URL/job/JOBNAME/build?token=TOKEN_NAME来启动build
build periodically 在schedule中设置，语法类似于cron中语法
Poll SCM   在schedule中设置时间间隔来抓取SCM server，如果有新的修改，则启动build。 所以这里的作用相当于continous build
```
