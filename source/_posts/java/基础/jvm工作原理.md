---
title: jvm工作原理
date: {{ date }}
categories: learn
tags: 
- java
thumbnail: 	http://img.matosiki.site/tina/638.webp
---


# 一、	JVM的生命周期
1.	JVM实例对应了一个独立运行的java程序它是进程级别
    a)	启动。启动一个Java程序时，一个JVM实例就产生了，任何一个拥有public static void main(String[] args)函数的class都可以作为JVM实例运行的起点
    b)	运行。main()作为该程序初始线程的起点，任何其他线程均由该线程启动。JVM内部有两种线程：守护线程和非守护线程，main()属于非守护线程，守护线程通常由JVM
    自己使用，java程序也可以标明自己创建的线程是守护线程
    c)	消亡。当程序中的所有非守护线程都终止时，JVM才退出；若安全管理器允许，程序也可以使用Runtime类或者System.exit()来退出
2.	JVM执行引擎实例则对应了属于用户运行程序的线程它是线程级别的

# 二、	JVM的体系结构
![jvm体系结构](http://img.matosiki.site/image/jvm/jvm-struct.png)
1.	类装载器（ClassLoader）（用来装载.class文件）
2.	执行引擎（执行字节码，或者执行本地方法）
3.	运行时数据区（方法区、堆、java栈、PC寄存器、本地方法栈）

# 三、	JVM类加载器
**JVM整个类加载过程的步骤：**
1.	**装载**
  装载过程负责找到二进制字节码并加载至JVM中，JVM通过类名、类所在的包名通过ClassLoader来完成类的加载，
同样，也采用以上三个元素来标识一个被加载了的类：类名+包名+ClassLoader实例ID。
2.	**链接**
  链接过程负责对二进制字节码的格式进行校验、初始化装载类中的静态变量以及解析类中调用的接口、类。
完成校验后，JVM初始化类中的静态变量，并将其值赋为默认值。
  最后对类中的所有属性、方法进行验证，以确保其需要调用的属性、方法存在，以及具备应的权限（例如public、private域权限等），
  会造成NoSuchMethodError、NoSuchFieldError等错误信息。
3.	**初始化**
初始化过程即为执行类中的静态初始化代码、构造器代码以及静态属性的初始化，在四种情况下初始化过程会被触发执行：
调用了new；
反射调用了类中的方法；
子类调用了初始化；
JVM启动过程中指定的初始化类。

**VM类加载顺序：**
![jvm加载顺序](http://img.matosiki.site/image/jvm/jvm-loader.png)
**JVM两种类装载器包括：**启动类装载器和用户自定义类装载器。
启动类装载器是JVM实现的一部分；
用户自定义类装载器则是Java程序的一部分，必须是ClassLoader类的子类。
**JVM装载顺序：**
	Jvm启动时，由Bootstrap向User-Defined方向加载类；
	应用进行ClassLoader时，由User-Defined向Bootstrap方向查找并加载类；
1.	**Bootstrap ClassLoaderzh**
    这是JVM的根ClassLoader，它是用C++实现的，JVM启动时初始化此ClassLoader，并由此ClassLoader完成$JAVA_HOME中jre/lib/rt.jar（Sun JDK的实现）
中所有class文件的加载，这个jar中包含了java规范定义的所有接口以及实现。
2.	**Extension ClassLoader**
JVM用此classloader来加载扩展功能的一些jar包。
3.	**System ClassLoader**
JVM用此classloader来加载启动参数中指定的Classpath中的jar包以及目录，在Sun JDK中ClassLoader对应的类名为AppClassLoader。
4.	**User-Defined ClassLoader**
User-DefinedClassLoader是Java开发人员继承ClassLoader抽象类自行实现的ClassLoader，基于自定义的ClassLoader可用于加载非Classpath中的jar以及目录。

**ClassLoader抽象类的几个关键方法：**
（1）	loadClass
  此方法负责加载指定名字的类，ClassLoader的实现方法为先从已经加载的类中寻找，如没有则继续从parent ClassLoader中寻找，
如仍然没找到，则从System ClassLoader中寻找，最后再调用findClass方法来寻找，如要改变类的加载顺序，则可覆盖此方法
（2）	findLoadedClass
此方法负责从当前ClassLoader实例对象的缓存中寻找已加载的类，调用的为native的方法。
（3）	findClass
此方法直接抛出ClassNotFoundException，因此需要通过覆盖loadClass或此方法来以自定义的方式加载相应的类。
（4）	findSystemClass
此方法负责从System ClassLoader中寻找类，如未找到，则继续从Bootstrap ClassLoader中寻找，如仍然为找到，则返回null。
（5）	defineClass
此方法负责将二进制的字节码转换为Class对象
（6）	resolveClass
此方法负责完成Class对象的链接，如已链接过，则会直接返回。

# 四、	JVM执行引擎
**在执行方法时JVM提供了四种指令来执行：**
（1）invokestatic：调用类的static方法
（2）invokevirtual：调用对象实例的方法
（3）invokeinterface：将属性定义为接口来进行调用
（4）invokespecial：JVM对于初始化对象（Java构造器的方法为：<init>）以及调用对象实例中的私有方法时。

**主要的执行技术有:**
解释，即时编译，自适应优化、芯片级直接执行
（1）解释属于第一代JVM，
（2）即时编译JIT属于第二代JVM，
（3）自适应优化（目前Sun的HotspotJVM采用这种技术）则吸取第一代JVM和第二代
JVM的经验，采用两者结合的方式
  开始对所有的代码都采取解释执行的方式，并监视代码执行情况，然后对那些经常调用的方法启动一个后台线程，将其编译为本地代码，
并进行优化。若方法不再频繁使用，则取消编译过的代码，仍对其进行解释执行。

# 五、	JVM运行时数据区
![](http://img.matosiki.site/image/jvm/jvm-memory.png)
**第一块：PC寄存器**
PC寄存器是用于存储每个线程下一步将执行的JVM指令，如该方法为native的，则PC寄存器中不存储任何信息。
**第二块：JVM栈**
JVM栈是线程私有的，每个线程创建的同时都会创建JVM栈，JVM栈中存放的为当前线程中局部基本类型的变量（java中定义的八种基本类型：boolean、char、byte、short、int、long、float、double）、部分的返回结果以及Stack Frame，非基本类型的对象在JVM栈上仅存放一个指向堆上的地址
**第三块：堆（Heap）**
它是JVM用来存储对象实例以及数组值的区域，可以认为Java中所有通过new创建的对象的内存都在此分配，Heap中的对象的内存需要等待GC进行回收。
![](http://img.matosiki.site/image/jvm/jvm-heap.png)
（1）	堆是JVM中所有线程共享的，因此在其上进行对象内存的分配均需要进行加锁，这也导致了new对象的开销是比较大的
（2）	Sun Hotspot JVM为了提升对象内存分配的效率，对于所创建的线程都会分配一块独立的空间TLAB（Thread Local Allocation Buffer），其大小由JVM根据运行的情况计算而得，在TLAB上分配对象时不需要加锁，因此JVM在给线程的对象分配内存时会尽量的在TLAB上分配，在这种情况下JVM中分配对象内存的性能和C基本是一样高效的，但如果对象过大的话则仍然是直接使用堆空间分配
（3）	TLAB仅作用于新生代的Eden Space，因此在编写Java程序时，通常多个小的对象比大的对象分配起来更加高效。
**第四块：方法区域（Method Area）**
（1）在Sun JDK中这块区域对应的为PermanetGeneration，又称为持久代。
（2）方法区域存放了所加载的类的信息（名称、修饰符等）、类中的静态变量、类中定义为final类型的常量、类中的Field信息、类中的方法信息，当开发人员在程序中通过Class
  对象中的getName、isInterface等方法来获取信息时，这些数据都来源于方法区域，同时方法区域也是全局共享的，在一定的条件下它也会被GC，
当方法区域需要使用的内存超过其允许的大小时，会抛出OutOfMemory的错误信息。
**第五块：运行时常量池（Runtime Constant Pool）**
存放的为类中的固定的常量信息、方法和Field的引用信息等，其空间从方法区域中分配。
**第六块：本地方法堆栈（Native Method Stacks）**
JVM采用本地方法堆栈来支持native方法的执行，此区域用于存储每个native方法调用的状态。

# 六、	JVM垃圾回收
**GC的基本原理：** 将内存中不再被使用的对象进行回收，GC中用于回收的方法称为收集器，由于GC需要消耗一些资源和时间，Java在对对象的生命周期特征进行分析后，按照新生代、旧生代的方式来对对象进行收集，以尽可能的缩短GC对应用造成的暂停
（1）对新生代的对象的收集称为minor GC；
（2）对旧生代的对象的收集称为Full GC；
（3）程序中主动调用System.gc()强制执行的GC为Full GC。
**不同的对象引用类型， GC会采用不同的方法进行回收，JVM对象的引用分为了四种类型：**
（1）强引用：默认情况下，对象采用的均为强引用（这个对象的实例没有其他对象引用，GC时才会被回收）
（2）软引用：软引用是Java中提供的一种比较适合于缓存场景的应用（只有在内存不够用的情况下才会被GC）
（3）弱引用：在GC时一定会被GC回收
（4）虚引用：由于虚引用只是用来得知对象是否被GC
