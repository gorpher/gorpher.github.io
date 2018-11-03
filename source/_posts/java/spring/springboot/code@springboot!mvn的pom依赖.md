<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>com.cxsoft.max.sb</groupId>
	<artifactId>springbootDemo</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<!-- spring boot 父类依赖 版本 -->
	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>1.5.2.RELEASE</version>
	</parent>

	<properties>
		<!-- 声明项目配置依赖编码格式为 utf-8 -->
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<!-- java jdk 版本声明 可变更 根据自己配置去匹配 -->
		<java.version>1.8</java.version>
	</properties>
	<build>
		<plugins>
			<!-- spring boot maven插件，可以将项目打包成一个可执行的jar文件 -->
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
		</plugins>
	</build>
	<dependencies>
		<!-- 对web开发的支持，包括tomcat,spring-webmvc -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>
			<!-- spring boot核心,包括自动配置支持，日志和YAML -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter</artifactId>
		</dependency>

		<!-- spring boot提供面向切面编程的支持，包括spring-aop和Aspectj -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-aop</artifactId>
		</dependency>

		<!-- spring boot 对ES搜索隐形的支持包含spring-data-elasticsearch -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-elasticsearch</artifactId>
		</dependency>

		<!-- spring boot 提供对mongodb Nosql的支持 spring-data-mongodb -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-mongodb</artifactId>
		</dependency>
		<!-- spring boot 提供对rest服务支持，spring-data-rest-webmvc -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-rest</artifactId>
		</dependency>
		<!-- spring boot 提供对solr搜索引擎的支持，spring-data-solr -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-solr</artifactId>
		</dependency>
		<!-- spring boot 提供对模板引擎 freemarker的支持 -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-freemarker</artifactId>
		</dependency>
		<!-- spring boot 提供对velocity模板引擎的支持 -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-velocity</artifactId>
		</dependency>
		<!-- spring boot 对redis 数据存储支持 ，spring-redis -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-redis</artifactId>
		</dependency>
		<!-- spring boot提供对mail服务的支持 -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-mail</artifactId>
		</dependency>
		<!-- spring boot提供对jdbc的支持 -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-jdbc</artifactId>
		</dependency>
		<!-- spring boot提供对持久化API的支持，包括spring-data-jpa,spring-orm,hibernate -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-jpa</artifactId>
		</dependency>
		<!-- spring boot 提供对spring-security框架支持 -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-security</artifactId>
		</dependency>
		<!-- spring boot提供对websocket的支持 -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-websocket</artifactId>
		</dependency>
		<!-- spring boot 提供对jetty服务的支持，替代tomcat -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-jetty</artifactId>
		</dependency>
		<!-- spring boot 默认日志系统logback -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-logging</artifactId>
		</dependency>
		<!-- spring boot提供对log4J日志系统的支持 -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-log4j</artifactId>
		</dependency>
		<!-- spring boot 提供对mybatis的支持 -->
		<dependency>
			<groupId>org.mybatis.spring.boot</groupId>
			<artifactId>mybatis-spring-boot-starter</artifactId>
			<version>version</version>
		</dependency>
	</dependencies>
</project>