---
title: java使用apache common工具类
date: {{ date }}
categories: learn
tags: [java]
banner: http://img.matosiki.site/sky/2018052200.jpg
thumbnail : http://img.matosiki.site/sky/2018052230.jpg
---
 
# 查询字符串中出现任意字符
```java
String string = "baeldung.com";
boolean contained1 = StringUtils.containsAny(string, 'a', 'b', 'c');
boolean contained2 = StringUtils.containsAny(string, 'x', 'y', 'z');
boolean contained3 = StringUtils.containsAny(string, "abc");
boolean contained4 = StringUtils.containsAny(string, "xyz");
  
assertTrue(contained1);
assertFalse(contained2);
assertTrue(contained3);
assertFalse(contained4);
// 忽略大小写
String string = "matosiki.com";
boolean contained = StringUtils.containsIgnoreCase(string, "MATOSIKI");
  
assertTrue(contained);
```
# 匹配出现次数方法
```java
String string = "welcome to www.matosiki.com";
int charNum = StringUtils.countMatches(string, 'w');
int stringNum = StringUtils.countMatches(string, "com");
  
assertEquals(4, charNum);
assertEquals(2, stringNum);
```

# 匹配前缀和后缀的方法
```java
String string = "matosiki.com";
String stringWithSuffix = StringUtils.appendIfMissing(string, ".com");
String stringWithPrefix = StringUtils.prependIfMissing(string, "www.");
  
assertEquals("matosiki.com", stringWithSuffix);
assertEquals("www.matosiki.com", stringWithPrefix);
```
# 改变大小写
```java
String originalString = "matosiki.COM";
String swappedString = StringUtils.swapCase(originalString);
  
assertEquals("MATOSIKI.com", swappedString);

// 首字母大写
String capitalizedString = StringUtils.capitalize(originalString);
  
assertEquals("Matosiki.COM", capitalizedString);
//首字母不大写
String uncapitalizedString = StringUtils.uncapitalize(originalString);
  
assertEquals("matosiki.COM", uncapitalizedString);
```

# 翻转字符串
```java
String originalString = "matosiki";
String reversedString = StringUtils.reverse(originalString);
  
assertEquals("ikisotam", reversedString);
// 分割式翻转
String originalString = "www.matosiki.com";
String reversedString = StringUtils.reverseDelimited(originalString, '.');
  
assertEquals("com.matosiki.www", reversedString);
```

# 使用**rotate()**方法旋转
```java
String originalString = "matosiki";
String rotatedString = StringUtils.rotate(originalString, 4);
  
assertEquals("sikimatos", rotatedString);
```
# 比较不同
```java
String tutorials = "Baeldung Tutorials";
String courses = "Baeldung Courses";
String diff1 = StringUtils.difference(tutorials, courses);
String diff2 = StringUtils.difference(courses, tutorials);
  
assertEquals("Courses", diff1);
assertEquals("Tutorials", diff2);
```

总结: 使用StringUtils对字符串进行一些常用操作

