<!DOCTYPE hibernate-configuration PUBLIC
	"-//Hibernate/Hibernate Configuration DTD 3.0//EN"
	"http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">
<hibernate-configuration>
<session-factory>
	<property name="connection.username">root</property>
	<property name="connection.password">123456</property>
	<property name="connection.url">jdbc:mysql://127.0.0.1:3306/test</property>
	<property name="dialect">org.hibernate.dialect.MySQLDialect</property>
	<property name="connection.driver_class">com.mysql.jdbc.Driver</property>
	<property name="hbm2ddl.auto">update</property>
	<property name="show_sql">true</property>
	<property name="format_sql">true</property>
	<property name="myeclipse.connection.profile">test</property>
	<mapping resource="dps/bean/*.hbm.xml" />
	<mapping resource="dps/bean/*.hbm.xml" />
</session-factory>
</hibernate-configuration>