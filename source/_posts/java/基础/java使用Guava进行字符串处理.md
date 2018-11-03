---
title: java使用Guava **CharMatcher** 进行字符串处理
date: {{ date }}
categories: learn
tags: [java]
banner: http://img.matosiki.site/sky/2018052201.jpg
thumbnail : http://img.matosiki.site/sky/2018052210.jpg
---
 

# java使用Guava进行字符串处理

## 从字符串中删除特定的字符
```java
@Test
public void whenRemoveSpecialCharacters_thenRemoved(){
    String input = "H*el.lo,}12";
    CharMatcher matcher = CharMatcher.JAVA_LETTER_OR_DIGIT;
    String result = matcher.retainFrom(input);
 
    assertEquals("Hello12", result);
}
```

## 从字符串中删除不是字符串
```java
@Test
public void whenRemoveNonASCIIChars_thenRemoved() {
    String input = "あhello₤";
 
    String result = CharMatcher.ASCII.retainFrom(input);
    assertEquals("hello", result);
 
    result = CharMatcher.inRange('0', 'z').retainFrom(input);
    assertEquals("hello", result);
}
```

## 删除不在字符集中的字符
```java
@Test
public void whenRemoveCharsNotInCharset_thenRemoved() {
    Charset charset = Charset.forName("cp437");
    CharsetEncoder encoder = charset.newEncoder();
 
    Predicate<Character> inRange = new Predicate<Character>() {
        @Override
        public boolean apply(Character c) {
            return encoder.canEncode(c);
        }
    };
 
    String result = CharMatcher.forPredicate(inRange)
                               .retainFrom("helloは");
    assertEquals("hello", result);
}
```
## 验证字符串
```java
@Test
public void whenValidateString_thenValid(){
    String input = "hello";
 
    boolean result = CharMatcher.JAVA_LOWER_CASE.matchesAllOf(input);
    assertTrue(result);
 
    result = CharMatcher.is('e').matchesAnyOf(input);
    assertTrue(result);
 
    result = CharMatcher.JAVA_DIGIT.matchesNoneOf(input);
    assertTrue(result);
}
```
## 去除字符串空格
```java
@Test
public void whenTrimString_thenTrimmed() {
    String input = "---hello,,,";
 
    String result = CharMatcher.is('-').trimLeadingFrom(input);
    assertEquals("hello,,,", result);
 
    result = CharMatcher.is(',').trimTrailingFrom(input);
    assertEquals("---hello", result);
 
    result = CharMatcher.anyOf("-,").trimFrom(input);
    assertEquals("hello", result);
}

```

## 折叠字符串
```java
@Test
public void whenCollapseFromString_thenCollapsed() {
    String input = "       hel    lo      ";
 
    String result = CharMatcher.is(' ').collapseFrom(input, '-');
    assertEquals("-hel-lo-", result);
 
    result = CharMatcher.is(' ').trimAndCollapseFrom(input, '-');
    assertEquals("hel-lo", result);
}
```
## 替换字符串
```java
@Test
public void whenReplaceFromString_thenReplaced() {
    String input = "apple-banana.";
 
    String result = CharMatcher.anyOf("-.").replaceFrom(input, '!');
    assertEquals("apple!banana!", result);
 
    result = CharMatcher.is('-').replaceFrom(input, " and ");
    assertEquals("apple and banana.", result);
}
```

## 统计字串串出现的次数
```java
@Test
public void whenCountCharInString_thenCorrect() {
    String input = "a, c, z, 1, 2";
 
    int result = CharMatcher.is(',').countIn(input);
    assertEquals(4, result);
 
    result = CharMatcher.inRange('a', 'h').countIn(input);
    assertEquals(2, result);
}
```

总结: 使用**CharMatcher**处理字符串,简单方便.