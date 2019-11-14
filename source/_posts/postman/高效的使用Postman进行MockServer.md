---
title: 高效的使用Postman进行MockServer
categories: note
banner: 'http://img.matosiki.site/image/banner/20191013/handmade-do-it-yourself-advent-candle_compress.jpg'
thumbnail: 'http://img.matosiki.site/image/banner/20191013/butterfly-close-up_compress.jpg'
date: 2019-10-13 10:12:00
tags: ["postman","API","测试","装饰器","sanbox","mock","mock server","postman runner"]
---


### 1. 添加Example
在自己添加的collection中,正常测试完成,将response保存为Example.这样防止API接口断供后,无法获取数据,这样可以从Example中查看到保存的Response.

但是如果你想,根据Example做一个MockServer,这样每次访问接口都能拿到Example中Response的结果了.
接下来,第一步将Response保存到Example中.
![](http://img.matosiki.site/image/postman_request_example.png)

在弹出的页面中填写好Example的名称,还可以自己调正Response返回的值.
![](http://img.matosiki.site/image/postman_request_example_save.png)

### 2. 添加mock环境
正常情况下有一个collection的环境,但为了mock测试方便,新建一个mock环境.
![](http://img.matosiki.site/image/postman_request_env_mock.png)
注意: mock环境中有两个变量,**x-api-key**这个需要在自己的workspace上生成, **url**这个需要等到mock server 创建时填写.
![](http://img.matosiki.site/image/postman_request_env_mock_edit.png)
### 3.新建mock server
在postman中,点击**New**按钮,选择Mock Server,会看到如下图对话框
在第一步中选择 **Select an existing collection** 选择 **eureka**collection,点击**Next**.
![](http://img.matosiki.site/image/postman_mock_server_new.png)
第二步,设置mock server,注意选择 eureka mock 环境,并且注意要去自己的workspace生成**x-api-key**,再点击**Next**,页面会返回一个URL,这个就是Mock URL,复制这个变量拷贝到mock环境变量中,到这里差不多就快完成了,还有最后
![](http://img.matosiki.site/image/postman_mock_server_new_api.png)

如果找不到Mock Server Url 也可以去workspace中找到.
![](http://img.matosiki.site/image/postman_mock_server_web.png)


### 4.生成API-KEY
进入自己的workspace,生成自己的API key,复制Api-key到mock 环境中,完成了mock环境配置.
![](http://img.matosiki.site/image/postman_api_key_web.png)

### 5.Runner测试
最后我们来测试mock server,选择collection,添加Runner,选择环境变量,运行测试.
![](http://img.matosiki.site/image/postman_mock_server_new_mock_test.png)
查看测试结果
![](http://img.matosiki.site/image/postman_mock_server_new_mock_test_success.png)


总结: 如何使用postman进行mock server 对接口进行测试.



# 参考链接
- [Postman API](https://learning.getpostman.com/docs/postman/postman_api/intro_api/)
- [Postman Examples](https://learning.getpostman.com/docs/postman/collections/examples/)