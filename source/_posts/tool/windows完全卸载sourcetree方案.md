---
title: windows下完全卸载sourcetree重装
date: {{date}}
categories: note
tags: 
- java
- git
---
# windows下完全卸载sourcetree重装


## 一般windows版本下建议使用2.3.1.0版本一下
如果使用最新版2.5.1等版本需要下载.NET
[点击下载sourcetree](http://img.matosiki.site/sourcetree20180513/SourceTreeSetup-2.3.1.0.exe)

## 如果你安装过sourcetree又问题，建议完全删除再按装。
下面试卸载sourcetree的方法
1. 去控制面板点击卸载
2. 删除几个相关sourcetree遗留无法
    1. 去 %LocalAppData% 目录下删除 \Atlassian\SourceTree\这个目录
    2. 删除 ![删除的文件](http://img.matosiki.site/sourcetree20180513/show.png)
    3. 查看其他如果文件名是sourcetree 也把它删除了
3. 重新安装 

4. 关闭软件

5. 去%LocalAppData%\Atlassian\SourceTree\目录下添加accounts.json文件
    ![添加accounts.json文件](http://img.matosiki.site/sourcetree20180513/accounts.png)
### acounts.json文件内容，可以不用更改什么。 [点击下载account.json](http://img.matosiki.site/sourcetree20180513/accounts.json)
```json
[
  {
    "$id": "1",
    "$type": "SourceTree.Api.Host.Identity.Model.IdentityAccount, SourceTree.Api.Host.Identity",
    "Authenticate": true,
    "HostInstance": {
      "$id": "2",
      "$type": "SourceTree.Host.Atlassianaccount.AtlassianAccountInstance, SourceTree.Host.AtlassianAccount",
      "Host": {
        "$id": "3",
        "$type": "SourceTree.Host.Atlassianaccount.AtlassianAccountHost, SourceTree.Host.AtlassianAccount",
        "Id": "atlassian account"
      },
      "BaseUrl": "https://id.atlassian.com/"
    },
    "Credentials": {
      "$id": "4",
      "$type": "SourceTree.Model.BasicAuthCredentials, SourceTree.Api.Account",
      "Username": "",
      "Email": null
    },
    "IsDefault": false
  }
]
 ```
6. 重启软件
    ![成功](http://img.matosiki.site/sourcetree20180513/next.png)
    下一步-->下一步
    ![成功](http://img.matosiki.site/sourcetree20180513/sourceok.png)


7. 总结: 删除安装过的所有文件记录,再装sourcetree就可以使用了.
