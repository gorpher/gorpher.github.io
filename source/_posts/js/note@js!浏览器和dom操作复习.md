note@js！document操作复习
首先了解对象
再对一个对象的操作
可以看成对它的crud

# 浏览器对象 
    ## window
    ## navigator
    ## screen
    ## location
    ## document
    ## history

    1. window 对象不但充当全局作用域，而且表示浏览器窗口。
        window对象有innerWidth和innerHeight属性，可以获取浏览器窗口的内部宽度和高度。
        内部宽高是指除去菜单栏、工具栏、边框等占位元素后，用于显示网页的净宽高。
        > alert('window inner size: ' + window.innerWidth + ' x ' + window.innerHeight);
        > 对应的，还有一个outerWidth和outerHeight属性，可以获取浏览器窗口的整个宽高。
    2. navigator对象表示浏览器的信息
            navigator.appName：浏览器名称；
            navigator.appVersion：浏览器版本；
            navigator.language：浏览器设置的语言；
            navigator.platform：操作系统类型；
            navigator.userAgent：浏览器设定的User-Agent字符串。
                ```
                  alert('appName = ' + navigator.appName + '\n' +
                  'appVersion = ' + navigator.appVersion + '\n' +
                  'language = ' + navigator.language + '\n' +
                  'platform = ' + navigator.platform + '\n' +
                  'userAgent = ' + navigator.userAgent);
                ```
        3. screen对象表示屏幕的信息  言外之意：你电脑屏幕的信息
            screen.width：屏幕宽度，以像素为单位；
            screen.height：屏幕高度，以像素为单位；
            screen.colorDepth：返回颜色位数，如8、16、24。
        4. location对象表示当前页面的URL信息。
            location.protocol; // 'http'
            location.host; // 'www.example.com'
            location.port; // '8080'
            location.pathname; // '/path/index.html'
            location.search; // '?a=1&b=2'
            location.hash; // 'TOP'
                要加载一个新页面，可以调用location.assign()。如果要重新加载当前页面，调用location.reload()方法非常方便。
        5. document对象表示当前页面。由于HTML在浏览器中以DOM形式表示为树形结构，document对象就是整个DOM树的根节点。
            最常用的查找是根据ID和Tag Name。
            >用document对象提供的getElementById()和getElementsByTagName()可以按ID获得一个DOM节点和按Tag名称获得一组DOM节点
                document对象还有一个cookie属性，可以获取当前页面的Cookie。
                > document.cookie; 
                服务器在设置Cookie时可以使用httpOnly，设定了httpOnly的Cookie将不能被JavaScript读取。这个行为由浏览器实现，主流浏览器均支持httpOnly选项，IE从IE6 SP1开始支持。
                为了确保安全，服务器端在设置Cookie时，应该始终坚持使用httpOnly。
        6. history对象保存了浏览器的历史记录，JavaScript可以调用history对象的back()或forward ()，相当于用户点击了浏览器的“后退”或“前进”按钮。


对document对象的操作也是crud
# 查找dom
    ## 最常用的方法是document.getElementById()和document.getElementsByTagName()，以及CSS选择器document.getElementsByClassName()。
    ```
    // 返回ID为'test'的节点：
    var test = document.getElementById('test');

    // 先定位ID为'test-table'的节点，再返回其内部所有tr节点：
    var trs = document.getElementById('test-table').getElementsByTagName('tr');

    // 先定位ID为'test-div'的节点，再返回其内部所有class包含red的节点：
    var reds = document.getElementById('test-div').getElementsByClassName('red');

    // 获取节点test下的所有直属子节点:
    var cs = test.children;

    // 获取节点test下第一个、最后一个子节点：
    var first = test.firstElementChild;
    var last = test.lastElementChild;
    ```
    ## 第二种方法是使用querySelector()和querySelectorAll()
    ```
    // 通过querySelector获取ID为q1的节点：
    var q1 = document.querySelector('#q1');

    // 通过querySelectorAll获取q1节点内的符合条件的所有节点：
    var ps = q1.querySelectorAll('div.highlighted > p');
    ```
    严格地讲，我们这里的DOM节点是指Element，但是DOM节点实际上是Node，在HTML中，Node包括Element、Comment、CDATA_SECTION等很多种

# 更新dom
    一种是修改innerHTML属性
    innerText不返回隐藏元素的文本，而textContent返回所有文本。
    > var div.innerHTML = "<p>这里innerHTML 一般使用等号</p>";
# 插入DOM
      appendChild，把一个子节点添加到父节点的最后一个子节点
        ```
        var       js = document.getElementById('js'),
        list = document.getElementById('list');
        list.appendChild(js);
        ```
     insertBefore,
        >用parentElement.insertBefore(newElement, referenceElement);，子节点会插入到referenceElement之前。
# 删除DOM
        removeChild
            删除自己的节点
            ```
            // 拿到待删除节点:
            var self = document.getElementById('to-be-removed');
            // 拿到父节点:
            var parent = self.parentElement;
            // 删除:
            var removed = parent.removeChild(self);
            removed === self; // true
            ```
