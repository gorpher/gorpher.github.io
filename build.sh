#!/bin/bash
cd $(dirname $0)
pwd
hexo g
bash  ./submodule/bash-tutorial/build.sh
rm -rf ./public/bash
mv  ./submodule/bash-tutorial/dist ./public/bash