用 Maven 部署 war 包到远程 Tomcat 服务器

过去我们发布一个Java Web程序通常的做法就是把它打成一个war包，然后用SSH这样的工具把它上传到服务器，并放到相应的目录里，让Tomcat自动去解包，完成部署。

现在我要的是：一行命令部署到本地服务器，在本地测试一番，没有问题的话就一行命令部署到正式服务器，另外正式服务器的密码只有我自己知道，只有我能执行这个部署(其它开发组员不知道正式服务器密码)。
```xml
<build>
        <plugins>
            <plugin>
                <groupId>org.apache.tomcat.maven</groupId>
                <artifactId>tomcat7-maven-plugin</artifactId>
                <version>2.2</version>
            </plugin>
        </plugins>
</build>
```

这个叫“tomcat7-maven-plugin”的插件是利用Tomcat的“manager”模块来实现war包部署的，所以必须确保Tomcat安装了Manager模块，(看看webapp下有没有Manager目录)它虽然名字带“tomcat7”，但Tomcat8也适用，我用的就是Tomcat8。接下来我们对本地的Tomcat的manager模块进行一些配置，打开本地Tomcat的tomcat-users.xml文件，增加这样的配置：

<user username="matosiki" password="matosiki" roles="manager-script"/>

这个叫“matosiki”的用户，角色设定为“manager-script”，表明他可以使用Tomcat的manager模块的后台脚本管理，BTW，如果角色为“manager-gui”则表示此用户可使用manager模块的前端网页管理。然后对正式服务器也做一个类似的配置。

接下来完善一下tomcat7-maven-plugin的配置：
```xml

    <properties>
        <warPackageName>MyWebAppDemo</warPackageName>
        <tomcat.deploy.server>localTestServer</tomcat.deploy.server>
        <tomcat.deploy.serverUrl>http://localhost/manager/text</tomcat.deploy.serverUrl>
    </properties>

    <profiles>
        <profile>
            <id>deploy2production</id>
            <properties>
                <tomcat.deploy.server>productionServer</tomcat.deploy.server>
                <tomcat.deploy.serverUrl>http://120.26.93.30:8080/manager/text</tomcat.deploy.serverUrl>
            </properties>
        </profile>
    </profiles>
 
    <build>
        <finalName>${warPackageName}</finalName>
        <plugins>
            <plugin>
                <groupId>org.apache.tomcat.maven</groupId>
                <artifactId>tomcat7-maven-plugin</artifactId>
                <version>2.2</version>
                <configuration>
                    <server>${tomcat.deploy.server}</server>
                    <url>${tomcat.deploy.serverUrl}</url>
                    <path>/${warPackageName}</path>
                </configuration>
            </plugin>
        </plugins>
    </build>
```
OK，现在来讲解一番：

# Configuration-Server

Configuration中的server是个变量，叫tomcat.deploy.server，我并没有写死，因为我们要将WAR包部署到不同服务器去，而这个变量则由前面的properties来确定，我们可以看到，properties中，
tomcat.deploy.server被赋值为localTestServer，这就是我们的默认值，但通过调整Maven的运行参数，我们可以将它修改为别的值，那么localTestServer又表示什么呢？
我前面说了，服务器的密码是自己定的，而且不希望别人知道，别的开发组员能各自决定自己本地服务器的密码，但他们无需知道我的密码，所以这个localTestServer的相关的内容是定义在“~/.m2/settings.xml”中的，在Windows7下通常就是在“C:\Users\(用户名)\.m2\settings.xml”这里。
打开这个配置文件，在servers中增加两个server，也就是我们要将程序部署上去的两个server。
```xml
<servers>
    <server>
        <id>productionServer</id>
        <username>matosiki</username>
        <password>matosiki</password>
    </server>
    <server>
        <id>localTestServer</id>
        <username>matosiki</username>
        <password>matosiki</password>
    </server>
</servers>
```
这个貌似没什么好说了，这个配置非常的self-explanatory。

# Configuration-url

Configuration中的url也是个变量，很显然，我也不能把它写死，但它不像用户名和密码那么敏感，所以直接出现在POM.XML中也无所谓，默认情况下，其值是“http://localhost/manager/text”，这个地址便是Tomcat的Manager模块的后台脚本入口，url的值同样可以通过Maven的运行参数调整。

# Configuration-path

要将WAR包部署到哪里去？要指定一个path，如果path为“/”，也就是部署为传说中的ROOT.WAR，这次我们指定了一个名为MyWebAppDemo的path。部署成功之后可以通过http://localhost/MyWebAppDemo来访问。

# profile参数

也就是前面提到的Maven的参数，这里我们定了一个参数，叫deploy2production，在运行mvn的时候带上这个参数的话，就会用参数中的tomcat.deploy.server，tomcat.deploy.serverUrl来取代默认的值。

OK，所有的工作都完成了，就剩下部署了。开始吧：

mvn tomcat7:redeploy

为什么是redeploy而不是deploy？因为用deploy的话在我这里会出现些问题，具体啥问题就不说了，也许你那里正常，如果没问题的话用deploy也行啊。执行完这个之后，我们的程序就被部署到本地Tomcat服务器上了。再来看，这是带参数的mvn：

mvn tomcat7:redeploy -Pdeploy2production

这么一下，我们的程序就被部署到正式服务器去了。

如果你想把程序移除掉，那很简单，只需要使用undeploy来代替redeploy即可。

