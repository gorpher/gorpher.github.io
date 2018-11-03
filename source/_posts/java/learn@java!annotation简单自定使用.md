what : 元数据，即一种描述数据的数据。

why : 注解比较xml 方便简洁

how : 自定义注解
override 的注解定义
```java
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.SOURCE)
public @interface Override {
}
```
*** Annotations仅仅是元数据，和业务逻辑无关。 ***

注解提供:


**@Documented** –注解是否将包含在JavaDoc中
**@Retention** –什么时候使用该注解
**@Target?** –注解用于什么地方
**@Inherited** – 是否允许子类继承该注解

**@Documented**–一个简单的Annotations标记注解，表示是否将注解信息添加在java文档中。

**@Retention**– 定义该注解的生命周期。

**RetentionPolicy.SOURCE** – 在编译阶段丢弃。这些注解在编译结束之后就不再有任何意义，所以它们不会写入字节码。**@Override, @SuppressWarnings**都属于这类注解。

**RetentionPolicy.CLASS** – 在类加载的时候丢弃。在字节码文件的处理中有用。注解默认使用这种方式。

**RetentionPolicy.RUNTIME**– 始终不会丢弃，运行期也保留该注解，因此可以使用反射机制读取该注解的信息。我们自定义的注解通常使用这种方式。

**@Target** – 表示该注解用于什么地方。如果不明确指出，该注解可以放在任何地方。以下是一些可用的参数。需要说明的是：属性的注解是兼容的，如果你想给7个属性都添加注解，仅仅排除一个属性，那么你需要在定义target包含所有的属性。

    ElementType.TYPE:用于描述类、接口或enum声明
    ElementType.FIELD:用于描述实例变量
    ElementType.METHOD
    ElementType.PARAMETER
    ElementType.CONSTRUCTOR
    ElementType.LOCAL_VARIABLE
    ElementType.ANNOTATION_TYPE 另一个注释
    ElementType.PACKAGE 用于记录java文件的package信息

**@Inherited** – 定义该注释和子类的关系


# 定义一个自定义注解
```java
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@interface Todo {

    public enum Priority {LOW, MEDIUM, HIGH}

    public enum Status {STARTED, NOT_STARTED}

    String author() default "Yash";
    Priority priority() default Priority.LOW;
    Status status() default Status.NOT_STARTED;
}
```
# 使用注解
```java
@Todo(priority = Todo.Priority.MEDIUM, author = "Yashwant", status = Todo.Status.STARTED)
public void incompleteMethod1() {
//Some business logic is written
//But it’s not complete yet
}
```
# 用户调用注解实现
```java
Class businessLogicClass = BusinessLogic.class;
for(Method method : businessLogicClass.getMethods()) {
    Todo todoAnnotation = (Todo)method.getAnnotation(Todo.class);
    if(todoAnnotation != null) {
        System.out.println(" Method Name : " + method.getName());
        System.out.println(" Author : " + todoAnnotation.author());
        System.out.println(" Priority : " + todoAnnotation.priority());
        System.out.println(" Status : " + todoAnnotation.status());
    }
}
```
