---

title: java中字符串转字节流
date: {{ date }}
categories: learn
tags: [java]
banner: http://img.matosiki.site/sky/20180518.jpg
thumbnail : http://img.matosiki.site/sky/2018051801.jpg
---

# 1. 使用**chars()**方法 返回IntStream
```java
String testString = "String";
IntStream intStream = testString.chars();  // 获取 数字流 ,所以我们需要转换

Stream<Character> characterStream = testString.chars()
                        .mapToObj(c -> (char) c);  // 使用mapToObj强转
```

# 2. 使用**codePoint()**方法 得到点码,再强转.
```java
Stream<Character> characterStream2  = testString.codePoints()
                                .mapToObj(c -> (char) c);

// 也可以转换成单个字符串流
Stream<String> stringStream = testString.codePoints()
                    .mapToObj(c -> String.valueOf((char) c));
```

总结: 通过字符串转换整型流,也可以转换字节流,还可以转换单个字符串流.