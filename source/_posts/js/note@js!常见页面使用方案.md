note@js!复习 其他操作
    利用js md5加密
    ```
    <script>
    function checkForm() {
        var input_pwd = document.getElementById('input-password');
        var md5_pwd = document.getElementById('md5-password');
        // 把用户输入的明文变为MD5:
        md5_pwd.value = toMD5(input_pwd.value);
        // 继续下一步:
        return true;
    }
    </script>
    ```
# 操作文件
      HTML5的File API提供了File和FileReader两个主要对象，可以获得文件信息并读取文件。
    
        ```
        var
            fileInput = document.getElementById('test-image-file'),
            info = document.getElementById('test-file-info'),
            preview = document.getElementById('test-image-preview');
        // 监听change事件:
        fileInput.addEventListener('change', function () {
            // 清除背景图片:
            preview.style.backgroundImage = '';
            // 检查文件是否选择:
            if (!fileInput.value) {
                info.innerHTML = '没有选择文件';
                return;
            }
            // 获取File引用:
            var file = fileInput.files[0];
            // 获取File信息:
            info.innerHTML = '文件: ' + file.name + '<br>' +
                             '大小: ' + file.size + '<br>' +
                             '修改: ' + file.lastModifiedDate;
            if (file.type !== 'image/jpeg' && file.type !== 'image/png' && file.type !== 'image/gif') {
                alert('不是有效的图片文件!');
                return;
            }
            // 读取文件:
            var reader = new FileReader();
            reader.onload = function(e) {
                var
                    data = e.target.result; // 'data:image/jpeg;base64,/9j/4AAQSk...(base64编码)...'            
                preview.style.backgroundImage = 'url(' + data + ')';
            };
            // 以DataURL的形式读取文件:
            reader.readAsDataURL(file);
        });
        ```

        上面的代码演示了如何通过HTML5的File API读取文件内容。以DataURL的形式读取到的文件是一个字符串，类似于data:image/jpeg;base64,/9j/4AAQSk...(base64编码)...，常用于设置图像。如果需要服务器端处理，把字符串base64,后面的字符发送给服务器并用Base64解码就可以得到原始文件的二进制内容。

# ajax 
        一般js的ajax异步调用
        ```
        function success(text) {
            var textarea = document.getElementById('test-response-text');
            textarea.value = text;
        }

        function fail(code) {
            var textarea = document.getElementById('test-response-text');
            textarea.value = 'Error code: ' + code;
        }

        var request = new XMLHttpRequest(); // 新建XMLHttpRequest对象

        request.onreadystatechange = function () { // 状态发生变化时，函数被回调
            if (request.readyState === 4) { // 成功完成
                // 判断响应结果:
                if (request.status === 200) {
                    // 成功，通过responseText拿到响应的文本:
                    return success(request.responseText);
                } else {
                    // 失败，根据响应码判断失败原因:
                    return fail(request.status);
                }
            } else {
                // HTTP请求还在继续...
            }
        }
        // 发送请求:
        request.open('GET', '/api/categories');
        request.send();
        alert('请求已发送，请等待响应...');
        ```

        如果你想把标准写法和IE写法混在一起，可以这么写：
        ```
        var request;
        if (window.XMLHttpRequest) {
            request = new XMLHttpRequest();
        } else {
            request = new ActiveXObject('Microsoft.XMLHTTP');
        }
        ```

## 跨域访问  (具体查看跨域访问的笔记)
        一是通过Flash插件发送HTTP请求，这种方式可以绕过浏览器的安全限制，但必须安装Flash，并且跟Flash交互。不过Flash用起来麻烦，而且现在用得也越来越少了。

        二是通过在同源域名下架设一个代理服务器来转发，JavaScript负责把请求发送到代理服务器：

        '/proxy?url=http://www.sina.com.cn'
        代理服务器再把结果返回，这样就遵守了浏览器的同源策略。这种方式麻烦之处在于需要服务器端额外做开发。

        第三种方式称为JSONP，它有个限制，只能用GET请求，并且要求返回JavaScript。这种方式跨域实际上是利用了浏览器允许跨域引用JavaScript资源：
        ```
        <head>
            <script src="http://example.com/abc.js"></script>
            ...
        </head>
        ```
        JSONP通常以函数调用的形式返回，例如，返回JavaScript内容如下：
        foo('data');

        以163的股票查询URL为例，对于URL：http://api.money.126.net/data/feed/0000001,1399001?callback=refreshPrice，你将得到如下返回：
        > refreshPrice({"0000001":{"code": "0000001", ... });

        我们需要准备一个回掉函数；
        ```
        function refreshPrice(data) {
            var p = document.getElementById('test-jsonp');
            p.innerHTML = '当前价格：' +
                data['0000001'].name +': ' + 
                data['0000001'].price + '；' +
                data['1399001'].name + ': ' +
                data['1399001'].price;
          }
          ``` 
          ```
            getPrice()函数触发：

            function getPrice() {
                var
                    js = document.createElement('script'),
                    head = document.getElementsByTagName('head')[0];
                js.src = 'http://api.money.126.net/data/feed/0000001,1399001?callback=refreshPrice';
                head.appendChild(js);
            }
            就完成了跨域加载数据。
          ```

        CORS
        如果浏览器支持HTML5，那么就可以一劳永逸地使用新的跨域策略：CORS了。
        CORS全称Cross-Origin Resource Sharing，是HTML5规范定义的如何跨域访问资源。
        如果该CDN服务商未正确设置Access-Control-Allow-Origin，那么浏览器无法加载字体资源。
        对于PUT、DELETE以及其他类型如application/json的POST请求，在发送AJAX请求之前，浏览器会先发送一个OPTIONS请求（称为preflighted请求）到这个URL上，询问目标服务器是否接受：
        ```
        OPTIONS /path/to/resource HTTP/1.1
        Host: bar.com
        Origin: http://my.com
        Access-Control-Request-Method: POST
        ```
        服务器必须响应并明确指出允许的Method：
        ```
        HTTP/1.1 200 OK
        Access-Control-Allow-Origin: http://my.com
        Access-Control-Allow-Methods: POST, GET, PUT, OPTIONS
        Access-Control-Max-Age: 86400
        ```

# Promise
        在JavaScript的世界中，所有代码都是单线程执行的。

        由于这个“缺陷”，导致JavaScript的所有网络操作，浏览器事件，都必须是异步执行。异步执行可以用回调函数实现：

        function callback() {
            console.log('Done');
        }
        console.log('before setTimeout()');
        setTimeout(callback, 1000); // 1秒钟后调用callback函数
        console.log('after setTimeout()');

        古人云：“君子一诺千金”，这种“承诺将来会执行”的对象在JavaScript中称为Promise对象。

        看看Promise是如何异步执行的：

        'use strict';

        // 清除log:
        var logging = document.getElementById('test-promise-log');
        while (logging.children.length > 1) {
            logging.removeChild(logging.children[logging.children.length - 1]);
        }

        // 输出log到页面:
        function log(s) {
            var p = document.createElement('p');
            p.innerHTML = s;
            logging.appendChild(p);
        }

        new Promise(function (resolve, reject) {
            log('start new Promise...');
            var timeOut = Math.random() * 2;
            log('set timeout to: ' + timeOut + ' seconds.');
            setTimeout(function () {
                if (timeOut < 1) {
                    log('call resolve()...');
                    resolve('200 OK');
                }
                else {
                    log('call reject()...');
                    reject('timeout in ' + timeOut + ' seconds.');
                }
            }, timeOut * 1000);
        }).then(function (r) {
            log('Done: ' + r);
        }).catch(function (reason) {
            log('Failed: ' + reason);
        });

        要串行执行这样的异步任务，不用Promise需要写一层一层的嵌套代码。有了Promise，我们只需要简单地写：
        > job1.then(job2).then(job3).catch(handleError);
        
        其他细节参考 廖雪峰的官方网站：http://www.liaoxuefeng.com/

# Canvas
        一个Canvas定义了一个指定尺寸的矩形框，在这个范围内我们可以随意绘制：
        <canvas id="test-canvas" width="300" height="200"></canvas>
        getContext('2d')方法让我们拿到一个CanvasRenderingContext2D对象，所有的绘图操作都需要通过这个对象完成。
        > var ctx = canvas.getContext('2d');
        HTML5还有一个WebGL规范，允许在Canvas中绘制3D图形：
        > gl = canvas.getContext("webgl");
        Canvas的坐标以左上角为原点，水平向右为X轴，垂直向下为Y轴，以像素为单位，所以每个点都是非负整数。

        CanvasRenderingContext2D对象有若干方法来绘制图形：
        ```
        'use strict';

        var
            canvas = document.getElementById('test-shape-canvas'),
            ctx = canvas.getContext('2d');

            ctx.clearRect(0, 0, 200, 200); // 擦除(0,0)位置大小为200x200的矩形，擦除的意思是把该区域变为透明
            ctx.fillStyle = '#dddddd'; // 设置颜色
            ctx.fillRect(10, 10, 130, 130); // 把(10,10)位置大小为130x130的矩形涂色
            // 利用Path绘制复杂路径:
            var path=new Path2D();
            path.arc(75, 75, 50, 0, Math.PI*2, true);
            path.moveTo(110,75);
            path.arc(75, 75, 35, 0, Math.PI, false);
            path.moveTo(65, 65);
            path.arc(60, 65, 5, 0, Math.PI*2, true);
            path.moveTo(95, 65);
            path.arc(90, 65, 5, 0, Math.PI*2, true);
            ctx.strokeStyle = '#0000ff';
            ctx.stroke(path);
        ```
        绘制文本就是在指定的位置输出文本，可以设置文本的字体、样式、阴影等，与CSS完全一致：
        ```
        'use strict';
        var
            canvas = document.getElementById('test-text-canvas'),
            ctx = canvas.getContext('2d');
            ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.shadowOffsetX = 2;
        ctx.shadowOffsetY = 2;
        ctx.shadowBlur = 2;
        ctx.shadowColor = '#666666';
        ctx.font = '24px Arial';
        ctx.fillStyle = '#333333';
        ctx.fillText('带阴影的文字', 20, 40);
        ```
        'use strict';

        请根据从163获取的JSON数据绘制最近30个交易日的K线图，数据已处理为包含一组对象的数组：
        ```
        <canvas id="stock-canvas" width="300" height="200" style="border: 1px solid #ccc; margin-top: 15px;"></canvas>
        ```
        ```
        window.loadStockData = function (r) {
            var
                NUMS = 30,
                data = r.data;
            if (data.length > NUMS) {
                data = data.slice(data.length - NUMS);
            }
            data = data.map(function (x) {
                return {
                    date: x[0],
                    open: x[1],
                    close: x[2],
                    high: x[3],
                    low: x[4],
                    vol: x[5],
                    change: x[6]
                };
            });
            window.drawStock(data);
        }
        window.drawStock = function (data) {
         var
                canvas = document.getElementById('stock-canvas'),
                width = canvas.width,
                height = canvas.height,
                ctx = canvas.getContext('2d');
            console.log(JSON.stringify(data[0])); // {"date":"20150602","open":4844.7,"close":4910.53,"high":4911.57,"low":4797.55,"vol":62374809900,"change":1.69}
            ctx.clearRect(0, 0, width, height);
            ctx.fillText('Test Canvas', 10, 10);
            var
                OFFSET = 3700,
                pHeight = 0.5,
                lWidth = 1,
                pWidth = 8,
                x = 5;
            var drawLine = function(high, low, open, close){
                //判断涨跌
                ctx.strokeStyle = close >= open ? "red" : "green";
                ctx.beginPath();
                ctx.lineWidth = lWidth;
                ctx.moveTo(x, (OFFSET - low) * pHeight);
                ctx.lineTo(x, (OFFSET - high) * pHeight);
                ctx.stroke();
                ctx.beginPath();
                ctx.lineWidth = pWidth;
                ctx.moveTo(x, (OFFSET - open) * pHeight);
                ctx.lineTo(x, (OFFSET - close) * pHeight);
                ctx.stroke();
                //位置移动至下一天
                x += 10;
            }
            for (var t of data) {
                drawLine(t.high, t.low, t.open, t.close);
            }
            // 加载最近30个交易日的K线图数据:
           var js = document.createElement('script');
           js.src = 'http://img1.money.126.net/data/hs/kline/day/history/2015/0000001.json?callback=loadStockData&t=' + Date.now();
           document.getElementsByTagName('head')[0].appendChild(js);
            ```