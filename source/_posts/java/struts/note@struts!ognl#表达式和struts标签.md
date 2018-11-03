OGNL：对象图导航语言,计算表达式的值        
      OGNL取Action的属性值  以及 作用域(需要用#)的值 
      
<!-- 输出表达式(ognl)的值 -->
  	BookName长度:<s:property value="bookName.length()"/><br/>
  	user.userName:<s:property value="user.userName"/><br/>
  	
2、OGNL中的符号：#  { }  ?  ^  $ %

#的作用：取除了根元素（Action的属性）之外的数据
application:<s:property value="#application.proDesp"/><br/>
attr:<s:property value="#attr.proName"/><br/>
{ }的作用：创建集合、数组、Map 、用于过滤和投影
 所有用户的名称集合：<s:property value="userList.{userName}"/><br/>
第一个姓名：<s:property value="userList.{userName}[0]"/><br/>
得到编码大于106的集合：<s:property value="userList.{^#this.userId>106}[0]"/> 


? 选取匹配选择逻辑的所有元素，返回包含多个元素集合

^ 选取匹配选择逻辑的第一个元素，返回包含一个元素集合

$ 选取匹配选择逻辑的最后一个元素，返回包含一个元素集合

% 侧重于表达式 跟el表达式很像，但是一般计算表达式里面的值是从Struts标签里面的值时{}里面加个#如下
% 取后面表达式的值%{#book.booName}
3、总结：
取action的JavaBean属性的值，不需要#，因为该数据存放在根root（ActionContext 上下文  值栈）中
取request、session、application或参数的数据需要根#
#request.name      #session.name      #application.name
#attr.name：不确定范围，自动在request、session、application中搜索

取查询字符串或表单中参数的值：# parameters.name


     
struts2:常用标签(条件判断、循环)
语法：<s:set name="名" value="值 OGNL" scope="数据存放的作用域"></s:set>  不指定scope，默认存放在值栈和request中
代码：<s:set name="loginName" value="%{'张三'}" scope="session"></s:set>  向session作用域中存放一个字符串常量




bookName2:<s:set name="bookName2" value="bookName" scope="session"></s:set> 将值栈中的bookName属性去出来  存入session作用域中，取名为bookName2
语法： <s:date name="OGNL" format="输出格式：yyyy-MM-dd  HH:mm:ss"/>
代码： <s:date name="now" format="yyyy-MM-dd  HH:mm:ss"/>   输出日期 
    
条件判断 

    <s:if test="user.userId<100">
    	小于100<br/>
    </s:if>
    <s:elseif test="user.userId<105">
    	小于105<br/>
    </s:elseif>
    <s:elseif test="user.userId<110">
    	小于110<br/>
    </s:elseif>
    <s:else>
    	大于100<br/>
    </s:else>
    
循环标签 
    <s:iterator begin="1" end="10" var="i" step="2" status="sta">
    	循环的序号是<s:property value="#sta.count"/> : <s:property value="#i"/>
    </s:iterator>
    
循环用表格输出集合的数据 
    <table border="1">
	    <s:iterator value="userList" var="user">
	    	<tr>
	    		<td><s:property value="#user.userId"/> </td>
	    		<td><s:property value="#user.userName"/> </td>
	    		<td><s:property value="#user.userPwd"/> </td>
	    	</tr>
	    </s:iterator>
    </table>

包含页面的静态注入标签    
    <s:include value="top.jsp"></s:include>
    

(2).表单标签
    <s:form action="TestAction2" method="post">
    	<s:textfield label="用户名" name="user.userName"></s:textfield><br/>
    	<s:password label="密码" name="user.userPwd"></s:password><br/>
    	<s:textarea label="简介" cols="20" rows="3" name="user.userInfo"></s:textarea>     	OGNL定义一个List，单选按钮的value 和选项内容都一样   
    	<s:radio label="性别" list="{'男','女','不确定'}" name="user.sex"></s:radio> OGNL定义一个MAP，单选按钮的value为键，选项内容为值
    	<s:radio label="性别" list="#{1:'男',2:'女',3:'不确定'}" name="userSex"></s:radio>
  	 <s:checkboxlist list="{'a','b','c'}" name="user.aiHao" label="爱好"></s:checkboxlist>
    	 
下拉列表是固定的值 
静态设置  	 <s:select list="{'中国','美国','韩国'}" name="userGJ" label="国籍"></s:select>
    	  
下拉列表的值来自集合
动态设置    	  <s:select list="OGNL表达式的集合" name="名称" label="文本" listKey="option的value" listValue="选项内容"></s:select>
 			
     	  	<s:select list="userList" name="user.guoJi" label="国籍" listKey="userId" listValue="userName"></s:select>
    	  
  <s:submit value="注册"></s:submit>
    </s:form>