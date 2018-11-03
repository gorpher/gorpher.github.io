

> Java 打印字符串
```java
System.out.print("Amit Shekhar");
System.out.println("Amit Shekhar");
```
> Kotlin
```java
print("Amit Shekhar")
println("Amit Shekhar")
```
> java 声明字符串

```java
String name = "Amit Shekhar";
final String name = "Amit Shekhar";
``
> kotlin
```java
var name = "Amit Shekhar"
val name = "Amit Shekhar"   
```
> java  声明变量并赋值
```java
String otherName;
otherName = null;
```
> kotlin
```java
var otherName : String?
otherName = null
```
> java 判断是否为空
```java
if (text != null) {
  int length = text.length();
}
```
> kotlin
```java
text?.let {
    val length = text.length
}
// or simple
val length = text?.length
```
> java 连接字符串
```java
String firstName = "Amit";
String lastName = "Shekhar";
String message = "My name is: " + firstName + " " + lastName;
```
> kotlin  表达式
```java
val firstName = "Amit"
val lastName = "Shekhar"
val message = "My name is: $firstName $lastName"
```

> java      多行打印字符串
```java
String text = "First Line\n" +
              "Second Line\n" +
              "Third Line";
```
> kotlin
```java
val text = """
        |First Line
        |Second Line
        |Third Line
        """.trimMargin()
```
> java      三目运算
```java
String text = x > 5 ? "x > 5" : "x <= 5";

String message = null;
log(message != null ? message : "");
```
> kotlin
```java
val text = if (x > 5)
              "x > 5"
           else "x <= 5"
	   
val message: String? = null
log(message ?: "")
```
> java  逻辑运算符
```java
final int andResult  = a & b;
final int orResult   = a | b;
final int xorResult  = a ^ b;
final int rightShift = a >> 2;
final int leftShift  = a << 2;
```
> kotlin
```java
val andResult  = a and b
val orResult   = a or b
val xorResult  = a xor b
val rightShift = a shr 2
val leftShift  = a shl 2
```
> java      对象比较
```java
if (object instanceof Car) {
}
Car car = (Car) object;
```
> kotlin
```java
if (object is Car) {
}
var car = object as Car

// if object is null
var car = object as? Car // var car = object as Car?
```
> java      对象比较 对象类型转换
```java
if (object instanceof Car) {
   Car car = (Car) object;
}
```
> kotlin    
```java
if (object is Car) {
   var car = object // smart casting
}

// if object is null
if (object is Car?) {
   var car = object // smart casting, car will be null
}
```
> java      if条件
```java
if (score >= 0 && score <= 300) { }
```
> kotlin
```java
if (score in 0..300) { }
```
> java  switch 
```java
int score = // some score;
String grade;
switch (score) {
	case 10:
	case 9:
		grade = "Excellent";
		break;
	case 8:
	case 7:
	case 6:
		grade = "Good";
		break;
	case 5:
	case 4:
		grade = "Ok";
		break;
	case 3:
	case 2:
	case 1:
		grade = "Fail";
		break;
	default:
	    grade = "Fail";				
}
```
> kotlin
```java
var score = // some score
var grade = when (score) {
	9, 10 -> "Excellent" 
	in 6..8 -> "Good"
	4, 5 -> "Ok"
	in 1..3 -> "Fail"
	else -> "Fail"
}
```
> java      for循环
```java
for (int i = 1; i <= 10 ; i++) { }

for (int i = 1; i < 10 ; i++) { }

for (int i = 10; i >= 0 ; i--) { }

for (int i = 1; i <= 10 ; i+=2) { }

for (int i = 10; i >= 0 ; i-=2) { }

for (String item : collection) { }

for (Map.Entry<String, String> entry: map.entrySet()) { }
```
> kotlin
```java
for (i in 1..10) { }

for (i in 1 until 10) { }

for (i in 10 downTo 0) { }

for (i in 1..10 step 2) { }

for (i in 10 downTo 1 step 2) { }

for (item in collection) { }

for ((key, value) in map) { }
```
> java      list 和 map
```java
final List<Integer> listOfNumber = Arrays.asList(1, 2, 3, 4);

final Map<Integer, String> keyValue = new HashMap<Integer, String>();
map.put(1, "Amit");
map.put(2, "Ali");
map.put(3, "Mindorks");

// Java 9
final List<Integer> listOfNumber = List.of(1, 2, 3, 4);

final Map<Integer, String> keyValue = Map.of(1, "Amit",
                                             2, "Ali",
                                             3, "Mindorks");
```
> kotlin
```java
val listOfNumber = listOf(1, 2, 3, 4)
val keyValue = mapOf(1 to "Amit",
                     2 to "Ali",
                     3 to "Mindorks")
```
> java      foreach循环 stream流
```java
// Java 7 and below
for (Car car : cars) {
  System.out.println(car.speed);
}

// Java 8+
cars.forEach(car -> System.out.println(car.speed));

// Java 7 and below
for (Car car : cars) {
  if (car.speed > 100) {
    System.out.println(car.speed);
  }
}

// Java 8+
cars.stream().filter(car -> car.speed > 100).forEach(car -> System.out.println(car.speed));
```
> kotlin
```java
cars.forEach {
    println(it.speed)
}

cars.filter { it.speed > 100 }
      .forEach { println(it.speed)}

// kotlin 1.1+
cars.stream().filter { it.speed > 100 }.forEach { println(it.speed)}
cars.parallelStream().filter { it.speed > 100 }.forEach { println(it.speed)}
```
> java      字符串截取
```java
String[] splits = "param=car".split("=");
String param = splits[0];
String value = splits[1];
```
> kotlin
```java
val (param, value) = "param=car".split("=")
```
> java      定义方法
```java
void doSomething() {
   // logic here
}
```
> kotlin
```java
fun doSomething() {
   // logic here
}
```
> java      定义方法并返回数据
```java
int getScore() {
   // logic here
   return score;
}
```
> kotlin
```java
fun getScore(): Int {
   // logic here
   return score
}

// as a single-expression function

fun getScore(): Int = score
```
> java      定义有参有返回方法
```java
int getScore(int value) {
    // logic here
    return 2 * value;
}
```
> kotlin
```java
fun getScore(value: Int): Int {
   // logic here
   return 2 * value
}
// as a single-expression function
fun getScore(value: Int): Int = 2 * value
```

> java      定义工具类
```java
public class Utils {

    private Utils() { 
      // This utility class is not publicly instantiable 
    }
    
    public static int getScore(int value) {
        return 2 * value;
    }
    
}
```
> kotlin
```java
class Utils private constructor() {

    companion object {
    
        fun getScore(value: Int): Int {
            return 2 * value
        }
        
    }
}

// other way is also there

object Utils {

    fun getScore(value: Int): Int {
        return 2 * value
    }

}
```

> java      定义实体类
```java
public class Developer {

    private String name;
    private int age;

    public Developer(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Developer developer = (Developer) o;

        if (age != developer.age) return false;
        return name != null ? name.equals(developer.name) : developer.name == null;

    }

    @Override
    public int hashCode() {
        int result = name != null ? name.hashCode() : 0;
        result = 31 * result + age;
        return result;
    }

    @Override
    public String toString() {
        return "Developer{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
}
```
> kotlin
```java
data class Developer(var name: String, var age: Int)
```

> java      定义深拷贝对象
```java 
public class Developer implements Cloneable {

    private String name;
    private int age;

    public Developer(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        return (Developer)super.clone();
    }
}

// cloning or copying 
Developer dev = new Developer("Mindorks", 30);
try {
     Developer dev2 = (Developer) dev.clone();
} catch (CloneNotSupportedException e) {
     // Handle Exception
}
```
> kotlin
```java
data class Developer(var name: String, var age: Int)

// cloning or copying
val dev = Developer("Mindorks", 30)
val dev2 = dev.copy()
// in case you only want to copy selected properties
val dev2 = dev.copy(age = 25)
```

> java      定义工具类 并调用
```java  
public class Utils {

    private Utils() { 
      // This utility class is not publicly instantiable 
    }
    
    public static int triple(int value) {
        return 3 * value;
    }
    
}

int result = Utils.triple(3);
```
> kotlin
```java
fun Int.triple(): Int {
  return this * 3
}

var result = 3.triple()
```

> java     声明空对象
```java
Person person;
```
> kotlin
```java
internal lateinit var person: Person
```

# lateinit vs lazy 延迟
> lateinit
```java kotlin
public class Test {

  lateinit var mock: Mock

  @SetUp fun setup() {
     mock = Mock()
  }

  @Test fun test() {
     mock.do()
  }
}
```
> lazy
```java kotlin
public class Example{
  val name: String by lazy { “Amit Shekhar” }
}
```

## apply vs with

> Example of apply

```java
fun getDeveloper(): Developer {
    return Developer().apply {
        developerName = "Amit Shekhar"
        developerAge = 22
    }
}   
```
> Example of with
```java
fun getPersonFromDeveloper(developer: Developer): Person {
    return with(developer) {
        Person(developerName, developerAge)
    }
} ```
### Data Class
> In Java

```java
public class Developer {

    private String name;
    private int age;

    public Developer(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Developer developer = (Developer) o;

        if (age != developer.age) return false;
        return name != null ? name.equals(developer.name) : developer.name == null;

    }

    @Override
    public int hashCode() {
        int result = name != null ? name.hashCode() : 0;
        result = 31 * result + age;
        return result;
    }

    @Override
    public String toString() {
        return "Developer{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
}
```

> In Kotlin
```java
data class Developer(val name: String, val age: Int)
```

### Destructuring Declarations

>  Example
```java
data class Developer(val name: String, val age: Int)
fun getDeveloper(): Developer {
 // some logic
 return Developer(name, age)
}


// Now, to use this function:
val (name, age) = getDeveloper()
```

### Extension Functions

```java
fun Int.triple(): Int {
  return this * 3
}


// now we can use like this
var result = 3.triple()

```
> Another example, let’s see how we can use this with Android View.

```java
fun ImageView.loadImage(url: String) {
    Glide.with(context).load(url).into(this)
}


// now we can use like this
imageView.loadImage(url)
```

###  Sealed Classes
> Just put the sealed modifier before the name of the class.

```java
sealed class Car {

    data class Maruti(val speed: Int) : Car()
    data class Bugatti(val speed: Int, val boost: Int) : Car()
    object NotACar : Car()

}
```

```java
fun speed(car: Car): Int = when (car) {
    is Car.Maruti -> car.speed
    is Car.Bugatti -> car.speed + car.boost
    Car.NotACar -> INVALID_SPEED
    // else clause is not required as we've covered all the cases
}

```