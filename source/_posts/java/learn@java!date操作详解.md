# java 处理时间

## java相关时间日期类
　　java.util.Date。实现类，其对象具有时间、日期组件。
　　java.util.Calendar。抽象类，其对象具有时间、日期组件。
　　java.sql.Date。实现类，其对象具有日期组件。
　　java.sql.Time。实现类，其对象具有时间组件。
　　java.sql.Timestamp。实现类，其对象具有时间日期组件。
　　java.text.DateFormat。抽象类，其对象格式化时间日期。

    java8新增
    java.time.*  Clock、Duration、LocalDate、LocalTime、LocalDateTime、MonthDay、Year、YearMonth、DayOfWeek、Month。

## 认识时间
时间数字字符格式
YYYY/MM/DD HH:MM:SS ± timezone(时区用4位数字表示)
// 1992/02/12 12:23:22+0800

iso 8601
YYYY-MM-DDThh:mm:ss ± timezone(时区用HH:MM表示)
1997-07-16T08:20:30Z
// “Z”表示UTC标准时区，即"00:00",所以这里表示零时区的`1997年7月16日08时20分30秒`
//转换成位于东八区的北京时间则为`1997年7月17日16时20分30秒`
1997-07-16T19:20:30+01:00
// 表示东一区的1997年7月16日19时20秒30分，转换成UTC标准时间的话是1997-07-16T18:20:30Z

注意: **GMT**是格林威治标准时间  **UTC**是世界时间标准  UTC 比GMT 更加精准
**ISO 8601** 是日期和时间的表示方法
## 公式: 日期时间=  日期 +时间 (处理日期 和 时间分开操作)

在计算机中所有的时间都可以用数字存储 **时间日期** 也不例外
在Java 1.0中，对日期和时间的支持只能依赖java.util.Date类
java.util.Date java 最初的时间日期处理类 ,可以处理时间和日期 ,但是很多方法已近过期
java.util.Calendar  处理日历日期     儒略历和格里历   日本历 佛教日历
java.sql.Date  继承的是util.Date类 处理**日期**
java.sql.Time  extends java.util.Date  处理**时间**
abstract class DateFormat extends Format 格式化**日期**   但是不是线程安全的
class SimpleDateFormat extends DateFormat  实现dataformat类 格式化 **日期时间**

// 第三方时间日期库Joda-Time

//使用java8 新日期时间处理 
首先三大类 : LocalDateTime(处理日期和时间) = LocalDate(处理日期)  + LocalTime(处理时间)  (不附带任何与时区相关
的信息)
DateTimeFormatter 代替 Dateformat 进行日期格式化

java.time.Instant类对时间建模的方式 (从1970-1-1 开始计算)  (Instant的设计初衷是为了便于机器使用)

新的java.time.ZoneId 类是老版java.util.TimeZone的替代品

新版的日期和时间API中，日期时间对象是不可变的。 
新的API提供了两种不同的时间表示方式，有效地区分了运行时人和机器的不同需求。

TemporalAdjuster让你能够用更精细的方式操纵日期，不再局限于一次只能改变它的一个值，并且你还可按照需求定义自己的日期转换器。

你现在可以按照特定的格式需求，定义自己的格式器，打印输出或者解析日期时间对象。这些格式器可以通过模板创建，也可以自己编程创建，并且它们都是线程安全的。



## timestamp
```java
// 利用系统标准时间创建
Timestamp timestamp = new Timestamp(System.currentTimeMillis());

// 从 Date 对象中创建
new Timestamp((new Date()).getTime());

// 获取自 1970-01-01 00:00:00 GMT 以来的毫秒数
timestamp.getTime();
```

## in java8 
