1. android 架构分析
活动管理器（Activity Mananger）	管理各个应用程序生命周期并提供常用的导航回退功能，为所有程序的窗口提供交互的接口
窗口管理器（Window Manager）	对所有开启的窗口程序进行管理
内容提供器（Content Provider）	提供一个应用程序访问另一个应用程序数据的功能，或者实现应用程序之间的数据共享
视图系统（View System）	创建应用程序的基本组件，包括列表（lists），网格（grids），文本框（text boxes），按钮（buttons），还有可嵌入的web浏览器。
通知管理器（Notification Manager）	使应用程序可以在状态栏中显示自定义的客户提示信息
包管理器（Package Manager）	对应用程序进行管理，提供的功能诸如安装应用程序，卸载应用程序，查询相关权限信息等。
资源管理器（Resource Manager）	提供各种非代码资源供应用程序使用，如本地化字符串，图片，音频等
位置管理器（Location Manager）	提供位置服务
电话管理器（Telephony Manager）	管理所有的移动设备功能
XMPP服务	是Google在线即时交流软件中一个通用的进程，提供后台推送服务

2. activity

```java
public class Activity extends ApplicationContext {  
       protected void onCreate(Bundle savedInstanceState);  
         
       protected void onStart();     
         
       protected void onRestart();  
         
       protected void onResume();  
         
       protected void onPause();  
         
       protected void onStop();  
         
       protected void onDestroy();  
   }  
```

```java
import android.app.Activity;  
import android.os.Bundle;  
import android.util.Log;  
public class ActivityDemo extends Activity {  
     
    private static final String TAG = "ActivityDemo";  
      
    public void onCreate(Bundle savedInstanceState) {  
        super.onCreate(savedInstanceState);  
        setContentView(R.layout.main);  
          
        Log.e(TAG, "start onCreate~~~");  
    }  
      
    @Override  
    protected void onStart() {  
        super.onStart();  
        Log.e(TAG, "start onStart~~~");  
    }  
      
    @Override  
    protected void onRestart() {  
        super.onRestart();  
        Log.e(TAG, "start onRestart~~~");  
    }  
      
    @Override  
    protected void onResume() {  
        super.onResume();  
        Log.e(TAG, "start onResume~~~");  
    }  
      
    @Override  
    protected void onPause() {  
        super.onPause();  
        Log.e(TAG, "start onPause~~~");  
    }  
      
    @Override  
    protected void onStop() {  
        super.onStop();  
        Log.e(TAG, "start onStop~~~");  
    }  
      
    @Override  
    protected void onDestroy() {  
        super.onDestroy();  
        Log.e(TAG, "start onDestroy~~~");  
    }  
      
}  
```
3. Intent&....Filter&Broadcast      意图，意向  组件数据传递
```java
Activity
startActvity( )
startActivity( )
 
Service
startService( )
bindService( )
 
Broadcasts
sendBroadcasts( )
sendOrderedBroadcasts( )
sendStickyBroadcasts( )
```
动作(Action),数据(Data),分类(Category),类型(Type),组件(Compent)以及扩展信(Extra)。其中最常用的是Action属性和Data数据

```java
getBtn.setOnClickListener(new OnClickListener() {  
            @Override 
            public void onClick(View v) {     
                Intent intent = new Intent();                 
                intent.setAction(Intent.ACTION_GET_CONTENT);// 设置Intent Action属性                  
                intent.setType("vnd.android.cursor.item/phone");// 设置Intent Type 属性   
                                                                //主要是获取通讯录的内容  
                startActivity(intent); // 启动Activity  
            }  
});      
```
```java
btn.setOnClickListener(new OnClickListener() {  
            @Override 
            public void onClick(View v) {     
                Intent intent = new Intent();                 
                intent.setAction(Intent.ACTION_MAIN);// 添加Action属性                
                intent.addCategory(Intent.CATEGORY_HOME);// 添加Category属性              
                startActivity(intent);// 启动Activity  
            }  
        });  
```
```java
    //FirstActivity.java
  btn.setOnClickListener(new OnClickListener() {  
            @Override  
            public void onClick(View v) {  
                Intent intent = new Intent();  
                //设置Intent的class属性，跳转到SecondActivity  
                intent.setClass(FirstActivity.this, SecondActivity.class);  
                //为intent添加额外的信息  
                intent.putExtra("useName", etx.getText().toString());  
                //启动Activity  
                startActivity(intent);  
            }  
        });         
    }  
    //SecondActivity.java
    @Override 
    public void onCreate(Bundle savedInstanceState) {  
        super.onCreate(savedInstanceState);  
        //设置当前的Activity的界面布局  
        setContentView(R.layout.second);  
        //获得Intent  
        Intent intent = this.getIntent();         
        tv = (TextView)findViewById(R.id.TextView1);  
        //从Intent获得额外信息，设置为TextView的文本  
        tv.setText(intent.getStringExtra("useName"));  
```

4. Service
5. ContentPrividers
6. 用户界面
7. 线程进程
8. 全面数据存储
9. widget
10. 网络通信 xml
11. 多设备配置
12. ui 设计规范