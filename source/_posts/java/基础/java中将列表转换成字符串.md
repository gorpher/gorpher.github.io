---
title: java中将列表转换成字符串
date: {{ date }}
categories: learn
tags: [java]
banner: http://img.matosiki.site/sky/20180512.jpg
thumbnail : http://img.matosiki.site/sky/20180510.jpg
---

### 1. 直接打印
```java
@Test
public void whenListToString_thenPrintDefault() {
    List<Integer> intLIst = Arrays.asList(1, 2, 3);
  
    System.out.println(intLIst);  //这个方式,对简单类型对象适用
}
```

### 2. 实用**stream**方式转换
```java
@Test
public void whenCollectorsJoining_thenPrintCustom() {
    List<Integer> intList = Arrays.asList(1, 2, 3);
    String result = intList.stream()
      .map(n -> String.valueOf(n))
      .collect(Collectors.joining("-", "{", "}"));
  
    System.out.println(result);
}
```

### 3. 实用**Common lang** 工具
```java
@Test
public void whenStringUtilsJoin_thenPrintCustom() {
    List<Integer> intList = Arrays.asList(1, 2, 3);
  
    System.out.println(StringUtils.join(intList, "|"));
}
```
总结: 简单的类型可以直接打印,但是复杂自定义对象建议使用流方式打印.