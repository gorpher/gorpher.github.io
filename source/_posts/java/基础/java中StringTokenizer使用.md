---
title: java中StringTokenizer使用
date: {{ date }}
categories: learn
tags: [java]
banner: http://img.matosiki.site/sky/2018052001.jpg
thumbnail : http://img.matosiki.site/sky/20180520.jpg
---

## 使用特殊分割符分割String类型一般使用**StringTokenize()**
# 1. 使用逗号分割,再用枚举递归
```java
public List<String> getTokens(String str) {
    List<String> tokens = new ArrayList<>();
    StringTokenizer tokenizer = new StringTokenizer(str, ",");
    while (tokenizer.hasMoreElements()) {
        tokens.add(tokenizer.nextToken());
    }
    return tokens;
}
```

# 2. 使用java8  
```java
public List<String> getTokensWithCollection(String str) {
    return Collections.list(new StringTokenizer(str, ",")).stream()
      .map(token -> (String) token)  // 注意这里返回类型为Object类型需要强转
      .collect(Collectors.toList());
}
```

# 3. 自定义分割符
```java
tokens.add(tokenizer.nextToken("e"));
```

# 读取CVS文件
```java
public List<String> getTokensFromFile( String path , String delim ) {
    List<String> tokens = new ArrayList<>();
    String currLine = "";
    StringTokenizer tokenizer;
    try (BufferedReader br = new BufferedReader(
        new InputStreamReader(Application.class.getResourceAsStream( 
          "/" + path )))) {
        while (( currLine = br.readLine()) != null ) {
            tokenizer = new StringTokenizer( currLine , delim );
            while (tokenizer.hasMoreElements()) {
                tokens.add(tokenizer.nextToken());
            }
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
    return tokens;
}
```

## 测试
```java
public class TokenizerTest {
 
    private MyTokenizer myTokenizer = new MyTokenizer();
    private List<String> expectedTokensForString = Arrays.asList(
      "Welcome" , "to" , "baeldung.com" );
    private List<String> expectedTokensForFile = Arrays.asList(
      "1" , "IND" , "India" , 
      "2" , "MY" , "Malaysia" , 
      "3", "AU" , "Australia" );
 
    @Test
    public void givenString_thenGetListOfString() {
        String str = "Welcome,to,baeldung.com";
        List<String> actualTokens = myTokenizer.getTokens( str );
  
        assertEquals( expectedTokensForString, actualTokens );
    }
 
    @Test
    public void givenFile_thenGetListOfString() {
        List<String> actualTokens = myTokenizer.getTokensFromFile( 
          "data.csv", "|" );
  
        assertEquals( expectedTokensForFile , actualTokens );
    }
}
```