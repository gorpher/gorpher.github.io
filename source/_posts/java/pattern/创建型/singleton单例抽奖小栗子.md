```java

import java.util.Comparator;
import java.util.Iterator;
import java.util.Random;
import java.util.TreeSet;

/*
 * 
 * 红色球 （1-33 不能重复出6个数）  蓝色球(1-16 出一个数)
         结果模式：01,05,23,28,29,33-05 **/
public class TicketResult {
   private TicketResult(){}
   //把每期结果作为属性私有化，且静态化，每次JVM运行（运行一次程序）初始化该类时，即为该属性赋值且不论这次运行创建多少个对象只返回一个同一个值
   private static final String result = getResult();
    public static String getFinallyResult(){
    	return result;
    }
 
   /**
    * 利用TreeSet装入红色球选出的值（1.值不重复    2.利用默认比较器或自定义比较器可以实现排序）
    * @return
    */
   private static TreeSet<Integer> getRedBall(){
    	TreeSet<Integer> set = new TreeSet<Integer>(new MyComparator());
    	Random ran = new Random();
    	//保证只取6个不重复的值
    	while(set.size()<6){
    		//nextInt(int n) 方法：随机产生0~n（包括0，不包括n）之间的int值
    		set.add(ran.nextInt(33)+1);
    	}
		return set;
    }
    
   /**
    * 获取特殊号码值
    * @return
    */
    private static int getBlueBall(){
    	Random ran = new Random();
		return ran.nextInt(16)+1;
    }
    
    /**
     * 拼接字符串，返回固定格式的开奖结果
     * @return
     */
    private static String getResult(){
    	TreeSet<Integer> set = getRedBall();
    	int blue = getBlueBall();
    	Iterator<Integer> it = set.iterator();
    	StringBuffer sbf = new StringBuffer();
    	while(it.hasNext()){
    		int temp =it.next();
    //把1,2,3...等转为01,02,03...
    if(temp<10)
       sbf.append("0"+temp+",");
    else
       sbf.append(temp+",");
    	}
    	String result = sbf.toString().substring(0,sbf.toString().lastIndexOf(","));
    	result = result +"-"+blue;
    	return result;
    }
}

/**
 * 自定义比较器
 * @author ml1990s
 *
 */
class MyComparator implements Comparator<Integer>{

	@Override
	public int compare(Integer o1, Integer o2) {
		
		return o1-o2;
	}
	
	
}
```
## 测试
```java
public class Test {

	public static void main(String[] args) {
		System.out.println(TicketResult.getFinallyResult());
		System.out.println(TicketResult.getFinallyResult());

	}

}
```