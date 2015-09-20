gulp       = require 'gulp'
stylus     = require 'gulp-stylus'
jade       = require "gulp-jade"
coffee     = require 'gulp-coffee'
cjsx       = require 'gulp-cjsx'
plumber    = require 'gulp-plumber'
browserify = require 'gulp-browserify'
source     = require 'vinyl-source-stream'
watchify   = require 'gulp-watchify'
rename     = require 'gulp-rename'
babel      = require 'gulp-babel'

paths =
  coffee: 'src/**/*.coffee',
  cjsx: 'src/**/*.cjsx',
  jade: 'src/**/*.jade',
  stylus: 'src/**/*.styl'
  es6: './src/**/*.js'

gulp.task 'build:es6', ->
  gulp.src paths.es6
    .pipe plumber()
    .pipe babel()
    .pipe gulp.dest('build')

gulp.task 'watchify:coffee', watchify (watchify) ->
  gulp.src paths.coffee
    .pipe plumber()
    .pipe watchify
      watch     : on
      extensions: ['.coffee', '.js']
      transform : ['coffeeify']
    .pipe rename
      extname: ".js"
    .pipe gulp.dest 'build'

gulp.task 'watchify:cjsx', watchify (watchify) ->
  gulp.src paths.cjsx
    .pipe plumber()
    .pipe watchify
      watch     : on
      extensions: ['.cjsx']
      transform : ['coffee-reactify']
    .pipe rename
      extname: ".js"
    .pipe gulp.dest 'build'

gulp.task 'build:stylus', ->
  gulp.src paths.stylus
    .pipe plumber()
    .pipe stylus()
    .pipe gulp.dest('build')

gulp.task 'build:jade', ->
  gulp.src paths.jade
    .pipe plumber()
    .pipe jade()
    .pipe gulp.dest('build')

gulp.task 'build', [
  'watchify:coffee',
  'watchify:cjsx',
  'build:stylus',
  'build:jade'
  'build:es6'
]

gulp.task 'watch', ->
  gulp.watch paths.coffee, ['watchify:coffee']
  gulp.watch paths.cjsx, ['watchify:cjsx']
  gulp.watch paths.stylus, ['build:stylus']
  gulp.watch paths.jade, ['build:jade']
  gulp.watch paths.es6, ['build:es6']

gulp.task 'default', ['build', 'watch']
