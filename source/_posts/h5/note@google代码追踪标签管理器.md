---
title: google代码追踪标签管理器
---
# tag manager
放入头部
```html
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-N56SN5T');</script>
<!-- End Google Tag Manager -->
```
放入body尾部
```html
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-N56SN5T"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
```
# ga
跟踪 ID:UA-104393124-1
```html
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-104393124-1', 'auto');
  ga('send', 'pageview');

</script>
```
百度上非阻塞方式ga

```html
<script>
var gaJsHost = (("https:" == document.location.protocol)?"https://ssl." : "http://www.");  
var head = document.getElementsByTagName("head")[0] || document.documentElement;  
var script = document.createElement("script");  
script.src = gaJsHost + "google-analytics.com/ga.js";  
var done = false; // 防止onload，onreadystatechange同时执行  
// 加载完毕后执行，适应所有浏览器  
script.onload = script.onreadystatechange = function() {  
    if (!done && (!this.readyState ||   
         this.readyState === "loaded" ||   
         this.readyState === "complete")){  
        done = true;  
        try {  
            var pageTracker = _gat._getTracker("UA-104393124-1");  
            pageTracker._trackPageview();  
        } catch(err) {}  
        script.onload = script.onreadystatechange = null;  
    }  
};   
head.insertBefore(script,head.firstChild);  
</script>
```