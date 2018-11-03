---
title: java截取字符串的最后一个字符方法
date: {{ date }}
categories: learn
tags: 
- java
thumbnail: http://img.matosiki.site/tina/640.webp
---

# 1. 原生java方式 先判断是否为空
```java
public static String removeLastChar(String s) {
    return (s == null || s.length() == 0)
      ? null
      : (s.substring(0, s.length() - 1));
}
```
# 2. 使用java8
```java
public static String removeLastCharOptional(String s) {
    return Optional.ofNullable(s)
      .filter(str -> str.length() != 0)
      .map(str -> str.substring(0, str.length() - 1))
      .orElse(s);
}
```

# 3. 使用** apache common lang** StringUtils.substring()

```java
String TEST_STRING = "ACBDEF";
StringUtils.substring(TEST_STRING,0,TEST_STRING.length()-1);

```

# 4. 使用 ** StringUtils.chop()**方法 因对边缘场景的情况（empty or null）时
```java
StringUtils.chop(TEST_STRING)
```

# 5. 使用replaceAll() 的正则表达式方式
```java
public static String removeLastCharRegex(String s) {
    return (s == null) ? null : s.replaceAll(".$", "");
}
// java8
public static String removeLastCharRegexOptional(String s) {
    return Optional.ofNullable(s)
      .map(str -> str.replaceAll(".$", ""))
      .orElse(s);
}
```

### 总结： 以上主要使用substring方法截取字符串，复杂的话建议使用正则表达式方式处理。
