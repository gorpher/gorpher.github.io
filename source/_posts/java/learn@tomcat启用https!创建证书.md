1. 创建证书  
      使用JDK自带的keytool工具生成证书

```sh
keytool -genkey -alias wsria -keyalg RSA -keystore d:/wsriakey.keystore
```

      创建一个用户别名为wsria的keystore文件，名称为wsriakey，存放在D盘根目录下，该文件使用的加密算法为RSA算法。


2. 导入证书   

将第一步生成的证书导入到签名文件中。

```sh
keytool -export -file d:/wsria.crt -alias wsria -keystore d:/wsriakey.keystore
```

3. 应用证书到Tomcat  
修改tomcat目录下的conf/server.xml
注释掉代码（关闭APR，这样就享受不到APR带来的好处了！）
```xml
  <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
```
修改以下代码：
```xml
	<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"  maxThreads="150" SSLEnabled="true" scheme="https" secure="true" clientAuth="false" sslProtocol="TLS" 
               keystoreFile="d:\\wsriakey.keystore" keystorePass="123456"/>
```
to be continue...

---

4. 启用APR

5. OpenSSL 

```shell
openssl pkcs12 -export -in mycert.crt -inkey mykey.key
                       -out mycert.p12 -name tomcat -CAfile myCA.crt
                       -caname root -chain
```

5. 最终的server.xml中关于HTTPS的配置

```xml
<Connector port="443" protocol="HTTP/1.1"
               maxThreads="150" SSLEnabled="true" scheme="https" secure="true"
               clientAuth="false" sslProtocol="TLS" keystorefile="d:/wsriakey" keystorepass="123456"
               SSLCertificateFile="${catalina.base}/conf/wsria.crt"
               SSLCertificateKeyFile="${catalina.base}/conf/wsria.key"/>
```



# 以下为公司期货网站配置https测试时的配置，以Tomcat为例。


0. 公司购买的数字证书，测试用的tomcat为8.0，测试网站为期货网站测试环境。
1. 自行下载tomcat8数字证书文件.jks，下载时记住填写的证书密码，后面有用。
2. 把jks上传到java容器在的服务器上，路径只要不是webapps下就可以，然后到conf目录下server.xml里配置

```xml
<
  Connector port="8443" 
  protocol="HTTP/1.1" 
  SSLEnabled="true"  
  maxThreads="150" scheme="https" secure="true" 
  keystoreFile="conf\cesfutures.com.jks"  
  keystorePass="cesfutures.com"
  clientAuth="false" sslProtocol="TLS"/>

  这个connector元素默认被注释掉的，打开注释后添加一些属性，如：
  keystoreFile指向刚才的jks文件
  keystorePass值为jks密码，就是刚才第二步里设置的密码。
  Port是端口
  SSLEnable是开启ssl的意思。
```

保存修改后重启容器即可。
3. 为保证http自动跳转到https，进行以下操作。

```xml
打开$CATALINA_HOME/conf/web.xml，在该文件末尾增加：
<security-constraint> 
       <web-resource-collection > 
              <web-resource-name >SSL</web-resource-name> 
              <url-pattern>/*</url-pattern> 
       </web-resource-collection>

       <user-data-constraint> 
              <transport-guarantee>CONFIDENTIAL</transport-guarantee> 
       </user-data-constraint> 
</security-constraint>
```
如果这串代码放置到项目的web.xml里，只对首页有用，对其他页面不起作用。  

---

# 以上为本文内容。