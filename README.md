# wx11055.github.io
hexo blog


### 新建文件

``` bash
$ hexo new "My New Post"
```
### 运行服务站点

``` bash
$ hexo server
```


### 发布前清理站点

``` bash
$ hexo clean
```

### 生成静态html文件

``` bash
$ hexo generate
```


### 发布的github远程站点

``` bash
$ hexo deploy
```


git 发布错误插件解决办法

> npm install hexo-deployer-git –-save  

More info: [hexo](https://hexo.io/)


## 使用gulp压缩博客发布
> npm install gulp-minify-css gulp-uglify gulp-htmlmin gulp-htmlclean gulp --save

> hexo g && gulp

## 同步文章内容到algolia搜索
> hexo algolia