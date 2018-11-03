1.页面用jQuery的ajax
<script type="text/javascript">
	$(function() {
		//当页面加载是，更新表格默认隐藏
		$("#updateTable").hide();
		
		$("#updateUserBtn").click(function() {
			var userId = $("#updateUserId").val();
			var userName = $("#updateUserName").val();
			var userAge = $("#updateUserAge").val();
			
			$.post(
				"${pageContext.request.contextPath}/user_update",
				{"user.id" : userId, "user.userName" : userName, "user.age":userAge},
				function(data) {
				//返回的结果被封装到data中，你想怎么玩就怎么玩 
					console.log(data);
					if(data==true) {

						findAllUser();
					}
				}
				
			);
			$("#updateTable").hide();
		});
	
});
	
2.struts配置文档写返回
#返回类型为stream 将inputStream作为参数返回到页面
<result name="ajax" type="stream">
  				<!-- 表示返回的数据类型为JSON格式 -->
  				<param name="contentType">application/json</param>
  				<param name="inputName">inputStream</param>
</result>

3.action的写法
	//返回到页面的data值
	private InputStream inputStream;
	//实例化一个gson对象
	private Gson gson = new Gson();

	//给这返回值一个getter方法
	public InputStream getInputStream() {
		return inputStream;
	}

	//具体的一个action方法
	public String list() throws Exception {
		List<User> list = userDAO.findAllUser();
		//将list封装到json中
		String result = gson.toJson(list);
		inputStream = new ByteArrayInputStream(result.getBytes("UTF-8"));
		//根据这个返回值确定返回是一个json功能
		return "ajax";
	}