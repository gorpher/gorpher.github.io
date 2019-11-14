---
title: terraform-进阶实践
categories: note
banner: 'http://img.matosiki.site/image/banner/20190805/man-with-roses-waiting-for-his-lady.jpg'
thumbnail: 'http://img.matosiki.site/banner/20190805/segla-mountain-norway-free-photos.jpg'
date: 2019-08-05 10:43:00
tags: ["cloud","基础服务","中间件","编排","terraform"]
---

## 架构图
![image](http://img.matosiki.site/image/terrafrom/terraform_arch.jpg)
### 一、导入
terraform 用户导入现有的基础结构

### 二、状态
Terraform必须存储有关托管基础架构和配置的状态。Terraform使用此状态将现实世界资源映射到您的配置，跟踪元数据并提高大型基础架构的性能。
默认情况下，此状态存储在名为“terraform.tfstate”的本地文件中，但也可以远程存储，这在团队环境中更有效。

Terraform使用此本地状态来创建计划并对您的基础架构进行更改。在任何操作之前，Terraform会进行 刷新以使用真实基础架构更新状态。

 terraform state命令，使用CLI对状态进行基本修改。
 
1. terraform state目的

**映射真实世界**

terraform需要某种数据库来将Terraform配置映射到现实世界。

**元数据**

Terraform通常使用配置来确定依赖顺序，但是，从Terraform配置中删除资源时，Terraform必须知道如何删除该资源。
Terraform还出于类似的原因存储其他元数据，例如指向最近在存在多个别名提供程序的情况下与资源一起使用的提供程序配置的指针。

**表现**
Terraform还为状态中的所有资源存储属性值的缓存，terraform plan，Terraform必须知道当前的资源状态，以便有效地确定为达到所需配置而需要进行的更改

**同步**
在默认配置中，Terraform将状态存储在运行Terraform的当前工作目录中的文件中
2. 导入现有资源
3. 锁
如果您的后端支持，Terraform将锁定您可以写入状态的所有操作的状态。这可以防止他人获得锁定并可能破坏您的状态。
4. 工作空间
每个Terraform配置都有一个关联的后端 ，用于定义操作的执行方式以及存储Terraform状态等持久性数据的位置。

支持工作区有： AzureRM、Consul、GCS、local、manta、pg、remote、S3
当前工作区插值

```
resource "aws_instance" "example" {
  count = "${terraform.workspace == "default" ? 5 : 1}"
  # ... other arguments
}
```

5. 远程状态

将状态远程存储起来，Terraform还可以使用 状态锁定来防止Terraform在同一状态下并发运行，从而到达团队协作。

6. 敏感数据
使用本地状态时，state存储在纯文本JSON文件中。使用远程状态时，状态仅在Terraform使用时保存在内存中。它可以在静止时加密，但这取决于特定的远程状态后端。远程存储状态可能会为您提供静态加密，具体取决于您选择的后端。

### 三、提供商
云提供商: 亚马逊、谷歌、百度云、阿里云、腾讯云等等。
### 四、[预配器](https://www.terraform.io/docs/provisioners/connection.html)

1. connect 预配器
```
provisioner "file" {
  source      = "conf/myapp.conf"
  destination = "/etc/myapp.conf"

  connection {
    type     = "ssh"
    user     = "root"
    password = "${var.root_password}"
  }
}

# Copies the file as the Administrator user using WinRM
provisioner "file" {
  source      = "conf/myapp.conf"
  destination = "C:/App/myapp.conf"
  // connection块来覆盖这些默认值
  connection {
    type     = "winrm"
    user     = "Administrator"
    password = "${var.admin_password}"
    host = "192.168.0.1"
    timeout = "30s"
    script_path = "path" //用于复制脚本的路径，用于远程执行。
  }
}

```
2. 没有资源的预配器
null_resource被视为普通资源

3. chef
chef预配安装，配置和运行上的远程资源的厨师客户端
该chef预配有特定的连接类型的一些先决条件：
- 对于ssh类型连接，cURL必须在远程主机上可用。
- 对于winrm连接，PowerShell 2.0必须在远程主机上可用。

4. 文件预配器
该file预配用于从执行Terraform到新创建的资源的机器复制文件或目录。
```

resource "aws_instance" "web" {
  # ...

  # Copies the myapp.conf file to /etc/myapp.conf
  provisioner "file" {
    source      = "conf/myapp.conf"
    destination = "/etc/myapp.conf"
  }
}
```
5. habitat
habitat预配装的Habitat管理者和配置加载服务
先决条件：
对于ssh类型连接，我们假设在远程主机上有一些工具可用：
- curl
- tee
- setsid- 仅在使用unmanaged服务类型时

5. local-exec
在local-exec创建资源后供应者调用本地可执行文件。


6. Puppet 预配器
先决条件：

对于ssh类型连接，cURL必须在远程主机上可用。
对于winrm连接，PowerShell 2.0必须在远程主机上可用。

7. remote-exec
remote-exec供应方的远程资源调用的脚本在创建后。
8. salt-masterless
salt-masterlessTerraform供应方规定的机器使用内置Terraform salt的状态，而无需连接到salt-masterless

### 五、模块
1. 发布来源
[terraform registry](https://registry.terraform.io/) 上发布模块公共的模块

[自己实现api](https://www.terraform.io/docs/registry/api.html)

2. 来源类型
在module块中source参数告诉terraform从哪里找到子module
有如下方式：
- 本地路径
- terraform registry
- github
- bitbucket
- 公共git仓库
- http urls
- s3 bucket
- gcs bucket

3. 模块组成
依赖性倒置
有条件地创建对象
多云抽象
仅数据模块

核心: 
1. 定义
- main.tf 资源定义值文件
- outputs.tf 输出变量,用于其他模块引用
- aliables.tf 输入变量,用于获取外部变量.
2. 引用
使用外部module



### 六、后端
后端的作用,可以团队工作、保持磁盘上的敏感信息和远程操作。
后端初始化配置好后端使用配置进行***terraform init***

```
terraform {
  backend "consul" {
    address = "demo.consul.io"
    scheme  = "https"
    path    = "example_app/terraform_state"
  }
}
```
后端负责存储状态并提供状态锁定API
手动推拉从远程状态中检索状态

### 七、插件
Terraform供应商插件提供。gong'kai特定服务和配置程序。
安装插件将插件放入**%APPDATA%\terraform.d\plugins**目录下。
开发插件
```
package main

import (
    "github.com/hashicorp/terraform/plugin"
)

func main() {
    plugin.Serve(new(MyPlugin)) //实现Provider或Provisioner
}
```

provider插件
插件提供者负责资源的生命周期：创建、读取、更新和删除。
提供插件

```

import (
	"github.com/hashicorp/terraform/helper/schema"
	"github.com/hashicorp/terraform/terraform"
)
//这是提供程序本身的配置架构  
func Provider() terraform.ResourceProvider {
	return &schema.Provider{
		DataSourcesMap: map[string]*schema.Resource{
			"template_file":             dataSourceFile(),
			"template_cloudinit_config": dataSourceCloudinitConfig(),
		},
		ResourcesMap: map[string]*schema.Resource{
			"template_file": schema.DataSourceResourceShim(
				"template_file",
				dataSourceFile(),
			),
			"template_cloudinit_config": schema.DataSourceResourceShim(
				"template_cloudinit_config",
				dataSourceCloudinitConfig(),
			),
			"template_dir": resourceDir(),
		},
	}
}
```

部分状态改变操作

```
func resourceUpdate(d *schema.ResourceData, meta interface{}) error {
    // Enable partial state mode
    d.Partial(true)


    if d.HasChange("tags") {
    // 如果tags属性值变化了进行其他操作
        // If an error occurs, return with an error,
        // we didn't finish updating
        if err := updateTags(d, meta); err != nil {
            return err
        }

        d.SetPartial("tags")
    }

    if d.HasChange("name") {
        if err := updateName(d, meta); err != nil {
            return err
        }

        d.SetPartial("name")
    }

    // We succeeded, disable partial mode
    d.Partial(false)

    return nil
}
```



### 八、内幕
**调试terraform设置日志打印**
环境变量中添加

```
# 打印等级 TRACE，DEBUG，INFO，WARN或ERROR
TF_LOG=TRACE
TF_LOG_PATH=path


```

Terraform崩溃（Go运行时中的“恐慌”），它会保存一个日志文件，其中包含来自会话的调试日志以及恐慌消息和回溯到crash.log

**资源图**


 所有资源组合编排实际在terraform中，组成了一个复杂的资源依赖图，资源图由资源节点、提供者配置节点和资源元节点组成，所以并发构建其实是对图中未依赖的资源节点和依赖的执行节点进行并发创建. terraform是支持并发构建的。让我默认看看terraform资源图创建与遍历原理，来理解terraform并发创建基础设施。
图形节点：
1. 资源节点  - 表示单个资源 count设置了元参数，那么每个计数将有一个资源节点 （更改中的资源的配置，差异，状态等附加到此节点。）
2. 提供者配置节点 -表示完全配置提供者的时机，将提供者配置提供给提供者的实际，如aws安全认证
3.资源源节点 -表示一组资源，但不代表任何操作
构建图形:
1. 根据配置添加资源节点。如果存在diff（计划）或状态，则将该元数据附加到每个资源节点。
2. 如果资源有任何已定义的资源，则映射到资源。必须在创建所有资源节点后执行此操作，以便具有相同配置程序类型的资源可以共享配置程序实现。
3. depends_on元参数的显式依赖关系用于创建资源边缘。
4. 如果存在状态，则将任何“孤立”资源添加到图形中。孤立资源是配置中不再存在但存在于状态文件中的任何资源。孤儿永远不会有任何与之关联的配置，因为状态文件不存储配置。
5. 资源映射到提供者。为这些提供程序创建提供程序配置节点，并创建边缘，以便资源依赖于正在配置的各自提供程序。
6. 在资源和提供程序配置中解析插值以确定依赖性。对资源属性的引用变为从具有内插的资源到被引用资源的依赖性。
7. 创建根节点。根节点指向所有资源并且已创建，因此依赖关系图中只有一个根。遍历图形时，将忽略根节点。
8. 如果存在diff，则遍历所有资源节点并查找正在销毁的资源。这些资源节点分为两个：一个销毁资源的节点和另一个创建资源的节点（如果正在重新创建）。必须拆分节点的原因是因为销毁顺序通常与创建顺序不同，因此它们不能由单个图节点表示。
9. 验证图表没有周期并且具有单个根节点。
遍历图形：
遍历图形，采用一个标准的深度优先遍历方式，图的遍历是并行的，一旦遍历所有依赖关系，就运行一个节点。默认图表同时操作10个节点，也可以使用-parallelism参数更改并发数

**资源的生命周期**

1. ValidateResource被称为对资源配置进行高级结构验证。
2. Diff使用当前状态和配置调用。
3. Apply用当前状态和差异调用。
4. 如果资源刚刚创建且之前不存在，并且应用成功而没有错误，则按顺序执行配置程序。如果任何供应商错误，资源被标记为 污染，以便在下次申请时将其销毁。

**资源地址**
一个资源地址是引用了一个更大的基础设施中的特定资源的字符串。
1. 模块路径
```
module.A.module.B.module.C...
```
2. 资源规格
```
resource_type.resource_name[N]
```

**json输出格式**
状态表示、计划表示、值表示形式、配置表示和更改表示都可以使用json的方式查看。

**远程服务发现**
**插件**
