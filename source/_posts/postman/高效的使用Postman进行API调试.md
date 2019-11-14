---
title: 高效的使用Postman进行API调试
categories: note
banner: 'http://img.matosiki.site/image/banner/20190926/san-francisco-bay-panorama-with-coit-tower_compress.jpg'
thumbnail: 'http://img.matosiki.site/banner/20190926/young-man-taking-selfie_compress.jpg'
date: 2019-09-26 15:43:00
tags: ["postman","API","测试","装饰器","sanbox"]
---


## 简介
在postman使用中,很多接口使用共同的请求地址和相同的参数,这样我们可以定义一些公共的环境变量,每个collection可以使用变量.postman也内置了一些变量,比如生成随机数,生成字符串,生成id,这些变量用于表单测试是非常方便的.

下面我就简简单单定义变量和请求参数自定义装饰器并测试结果.

### 定义环境变量
![img](http://img.matosiki.site/image/postman/postman_def_env_variable.png)
在postman中可以自定义环境变量,我们可以添加全局变量也可以添加自定义collection的变量,这里我定义了一个,eureka集合的变量,其中包含主机名和端口地址等变量.


### 使用变量
使用变量目前有三种方式:
- 第一种如图,在表单中添加变量,注意使用** {{variables}} **中的变量将会被定义的变量值替换掉

![img](http://img.matosiki.site/image/postman/postman_use_env_variable_form_data.png)


- 第二种如图, 在使用application/json的方式发送请求时,就没办法使用** {{variables}} **形式的变量.此时我们需要在pre-request-Srcipt中手动些装饰器,将**{{variables}}**替换掉. 
在这种方式下可分为两种具体实现:
1. 方式一:将使用replace替换** {{variables}} **内置变量
2. 方式二:解析json为obj对象,然后更改obj对象的值

![img](http://img.matosiki.site/image/postman/postman_use_env_variable_json.png)

json请求值:
```
{
    "instance": {
        "instanceId": "{{appID}}:11101",
        "app": "{{appID}}",
        "appGroutName": null,
        "ipAddr": "127.0.0.1",
        "sid": "na",
        "homePageUrl": null,
        "statusPageUrl": null,
        "healthCheckUrl": null,
        "secureHealthCheckUrl": null,
        "vipAddress": "tf-service",
        "secureVipAddress": "tf-service",
        "countryId": 1,
        "dataCenterInfo": {
            "@class": "com.netflix.appinfo.InstanceInfo$DefaultDataCenterInfo",
            "name": "MyOwn"
        },
        "hostName": "127.0.0.1",
        "status": "UP",
        "leaseInfo": null,
        "isCoordinatingDiscoveryServer": false,
        "lastUpdatedTimestamp": 1529391461000,
        "lastDirtyTimestamp": 1529391461000,
        "actionType": null,
        "asgName": null,
        "overridden_status": "UNKNOWN",
        "port": {
            "$": 11102,
            "@enabled": "false"
        },
        "securePort": {
            "$": 7002,
            "@enabled": "false"
        },
        "metadata": {
            "@class": "java.util.Collections$EmptyMap"
        }
    }
}
```
pre-request-Srcipt中的内容
```
// 检查请求头是否是json

function isJsonReq(){
   var header =  pm.request.headers;
   header.each(function(v){
       if(v['key']=='Content-Type'&&v['value']=="application/json"){
           return true;
       }
   });
   return false;
    
}
```
```

// 方法一: 替换全局变量
pm.request.body.raw = replace(pm.request.body.raw);
console.log(pm.request)

function replace(reqbody){
    if(reqbody&&isJsonReq()){
        var values = pm.environment.values;
        values.each(function(v){
          reqbody = reqbody.replace(new RegExp("{{"+v['key']+"}}",'g'),v['value'])
        })
    }
    return reqbody;
}
```

```
// 方法二: 动态生成编号

gen(pm.request.body.raw);

console.log(pm.ace)

function gen(reqbody){
    if(reqbody&&isJsonReq()){
       var obj = JSON.parse(reqbody)
       obj = doit(obj) //实现对象属性值替换
       pm.request.body.raw =  JSON.stringify(obj)
    }
}

function doit(obj){
    obtuoj['instance']['instanceID']=require('uuid')();
    // todo 替换变量
    console.log(obj)
    return obj;
}
```


### 使用高级js库

在postman的沙盒环境中,我们可以使用一些高级的js库.
我们可以在pre-request-script和end-test中使用.
![img](http://img.matosiki.site/image/postman/postman_pre_script.png)


```
var Ajv = require('ajv');
var ajv = new Ajv();
// 根据schema验证json
// var validate = ajv.compile(schema);
// var valid = validate(data);
// if (!valid) console.log(validate.errors);

// atob 
var atob = require('atob');
var b64 = "SGVsbG8sIFdvcmxkIQ==";
var bin = atob(b64); // base64转ascii码
console.log(bin);

var btoa = require('btoa');
var b64 = btoa(bin);
console.log(b64);

var should = require('chai').should() // BDD/TDD assert 库
  , foo = 'bar'
  , beverages = { tea: [ 'chai', 'matcha', 'oolong' ] };

foo.should.be.a('string');
foo.should.equal('bar');
foo.should.have.lengthOf(3);
beverages.should.have.property('tea').with.lengthOf(3)

var CryptoJS = require("crypto-js");
console.log(CryptoJS.HmacSHA1("Message", "Key"));


var moment = require('moment');
console.log(moment().format())

const uuidv1 = require('uuid');
console.log(uuidv1())


const { StringDecoder } = require('string_decoder');
const decoder = new StringDecoder('utf8');
const cent = Buffer.from([0xC2, 0xA2]);
console.log(decoder.write(cent));
const path = require('path');
console.log(path.basename('C:\\temp\\myfile.html'))
const assert = require('assert');

assert.deepEqual([[[1, 2, 3]], 4, 5], [[[1, 2, '3']], 4, 5]);

const util = require('util');

// console.log(require('lodash').join([1,24,5],[1234]))

var _ = require('lodash');
console.log(_.random(5, true)) //生成随机数1-5
var abc = function(a,b,c){
    return [a,b,c];
}
var curried = _.curry(abc);
console.log(curried(1)(2)(3)) //函数柯里化
console.log(_.now()) //获取当前时间搓

var timer = require('timers')
console.log(timer)
```

### 测试结果
在每次请求后还可以编写断言脚本验证结果

![img](http://img.matosiki.site/image/postman/postman_end_test.png)

```
tests["请求成功"] = responseCode.code === 204;
pm.test("注册新实例成功", function () {
    pm.response.to.have.body("");
});

```

参考:
- [postman官方文档-sanbox](https://learning.getpostman.com/docs/postman/scripts/postman_sandbox_api_reference/)