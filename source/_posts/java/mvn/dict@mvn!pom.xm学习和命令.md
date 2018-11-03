# pom.xml 简单描述
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  
  <modelVersion>4.0.0</modelVersion>
  
  <!-- 坐标、版本以及打包方式 -->
  <groupId>com.alanlee</groupId>
  <artifactId>UidpWeb</artifactId>
  <version>0.0.1-SNAPSHOT</version>
  <packaging>war</packaging>
  
  <!-- maven属性的使用 -->
  <properties>
      <plugin.version>2.5</plugin.version>
  </properties>
  
  <!-- 依赖配置的使用 -->
  <dependencies>
      
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.11</version>
        <!-- 测试范围有效，在编译和打包时都不会使用这个依赖 -->
        <scope>test</scope>
    </dependency>
    
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>servlet-api</artifactId>
        <version>2.5</version>
        <!-- 在编译和测试的过程有效，最后生成war包时不会加入 -->
        <scope>provided</scope>
    </dependency>
    
    <dependency>
        <groupId>javax.servlet.jsp</groupId>
        <artifactId>jsp-api</artifactId>
        <version>2.2</version>
        <!-- 在编译和测试的过程有效，最后生成war包时不会加入 -->
        <scope>provided</scope>
    </dependency>
    
  </dependencies>
  
  <!-- 用来支持项目发布到私服中,用来配合deploy插件的使用 -->
  <distributionManagement>
      <!-- 发布版本 -->
    <repository>
        <id>releases</id>
        <name>public</name>
        <url>http://10.200.11.21:8081/nexus/content/repositories/releases/</url>
    </repository>
    <!-- 快照版本 -->
    <snapshotRepository>
        <id>snapshots</id>
        <name>Snapshots</name>
        <url>http://10.200.11.21:8081/nexus/content/repositories/snapshots</url>
    </snapshotRepository>
  </distributionManagement>
  
  <!-- 注意体会插件配置的顺序，这正体现了一个maven的运行流程 -->
  <build>
      <plugins>
          <!-- 插件使用练习 -->
          <!-- 清理插件的使用，maven3.0.4会默认使用2.4.1版本的clean插件 -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-clean-plugin</artifactId>
            <version>${plugin.version}</version>
            <executions>
                <execution>
                    <id>auto-clean</id>
                    <!-- clean生命周期clean阶段 -->
                    <phase>clean</phase>
                    <goals>
                        <!-- 执行clean插件的clean目标 -->
                        <goal>clean</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>
        
        <!-- maven-resources-plugin在maven3.0.4中默认使用2.5版本的resources -->
        
        <!-- 编译插件的使用，maven3.0.4会默认使用2.3.2版本的compile插件 -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>${plugin.version}</version>
            <configuration>
                <!-- 源代码使用的jdk版本 -->
                <source>1.7</source>
                <!-- 构建后生成class文件jdk版本 -->
                <target>1.7</target>
            </configuration>
        </plugin>
        
        <!-- maven-surefire-plugin插件，maven3.0.4默认使用2.10版本的surefire插件 -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-surefire-plugin</artifactId>
            <version>${plugin.version}</version>
            <configuration>
                <!-- 改变测试报告生成目录 ，默认为target/surefire-reports-->
                <!-- project.build.directory表示maven的属性，这里指的是构建的目录下面test-reports，project.build.directory就是pom标签的值 -->
                <reportsDirectory>${project.build.directory}/test-reports</reportsDirectory>
            </configuration>
        </plugin>
        
        <!-- war包插件的使用，maven3.0.4会默认使用xxx版本的war插件，建议配置编码格式和打包名称 -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-war-plugin</artifactId>
            <!-- 利用属性传递版本号 -->
            <version>${plugin.version}</version>
            <configuration>
                <!-- 设置编码 -->
                <encoding>UTF-8</encoding>
                <!-- 设置名称 -->
                <warName>ROOT</warName>
            </configuration>
        </plugin>
        
        <!-- maven-install-plugin插件一般不需要配置,maven3.0.4默认使用2.3.1版本的install插件 -->
        
        <!-- 部署插件的使用，maven3.0.4会默认使用2.7版本的deploy插件 -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-deploy-plugin</artifactId>
            <version>${plugin.version}</version>
            <configuration>
                <!-- 更新元数据 -->
                <updateReleaseInfo>true</updateReleaseInfo>
            </configuration>
        </plugin>
        
    </plugins>
  </build>
</project>
```
# 配置mvn实现tomcat热发布
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>com.cxsoft.max</groupId>
	<artifactId>max</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<packaging>war</packaging>
    <!--  这里配置公共属性值 -->
	<properties>
		<warPackageName>myWebAppDemo</warPackageName>
		<tomcat.deploy.server>localTestServer</tomcat.deploy.server>
		<tomcat.deploy.serverUrl>http://localhost:8080/manager/text</tomcat.deploy.serverUrl>
		<tomcat.deploy.username>matosiki</tomcat.deploy.username>
		<tomcat.deploy.password>matosiki</tomcat.deploy.password>
	</properties>
    <!-- 发布选项设置 执行mvn tomcat7:deploy2production  使用该选项发布 -->
	<profiles>
		<profile>
			<id>deploy2production</id>
			<properties>
				<tomcat.deploy.server>productionServer</tomcat.deploy.server>
				<tomcat.deploy.serverUrl>http://61.183.83.186:10081/manager/text</tomcat.deploy.serverUrl>
			</properties>
		</profile>
	</profiles>
    <!-- 两个支持jsp 的jar包-->
	<dependencies>
		<dependency>
			<groupId>javax.servlet.jsp</groupId>
			<artifactId>jsp-api</artifactId>
			<version>2.2</version>
		</dependency>
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>javax.servlet-api</artifactId>
			<version>3.0.1</version>
		</dependency>
	</dependencies>
	<build>
		<finalName>${warPackageName}</finalName>
		<plugins>
        <!-- 添加tomcat7 热发布插件-->
			<plugin>
				<groupId>org.apache.tomcat.maven</groupId>
				<artifactId>tomcat7-maven-plugin</artifactId>
				<version>2.2</version>
				<configuration>
					<server>${tomcat.deploy.server}</server>
					<url>${tomcat.deploy.serverUrl}</url>
			        <username>${tomcat.deploy.username}</username>  
			        <password>${tomcat.deploy.password}</password>  
			        <ignorePackaging>true</ignorePackaging>   
					<path>/${warPackageName}</path>
				</configuration>
			</plugin>
		</plugins>
	</build>
</project>
```
还得在tomcat config文件下 tomcat-user.xml
角色role 好像可配可不配
```xml
<user password="matosiki" roles="admin-gui,manager-gui,manager-script" username="matosiki"/>
```

# Maven常用命令 
1. 创建Maven的普通java项目： 
mvn archetype:create -DgroupId=packageName -DartifactId=projectName 
2. 创建Maven的Web项目： 
mvn archetype:create -DgroupId=packageName -DartifactId=webappName -DarchetypeArtifactId=maven-archetype-webapp 
3. 编译源代码： mvn compile 
4. 编译测试代码：mvn test-compile 
5. 运行测试：mvn test 
6. 产生site：mvn site 
7. 打包：mvn package 
8. 在本地Repository中安装jar：mvn install 
9. 清除产生的项目：mvn clean 
10. 生成eclipse项目：mvn eclipse:eclipse 
11. 生成idea项目：mvn idea:idea 
12. 组合使用goal命令，如只打包不测试：mvn -Dtest package 
13. 编译测试的内容：mvn test-compile 
14. 只打jar包: mvn jar:jar 
15. 只测试而不编译，也不测试编译：mvn test -skipping compile -skipping test-compile 
            ( -skipping 的灵活运用，当然也可以用于其他组合命令) 
16. 清除eclipse的一些系统设置:mvn eclipse:clean