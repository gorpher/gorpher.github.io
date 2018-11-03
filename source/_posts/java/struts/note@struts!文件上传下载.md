Struts 实现文件上传下载


1.form表单设置提交编码<form ... enctype="Multipart/form-data"></form>
  enctype属性有三个值：
			Application/x-www-form-urlencode(key-value)默认传输方式
			Multipart/form-data（mine编码）以二进制流方式处理
			Text/plain（纯文本编码）
<s:file name=“myUpload" label="选择上传的文件"/>




2.Action中创建3个属性与文件域对应：
private File myUpload; //上传文件属性 名称与与页面对应
private String myUploadFileName; //上传文件对应的文件名 
private String myUploadContentType;//上传文件的文件类型
private String savePath;  //保存到服务器存放上传文件的路径  在对应的set方法中设置绝对路径
public String getSavePath() throws Exception 
{  //返回上传文件的保存位置
	String  str = ServletActionContext.getServletContext().getRealPath(savePath);
	return str;
}

										
3.实现上传方法： 		文件上传的action方法 
	方法1：使用uuid设置唯一标识的路径地址，文件输出流传输
public String upload() throws Exception {
		String strNewFileName = UUID.randomUUID().toString();
		String suffix = myUploadFileName.substring(myUploadFileName.lastIndexOf("."));
		strNewFileName+=suffix;
		//以服务器的文件保存地址和原文件名建立上传文件输出流
		FileOutputStream fos = new FileOutputStream(getSavePath()
			+ "\\" + strNewFileName);
		myUploadFileName = strNewFileName;
		FileInputStream fis = new FileInputStream(getMyUpload());
		byte[] buffer = new byte[1024];
		int len = 0;
		while ((len = fis.read(buffer)) > 0)
		{
			fos.write(buffer , 0 , len);
		}
		fos.close();
		return SUCCESS;
}
	方法2：使用時間設置唯一的路径地址（new Date().getTime();），使用FileUtils.copyFile(File myUpload,File target);方法传输（org.apache.commons.io.FileUtils）
	
public String upload() throws Exception {
		//创建新的文件名，避免上传同名的文件而覆盖
		//new Date().getTime() 得到系统当前时间距1970/1/1的毫秒数
		String newFileName = new Date().getTime()+this.getMyUploadFileName();

		//以上传的路径和新的文件名创建目标文件对象
		File target = new File(savePath,newFileName);

		//将用户上传的临时文件复制到目标文件中
		FileUtils.copyFile(myUpload, target);

		return SUCCESS;
}

 								
4.Struts拦截器配置

      Struts2自带的拦截器（fileUpload）：限制上传的文件类型、限制上传的文件大小 
<struts>
	<!-- 全局过滤上传文件的最大值 -->
   	 <constant name="struts.multipart.maxSize" value="500000000"></constant>
	<!-- 指定文件上传错误消息对应的资源文件 -->
	<constant name="struts.custom.i18n.resources”  value="ApplicationResources"></constant>

	<package name="myPackage" extends="struts-default" namespace="/">
	    <action name="upload" class="dps.action.FileAction" method="upload">
	       <param name="savePath">/uploadFiles</param>
	       <result name="success">/uploadSucc.jsp</result>
		<!– 出错后默认返回到input元素对应的页面 提示错误信息 -->
		<result name="input">/index.jsp</result>

		<interceptor-ref name="fileUpload">
			<!-- 上传文件的类型(后缀名) -->
			<param name="allowedExtensions">.jpg,.gif</param>
			<!-- 上传文件的大小(单位：字节) -->
			<param name="maximumSize">102400</param>
			</interceptor-ref>
			<!– 引用系统默认的拦截器 -->
			<interceptor-ref name="defaultStack"></interceptor-ref>
	    </action>
	</package>
</struts>
5.设置上传过滤的错误信息为中文，需要在项目的src目录下创建ApplicationResources.properties文件，并对不同的错误信息进行配置
struts.messages.error.uploading
struts.messages.error.file.too.large
struts.messages.error.file.extension.not.allowed
6.配置多个文件上传

private List<File> myFile;//上传文件属性
private List<String> myFileFileName;//上传文件对应的文件名 
private List<String> myFileContentType;//上传文件的文件类型

public String execute()throws Exception{
	//得到服务器上存放上传文件的路径
	String realPath = ServletActionContext.getServletContext().getRealPath("/upload");
	//循环遍历文件名集合
	for (int i = 0; i < this.myFileFileName.size(); i++) {
	//得到当前的文件名并构建新的文件名
	String fileName = this.myFileFileName.get(i);
	String newFileName = new Date().getTime()+fileName;
	//以上传的路径和新的文件名创建目标文件对象
	File target = new File(realPath,newFileName);
	//将上传的临时文件复制到目标文件中
	FileUtils.copyFile(this.myFile.get(i), target);
        }
        return "success";
}

文件的下载：服务器端的文件 下载到  客户端
1.设置action类
public class FileDownloadAction extends ActionSupport {
private String downloadPath;//需要下载的文件的路径，与struts.xml中的配置对应
public String getDownloadPath() {
	return downloadPath;
}
public void setDownloadPath(String downloadPath) {
	this.downloadPath = downloadPath;
}
//InputStream的get方法，用于读取下载路径中的文件，并以InputStream流的形式返回
public InputStream getInputStream() throws Exception{
	return ServletActionContext.getServletContext().getResourceAsStream(downloadPath);
}
public String execute()throws Exception{
	return super.execute(); //调用父类的方法
}
}
2.配置struts文件
<action name="download" class="**">
<!-- 指定action中的属性downloadPath的值，即下载文件的路径 -->
<param name="downloadPath">/java.rar</param>
<!-- success结果为stream(流)的类型 -->
<result name="success" type="stream">
<!-- 设置下载的文件的类型 -->
<param name="contentType">application/rar</param>
<!--默认就是 inputStream，它将会指示 StreamResult 通过 inputName 属性值的 getter 方法, 比如这里就是 getInputStream() 来获取下载文件的内容，意味着你的 Action 要有这个方法，默认为inputStream -->
<param name="inputName">inputStream</param>
<!-- 设置下载提示框中提示的下载的文件名 ，该提示框默认为 inline(在线打开)，设置为 attachment 将会告诉浏览器下载该文件-->
<param name="contentDisposition">attachment;filename="java.rar"</param>
<!-- 指定下载的缓冲区的大小 -->
<param name="bufferSize">2048</param>
</result>
</action>
3.下载中文问题处理
action文件
public class FileDownloadAction extends ActionSupport {
private String fileName;
public String getFileName() {
try {
	ServletActionContext.getResponse().setHeader("charset", "ISO8859-1");
	return new String(this.fileName.getBytes(), "ISO8859-1");
} catch (Exception e) {
	return "获取文件名出现了错误!";
}
}

// InputStream的get方法，用于读取下载路径中的文件，并以InputStream流的形式返回
public InputStream getInputStream() throws Exception {
this.fileName="java编程基础.rar";  //读取文件时指定下载的文件名
        return 	ServletActionContext.getServletContext().getResourceAsStream("/"+this.fileName);
}

public String execute() throws Exception {
	return super.execute();// 调用父类的方法
}
}
struts配置
<action name="download" class="**">
<!-- success结果为stream(流)的类型 -->
<result name="success" type="stream">
<!-- 设置下载的文件的类型 -->
<param name="contentType">application/rar</param>
<!-- 设置下载提示框中提示的下载的文件名为action中的fileName的属性值，自动调用属性的get方法-->
<param name="contentDisposition">filename="${fileName}"</param> 
<!-- 指定缓冲区的大小 -->
<param name="bufferSize">2048</param>
</result>
</action>

实现页面 传文件名直接下载文件
	<s:url id="url" action="download.action">
			<s:param name="fileName">
				<s:property value="%{'abc.zip'}" />
			</s:param>
		</s:url>
<s:a href="%{url}"  >download abc!!</s:a>
该方法属于给直接给值栈的fileName赋值，调用下载方法，能够使一个下载action实现不同文件的下载
