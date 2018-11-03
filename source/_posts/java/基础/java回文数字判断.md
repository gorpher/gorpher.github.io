---
title: java回文数字判断方式
date: {{ date }}
categories: learn
tags: [java]
banner: http://img.matosiki.site/banner/music1.jpg
thumbnail: http://img.matosiki.site/tina/637.webp
---

# 1. 使用原生java方式
```java
public boolean isPalindrome(String text) {
    String clean = text.replaceAll("\\s+", "").toLowerCase();
    int length = clean.length();
    int forward = 0;
    int backward = length - 1;
    while (backward > forward) { //两边指针同时变动,比较.
        char forwardChar = clean.charAt(forward++);
        char backwardChar = clean.charAt(backward--);
        if (forwardChar != backwardChar)
            return false;
    }
    return true;
}
```
# 2. 使用字符串reverse比较
```java
public boolean isPalindromeReverseTheString(String text) {
    StringBuilder reverse = new StringBuilder();
    String clean = text.replaceAll("\\s+", "").toLowerCase();
    char[] plain = clean.toCharArray();
    for (int i = plain.length - 1; i >= 0; i--) {
        reverse.append(plain[i]);
    }
    return (reverse.toString()).equals(clean);
}
```
# 3. 使用**stringbuffer **和**stringbuilder**直接翻转字符串比较
```java
public boolean isPalindromeUsingStringBuilder(String text) {
    String clean = text.replaceAll("\\s+", "").toLowerCase();
    StringBuilder plain = new StringBuilder(clean);
    StringBuilder reverse = plain.reverse();
    return (reverse.toString()).equals(clean);
}
 
public boolean isPalindromeUsingStringBuffer(String text) {
    String clean = text.replaceAll("\\s+", "").toLowerCase();
    StringBuffer plain = new StringBuffer(clean);
    StringBuffer reverse = plain.reverse();
    return (reverse.toString()).equals(clean);
}
```
# 4. 使用java8 intStream
```java
public boolean isPalindromeUsingIntStream(String text) {
    String temp  = text.replaceAll("\\s+", "").toLowerCase();
    return IntStream.range(0, temp.length() / 2)
      .noneMatch(i -> temp.charAt(i) != temp.charAt(temp.length() - i - 1));
}
```
# 5. 使用递归调用
```java
public boolean isPalindromeRecursive(String text){
    String clean = text.replaceAll("\\s+", "").toLowerCase();
    return recursivePalindrome(clean,0,clean.length()-1);
}
 
private boolean recursivePalindrome(String text, int forward, int backward) {
    if (forward == backward) {
        return true;
    }
    if ((text.charAt(forward)) != (text.charAt(backward))) {
        return false;
    }
    if (forward < backward + 1) {
        return recursivePalindrome(text, forward + 1, backward - 1);
    }
 
    return true;
}
```

总结: 回文数验证分两种 一种是**移动下标**比较 另一种是 **翻转** 比较,翻转比较性能没有下标比较好,
所以建议使用java8 InStrean**nomatch**方法
