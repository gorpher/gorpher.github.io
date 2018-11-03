<%@ page import="java.net.*,java.util.*,java.lang.*,java.io.*"%>
<%@ page contentType="text/xml;charset=utf-8"%>
<%
String url = null;
StringBuffer params = new StringBuffer();
Enumeration enu = request.getParameterNames();
int total = 0;
while (enu.hasMoreElements()) {
String paramName=(String)enu.nextElement();
if(paramName.equals("url")){
   url=request.getParameter(paramName);
}else{
   if(total==0){
    params.append(paramName).append("=").append(URLEncoder.encode(request.getParameter(paramName), "UTF-8"));
   } else {
    params.append("&").append(paramName).append("=").append(URLEncoder.encode(request.getParameter(paramName), "UTF-8"));
   }
   ++total;
}
}
//url = url + "?" + params.toString();

if(url != null){
URL connect = new URL(url.toString());
URLConnection connection = connect.openConnection();
connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
connection.setDoInput(true);
connection.setDoOutput(true);
connection.connect();
BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"utf-8"));
String line;
//StringBuilder json = new StringBuilder();  
while((line = reader.readLine()) != null){
	//json.append(line);  
  out.println(line);
}
//json.toString();  
//System.out.println(json.toString());
//out.print(json.toString());
//创建于2017/3/26 希望以后写出其他代理方法
reader.close();
}
%>