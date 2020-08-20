var gulp = require('gulp');
var minifycss = require('gulp-minify-css');
// var uglify = require('gulp-uglify');
var htmlclean = require('gulp-htmlclean');
var htmlmin = require('gulp-htmlmin');
const derequire = require('gulp-derequire');
const buffer = require('vinyl-buffer');
const sourcemaps = require('gulp-sourcemaps');
let uglify = require('gulp-uglify-es').default;
// 压缩 public 目录 css
gulp.task('minify-css', () => {
    return gulp.src('./public/**/*.css')
        .pipe(minifycss())
        .pipe(gulp.dest('./public'));
});

// 压缩 public 目录 html
gulp.task('minify-html', () => {
    return gulp.src(['./public/**/*.html', '!index.html'])
        .pipe(htmlclean())
        .pipe(htmlmin({
            removeComments: true,
            minifyJS: true,
            minifyCSS: true,
            minifyURLs: true,
        }))
        .pipe(gulp.dest('./public'))
});
// 压缩 public/js 目录 js
gulp.task('minify-js', () => {
    return gulp.src('./public/**/*.js')
        .pipe(buffer())
        .pipe(derequire())
        .pipe(sourcemaps.init({ loadMaps: true }))
        .pipe(uglify())
        .pipe(gulp.dest('./public'));
});


// 执行 gulp 命令时执行的任务
gulp.task('default', gulp.parallel('minify-html', 'minify-css', 'minify-js'));