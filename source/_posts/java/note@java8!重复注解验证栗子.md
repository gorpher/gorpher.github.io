# 正整数验证器
```java
import java.util.function.Supplier;

@Validate(value = Validator.INTEGER_NUMBER,
        description = "It's not an Integer ")
@Validate(value = Validator.POSITIVE_NUMBER,
        description = "It's not a positive Number")
public class PositiveIntegerSupplier implements Supplier<String> {
	 String value;
	public PositiveIntegerSupplier(String val){
		this.value = val;
	}
    @Override
    public String get() {
        return value; //random number
    }
}
```

# 验证注解
```java
import java.lang.annotation.Repeatable;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
@Repeatable(ValidateContainer.class)
public @interface Validate {

    Validator value();

    String description() default "";
}

/**
 * A container for the repeatable @Validate annotation.
 *
 * @author Andrey Nazarov
 */
@Retention(RetentionPolicy.RUNTIME)
@interface ValidateContainer {

    Validate[] value();
}
```
# 验证提供器
```java
import javax.xml.bind.ValidationException;
import java.util.function.Supplier;


public class SupplierValidator {

    /**
     * Validates the supplier.
     *
     * @param supplier - Supplier that needs to be validated.
     * @return true if supplier has passed validation check. False otherwise.
     */
    public static boolean validate(Supplier<?> supplier) throws ValidationException {
        for (Validate annotation
                : supplier.getClass().getAnnotationsByType(Validate.class)) {
            return annotation.value().validate(supplier);
        }
        return true;
    }
}
```
# 验证枚举实现
```java
import java.util.function.Supplier;

public enum Validator {
    //这简单验证整数 没有达到要求
	INTEGER_NUMBER,POSITIVE_NUMBER;
	public boolean validate(Supplier<?> supplier) {
		String o = (String) supplier.get();
		boolean f = Integer.parseInt(o)>0?true:false;
		return f;
	}
}
```
# main 
```java
    PositiveIntegerSupplier supplier = new PositiveIntegerSupplier("-123");
	boolean flag = SupplierValidator.validate(supplier);
	System.out.println(flag);
```