---
title: java统计字符串中字符出现的次数
date: {{ date }}
categories: learn
tags: 
- java
thumbnail: 	http://img.matosiki.site/tina/638.webp
---

# 1. 使用java原生方式for循环
```java
String someString = "elephant";
char someChar = 'e';
int count = 0;
  
for (int i = 0; i < someString.length(); i++) {
    if (someString.charAt(i) == someChar) {
        count++;
    }
}
assertEquals(2, count);
```


# 2. 使用java原生递归调用
```java
private static int countOccurences(
  String someString, char searchedChar, int index) {
    if (index >= someString.length()) {
        return 0;
    }
     
    int count = someString.charAt(index) == searchedChar ? 1 : 0;
    return count + countOccurences(
      someString, searchedChar, index + 1);
}
```
# 3. 使用正则表达式
```java
Pattern pattern = Pattern.compile("[^e]*e");
Matcher matcher = pattern.matcher("elephant");
int count = 0;
while (matcher.find()) {
    count++;
}
  
assertEquals(2, count);
```

# 4.使用java8
```java
String someString = "elephant";
long count = someString.chars().filter(ch -> ch == 'e').count();
assertEquals(2, count);
 
long count2 = someString.codePoints().filter(ch -> ch == 'e').count();
assertEquals(2, count2);
```
---- 
## 使用外部jar包
# 5. 使用lang包
```java
int count = StringUtils.countMatches("elephant", "e");
assertEquals(2, count);
```

# 6. 使用guava
```java
int count = CharMatcher.is('e').countIn("elephant");
assertEquals(2, count);
```
# 7.使用spring utils
```java
int count = StringUtils.countOccurrencesOf("elephant", "e");
assertEquals(2, count);
```
总结: 原生方式简单粗暴,也可以使用其他工具类,但使用java8感觉最优雅.