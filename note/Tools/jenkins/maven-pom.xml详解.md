POM的全称是“ProjectObjectModel(项目对象模型)”。

# 声明规范
```
<projectxmlns="http://maven.apache.org/POM/4.0.0"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://maven.apache.org/POM/4.0.0http://maven.apache.org/maven-v4_0_0.xsd">

<!--声明项目描述符遵循哪一个POM模型版本。模型本身的版本很少改变，虽然如此，但它仍然是必不可少的，这是为了当Maven引入了新的特性或者其他模型变更的时候，确保稳定性。-->
<modelVersion>4.0.0</modelVersion>
```

## parent
```
<!--父项目的坐标。如果项目中没有规定某个元素的值，那么父项目中的对应值即为项目的默认值。坐标包括groupID，artifactID和version。-->

<parent>
<!--被继承的父项目的构件标识符-->
<artifactId/>
<!--被继承的父项目的全球唯一标识符-->
<groupId/>
<!--被继承的父项目的版本-->
<version/>
<!--父项目的pom.xml文件的相对路径。相对路径允许你选择一个不同的路径。默认值是../pom.xml。Maven首先在构建当前项目的地方寻找父项目的pom，其次在文件系统的这个位置（relativePath位置），然后在本地仓库，最后在远程仓库寻找父项目的pom。-->
<relativePath/>
</parent>
```

## groupId
```
<!- groupId在一个组织或项目中通常是特有的。例如：(大概、也许)Maven所有artifacts的groupId都使用org.apache.maven。groupId并不一定必须使用点符号，例如，JUnit项目。注意使用点符号的groupId不必与项目的包结构相同，但它是一个很好的做法。 -->

<groupId>org.codehaus.mojo</groupId>
```

## artifactId
```
<!--artifactId一般是该项目的名字。它和groupID一起标识一个唯一的项目。换句话说，你不能有两个不同的项目拥有同样的artifactID和groupID；在某个特定的groupID下，artifactID也必须是唯一的。-->

<artifactId>my-project</artifactId>
```

## version
```
<!--这是命名的最后一段。groupId：artifactId表示单个项目，但它们无法描绘具体的版本。如：我想要junit:junit项目今天第四版。version定义当前项目的版本，如：1.0（-SNAPSHOT），SNAPSHOT表示快照，说明该项目还处于开发阶段，是不稳定版本；建议version格式为:主版本.次版本.增量版本-限定版本号-->

<version>1.0-SNAPSHOT</version>
```

## packaging
```
<!--项目产生的构件类型，例如jar、war、ear、pom等等。插件可以创建他们自己的构件类型，所以前面列的不是全部构件类型。默认值jar。-->

<packaging>jar</packaging>

<!-- ps：
groupId：artifactId：version：packaging在YouTube某些教学视频也称为UUID。

产物是如何储存在仓库中的？存放到私服库时点符号将会被解析成目录分隔符，SNAPSHOT版本在私服库中会被解析成8位日期.时分秒毫秒-序号。序号代表第几次部署。

上面的坐标将会被解析成：org/codehaus/mojo/my-project/1.0-SNAPSHOT/my-project-8位日期.时分秒毫秒-序号.jar

特例：如果你编译源代码将产物存放到本地仓库，将保持不变。
-->
```

## dependencies
```
<!--该元素描述了项目相关的所有依赖。这些依赖组成了项目构建过程中的一个个环节。它们自动从项目定义的仓库中下载。要获取更多信息，请看项目依赖机制。-->

<dependencies>

<dependency>

<!--依赖的groupID-->
<groupId>org.apache.maven</groupId>
<!--依赖的artifactID-->


<artifactId>maven-artifact</artifactId>
<!--依赖的版本号。可以配置成确定的版本号,也可以配置成版本号的范围。


(, )不包含 [, ]包含 例如：[3.8,4.0) 表示3.8 - 4.0的版本，但是不包含4.0


 -->


<version>3.8.1</version>


<!--依赖类型，默认类型是jar。它通常表示依赖的文件的扩展名，但也有例外。一个类型可以被映射成另外一个扩展名或分类器。类型经常和使用的打包方式对应，尽管这也有例外。一些类型的例子：jar，war，ejb-client和test-jar。如果设置extensions为true，就可以在plugin里定义新的类型。所以前面的类型的例子不完整。-->


<type>jar</type>


<!--依赖的分类器。分类器可以区分属于同一个POM，但不同构建方式的构件。分类器名被附加到文件名的版本号后面。例如，如果你想要构建两个单独的构件成JAR，一个使用Java1.4编译器，另一个使用Java6编译器，你就可以使用分类器来生成两个单独的JAR构件。-->


<classifier></classifier>


<!--依赖范围。在项目发布过程中，帮助决定哪些构件被包括进来。欲知详情请参考依赖机制。


-compile：compile是默认的范围；如果没有提供一个范围，那该依赖的范围就是编译范


围。编译范围依赖在所有的classpath中可用，同时它们也会被打包。


-provided：provided依赖只有在当JDK 或者一个容器已提供该依赖之后才使用。例如， 如果你开发了一个web 应用，你可能在编译 classpath 中需要可用的Servlet API 来编译一个servlet，但是你不会想要在打包好的WAR 中包含这个Servlet API；这个Servlet API JAR 由你的应用服务器或者servlet 容器提供。已提供范围的依赖在编译时 （不是运行时）可用。它不具有传递性的，也不会被打包。


-runtime：runtime依赖在运行和测试系统的时候需要，但在编译的时候不需要。比如，你


可能在编译的时候只需要JDBC API JAR，而只有在运行的时候才需要JDBC驱动实


现。


-test： test范围依赖 在一般的 编译和运行时都不需要，它们只有在测试编译和测试运


行阶段可用。


-system：system范围依赖与provided类似，但是你必须显式的提供一个对于本地系统中


JAR文件的路径。这么做是为了允许基于本地对象编译，而这些对象是系统类库


的一部分。这样的构件应该是一直可用的，Maven也不会在仓库中去寻找它。如


果你将一个依赖范围设置成系统范围，你必须同时提供一个systemPath元素。注


意该范围是不推荐使用的（你应该一直尽量去从公共或定制的Maven仓库中引用


依赖）。-->


<scope>test</scope>





<!--仅供system范围使用。注意，不鼓励使用这个元素，并且在新的版本中该元素可能被覆盖掉。该元素为依赖规定了文件系统上的路径。需要绝对路径而不是相对路径。推荐使用属性匹配绝对路径，例如${java.home}。-->


<systemPath></systemPath>





<!--默认为false,即子项目默认都继承，为true,则子项目必需显示的引入。例如：假设项目A在编译时需要项目B的代码，但运行时并不需要项目B，而且我们可能并不需要所有项目都依赖项目B。-->


<optional>true</optional>
<!--当计算传递依赖时，从依赖构件列表里，列出被排除的依赖构件集。即告诉maven你只依赖指定的项目，不依赖项目的依赖。也可以使用通配符*排除所有依赖。此元素主要用于解决版本冲突问题.-->


<exclusions>


<exclusion>


<artifactId>spring-core</artifactId>


<groupId>org.springframework</groupId>


</exclusion>


</exclusions>


<!--可选依赖，如果你在项目B中把C依赖声明为可选，你就需要在依赖于B的项目（例如项目A）中显式的引用对C的依赖。可选依赖阻断依赖的传递性。-->


<optional>true</optional>


</dependency>


</dependencies>





dependencyManagement
<!--继承自该项目的所有子项目的默认依赖信息。这部分的依赖信息不会被立即解析,而是当子项目声明一个依赖（必须描述groupID和artifactID信息），如果groupID和artifactID以外的一些信息没有描述，则通过groupID和artifactID匹配到这里的依赖，并使用这里的依赖信息。-->


<dependencyManagement>


<!--参见dependencies元素-->


<dependencies>


<dependency>


......


</dependency>


</dependencies>


</dependencyManagement>


modules
<!--模块（有时称作子项目）被构建成项目的一部分。列出的每个模块元素是指向该模块的目录的相对路径-->


<modules/>


<!-- Ps：继承和模块的区别：继承父不知子，但子知父。模块父知子，但子不知父。所以在具体的项目中一般都是继承和模块融合使用。 -->


properties
<!--键值对，Properties可以在整个POM中使用，也可以作为触发条件（见settings.xml配置文件里profiles→properties元素的说明）。格式是<name>value</name>。-->


<properties>


<dept>No</dept>


</properties>





编译设置
build
<!--构建项目需要的信息-->


<build>


<!-- 预定义执行的目标或者阶段，必须和命令行的参数相同。如：jar:jar或者clean install等等。例如：defaultGoal配置clean install ，在命令行输入mvn时会自动拼接成mvn clean install。偷懒的福音啊。-->


<defaultGoal>install</defaultGoal>
<!-- 编译输出目录，默认值${basedir}/target(不建议修改) -->
<directory>${basedir}/target</directory>
<!-- 构建产物的名称，没有文件扩展名。默认值${artifactId}-${version}。 -->
<finalName>${artifactId}-${version}</finalName>
<!-- 单独过滤某个文件，更多内容请访问如何过滤资源文件 -->
<filters>
    <filter>src/main/filters/filter.properties</filter>
</filters>
<!--这个元素描述了项目相关的所有资源路径列表，例如和项目相关的属性文件，这些资源被包含在最终的打包文件里。-->


<resources>


<!--这个元素描述了项目相关的资源路径-->


<resource>


<!--  指定build后的resource存放的文件夹。该路径默认是basedir。通常被打包在JAR中的resources的目标路径为META-INF -->


<targetPath></targetPath>


<!--是否使用参数值代替参数名。如：aa=name 将my ${aa}显示为my name。true代表替换，false代表不替换。参数值取自properties元素、文件里配置的属性或者命令行的-D选项。有@aa@和${aa}俩种写法。更多内容请查看在线帮助-->


<filtering>false</filtering>


<!--描述存放资源的目录，该路径相对POM路径。默认值${basedir}/src/main/resources -->


<directory>${basedir}/src/main/resources </directory>


<!--用于指定要包括的文件。可以使用通配符*。例如**/*.xml。 -->


<includes>


          <include>configuration.xml</include>


 </includes>


<!--用于指定不需要包括的文件。可以使用通配符*。例如**/*.xml。如果和includes的配置冲突，excludes的优先级更高。 -->


<excludes>


          <exclude>**/*.properties</exclude>


</excludes>


</resource>


</resources>


<!--该testResources元素块包含testResource元素。它们的定义是类似的resource 元素，仅在测试阶段使用。和resource元素唯一一点不同是testResource的默认值是${project.basedir}/src/test/resources。测试资源是不会部署。-->


<testResources>


<testResource>


<targetPath/>


<filtering/>


<directory/>


<includes/>


<excludes/>


</testResource>


</testResources>


<plugins>


<!--plugin元素包含描述插件所需要的信息。-->


<plugin>


<!--插件在仓库里的groupID-->


<groupId>org.apache.maven.plugins</groupId>


<!--插件在仓库里的artifactID-->


<artifactId>maven-jar-plugin</artifactId>


<!--被使用的插件的版本（或版本范围）-->


<version>2.0</version>


<!--是否从该插件下载Maven扩展（例如打包和类型处理器），由于性能原因，只有在真需要下载时，该元素才被设置成enabled。-->


<extensions>false</extensions>


<!-- true 或 false ,这个插件的配置是否，可以继承。默认true。  -->


<inherited>true</inherited>


<!-- 请查阅https://maven.apache.org/pom.html#Plugins或者查阅中文版http://blog.csdn.net/tomato__/article/details/13625497 -->


<configuration>


<classifier>test</classifier>


</configuration>


<!-- 请参考dependencies元素  -->


<dependencies>


<dependency>


  <groupId/>


  <artifactId/>


  <version/>


  <type/>


  <classifier/>


  <scope/>


  <systemPath/>


  <exclusions>


         <exclusion>


           <artifactId/>


           <groupId/>


         </exclusion>


  </exclusions>


  <optional/>


</dependency>


</dependencies>


<!--在构建生命周期中执行一组目标的配置。每个目标可能有不同的配置。-->


<executions>


<!--execution元素包含了插件执行需要的信息-->


<execution>


<!--执行目标的标识符，用于标识构建过程中的目标，或者匹配继承过程中需要合并的执行目标-->


<id>echodir</id>


<!--绑定了目标的构建生命周期阶段，如果省略，目标会被绑定到源数据里配置的默认阶段-->


<phase>verify</phase>


<!--配置的执行目标-->


<goals>


<goal>run</goal>


</goals>


<!--配置是否被传播到子POM-->


<inherited>false</inherited>


<!-- 请查阅https://maven.apache.org/pom.html#Plugins -->


<configuration>


<tasks>


<echo>Build Dir: ${project.build.directory}</echo>


</tasks>


</configuration>


</execution>


</executions>


</plugin>


</plugins>


<!--子项目可以引用的默认插件信息。该插件配置项直到被引用时才会被解析或绑定到生命周期。给定插件的任何本地配置都会覆盖这里的配置-->


<pluginManagement>


<plugins>


.................


</plugins>


</pluginManagement>


<!--该元素设置了项目源码目录，当构建项目的时候，构建系统会编译目录里的源码。该路径是相对于pom.xml的相对路径。-->


<sourceDirectory>${basedir}/src/main/java</sourceDirectory>


<!--该元素设置了项目脚本源码目录，该目录和源码目录不同：绝大多数情况下，该目录下的内容会被拷贝到输出目录(因为脚本是被解释的，而不是被编译的)。-->


<scriptSourceDirectory>${basedir}/src/main/scripts</scriptSourceDirectory>


<!--该元素设置了项目单元测试使用的源码目录，当测试项目的时候，构建系统会编译目录里的源码。该路径是相对于pom.xml的相对路径。-->


<testSourceDirectory>${basedir}/src/test/java</testSourceDirectory>


<!--被编译过的应用程序class文件存放的目录。-->


<outputDirectory>${basedir}/target/classes</outputDirectory>


<!--被编译过的测试class文件存放的目录。-->


<testOutputDirectory>${basedir}/target/test-classes</testOutputDirectory>


<!--使用来自该项目的一系列构建扩展-->


<extensions>


<!--描述使用到的构建扩展。-->


<extension>


<!--构建扩展的groupId-->


<groupId/>


<!--构建扩展的artifactId-->


<artifactId/>


<!--构建扩展的版本-->


<version/>


</extension>


</extensions>


</build>


reporting
<!--该元素描述使用报表插件产生报表的规范。当用户执行“mvn site”，这些报表就会运行。在页面导航栏能看到所有报表的链接。-->


<reporting>


<!--所有产生的报表存放到哪里。默认值是${basedir}/target/site
。-->


<outputDirectory>${basedir}/target/site</outputDirectory>
<!--如果为true，则网站不包括默认的报表。这包括“项目信息”菜单中的报表。默认false-->


<excludeDefaults>false</excludeDefaults>


<!--使用的报表插件和他们的配置。-->


<plugins>


<!--plugin元素包含描述报表插件需要的信息-->


<plugin>


<!--报表插件在仓库里的groupID,默认值是 : org.apache.maven.plugins 。-->


<groupId>org.apache.maven.plugins</groupId>


<!--报表插件在仓库里的artifactID-->


<artifactId>maven-project-info-reports-plugin</artifactId>
<!--被使用的报表插件的版本（或版本范围）-->


<version>2.7</version>


<!--任何配置是否被传播到子项目，默认true-->


<inherited>true<inherited/>


<!--报表插件的配置-->


<configuration/>


<!--一组报表的多重规范，每个规范可能有不同的配置。一个规范（报表集）对应一个执行目标。例如，有1，2，3，4，5，6，7，8，9个报表。1，2，5构成A报表集，对应一个执行目标。2，5，8构成B报表集，对应另一个执行目标-->


<reportSets>


<!--表示报表的一个集合，以及产生该集合的配置-->


<reportSet>


<!--报表集合的唯一标识符，POM继承时用到，默认值：default -->


<id>default<id>


<!--产生报表集合时，被使用的报表的配置-->


<configuration/>


<!--配置是否被继承到子POMs-->


<inherited/>


<!--这个集合里使用到哪些报表-->


<reports/>


</reportSet>


</reportSets>


</plugin>


</plugins>


</reporting>


项目信息
name
<!--项目的名称,Maven产生的文档用-->


<name>banseon-maven</name>


description
<!--项目的详细描述,Maven产生的文档用。当这个元素能够用HTML格式描述时（例如，CDATA中的文本会被解析器忽略，就可以包含HTML标签），不鼓励使用纯文本描述。如果你需要修改产生的web站点的索引页面，你应该修改你自己的索引页文件，而不是调整这里的文档。-->


<description>Amavenprojecttostudymaven.</description>


url
<!--项目主页的URL,Maven产生的文档用-->


<url>http://www.baidu.com/banseon</url>


inceptionYear
<!--项目创建年份，4位数字。当产生版权信息时需要使用这个值。-->


<inceptionYear/>


licenses
<!--该元素描述了项目所有License列表。应该只列出该项目的license列表，不要列出依赖项目的license列表。如果列出多个license，用户可以选择它们中的一个而不是接受所有license。-->


<licenses>


<!--描述了项目的license，用于生成项目的web站点的license页面，其他一些报表和validation也会用到该元素。-->


<license>


<!--完整的法律许可的名称。 -->


<name>Apache2</name>


<!--官方的license正文页面的URL-->


<url>http://www.baidu.com/banseon/LICENSE-2.0.txt</url>


<!--项目分发的主要方式：


repo，可以从Maven库下载


manual，用户必须手动下载和安装依赖-->


<distribution>repo</distribution>


<!--关于license的补充信息-->


<comments>Abusiness-friendlyOSSlicense</comments>


</license>


</licenses>


organization
<!--描述项目所属组织的各种属性。Maven产生的文档用-->


<organization>


<!--组织的全名-->


<name>demo</name>


<!--组织主页的URL-->


<url>http://www.baidu.com/banseon</url>


</organization>


developers
<!--项目开发者列表-->


<developers>


<!--某个项目开发者的信息-->


<developer>


<!--SCM里项目开发者的唯一标识符-->


<id>HELLOWORLD</id>


<!--项目开发者的全名-->


<name>banseon</name>


<!--项目开发者的email-->


<email>banseon@126.com</email>


<!--项目开发者的主页的URL-->


<url/>


<!--项目开发者在项目中扮演的角色，角色元素描述了各种角色-->


<roles>


<role>ProjectManager</role>


<role>Architect</role>


</roles>


<!--项目开发者所属组织-->


<organization>demo</organization>


<!--项目开发者所属组织的URL-->


<organizationUrl>http://hi.baidu.com/banseon</organizationUrl>


<!--项目开发者所在时区，-12到14范围内的整数。-->


<timezone>-5</timezone>


<!-- 其他配置，键值对 -->


<properties>


<picUrl>http://tinyurl.com/prv4t</picUrl>


</properties>


</developer>


</developers>


contributors
<!--项目的其他贡献者列表-->


<contributors>


<!--项目的其他贡献者。参见developers/developer元素-->


<contributor>


<name/><email/><url/><organization/><organizationUrl/><roles/><timezone/><properties/>


</contributor>


</contributors>


环境设置
issueManagement
<!--项目的问题管理系统(Bugzilla,Jira,Scarab,或任何你喜欢的问题管理系统)的名称和URL，本例为jira-->


<issueManagement>


<!--问题管理系统（例如jira）的名字，-->


<system>jira</system>


<!--该项目使用的问题管理系统的URL-->


<url>http://jira.baidu.com/banseon</url>


</issueManagement>


ciManagement
<!--项目持续集成信息-->


<ciManagement>


<!--持续集成系统的名字，例如continuum-->


<system>continuum</system>


<!--该项目使用的持续集成系统的URL（如果持续集成系统有web接口的话）。-->


<url>http://127.0.0.1:8080/continuum</url>


<!--构建完成时，需要通知的开发者/用户的配置项。包括被通知者信息和通知条件（错误，失败，成功，警告）-->


<notifiers>


<!--配置一种方式，当构建中断时，以该方式通知用户/开发者-->


<notifier>


<!--传送通知的途径-->


<type>mail</type>


<!--发生错误时是否通知-->


<sendOnError>true</sendOnError>


<!--构建失败时是否通知-->


<sendOnFailure>true</sendOnFailure>


<!--构建成功时是否通知-->


<sendOnSuccess>false</sendOnSuccess>


<!--发生警告时是否通知-->


<sendOnWarning>false</sendOnWarning>


<!--弃用。通知发送到哪里-->


<address/>


<!--通知扩展配置项-->


<configuration><address>continuum@127.0.0.1</address></configuration>


</notifier>


</notifiers>


</ciManagement>


mailingLists
<!--项目相关邮件列表信息-->


<mailingLists>


<!--该元素描述了项目相关的所有邮件列表。自动产生的网站引用这些信息。-->


<mailingList>


<!--邮件的名称-->


<name>User List</name>


<!--发送邮件的地址或链接，如果是邮件地址，创建文档时，mailto:链接会被自动创建-->


<post>user@127.0.0.1</post>


<!--订阅邮件的地址或链接，如果是邮件地址，创建文档时，mailto:链接会被自动创建-->


<subscribe>user-subscribe@127.0.0.1</subscribe>


<!--取消订阅邮件的地址或链接，如果是邮件地址，创建文档时，mailto:链接会被自动创建-->


<unsubscribe>user-unsubscribe@127.0.0.1</unsubscribe>


<!--你可以浏览邮件信息的URL-->


<archive>http://127.0.0.1/user/</archive>


<!--备用url的链接,可以浏览存档列表。-->


<otherArchives>


<otherArchive>http://base.google.com/base/1/127.0.0.1</otherArchive>


</mailingList>


</mailingLists>


scm
<!--SCM(Source Control Management)标签允许你配置你的代码库，供Maven web站点和其它插件使用。-->


<scm>


<!--SCM的URL,该URL描述了版本库和如何连接到版本库。欲知详情，请看SCMs提供的URL格式和支持列表。该连接只读。-->


<connection>scm:svn:http://127.0.0.1/svn/my-project</connection>


<!--给开发者使用的，类似connection元素。即该连接不仅仅只读-->


<developerConnection>scm:svn:https://127.0.0.1/svn/my-project</developerConnection>


<!--当前代码的标签，在开发阶段默认为HEAD-->


<tag>HEAD</tag>


<!--指向项目的可浏览SCM库（例如ViewVC或者Fisheye）的URL。-->


<url>http://127.0.0.1/websvn/my-project</url>


</scm>


prerequisites
<!--描述了这个项目构建环境中的前提条件。-->


<prerequisites>


<!--构建该项目或使用该插件所需要的Maven的最低版本。默认值：2.0-->


<maven>2.0.6</maven>


</prerequisites>


repositories
<!--远程仓库列表，它是Maven用来填充构建系统本地仓库所使用的一组远程项目。 -->


   <repositories>


    <!--包含需要连接到远程仓库的信息 -->


    <repository>


     <!--远程仓库唯一标识-->


     <id>codehausSnapshots</id>


     <!--远程仓库名称 -->


     <name>Codehaus Snapshots</name>


     <!--如何处理远程仓库里发布版本的下载-->


     <releases>


      <!--true或者false表示该仓库是否为下载某种类型构件（发布版，快照版）开启。  -->


      <enabled>false</enabled>


      <!--该元素指定更新发生的频率。Maven会比较本地POM和远程POM的时间戳。这里的选项是：always（一直），daily（默认，每日），interval：X（这里X是以分钟为单位的时间间隔），或者never（从不）。 -->


      <updatePolicy>always</updatePolicy>


      <!--当Maven验证构件校验文件失败时该怎么做-ignore（忽略），fail（失败），或者warn（警告）。-->


      <checksumPolicy>warn</checksumPolicy>


     </releases>


     <!--如何处理远程仓库里快照版本的下载。有了releases和snapshots这两组配置，POM就可以在每个单独的仓库中，为每种类型的构件采取不同的策略。例如，可能有人会决定只为开发目的开启对快照版本下载的支持。参见repositories/repository/releases元素-->


     <snapshots>


      <enabled/><updatePolicy/><checksumPolicy/>


     </snapshots>


     <!--远程仓库URL，按protocol://hostname/path形式 -->


     <url>http://snapshots.maven.codehaus.org/maven2</url>


     <!--用于定位和排序构件的仓库布局类型-可以是default（默认）或者legacy（遗留）。Maven 2为其仓库提供了一个默认的布局；然而，Maven 1.x有一种不同的布局。我们可以使用该元素指定布局是default（默认）还是legacy（遗留）。 -->


     <layout>default</layout>


    </repository>


   </repositories>


pluginRepositories
<!--包含需要连接到远程插件仓库的信息.参见repositories/repository元素-->


<pluginRepositories>


<pluginRepository>


<releases>


<enabled/>


<updatePolicy/>


<checksumPolicy/>


</releases>


<snapshots>


<enabled/>


<updatePolicy/>


<checksumPolicy/>


</snapshots>


<id/>


<name/>


<url/>


<layout/>


</pluginRepository>


</pluginRepositories>


distributionManagement
<!--项目分发信息，在执行mvndeploy后表示要发布的位置。有了这些信息就可以把网站部署到远程服务器或者把构件部署到远程仓库。-->


<distributionManagement>


<!--部署项目产生的构件到远程仓库需要的信息，参见repositories/repository元素-->


<repository>


<!--true:分配给快照一个唯一的版本号（由时间戳和构建流水号组成）。false：每次都使用相同的版本号 -->


<uniqueVersion>true</uniqueVersion>


 <id/>


<name/>


<url/>


 <layout/>


<releases>


<enabled/>


<updatePolicy/>


<checksumPolicy/>


</releases>


<snapshots>


<enabled/>


<updatePolicy/>


<checksumPolicy/>


</snapshots>


</repository>


<!--构件的快照部署到哪里？ -->


<snapshotRepository>


<uniqueVersion>true</uniqueVersion>


 <id/>


<name/>


<url/>


 <layout/>


<releases>


<enabled/>


<updatePolicy/>


<checksumPolicy/>


</releases>


<snapshots>


<enabled/>


<updatePolicy/>


<checksumPolicy/>


</snapshots>


</snapshotRepository>


<!--部署项目的网站需要的信息-->


<site>


<!--部署位置的唯一标识符，用来匹配站点和settings.xml文件里的配置-->


<id>banseon-site</id>


<!--部署位置的名称-->


<name>businessapiwebsite</name>


<!--部署位置的URL，按protocol://hostname/path形式-->


<url>


scp://svn.baidu.com/banseon:/var/www/localhost/banseon-web


</url>


</site>


<!--项目下载页面的URL。如果没有该元素，用户应该参考主页。使用该元素的原因是：帮助定位那些不在仓库里的构件（由于license限制）。-->


<downloadUrl/>


<!--如果构件有了新的groupID和artifactID（构件移到了新的位置），这里列出构件的重定位信息。-->


<relocation>


<!--构件新的groupID-->


<groupId/>


<!--构件新的artifactID-->


<artifactId/>


<!--构件新的版本号-->


<version/>


<!--显示给用户的，关于移动的额外信息，例如原因。-->


<message/>


</relocation>


<!--给出该构件在远程仓库的状态。不得在本地项目中设置该元素，因为这是工具自动更新的。有效的值有：none（默认），converted（仓库管理员从Maven1 POM转换过来），partner（直接从伙伴Maven2仓库同步过来），deployed（从Maven2实例部署），verified（被核实时正确的和最终的）。-->


<status/>


</distributionManagement>


profiles
<!--在列的项目构建profile，如果被激活，会修改构建处理-->


<profiles>


<!--根据环境参数或命令行参数激活某个构建处理-->


<profile>


<!--构建配置的唯一标识符。即用于命令行激活，也用于在继承时合并具有相同标识符的profile。-->


<id>test</id>


   <!--自动触发profile的条件逻辑。Activation是profile的开启钥匙。如POM中的profile一样，profile的力量来自于它能够在某些特定的环境中自动使用某些特定的值；这些环境通过activation元素指定。activation元素并不是激活profile的唯一方式。settings.xml文件中的activeProfile元素可以包含profile的id。profile也可以通过在命令行，使用-P标记和逗号分隔的列表来显式的激活（如，-P test）。-->


   <activation>


    <!--profile默认是否激活的标识-->


    <activeByDefault>false</activeByDefault>


    <!--当匹配的jdk被检测到，profile被激活。例如，1.4激活JDK1.4，1.4.0_2，而!1.4激活所有版本不是以1.4开头的JDK。-->


    <jdk>1.5</jdk>


    <!--当匹配的操作系统属性被检测到，profile被激活。os元素可以定义一些操作系统相关的属性。-->


    <os>


     <!--激活profile的操作系统的名字 -->


     <name>Windows XP</name>


     <!--激活profile的操作系统所属家族(如 'windows')  -->


     <family>Windows</family>


     <!--激活profile的操作系统体系结构  -->


     <arch>x86</arch>


     <!--激活profile的操作系统版本-->


     <version>5.1.2600</version>


    </os>


    <!--如果Maven检测到某一个属性（其值可以在POM中通过${name}引用），其拥有对应的name = 值，Profile就会被激活。如果值字段是空的，那么存在属性名称字段就会激活profile，否则按区分大小写方式匹配属性值字段-->


    <property>


     <!--激活profile的属性的名称-->


     <name>mavenVersion</name>


     <!--激活profile的属性的值 -->


     <value>2.0.3</value>


    </property>


    <!--提供一个文件名，通过检测该文件的存在或不存在来激活profile。missing检查文件是否存在，如果不存在则激活profile。另一方面，exists则会检查文件是否存在，如果存在则激活profile。-->


    <file>


     <!--如果指定的文件存在，则激活profile。 -->


     <exists>${basedir}/file2.properties</exists>


     <!--如果指定的文件不存在，则激活profile。-->


     <missing>${basedir}/file1.properties</missing>


    </file>


   </activation>


<!--构建项目所需要的信息。参见build元素-->


<build>


<defaultGoal/>


<resources>


<resource>


<targetPath/><filtering/><directory/><includes/><excludes/>


</resource>


</resources>


<testResources>


<testResource>


<targetPath/><filtering/><directory/><includes/><excludes/>


</testResource>


</testResources>


<directory/><finalName/><filters/>


<pluginManagement>


<plugins>


<!--参见build/pluginManagement/plugins/plugin元素-->


<plugin>


<groupId/><artifactId/><version/><extensions/>


<executions>


<execution>


<id/><phase/><goals/><inherited/><configuration/>


</execution>


</executions>


<dependencies>


<!--参见dependencies/dependency元素-->


<dependency>


......


</dependency>


</dependencies>


<goals/><inherited/><configuration/>


</plugin>


</plugins>


</pluginManagement>


<plugins>


<!--参见build/pluginManagement/plugins/plugin元素-->


<plugin>


<groupId/><artifactId/><version/><extensions/>


<executions>


<execution>


<id/><phase/><goals/><inherited/><configuration/>


</execution>


</executions>


<dependencies>


<!--参见dependencies/dependency元素-->


<dependency>


......


</dependency>


</dependencies>


<goals/><inherited/><configuration/>


</plugin>


</plugins>


</build>


<!--发现依赖和扩展的远程仓库列表。-->


<repositories>


<!--参见repositories/repository元素-->


<repository>


<releases>


<enabled/><updatePolicy/><checksumPolicy/>


</releases>


<snapshots>


<enabled/><updatePolicy/><checksumPolicy/>


</snapshots>


<id/><name/><url/><layout/>


</repository>


</repositories>


<!--该元素描述了项目相关的所有依赖。这些依赖组成了项目构建过程中的一个个环节。它们自动从项目定义的仓库中下载。要获取更多信息，请看项目依赖机制。-->


<dependencies>


<!--参见dependencies/dependency元素-->


<dependency>


......


</dependency>


</dependencies>


<!--不赞成使用.现在Maven忽略该元素.-->


<reports/>





<!--参见distributionManagement元素-->


<distributionManagement>


......


</distributionManagement>


<!--参见properties元素-->


<properties/>


</profile>


</profiles>


</project>


<!--参考：


http://maven.apache.org/ref/3.1.0/maven-model/maven.html


https://maven.apache.org/pom.html


-->
