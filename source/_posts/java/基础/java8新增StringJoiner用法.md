---
title: java8新增StringJoiner用法
date: {{ date }}
categories: learn
tags: [java]
banner: http://img.matosiki.site/sky/2018052110.jpg
thumbnail : http://img.matosiki.site/sky/2018052105.jpg
---

# 使用java8的StringJoiner连接,附带分割和前缀和后缀

# 1. 添加元素
```java
@Test
public void whenAddingElements_thenJoinedElements() {
    StringJoiner joiner = new StringJoiner(",", PREFIX, SUFFIX);
    joiner.add("Red")
      .add("Green")
      .add("Blue");
 
    assertEquals(joiner.toString(), "[Red,Green,Blue]");
}
```

# 2. 使用for循环添加内容
```java
@Test
public void whenAddingListElements_thenJoinedListElements() {
    List<String> rgbList = new ArrayList<>();
    rgbList.add("Red");
    rgbList.add("Green");
    rgbList.add("Blue");
 
    StringJoiner rgbJoiner = new StringJoiner(
      ",", PREFIX, SUFFIX);
 
    for (String color : rgbList) {
        rgbJoiner.add(color);
    }
 
    assertEquals(rgbJoiner.toString(), "[Red,Green,Blue]");
}
```

# 使用构造方式
```java
private String PREFIX = "[";
private String SUFFIX = "]";
 
@Test
public void whenEmptyJoinerWithoutPrefixSuffix_thenEmptyString() {
    StringJoiner joiner = new StringJoiner(",");
  
    assertEquals(0, joiner.toString().length());
}
 
@Test
public void whenEmptyJoinerJoinerWithPrefixSuffix_thenPrefixSuffix() {
    StringJoiner joiner = new StringJoiner(
      ",", PREFIX, SUFFIX);
  
    assertEquals(joiner.toString(), PREFIX + SUFFIX);
}
```
## 合并Joiner
```java
@Test
public void whenMergingJoiners_thenReturnMerged() {
    StringJoiner rgbJoiner = new StringJoiner(
      ",", PREFIX, SUFFIX);
    StringJoiner cmybJoiner = new StringJoiner(
      "-", PREFIX, SUFFIX);
 
    rgbJoiner.add("Red")
      .add("Green")
      .add("Blue");
    cmybJoiner.add("Cyan")
      .add("Magenta")
      .add("Yellow")
      .add("Black");
 
    rgbJoiner.merge(cmybJoiner);
 
    assertEquals(
      rgbJoiner.toString(), 
      "[Red,Green,Blue,Cyan-Magenta-Yellow-Black]");
}
```
## 使用流
```java
@Test
public void whenUsedWithinCollectors_thenJoined() {
    List<String> rgbList = Arrays.asList("Red", "Green", "Blue");
    String commaSeparatedRGB = rgbList.stream()
      .map(color -> color.toString())
      .collect(Collectors.joining(","));
 
    assertEquals(commaSeparatedRGB, "Red,Green,Blue");
}
```

## 总结: 构造一个简单分割的字符串,使用**StringJoiner**方式很不错,也可以使用流的方式.


