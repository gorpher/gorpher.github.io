```
servlet过滤器首先得在web.mxl配置maping

<?xml version="1.0" encoding="UTF-8"?>
<web-app version="2.5" xmlns="http://java.sun.com/xml/ns/javaee"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee   http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd">
	<!--一个时间的过滤器配置-->
	<filter>
		<filter-name>FilterDay</filter-name>
		<filter-class>com.houpu.filter.FilterDay</filter-class>
	</filter>
	<filter-mapping>
		<filter-name>FilterDay</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
</web-app>

#具体的filter实现
package com.houpu.filter;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

public class FilterDay extends HttpServlet implements Filter {

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		arg0.setCharacterEncoding("utf-8");
		Calendar instance = Calendar.getInstance();
		int hours = instance.get(Calendar.HOUR_OF_DAY);
		arg0.setAttribute("time", instance.get(Calendar.YEAR) + "年"
				+ instance.get(Calendar.MONTH) + "月"
				+ instance.get(Calendar.DAY_OF_MONTH) + "日"
				+ instance.get(Calendar.HOUR_OF_DAY) + "时"
				+ instance.get(Calendar.MINUTE) + "分");
		System.out.println(hours);
		if ((hours <= 24 && hours >= 19) || (hours >= 0 && hours <= 5)) {
		
            //利用dispatcher跳转
			arg0.getRequestDispatcher("black.jsp").forward(arg0, arg1);
			System.out.println("晚上");
		}
		if (hours < 19 && hours >= 14) {
			System.out.println("下午");
			arg0.getRequestDispatcher("guoguo.jsp").forward(arg0, arg1);
			// arg2.doFilter(arg0, arg1);   继续请求、
		}
		if (hours >= 6 && hours <= 12) {
			arg0.getRequestDispatcher("day.jsp").forward(arg0, arg1);
			System.out.println("上午");
		}
		if (hours > 12 && hours < 14) {
			arg0.getRequestDispatcher("day.jsp").forward(arg0, arg1);
			System.out.println("中午");
		}
	}
	public void init(FilterConfig arg0) throws ServletException {

	}

}

```