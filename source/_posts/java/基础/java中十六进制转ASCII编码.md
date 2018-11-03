---
title: java中十六进制转ASCII编码
date: {{ date }}
categories: learn
tags: [java]
banner: http://img.matosiki.site/sky/20180519.jpg
thumbnail : http://img.matosiki.site/sky/2018051901.jpg
---

# 将字符串转换成十六进制
1. 将每个字符串转换成数组
2. 将数组中字符转换成整型
3. 使用Integer.toHexString()方法转换成十六进制

```java
private static String asciiToHex(String asciiStr) {
    char[] chars = asciiStr.toCharArray();
    StringBuilder hex = new StringBuilder();
    for (char ch : chars) {
        hex.append(Integer.toHexString((int) ch));
    }
 
    return hex.toString();
}
```

1. 截断一个十六进制为两个字符组
2. 使用**Integer.parseInt(hex, 16)**方法强转字符
3. 把每个字符添加的**StringBuilder**上

```java
private static String hexToAscii(String hexStr) {
    StringBuilder output = new StringBuilder("");
     
    for (int i = 0; i < hexStr.length(); i += 2) {
        String str = hexStr.substring(i, i + 2);
        output.append((char) Integer.parseInt(str, 16));
    }
     
    return output.toString();
}
```

## 测试
```java
@Test
public static void whenHexToAscii() {
    String asciiString = "www.matosiki.com";
    String hexEquivalent = 
      "3737373737373265363236313635366336343735366536373265363336663664";
 
    assertEquals(asciiString, hexToAscii(hexEquivalent));
}
 
@Test
public static void whenAsciiToHex() {
    String asciiString = "www.matosiki.com";
    String hexEquivalent = 
      "3737373737373265363236313635366336343735366536373265363336663664";
 
    assertEquals(hexEquivalent, asciiToHex(asciiString));
}
```
总结: 以上同16进制与ascii码相互转换.