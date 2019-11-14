---
title: terraform-理解入门
categories: note
banner: 'http://img.matosiki.site/image/banner/20190805/blossoms-of-cherry-tree-in-the-spring_free_stock_photos_picjumbo_DSC04173.jpg'
thumbnail: 'http://img.matosiki.site/banner/20190805/mountains-scenery-free-photos.jpg'
date: 2019-08-04 10:42:58
tags: ["cloud","基础服务","中间件","编排","terraform"]
---

## 腾讯云栗子
[下载-tencentcloud-demo-module.zip](http://doc.matosiki.site/terraform/tencentcloud-demo-module.zip)
### Terraform是一种安全有效地构建，更改和版本化基础架构的工具。
Terraform用于创建，管理和更新基础架构资源，例如物理机，VM，网络交换机，容器等。几乎任何基础设施类型都可以表示为Terraform中的资源。
### 四大功能
1. 基础设置代码
2. 执行计划
3. 资源图
4. 自动更新


### Terraform使用场景
1. Heroku应用设置
2. 多层应用
3. 自助服务集群
4. 软件演示
5. 一次性环境
6. 软件定义网络（SDN）
7. 资源调度程序
8. 多云部署

### 使用terraform

#### 安装
[下载](https://www.terraform.io/downloads.html)windows版本
使用命令验证安装
将terraform.exe拷贝到指定目录,并设置path环境变量
```
terraform
```
设置环境变量 插件缓存目录

```
set TF_PLUGIN_CACHE_DIR="%HOME%\.terraform.d\plugin-cache"
```

手动安装插件目录

```
%APPDATA%\terraform.d\plugins
```

手动安装provider插件
[aws-provider插件](https://github.com/terraform-providers/terraform-provider-aws)
[google-provider插件](https://github.com/terraform-providers/terraform-provider-google)



### 构建基础架构

#### 一.配置

```
provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
```




#### 二.初始化
```
terraform init
terraform apply 
terrafomr show
```


#### 三.应用更改
更改ami
```
resource "aws_instance" "example" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
}
```

```
terraform apply 
```
```
terrafomr show
```

```
# 销毁基础设施
terraform destroy
```

#### 四.资源依赖
1. 隐性依赖
Terraform可以自动推断出一个资源何时依赖于另一个资源.
Terraform使用此依赖关系信息来确定创建不同资源的正确顺序
通过插值表达式的隐式依赖关系是告知Terraform关于这些关系的主要方式，应尽可能使用。

2. 显式依赖
depends_on任何资源都接受该参数，并接受资源列表以创建显式依赖项。

```
depends_on=[google_instance.example]
```

3. 非资源依赖
Terraform将同时执行操作以减少应用更改所需的总时间,非资源依赖与其他资源依赖的可能同时创建.

#### 五.提供
负责实例创建完成初始化工作,比如运行shell、触发软件配置等等.
1. 定义提供者

```
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
```
terraform可以定义多个提供者
2. 应用配置
```
terraform apply
cat ip_address.txt
```

**失败的提供者和污点资源**

如果资源成功创建但在配置期间失败，则Terraform将发生错误并将资源标记为“受污染”。一个污点资源已被物理创建出来，由于预配失败，将无法被视为安全的使用。

当执行下一个计划时，因为不能保证安全，terraform不会在相同的资源上尝试重启预配置。取代方式是，terraform将移除所有污点资源，然后再创建资源并尝试预配置。

因为违反了执行计划，当执行期间失败时，terraform不会回滚和删除资源。

执行计划只告诉资源的创建，不会有删除资源，如果创建一个污点资源，计划将清除状态，资源将被删除。

#### 销毁provisioners
还可以定义仅在销毁操作期间运行的供应商。这些对于执行系统清理，提取数据等非常有用。
对于许多资源，建议尽可能使用内置清理机制（例如init脚本），但必要时可以使用配置程序。

[provisioners详细文档](https://www.terraform.io/docs/provisioners/)

#### 输入变量
1. 定义变量
创建**variables.tf**文件
```
variable "region" {
  default = "us-east-1"
}
```
2. 引用变量
```
provider "aws" {
  region = "${var.region}"
}
```
### 分配变量
1. 命令行分配方式
```
terraform apply   -var region=us-east-2
```
2. 从文件中分配
创建目录匹配**terraform.tfvars**或 **.auto.tfvars**存在的所有文件，分配变量值。

```
region = "us-east-2"
```
指定多个变量文件
```
terraform apply \
  -var-file="secret.tfvars" \
  -var-file="production.tfvars"

```
3. 环境变量
Terraform读取**TF_VAR_name**变量，**TF_VAR_region **设置region变量
 
4. UI输入
如果您terraform apply使用未指定的某些变量执行，Terraform将要求您以交互方式输入其值。

定义list类型变量

```
# 隐式声明
# implicitly by using brackets [...]
variable "cidrs" { default = [] }

# 显式声明
# explicitly
variable "cidrs" { type = list }
```
**terraform.tfvars**文件中定义
```
cidrs = [ "10.0.0.0/16", "10.1.0.0/16" ]
```
定义map类型变量
```
variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}
```

```
resource "aws_instance" "example" {
  ami           = var.amis[var.region]
  instance_type = "t2.micro"
}
```
命令行分配map类型变量
```
terraform apply -var 'amis={ us-east-1 = "foo", us-west-2 = "bar" }'
```

栗子
variables.tf
```
variable "region" {}
variable "amis" {
  type = "map"
}
```
terraform.tfvars
```
amis = {
  "us-east-1" = "ami-abc123"
  "us-west-2" = "ami-def456"
}
```
main.tf
```
resource "aws_instance" "example" {
  # ami           = "ami-b374d5a5"
  ami           = "${var.amis[var.region]}"
  instance_type = "t2.micro"
}
output "ami" {
  value = aws_instance.example.ami
}
```
cli
```
terraform apply -var region=us-west-2
```



#### 输出变量
1. 定义输出
添加到任何 **\*.tf** 文件中
```
output "ip" {
  value = aws_eip.ip.public_ip
}
```
output可以定义多个块以指定多个输出变量。

2.查看输出
命令行

```
terraform ouput ip
```
此命令对于脚本提取输出很有用

#### 模块
Terraform中的模块是Terraform配置的独立包，可作为一个组进行管理。模块用于创建可重用组件，改进组织，并将基础架构处理为黑盒子。
[模块文档](https://www.terraform.io/docs/modules/index.html)

1. 使用模块

```
terraform {
  required_version = "0.12.5"
}

provider "aws" {
  access_key = "AWS ACCESS KEY"
  secret_key = "AWS SECRET KEY"
  region     = "us-east-1"
}

module "consul" {
  source      = "hashicorp/consul/aws"
  num_servers = "3"
}
```
该source属性是模块的唯一必需参数。它告诉Terraform可以检索模块的位置。Terraform会自动为您下载和管理模块。

模块从官方Terraform Registry中检索。Terraform还可以从各种来源检索模块，包括私有模块注册表或直接从Git，Mercurial，HTTP和本地文件。

```
terraform init
```

2. 应用更改

```
terraform apply
```

3. 模块输出
[模块输出文档](https://registry.terraform.io/modules/hashicorp/consul/aws?tab=outputs)
描述了它产生的所有不同值。总的来说，它暴露了它创建的每个资源的id，以及回显一些输入值。
4. 销毁
```
terraform destroy
```

#### 远程状态存储
[远程后端文档](https://www.terraform.io/docs/backends/index.html)
远程后端允许Terraform使用共享存储空间来存储状态数据，因此团队中的任何成员都可以使用Terraform来管理相同的基础架构。

##### 1. 如何远程状态存储
```
terraform {
  backend "remote" {
    organization = "Cloud-Org"

    workspaces {
      name = "Dev-QA"
    }
  }
}
```
##### 2. 远程状态存储方案

##### 3. [Terraform Cloud文档](https://www.hashicorp.com/products/terraform/?utm_source=oss&utm_medium=getting-started&utm_campaign=terraform)
它支持执行Terraform运行的两个主要工作流程：

- VCS驱动的工作流，在将更改提交到配置的VCS存储库时，它会自动对计划进行排队。
- API驱动的工作流，CI管道或其他自动化工具可以直接上传配置。

1. 登录[terraform cloud console](https://app.terraform.io/app)
2. 升级terraform版本到0.11.13以上
3. 在cloud上创建组织
4. 添加组织成员
5. 在cloud上添加[access token](https://app.terraform.io/app/settings/tokens)并配置本机认证
文件**%APPDATA%\terraform.rc**

```
credentials "app.terraform.io" {
  token = "REPLACE_ME"
}
```

6. 在配置中开启terraform remote state 配置

```
terraform {
  backend "remote" {
    organization = "max"

    workspaces {
      name = "app-max-hello"
    }
  }
}
```

7. 重新初始化并运行terraform

```
terraform init
```

8. 协作查看
- 查看工作区
- 工作区锁定
- 查看状态历史版本

9. 删除工作空间

```
terraform destroy -auto-approve
```

