```java
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.function.Supplier;

public class FunctionDemo {

	static int funcInterface(int t, Function<Integer, Integer> function) {
		int r = function.apply(t);
		//to do something 
		return r;
	}
	static void consInterface(int t,Consumer<Integer> consumer) {
		consumer.accept(t);  // no return
	}
	static int suppInterface(int t,Supplier<Integer> supplier) {
		return supplier.get()*t;  //return R
	}
	
	static boolean preInterface(int t,Predicate<Integer> predicate) {
		return predicate.test(t);  // return o boolean
	}
	public static void main(String[] args) {
		funcInterface(10, val-> val + 20);  //10 -> 10 + 20 
		consInterface(20,System.out::println);  // System.out.println(20)
		System.out.println(suppInterface(10, ()->20)); //supplier.get()*t ==> 20*10 
		System.out.println(preInterface(10,(x)->20>x));//20>10?true:false
	}

}
```