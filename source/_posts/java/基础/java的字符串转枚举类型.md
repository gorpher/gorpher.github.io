---
title: java的字符串转枚举类型
date: {{ date }}
categories: learn
tags: 
- java
banner: http://img.matosiki.site/sky/20180512.jpg
thumbnail : http://img.matosiki.site/sky/20180511.jpg
---
### 假定一个美酒类型
```java
PizzaStatusEnum readyStatus = PizzaStatusEnum.READY;
```

# 使用 **valueOf("")**方法
```java
@Test
public void whenConvertedIntoEnum_thenGetsConvertedCorrectly() {
  
    String pizzaEnumValue = "READY";
    PizzaStatusEnum pizzaStatusEnum
      = PizzaStatusEnum.valueOf(pizzaEnumValue);
    assertTrue(pizzaStatusEnum == PizzaStatusEnum.READY);
}
```
### 注意: 如果参数不对,会抛出非法参数异常

```java
@Test(expected = IllegalArgumentException.class)
public void whenConvertedIntoEnum_thenThrowsException() {
    String pizzaEnumValue = "invalid";
    PizzaStatusEnum pizzaStatusEnum = PizzaStatusEnum.valueOf(pizzaEnumValue);
}
```