---
title: java字符类型转字符串类型六种方式
date: {{ date }}
categories: learn
tags: 
- java
banner: http://img.matosiki.site/sky/20180513.jpg
thumbnail : http://img.matosiki.site/sky/20180512.jpg
---

# 1. 使用**String.valueOf()**方法
```java
@Test
public void givenChar_whenCallingStringValueOf_shouldConvertToString() {
    char givenChar = 'x';
 
    String result = String.valueOf(givenChar);
 
    assertThat(result).isEqualTo("x");
}
```

# 2. 使用** Character.toString()** 方法
```java
@Test
public void givenChar_whenCallingToStringOnCharacter_shouldConvertToString() {
    char givenChar = 'x';
 
    String result = Character.toString(givenChar);
 
    assertThat(result).isEqualTo("x");
}
```
# 3. 使用**Character**的构造方法
```java
@Test
public void givenChar_whenCallingCharacterConstructor_shouldConvertToString() {
    char givenChar = 'x';
 
    String result = new Character(givenChar).toString();
 
    assertThat(result).isEqualTo("x");
}
```

# 4. 通过String的隐式转换
```java
@Test
public void givenChar_whenConcatenated_shouldConvertToString() {
    char givenChar = 'x';
 
    String result = givenChar + "";
 
    assertThat(result).isEqualTo("x");
}
```

# 5. 
```java
@Test
public void givenChar_whenFormated_shouldConvertToString() {
    char givenChar = 'x';
 
    String result = String.format("%c", givenChar);
 
    assertThat(result).isEqualTo("x");
}
```

总结: 常用Stirng的隐式转换方式.
