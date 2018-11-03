---
title: java生成随机字符串的五种方式
date: {{ date }}
categories: learn
tags: 
- java
thumbnail: http://img.matosiki.site/tina/639.webp
---

# 1. 使用原生java生成无边界字符串
```java
@Test
public void givenUsingPlainJava_whenGeneratingRandomStringUnbounded_thenCorrect() {
    byte[] array = new byte[7]; // length is bounded by 7
    new Random().nextBytes(array);
    String generatedString = new String(array, Charset.forName("UTF-8"));
 
    System.out.println(generatedString);
}
```
# 2.使用原生java生成右边界字符串
```java
@Test
public void givenUsingPlainJava_whenGeneratingRandomStringBounded_thenCorrect() {
  
    int leftLimit = 97; // letter 'a'
    int rightLimit = 122; // letter 'z'
    int targetStringLength = 10;
    Random random = new Random();
    StringBuilder buffer = new StringBuilder(targetStringLength);
    for (int i = 0; i < targetStringLength; i++) {
        int randomLimitedInt = leftLimit + (int) 
          (random.nextFloat() * (rightLimit - leftLimit + 1));
        buffer.append((char) randomLimitedInt);
    }
    String generatedString = buffer.toString();
 
    System.out.println(generatedString);
}
```
# 3.使用 **apache common lang** 生成有边界字符串(只用字母)
```java
@Test
public void givenUsingApache_whenGeneratingRandomStringBounded_thenCorrect() {
  
    int length = 10;
    boolean useLetters = true;
    boolean useNumbers = false;
    String generatedString = RandomStringUtils.random(length, useLetters, useNumbers);
 
    System.out.println(generatedString);
}
```
# 4. 使用 **apache common lang** 生成有边界字母
```java
@Test
public void givenUsingApache_whenGeneratingRandomAlphabeticString_thenCorrect() {
    String generatedString = RandomStringUtils.randomAlphabetic(10);
 
    System.out.println(generatedString);
}
```
# 5. 使用 **apache common lang** 生成有边界字母和数字
```java
@Test
public void givenUsingApache_whenGeneratingRandomAlphanumericString_thenCorrect() {
    String generatedString = RandomStringUtils.randomAlphanumeric(10);
    System.out.println(generatedString);
}
```

### 总结: 使用lang包的生成方式简单,自己原生方式也可以实现.
