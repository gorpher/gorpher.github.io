#!/bin/bash
cd $(dirname $0)
pwd

# 获取所有banner图片
qshell listbucket2 iki-img  -p image/banner > themes/hexo-theme-varaint/source/js/images.csv 

# 将banner图片存储为images.json
qshell_csv2json themes/hexo-theme-varaint/source/js/images.csv themes/hexo-theme-varaint/source/js/images.json

# 删除csv文件
rm -f themes/hexo-theme-varaint/source/js/images.csv 

hexo clean && hexo g

bash  ./submodule/bash-tutorial/build.sh

rm -rf ./public/bash

mv  ./submodule/bash-tutorial/dist ./public/bash

# 复制html工具页面
mkdir -p  ./public/html
cp  -r ./submodule/html/* ./public/html/
# hexo algolia  --layouts post --flush 