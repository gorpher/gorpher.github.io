#!/bin/bash
# 变量声明并赋值
name="matosiki"
source ./test1.sh

# 局部变量
for skill in Ada Coffe Action Java; do
    echo "I am good at ${skill}Script"
done

# 拼接字符串
echo "Hello, I know your are \"$name\"! \n"
greeting="hello, "$name" !"
greeting_1="hello, ${name} !"
echo $greeting $greeting_1

# 获取字符串长度
string="matosiki"
echo ${#string}     #输出 4

# 提取子字符串
string="runoob is a great site"
echo ${string:1:5} 
echo '-------------------------'

# 定义数组
arr=('爱情' '家庭' '幸福' 28 1996.3)
phone=(
'诺基亚'
'iphone'
'华为'
'小米'
)
phone[4]='三星'
# 读取数组
echo ${phone[4]}
# 读取数组所有值
echo ${arr[@]}
# 取得数组元素的个数
length1=${#phone[@]}
# 或者
length2=${#phone[*]}
# 取得数组单个元素的长度  lengthn=${#phone[n]}
length3=${#phone[0]}
echo $length3

echo '-------------------------'
# 传递参数  执行命令行./hello.sh arg1 arg2 arg3
echo "执行的文件名：$0";
echo '参数一:'$1
echo '参数二:'$2
echo '参数三:'$3
# 传递到脚本的参数个数
echo '传递到脚本的参数个数:'$#
# 以一个单字符串显示所有向脚本传递的参数。
echo  '打印所有参数:'$*  
# $@与$*相同，但是使用时加引号，并在引号中返回每个参数。
echo '打印所有参数:'$@
# 脚本运行的当前进程ID号
echo $$
# 后台运行的最后一个进程的ID号
echo $!
# 显示Shell使用的当前选项，与set命令功能相同。
echo $-
# 显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。
echo $?
echo '-------------------------'
# 基本运算符
val=`expr 2 + 2`
echo "两数之和为 : $val"
## 算术运算符
a=10
b=20
# +	加法	`expr $a + $b` 结果为 30。
echo `expr $a + $b`
# -	减法	`expr $a - $b` 结果为 -10。
echo `expr $a - $b`
# *	乘法	`expr $a \* $b` 结果为  200。
echo `expr $a \* $b`
# /	除法	`expr $b / $a` 结果为 2。
echo `expr $a / $b`
# %	取余	`expr $b % $a` 结果为 0。
echo `expr $a % $b`
# =	赋值	a=$b 将把变量 b 的值赋给 a。
# a=$b
# ==	相等。用于比较两个数字，相同则返回 true。	[ $a == $b ] 返回 false。
if [ $a == $b ]
then
echo 'a 等于 b'
fi
# !=	不相等。用于比较两个数字，不相同则返回 true。	[ $a != $b ] 返回 true。
if [ $a != $b ]
then
echo 'a 不等于 b'
fi
## 关系运算符
#-eq	检测两个数是否相等，相等返回 true。	[ $a -eq $b ] 返回 false。
if [ $a -eq $b ]
then
echo true
else
echo false
fi
#-ne	检测两个数是否相等，不相等返回 true。	[ $a -ne $b ] 返回 true。
if [ $a -ne $b ]
then
echo true
else
echo false
fi
#-gt	检测左边的数是否大于右边的，如果是，则返回 true。	[ $a -gt $b ] 返回 false。
if [ $a -gt $b ]
then
echo true
else
echo false
fi
#-lt	检测左边的数是否小于右边的，如果是，则返回 true。	[ $a -lt $b ] 返回 true。
if [ $a -lt $b ]
then
echo true
else
echo false
fi
#-ge	检测左边的数是否大于等于右边的，如果是，则返回 true。	[ $a -ge $b ] 返回 false。
if [ $a -ge $b ]
then
echo true
else
echo false
fi
#-le	检测左边的数是否小于等于右边的，如果是，则返回 true。	[ $a -le $b ] 返回 true。
if [ $a -le $b ]
then
echo true
else
echo false
fi
echo '-------------------------'
#!	非运算，表达式为 true 则返回 false，否则返回 true。	[ ! false ] 返回 true。
if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
#-o	或运算，有一个表达式为 true 则返回 true。	[ $a -lt 20 -o $b -gt 100 ] 返回 true。
if [ $a != $b -o $a == $b ]
then
echo '按道理我是永久成立的.'
fi
#-a	与运算，两个表达式都为 true 才返回 true。	[ $a -lt 20 -a $b -gt 100 ] 返回 false。
if [ $a != $b -a $a == $b ]
then
echo 我不会哭,这就是命.
fi
#&&	逻辑的 AND	[[ $a -lt 100 && $b -gt 100 ]] 返回 false
if [[ $a -lt 100 && $b -gt 100 ]]
then
echo true
else
echo false
fi
#||	逻辑的 OR	[[ $a -lt 100 || $b -gt 100 ]] 返回 true
if [[ $a -lt 100 || $b -gt 100 ]]
then 
echo true
else
echo false
fi
echo '-------------------------'
a='abc'
b='efg'
# =	检测两个字符串是否相等，相等返回 true。	[ $a = $b ] 返回 false。
if [ $a = $b ] 
then 
echo true
else
echo false
fi
#!=	检测两个字符串是否相等，不相等返回 true。	[ $a != $b ] 返回 true。
if [ $a != $b ]
then 
echo true
else
echo false
fi
#-z	检测字符串长度是否为0，为0返回 true。	[ -z $a ] 返回 false。
if [ -z $a ]
then 
echo true
else
echo false
fi
#-n	检测字符串长度是否为0，不为0返回 true。	[ -n $a ] 返回 true。
if [ -n $a ]
then 
echo true
else
echo false
fi
#str	检测字符串是否为空，不为空返回 true。	[ $a ] 返回 true。
if [ $a ]
then 
echo true
else
echo false
fi

echo '-------------------------'
file='./hello.sh'
#-b file	检测文件是否是块设备文件，如果是，则返回 true。	[ -b $file ] 返回 false。
if [ -b $file ]
then
echo '设备模块'
else 
echo '不是设备模块'
fi
#-c file	检测文件是否是字符设备文件，如果是，则返回 true。	[ -c $file ] 返回 false。
if [ -c $file ]
then 
echo true
else
echo false
fi
#-d file	检测文件是否是目录，如果是，则返回 true。	[ -d $file ] 返回 false。
if [ -d $file ]
then 
echo true
else
echo false
fi
#-f file	检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。	[ -f $file ] 返回 true。
if [ -f $file ]
then 
echo true
else
echo false
fi
#-g file	检测文件是否设置了 SGID 位，如果是，则返回 true。	[ -g $file ] 返回 false。
if [ -g $file ]
then 
echo true
else
echo false
fi
#-k file	检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true。	[ -k $file ] 返回 false。
if [ -k $file ]
then 
echo true
else
echo false
fi
#-p file	检测文件是否是有名管道，如果是，则返回 true。	[ -p $file ] 返回 false。
if [ -p $file ]
then 
echo true
else
echo false
fi
#-u file	检测文件是否设置了 SUID 位，如果是，则返回 true。	[ -u $file ] 返回 false。
if [ -u $file ]
then 
echo true
else
echo false
fi
#-r file	检测文件是否可读，如果是，则返回 true。	[ -r $file ] 返回 true。
if [ -r $file ]
then 
echo true
else
echo false
fi
#-w file	检测文件是否可写，如果是，则返回 true。	[ -w $file ] 返回 true。
if [ -w $file ]
then 
echo true
else
echo false
fi
#-x file	检测文件是否可执行，如果是，则返回 true。	[ -x $file ] 返回 true。
if [ -x $file ]
then 
echo true
else
echo false
fi
#-s file	检测文件是否为空（文件大小是否大于0），不为空返回 true。	[ -s $file ] 返回 true。
if [ -s $file ]
then 
echo true
else
echo false
fi
#-e file	检测文件（包括目录）是否存在，如果是，则返回 true。	[ -e $file ] 返回 true。
if [ -e $file ]
then 
echo true
else
echo false
fi
echo '-----------------------------'

# 显示换行
echo -e "Ok! \n \c" # -e开启转义 \c 不换行
echo "It it a test"
# 显示结果定向至文件
# echo 'It is my best Test File' > myfile
echo '$name\"'
# 显示命令执行结果
echo `date`

echo '------------------------------'
# printf
echo "Hello, Shell"
printf "Hello, Shell\n"
# %-10s 指一个宽度为10个字符（-表示左对齐，没有则表示右对齐）
printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg  
printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234 
printf "%-10s %-8s %-4.2f\n" 杨过 男 48.6543 
printf "%-10s %-8s %-4.2f\n" 郭芙 女 47.9876 

# 格式只指定了一个参数，但多出的参数仍然会按照该格式输出，format-string 被重用
printf %s abc def

printf "%s\n" abc def

printf "%s %s %s\n" a b c d e f g h i j

# 如果没有 arguments，那么 %s 用NULL代替，%d 用 0 代替
printf "%s and %d \n" 

echo '-----------------------------'

# 测试命令
# 数值测试
num1=100
num2=100
echo test $[num1] -eq $[num2]
if test $[num1] -eq $[num2]
then
    echo '两个数相等！'
else
    echo '两个数不相等！'
fi

result=$[num1+num2]
echo "result为: $result"

# 字符串测试
if test $a = $b
then
    echo '两个字符串相等!'
else
    echo '两个字符串不相等!'
fi

# 文件测试
if test -e ./bash
then
    echo '文件已存在!'
else
    echo '文件不存在!'
fi

cd /bin
if test -e ./notFile -o -e ./bash
then
    echo '有一个文件存在!'
else
    echo '两个文件都不存在'
fi
echo '-------------------------'

# 流程控制
# if else-if else
if [ $a == $b ]
then
  echo 'a==b'
elif [ $a -gt $b ]
then
  echo 'a>b'
elif [ $a -lt $b ]
then
  echo 'a<b'
else
  echo '没有符合条件的??'
fi

# for 循环
for loop in 1 2 3 4 5
do
    echo "The value is: $loop"
done

for str in 'This is a string'
do
    echo $str
done
echo '-------------------'
# while 语句

int=1
while(( $int<=5 ))
do
        echo $int
        let "int++"
done

#echo '按下 <CTRL-D> 退出'
#echo -n '输入你最喜欢的电影名: '
#while read FILM
#do
#   echo "是的！$FILM 是一部好电影"
#done

#i = 1;
#while : ;do echo $[i++] ;done;
# until 循环


while :
do
    echo -n "输入 1 到 5 之间的数字:"
    read aNum
    case $aNum in
        1|2|3|4|5) echo "你输入的数字为 $aNum!"
        ;;
        *) echo "你输入的数字不是 1 到 5 之间的! 游戏结束"
            break
        ;;
    esac
done

# 函数
# $#	传递到脚本的参数个数
# $*	以一个单字符串显示所有向脚本传递的参数
# $$	脚本运行的当前进程ID号
# $!	后台运行的最后一个进程的ID号
# $@	与$*相同，但是使用时加引号，并在引号中返回每个参数。
# $-	显示Shell使用的当前选项，与set命令功能相同。
# $?	显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。
add(){
    echo "参数个数$#"
    echo "所有参数$*"
    echo "所有参数$@"
    let res=0
    for args in $@
    do
        res=$(($res+$args))
        #echo $args $res
    done
    return $res
}
add 1 2 3 4 5 6 7 8 9 10
val=$?
echo "$val!"
echo '--------------------------------'

# 输入/输出重定向
# command > file	将输出重定向到 file。
# command < file	将输入重定向到 file。
# command >> file	将输出以追加的方式重定向到 file。
# n > file	将文件描述符为 n 的文件重定向到 file。
# n >> file	将文件描述符为 n 的文件以追加的方式重定向到 file。
# n >& m	将输出文件 m 和 n 合并。
# n <& m	将输入文件 m 和 n 合并。
# << tag	将开始标记 tag 和结束标记 tag 之间的内容作为输入。
#$ command > file 2>&1
#或者
#$ command >> file 2>&1
#如果希望对 stdin 和 stdout 都重定向，可以这样写：
#$ command < file1 >file2
# 0 是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。

# 文件包含
#. filename   # 注意点号(.)和文件名中间有一空格
#source filename    
#. ./test1.sh
printf "thisFile>名称:%s 价格:%f" $name $money