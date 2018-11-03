---

title: java分割字符串的三种方式
date: {{ date }}
categories: learn
tags: [java]
banner: http://img.matosiki.site/sky/20180516.JPG
thumbnail : http://img.matosiki.site/tina/636.webp
---

# 使用java原生**String.split()**方法
```java
String[] splitted = "peter,james,thomas".split(",");  // 逗号分割
String[] splitted = "car jeep scooter".split(" "); // 空格分割
String[] splitted = "192.168.1.178".split("\\.")  // 点分割

String[] splitted = "b a, e, l.d u, n g".split("\\s+|,\\s*|\\.\\s*"));  //则这表达式多个分割符
```


# 使用工具类Common包下的**StringUtils.split()**方法

```java
String[] splitted = StringUtils.split("car jeep scooter"); //默认空白分割
```

# 使用guava工具包的**Splitter**流

```java
List<String> resultList = Splitter.on(',')
  .trimResults()
  .omitEmptyStrings()
  .splitToList("car,jeep,, scooter");
```

总结: String成员方法分割字符串处理简单分割比较容易,但是复杂一点使用工具类还是比较方法. 预先善其事必先利其器,多学习一些工具类的使用,提高开发效率也还不错.

