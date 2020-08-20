#!/bin/bash
cd $(dirname $0)
pwd

hexo clean

./build.sh

gulp default

hexo deploy