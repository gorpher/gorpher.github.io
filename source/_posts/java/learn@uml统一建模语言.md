# 建模视图
模型是对现实世界的形状或状态的抽象模拟和简化。
![](./../../img_lib/uml_view.gif)


# 类图关系
类与类之间的关系通常有4种: 


依赖关系（Dependency） 泛化关系（Generalization） 关联关系（Association） 、实现关系（Realization）


1. 依赖关系（Dependency）    (调用)

表示两个或多个模型元素之间语义上的连接关系
虚线箭头，箭头指向被使用者

![](./../../img_lib/uml_dependency.png)

2. 泛化关系（Generalization） （继承）

![](./../../img_lib/uml_generalization.png)

3. 关联关系（Association）     (组合)

表示一个事物的对象与另一个事物的对象之间的语义上连接，
简单的理解为两个类或类与接口之间的强依赖关系
**聚集**
描述的是部分与整体关系，描述了“has a”的关系，部分离开整体可以单独

![](./../../img_lib/uml_association_gather.png)

**组成**
一种更强形式的关联，在整体中拥有管理部分特有的职责，也被称为强聚合关系，部分不能脱离整体存在

![](./../../img_lib/uml_association_composite.png)

4. 实现关系（Realization）  (实现)

将一种模型关系与另一种模型关系连接起来，从而说明和其实现之间的关系，简单的理解为一个类或多个类实现一个接口

![](./../../img_lib/uml_realization.png)



依赖关系（uses-a）聚集关系（has-a）继承关系（is-a）