---
title: bash入门栗子
date: {{date}}
categories: note
tags: 
- linux
- bash
---

# 【例子:001】判断输入为数字，字符或其他
```sh
#!/bin/bash  
read -p "Enter a number or string here:" input  

case $input in  
   [0-9]) echo -e "Good job, Your input is a numberic! \n" ;;  
[a-zA-Z]) echo -e "Good job, Your input is a character! \n" ;;  
       *) echo -e "Your input is wrong, input again!   \n"  ;;  
esac
```
# 【例子:002】求平均数
代码如下:
```sh
#!/bin/bash  
  
# Calculate the average of a series of numbers.  
  
SCORE="0"  
AVERAGE="0"  
SUM="0"  
NUM="0"  
  
while true; do  
  
  echo -n "Enter your score [0-100%] ('q' for quit): "; read SCORE;  
  
  if (("$SCORE" < "0"))  || (("$SCORE" > "100")); then  
    echo "Be serious.  Common, try again: "  
  elif [ "$SCORE" == "q" ]; then  
    echo "Average rating: $AVERAGE%."  
    break  
  else  
    SUM=$[$SUM + $SCORE]  
    NUM=$[$NUM + 1]  
    AVERAGE=$[$SUM / $NUM]  
  fi  
  
done  
  
echo "Exiting." 
```


# 【例子:003】自减输出
代码如下:
[scriptname: doit.sh]  
```sh
while (( $# > 0 ))  
do  
  echo $*  
  shift  
done   
```        
/> ./doit.sh a b c d e  
a b c d e  
b c d e  
c d e  
d e  
e  


# 【例子:004】在文件中添加前缀
代码如下:

# 人名列表  
# cat namelist  
Jame  
Bob  
Tom  
Jerry  
Sherry  
Alice  
John  
```sh
# 脚本程序  
# cat namelist.sh  
#!/bin/bash  
for name in $(cat namelist)  
do  
        echo "name= " $name  
done  
echo "The name is out of namelist file"  
```
# 输出结果  
# ./namelist.sh  
name=  Jame  
name=  Bob  
name=  Tom  
name=  Jerry  
name=  Sherry  
name=  Alice  
name=  John 

# 【例子:005】批量测试文件是否存在
代码如下:

[root@host ~]# cat testfile.sh  
```sh      
#!/bin/bash  
  
  
for file in test*.sh  
do  
  if [ -f $file ];then  
     echo "$file existed."  
  fi  
done  
```
[root@host ~]# ./testfile.sh  
test.sh existed.  
test1.sh existed.  
test2.sh existed.  
test3.sh existed.  
test4.sh existed.  
test5.sh existed.  
test78.sh existed.  
test_dev_null.sh existed.  
testfile.sh existed.  



# 【例子:005】用指定大小文件填充硬盘
代码如下:

[root@host ~]# df -ih /tmp  
Filesystem            Inodes   IUsed   IFree IUse% Mounted on  
/dev/mapper/vg00-lvol5  
                       1000K    3.8K    997K    1% /tmp  
[root@host ~]# cat cover_disk.sh  
```sh
#!/bin/env bash  
counter=0  
max=3800  
remainder=0  
while true  
do  
    ((counter=counter+1))  
    if [ ${#counter} -gt $max ];then  
        break  
    fi  
    ((remainder=counter%1000))  
    if [ $remainder -eq 0 ];then  
        echo -e "counter=$counter\tdate=" $(date)  
    fi  
    mkdir -p /tmp/temp  
    cat < testfile > "/tmp/temp/myfile.$counter"  
    if [ $? -ne 0 ];then  
        echo "Failed to write file to Disk."  
        exit 1  
    fi  
done  
echo "Done!"  
```
[root@host ~]# ./cover_disk.sh  
counter=1000    date= Wed Sep 10 09:20:39 HKT 2014  
counter=2000    date= Wed Sep 10 09:20:48 HKT 2014  
counter=3000    date= Wed Sep 10 09:20:56 HKT 2014  
cat: write error: No space left on device  
Failed to write file to Disk.  
dd if=/dev/zero of=testfile bs=1M count=1  



# 【例子:006】通过遍历的方法读取配置文件
代码如下:

[root@host ~]# cat hosts.allow  
127.0.0.1  
127.0.0.2  
127.0.0.3  
127.0.0.4  
127.0.0.5  
127.0.0.6  
127.0.0.7  
127.0.0.8  
127.0.0.9  
[root@host ~]# cat readlines.sh 
```sh 
#!/bin/env bash  
i=0  
while read LINE;do  
    hosts_allow[$i]=$LINE  
    ((i++))  
done < hosts.allow  
for ((i=1;i<=${#hosts_allow[@]};i++)); do  
    echo ${hosts_allow[$i]}  
done  
echo "Done"  
```
[root@host ~]# ./readlines.sh  
127.0.0.2  
127.0.0.3  
127.0.0.4  
127.0.0.5  
127.0.0.6  
127.0.0.7  
127.0.0.8  
127.0.0.9  
Done  


# 【例子:007】简单正则表达式应用
代码如下:

[root@host ~]# cat regex.sh  
```sh
#!/bin/env sh  
#Filename: regex.sh  
regex="[A-Za-z0-9]{6}"  
if [[ $1 =~ $regex ]]  
then  
  num=$1  
  echo $num  
else  
  echo "Invalid entry"  
  exit 1  
fi  
```
[root@host ~]# ./regex.sh 123abc  
123abc  
```sh
#!/bin/env bash  
#Filename: validint.sh  
validint(){  
    ret=`echo $1 | awk '{start = match($1,/^-?[0-9]+$/);if (start == 0) print "1";else print "0"}'`  
    return $ret  
}  
  
validint $1  
  
if [ $? -ne 0 ]; then  
    echo "Wrong Entry"  
    exit 1  
else  
    echo "OK! Input number is:" $1  
fi  
```


# 【例子:008】简单的按日期备份文件
代码如下:
```sh
#!/bin/bash  
  
NOW=$(date +"%m-%d-%Y")      # 当前日期  
FILE="backup.$NOW.tar.gz"    # 备份文件  
echo "Backing up data to /tmp/backup.$NOW.tar.gz file, please wait..."  #打印信息  
tar xcvf /tmp/backup.$NOW.tar.gz /home/ /etc/ /var       # 同时备份多个文件到指定的tar压缩文件中  
echo "Done..."  
```         
