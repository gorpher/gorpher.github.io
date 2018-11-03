

两大容器 collection map

collection----------->  1.list
                                ------------->1. arraylist 2.linkedlist
collection ----------->  2.set
                                -------------->1.hashset   3.treeset

map ----------> 1.hashmap 2.treemap

collection
    |------List:元素是有序的，元素可以重复。因为该集合体系有索引。由于底层数据结构不同，有三个子类。
            |--ArrayList:底层数据结构使用的是数组结构。特点：查询速度快，但增删稍慢。线程不同步（建议使用）。
            |--LinkedList:底层的数据结构是链表数据结构。特点：增删的速度快，查询稍慢。
            |--Vector:底层是数组数据结构。线程同步。
                                ArrayList默认长度是10，超出长度时，50%延长。
                                Vector默认长度是10，超出长度时，100%延长。
    |------Set：元素是无序的，元素不可以重复。该集合体系无索引。Set集合的功能和Collection是一致的。
        |--HashSet：底层数据结构是哈希表。线程是非同步的。
        |--TreeSet：可以对Set集合中的元素进行排序。按照字母的自然顺序排序。底层数据结构是二叉树，保证元素唯一性的依据是compareTo方法return 0。
## ArrayList
ArrayList里边的元素不唯一，有序。 内存空间连续。 元素遍历快，增删慢。

增add  查get... 删remove  改set(index,obj)

## HashSet
元素唯一，无序。
此类实现 Set 接口，由哈希表（实际上是一个 HashMap 实例）支持。
它不保证 set 的迭代顺序；特别是它不保证该顺序恒久不变。此类允许使用 null 元素。

增add 查iterator 删remove  改...


## HashMap
存在一个K到V的一一映射，且K值不允许重复。
K - 此映射所维护的键的类型，V - 所映射值的类型
基于哈希表的 Map 接口的实现。此实现提供所有可选的映射操作，并允许使用 null 值和 null 键。（除了非同步和允许使用 null 之外，HashMap 类与 Hashtable 大致相同。）此类不保证映射的顺序，特别是它不保证该顺序恒久不变。
增 put  查get  删remove  改replace

