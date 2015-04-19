var gulp = require('gulp');
var sass = require('gulp-sass');
var rename = require('gulp-rename');
var autoprefixer = require('gulp-autoprefixer');
var sourcemaps = require('gulp-sourcemaps');


gulp.task('default', ['sass']);

gulp.task('sass', function(done) {
  gulp.src('./public/stylesheets/sass/style.sass')
    .pipe(sourcemaps.init())
      .pipe(sass({
        outputStyle: 'compressed',
        sourceComments: 'map'
      }))
      .pipe(autoprefixer({
        browsers: ['last 2 versions'],
        cascade: false
      }))
      .pipe(rename({ extname: '.min.css' }))
    .pipe(sourcemaps.write('../maps'))
    .pipe(gulp.dest('./public/stylesheets/'))
    .on('end', done);
});