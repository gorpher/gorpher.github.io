
1.The Struts dispatcher cannot be found.  This is usually caused by using Struts tags without the associated filter. Struts tags are only usable when the request has passed through its servlet filter, which initializes the Struts dispatcher needed for this tag. - [unknown location]
在web.xml中加入
	<filter-mapping>
		<filter-name>struts2</filter-name>
		<url-pattern>*.jsp</url-pattern>
	</filter-mapping>

