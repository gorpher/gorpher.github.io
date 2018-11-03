1.普通方式上传&下载文件
	a)上传文件
		
		if (!file.isEmpty()) {
			byte[] bytes = file.getBytes();
			File fileTo = new File("D:/" + time + file.getOriginalFilename());
			FileOutputStream fos = new FileOutputStream(fileTo);
			BufferedOutputStream bos = new BufferedOutputStream(fos);
			bos.write(bytes);
			bos.close();
			fos.close();
			System.out.println("文件保存了！");
		}
	b)下载文件

		File file=new File("D:/xxx.txt");		
		InputStream fis = file.getInputStream();
		ByteArrayOutputStream bos = new ByteArrayOutputStream(1000);  
        	 byte[] b = new byte[1000];  
        	 int n;  
        	 while ((n = fis.read(b)) != -1) {  
           		  bos.write(b, 0, n);  
        	 }  
        	 fis.close();  
        	 bos.close();  
         	byte[] bytes = bos.toByteArray(); 
2.springMVC上传与下载
	a)上传文件
	@RequestMapping("/upload")
	@ResponseBody
	public String upload(@RequestParam("file") MultipartFile file,HttpServletRequest request) throws IOException {
	
		//构建图片文件夹路径
		String path = request.getSession().getServletContext().getRealPath("picture/");
		//如果目录不存在新建目录
		if(!targetFile.exists()){  
	            targetFile.mkdirs();    //新建目录
	    }  
		// 获取文件名
		System.out.println("文件名: " + file.getOriginalFilename());
		// 获取文件类型
		System.out.println("文件类型: " + file.getContentType());
		// 获取文件对应的流
		System.out.println("文件流: " + file.getInputStream());
		// 文件传输
		file.transferTo(new File("D:/" + file.getOriginalFilename()));
		// 判断文件内容是否为空
		file.isEmpty();
		return "success";
	}

	b)下载文件
	@RequestMapping("/download")
	public ResponseEntity<byte[]> download() throws IOException {
		// 先定位文件
		File file = new File("D:/SpringMVC第一次课笔记.txt");
		// 用户设置返回到客户端的消息头
		HttpHeaders headers = new HttpHeaders();
		// 表示返回的内容是一个二进制流
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		// 如果想要将文件以附件的形式下载的话，需要添加一个叫contentDispotion属性
		headers.setContentDispositionFormData("attachment", new String("SpringMVC第一次课笔记.txt".getBytes(), "ISO8859-1"));

		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}
3.配置springMVC multipart注意
	a)web.xml跟springMVC一样
	b)dispatcher-servlet.xml文件配置 要加一个监听器
	<!-- SpringMVC文件上传解析器 -->
	<bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
		<!-- one of the properties available; the maximum file size in bytes -->
		<property name="maxUploadSize" value="2097152"/>
	</bean>