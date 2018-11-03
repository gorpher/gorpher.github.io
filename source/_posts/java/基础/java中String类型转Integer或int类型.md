---

title: java中String类型转Integer或int类型
date: {{ date }}
categories: learn
tags: [java]
banner: http://img.matosiki.site/sky/20180515.jpg
thumbnail : http://img.matosiki.site/sky/20180514.jpg
---


# 1. 使用** Integer.parseInt() **
```java
@Test
public void givenString_whenParsingInt_shouldConvertToInt() {
    String givenString = "42";
 
    int result = Integer.parseInt(givenString);
 
    assertThat(result).isEqualTo(42);
}
```
# 2. 使用**  Integer.valueOf() ** ,(不建议使用)内部使用缓存机制
```java
@Test
public void givenString_whenCallingIntegerValueOf_shouldConvertToInt() {
    String givenString = "42";
 
    Integer result = Integer.valueOf(givenString);
 
    assertThat(result).isEqualTo(new Integer(42));
}
```
# 3. 使用Integer构造方法 
```java
@Test
public void givenString_whenCallingIntegerConstructor_shouldConvertToInt() {
    String givenString = "42";
 
    Integer result = new Integer(givenString);
 
    assertThat(result).isEqualTo(new Integer(42));
}
```
# 4. 使用 **Integer.decode()**方法
```java
@Test
public void givenString_whenCallingIntegerDecode_shouldConvertToInt() {
    String givenString = "42";
 
    int result = Integer.decode(givenString);
 
    assertThat(result).isEqualTo(42);
}
```
### 以上方法如果转换错误会抛出**NumberFormatException**异常
```java
@Test(expected = NumberFormatException.class)
public void givenInvalidInput_whenParsingInt_shouldThrow() {
    String givenString = "nan";
    Integer.parseInt(givenString);
}
```
# 5. 使用guava 工具 ,如果解析失败,会跳过返回空值
```java
@Test
public void givenString_whenTryParse_shouldConvertToInt() {
    String givenString = "42";
 
    Integer result = Ints.tryParse(givenString);
 
    assertThat(result).isEqualTo(42);
}
```

总结: 使用java原生方式简单,但每次要考虑到解析异常也挺烦的,建议使用guava 的**Ints.tryParse**方法