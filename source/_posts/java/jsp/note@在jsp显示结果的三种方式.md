

###1,java代码
```
		<table>
			<tr>
				<td>
					用户名
				</td>
				<td>
					密码
				</td>
			</tr>
			<%
				Map<String, Integer> result = (Map<String, Integer>) request
						.getAttribute("result");
				for (Map.Entry<String, Integer> entry : result.entrySet()) {
			%>
			<tr>
				<td><%=entry.getKey()%></td>
				<td><%=entry.getValue()%></td>
			</tr>
			<%
				}
			%>
		</table>
```
---------
###2,jstl
```
		<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<table>
			<tr>
				<td>
					用户名
				</td>
				<td>
					密码
				</td>
			</tr>
			<c:forEach items="${result}" var="entry">
				<tr>
					<td>
						${entry.key}
					</td>
					<td>
						${${entry.value}
					</td>
				</tr>
			</c:forEach>
		</table>
```
-------
		
###3,struts标签
```
		<%@taglib prefix="s" uri="/struts-tags"%>
		<table>
			<tr>
				<td>
					用户名
				</td>
				<td>
					密码
				</td>
			</tr>
			<s:iterator value="result">
				<tr>
					<td>
						<s:property value="key" />
					</td>
					<td>
						<s:property value="value" />
					</td>
				</tr>
			</s:iterator>
		</table>
```