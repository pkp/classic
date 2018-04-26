var gulp = require('gulp');
var sass = require('gulp-sass');
var concat = require('gulp-concat');
var concatCss = require('gulp-concat-css');
var minifyCSS = require('gulp-csso');
var sourcemaps = require('gulp-sourcemaps');
var minify = require('gulp-minify');

gulp.task('sass', function () {
    gulp.src(['resources/scss/**/*.scss', 'resources/fontawesome/css/fontawesome-all.css']) // font-awesome css is installed manually because we cannot install 5+ version with node js yet
        .pipe(sass())
        .pipe(concat('app.min.css'))
        .pipe(minifyCSS())
        .pipe(gulp.dest('css'))
});

gulp.task('scripts', function () {
    gulp.src(['node_modules/jquery/dist/jquery.js', 'node_modules/popper.js/dist/umd/popper.js', 'node_modules/bootstrap/dist/js/bootstrap.js', 'resources/javascript/**/*.js'])
        .pipe(sourcemaps.init())
        .pipe(concat('app.min.js'))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest('js'));
});

gulp.task('compress', function () {
    gulp.src('js/app.js')
        .pipe(minify({
            ext: {
                src: '-debug.js',
                min: '.js'
            },
            exclude: ['tasks'],
            ignoreFiles: ['.combo.js', '-min.js']
        }))
        .pipe(gulp.dest('js'))
});

gulp.task('watch', function () {
    gulp.watch('resources/scss/**/*.scss', ['sass']);
    gulp.watch('resources/javascript/**/*.js', ['scripts']);
});

