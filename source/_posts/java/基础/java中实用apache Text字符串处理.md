---
title: java中实用apache Text字符串处理
date: {{ date }}
categories: learn
tags: [java]
banner: http://img.matosiki.site/sky/2018052202.jpg
thumbnail : http://img.matosiki.site/sky/2018052220.jpg
---

## 首字母大写
```java
@Test
public void whenCapitalized_thenCorrect() {
    String toBeCapitalized = "to be capitalized!";
    String result = WordUtils.capitalize(toBeCapitalized);
     
    assertEquals("To Be Capitalized!", result);
}
```
## 判断字符串中存在的字符
```java
@Test
public void whenContainsWords_thenCorrect() {
    boolean containsWords = WordUtils
      .containsAllWords("String to search", "to", "search");
     
    assertTrue(containsWords);
}
```

## 使用**StrSubstitutor**建立字符串模板
```java
@Test
public void whenSubstituted_thenCorrect() {
    Map<String, String> substitutes = new HashMap<>();
    substitutes.put("name", "John");
    substitutes.put("college", "University of Stanford");
    String templateString = "My name is ${name} and I am a student at the ${college}.";
    StrSubstitutor sub = new StrSubstitutor(substitutes);
    String result = sub.replace(templateString);
     
    assertEquals("My name is John and I am a student at the University of Stanford.", result);
}
```
 
## 使用**StrBuilder**替代原生**StirngBuilder** 方便替换字串串内容
```java
@Test
public void whenReplaced_thenCorrect() {
    StrBuilder strBuilder = new StrBuilder("example StrBuilder!");
    strBuilder.replaceAll("example", "new");
    
    assertEquals(new StrBuilder("new StrBuilder!"), strBuilder);
    //清理StrBuilder
    strBuilder.clear()
}

```

## 比较字符串不同次数
```java
@Test
public void whenEditScript_thenCorrect() {
    StringsComparator cmp = new StringsComparator("ABCFGH", "BCDEFG");
    EditScript<Character> script = cmp.getScript();
    int mod = script.getModifications();
     
    assertEquals(4, mod);
}
```

## 使用**text.similarily**方便比较字符串的不同程度
```java
// 得到相同数量
@Test
public void whenCompare_thenCorrect() {
    LongestCommonSubsequence lcs = new LongestCommonSubsequence();
    int countLcs = lcs.apply("New York", "New Hampshire");
     
    assertEquals(5, countLcs);
}
// 得到不同数量
@Test
public void whenCalculateDistance_thenCorrect() {
    LongestCommonSubsequenceDistance lcsd = new LongestCommonSubsequenceDistance();
    int countLcsd = lcsd.apply("New York", "New Hampshire");
     
    assertEquals(11, countLcsd);
}
```

## 自定义传唤字符串
```java
@Test
public void whenTranslate_thenCorrect() {
    UnicodeEscaper ue = UnicodeEscaper.above(0);
    String result = ue.translate("ABCD");
     
    assertEquals("\\u0041\\u0042\\u0043\\u0044", result);
}
```
