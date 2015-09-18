gulp = require 'gulp'
config = require './config.coffee'
fs = require 'fs'
server = require('browser-sync').create()
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
gutil = require 'gulp-util'
filter = require 'gulp-filter'
bowerFiles = require 'gulp-bower-files'
templateCache = require 'gulp-angular-templateCache'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'

# TODO: add source maps for coffee task and vendor task
gulp.task 'coffee', ->
  gulp.src "#{config.app_path}/**/*.coffee"
    .pipe coffee(bare: true)
    .pipe concat(config.app_main_file)
    .pipe gulp.dest "#{config.web_path}/js"
    .on 'error', gutil.log

gulp.task 'sass', ->
  gulp.src "#{config.app_path}/**/*.sass"
  .pipe sass()
  .pipe concat(config.css_main_file)
  .pipe gulp.dest "#{config.web_path}/css"
  .on 'error', gutil.log

gulp.task 'html', ->
  gulp.src "#{config.app_path}/{components,routes}/**/*.html"
    .pipe templateCache(module: "#{config.app_name}")
    .pipe gulp.dest "#{config.web_path}/js"
    .on 'error', gutil.log
  gulp.src "#{config.app_path}/index.html"
    .pipe gulp.dest "#{config.web_path}"
    .on 'error', gutil.log

gulp.task 'assets', ->
  gulp.src "#{config.assets_path}/**"
    .pipe gulp.dest "#{config.web_path}/assets"
    .on 'error', gutil.log

gulp.task 'vendor', ['bower'], ->
  if fs.existsSync "#{config.vendor_path}"
    gulp.src "#{config.vendor_path}/**/*.js"
      .pipe concat "#{config.vendor_main_file}"
      .pipe gulp.dest "#{config.web_path}/js"
      .on 'error', gutil.log

gulp.task 'bower:js', ->
  if fs.existsSync './bower_components'
    bowerFiles()
      .pipe filter '**/*.js'
      .pipe concat "#{config.bower_main_js_file}"
      .pipe gulp.dest "#{config.web_path}/js"
      .on 'error', gutil.log

gulp.task 'bower:css', ->
  if fs.existsSync './bower_components'
    bowerFiles()
      .pipe filter '**/*.css'
      .pipe concat "#{config.bower_main_css_file}"
      .pipe gulp.dest "#{config.web_path}/css"
      .on 'error', gutil.log

gulp.task 'bower', ['bower:js', 'bower:css']

gulp.task 'minify', ['vendor', 'bower:js', 'coffee'], ->
  gulp.src "#{config.web_path}/js/**.js"
    .pipe uglify outSourceMap: true
    .pipe gulp.dest "#{config.web_path}/js"
    .on 'error', gutil.log

gulp.task 'build', ['coffee','sass','html','vendor','assets']

gulp.task 'watch', ['build'], ->
  # TODO: could probably split up and make more efficent
  gulp.watch "#{config.app_path}/**", ['coffee','sass','html','assets']

gulp.task 'serve', ['build'], ->
  server.init server: "#{config.web_path}"
  gulp.watch "#{config.app_path}/**", ['build']
  gulp.watch("#{config.app_path}/**").on('change', server.reload)


gulp.task 'default', ['serve']
