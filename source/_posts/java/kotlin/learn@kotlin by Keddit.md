url https://android.jlelse.eu/learn-kotlin-while-developing-an-android-app-part-2-e53317ffcbe9

Part 1: Configuring Android Studio with Kotlin
Part 2: MainActivity.kt: Syntax, Null Safety and more…
Part 3: NewsFragment.kt: Extension Functions, Android Extensions…
Part 4: RecyclerView — Delegate Adapters & Data Classes with Kotlin
Part 5: Kotlin, RxJava & RxAndroid
Part 6: API — Retrofit & Kotlin
Part 7: Infinite Scroll: Higher-Order functions & Lambdas
Part 8: Orientation Change (Parcelable & Data Classes)
Part 9: Unit Test with Kotlin (Mockito, RxJava & Spek)
Part 10: Kotlin & Dagger 2 (Dependency Injection)
Part 11: Continuous Integration with Kotlin (BuddyBuild)
Final Part: Conclusion and thanks!

## 2. Syntax
> MainActivity files
```java
public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });
    }
}
```
```java
class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val toolbar = findViewById(R.id.toolbar) as Toolbar
        setSupportActionBar(toolbar)

        val fab = findViewById(R.id.fab) as FloatingActionButton
        fab.setOnClickListener { view -> Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG).setAction("Action", null).show() }
    }
}
```
要点： 
Extend and Implement: The words “extends” and “implement” were replaced by a colon “:”
Fun — ctions： with the “fun” keyword and the return type is added to the end
        void  >>>Unit
Bye Semicolon;   不需要分号了
Values and Variable    变量用var 常量用val        不算用值类型  

Safe ?: Safe!  
    val ok : String? = null   默认值为空
    val res = context?.getResources()   ?.不为空执行的方法
    context?.let {...}        代替判断是否为空,不为空执行函数体
    e.message ?: "Error message"    ?: 为空时后者代替前者字符串
Elvis Operator ?:  


# 3.Extension  Functions, Android Extensions and more
> NewsFragment.kt
```java
private var newsList: RecyclerView? = null

override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
    val view = inflater.inflate(R.layout.news_fragment, container, false)
    newsList = view.findViewById(R.id.news_list) as RecyclerView?
    newsList?.setHasFixedSize(true) // use this setting to improve performance
    newsList?.layoutManager = LinearLayoutManager(context)

    return view
}

// Java
ExtensionsKt.inflate(container, R.layout.news_fragment);
// Kotlin
container?.inflate(R.layout.news_fragment)
```
```java
@file:JvmName("ExtensionsUtils")

package com.droidcba.kedditbysteps.commons

import ...

fun ViewGroup.inflate(layoutId: Int): View {
    ...
}
// Use it in this way in Java:
ExtensionsUtils.inflate(container, R.layout.news_fragment);
```
```java
// old code:
newsList = view?.findViewById(R.id.news_list) as RecyclerView?
newsList?.setHasFixedSize(true)
newsList?.layoutManager = LinearLayoutManager(context)
// new code:
news_list.setHasFixedSize(true)
news_list.layoutManager = LinearLayoutManager(context)
```







# 4.RecyclerView        Delegate Adapters & Data Classes with Kotlin
        https://android.jlelse.eu/keddit-part-4-recyclerview-delegate-adapters-data-classes-with-kotlin-9248f44327f7
        Init Constructor
        Object Expressions
        Single Expressions
        Data Classes
        Ranges
        List & Lambdas (introduction)
```java
interface ViewType {
    fun getViewType(): Int
}

private var items: ArrayList<ViewType>
```
```java
class LoadingDelegateAdapter : ViewTypeDelegateAdapter {

    override fun onCreateViewHolder(parent: ViewGroup) = TurnsViewHolder(parent)

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, item: ViewType) {
    }

    class TurnsViewHolder(parent: ViewGroup) : RecyclerView.ViewHolder(
            parent.inflate(R.layout.news_item_loading)) {
    }
}
```
```java
private var delegateAdapters = SparseArrayCompat<ViewTypeDelegateAdapter>()
init {
    delegateAdapters.put(AdapterConstants.LOADING, LoadingDelegateAdapter())
    ...
}
```

```java
private val loadingItem = object : ViewType {
    override fun getViewType() : Int {
        return AdapterConstants.LOADING
    }
}
```

```java
init {
    delegateAdapters.put(...)
    items = ArrayList()
    items.add(loadingItem)
}
```
```java
override fun getViewType() : Int {
    return AdapterConstants.LOADING
}
// or to this
override fun getViewType() = AdapterConstants.LOADING

//--------
private val loadingItem = object : ViewType {
    override fun getViewType() = AdapterConstants.LOADING
}
```
```java
data class RedditNewsItem(var author: String, var title: String)
```
##  Part 5: Kotlin, RxJava & RxAndroid
```java
fun getNews(): Observable<List<RedditNewsItem>> {
    return Observable.create {
        subscriber ->

        val news = mutableListOf<RedditNewsItem>()
        // api call...
        subscriber.onNext(news)
        subscriber.onCompleted()
    }
}
```