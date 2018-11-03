> 分离kotlin和java代码
```java 
android {
   sourceSets {
       main.java.srcDirs += 'src/main/kotlin'
   }
}
```

>  Declare Activity in Kotlin
```java
class MyActivity : AppCompatActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity)
  }
}
```
> Declare Activity in Java
```java
public class MyActivity extends AppCompatActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity);
  }
}
```
> On-click listener in Kotlin
```java 
val fab = findViewById(R.id.fab) as FloatingActionButton
fab.setOnClickListener {
  ...
}
```
> On-click listener in Java
```java
FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
fab.setOnClickListener(new View.OnClickListener() {
  @Override
  public void onClick(View view) {
    ...
  }
});
```
> Item click listener in Kotlin
```java
private val mOnNavigationItemSelectedListener
    = BottomNavigationView.OnNavigationItemSelectedListener { item ->
  when (item.itemId) {
    R.id.navigation_home -> {
      mTextMessage.setText(R.string.title_home)
      return@OnNavigationItemSelectedListener true
    }
    R.id.navigation_dashboard -> {
      mTextMessage.setText(R.string.title_dashboard)
      return@OnNavigationItemSelectedListener true
    }
 }
 false
}
```
> Item click listener in Java
```java
private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener
    = new BottomNavigationView.OnNavigationItemSelectedListener() {
  @Override
  public boolean onNavigationItemSelected(@NonNull MenuItem item) {
    switch (item.getItemId()) {
      case R.id.navigation_home:
        mTextMessage.setText(R.string.title_home);
        return true;
      case R.id.navigation_dashboard:
        mTextMessage.setText(R.string.title_dashboard);
        return true;
    }
    return false;
  }
};
```