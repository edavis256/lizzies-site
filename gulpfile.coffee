gulp = require 'gulp'
config = require './config.coffee'
fs = require 'fs'
server = require('browser-sync').create()
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
gutil = require 'gulp-util'
bowerFiles = require 'gulp-bower-files'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'

gulp.task 'coffee', ->
  gulp.src "#{config.app_path}/**/*.coffee"
    .pipe coffee(bare: true)
    .pipe concat(config.app_main_file)
    .pipe gulp.dest "#{config.web_path}/js"
    .on 'error', gutil.log

gulp.task 'sass', ->
  gulp.src "#{config.styles_main_file}"
  .pipe sass()
  .pipe gulp.dest "#{config.web_path}/css"
  .on 'error', gutil.log

# TODO: add support for concating html files
gulp.task 'html', ->
  gulp.src "#{config.app_path}/index.html"
    .pipe gulp.dest "#{config.web_path}"
    .on 'error', gutil.log

gulp.task 'assets', ->
  gulp.src "#{config.assets_path}/**"
    .pipe gulp.dest "#{config.web_path}/assets"
    .on 'error', gutil.log

gulp.task 'vendor', ->
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

gulp.task 'build', ['coffee','sass','html','vendor','minify','assets']

gulp.task 'watch', ['build'], ->
  # TODO: could probably split up and make more efficent
  gulp.watch "#{config.app_path}/**", ['build']

gulp.task 'serve', ['build'], ->
  server.init server: "#{config.web_path}"
  gulp.watch "#{config.app_path}/**", ['build']
  gulp.watch("#{config.app_path}/**").on('change', server.reload)


gulp.task 'default', ['build', 'watch']
