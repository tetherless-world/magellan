gulp        = require 'gulp'
jade        = require 'gulp-jade'
plumber     = require 'gulp-plumber'
livereload  = require 'gulp-livereload'

# Import Paths
paths = require './paths.coffee'

# Copy Tasks
gulp.task 'copy_static', ['copy_elastic_ui', 'copy_facetview']
gulp.task 'copy', ['copy_fontawesome', 'copy_images', 'copy_static']

# Copy FontAwesome fonts
gulp.task 'copy_fontawesome', ->
  gulp.src paths.node_modules + 'font-awesome/fonts/*'
    .pipe plumber()
    .pipe gulp.dest paths.dest + 'fonts/'
    .pipe livereload()

# Copy Images
gulp.task 'copy_images', ->
  gulp.src paths.src + 'img/*'
    .pipe plumber()
    .pipe gulp.dest paths.dest + 'img/'
    .pipe livereload()

# Copy ElasticUI Codebase
gulp.task 'copy_elastic_ui', ->
  gulp.src paths.staticSrc + 'elastic_ui/**/*'
    .pipe plumber()
    .pipe gulp.dest paths.staticDest + 'elastic_ui'
    .pipe livereload()

# Copy FacetView Codebase
gulp.task 'copy_facetview', ->
  gulp.src paths.staticSrc + 'facetview/**/*'
    .pipe plumber()
    .pipe gulp.dest paths.staticDest + 'facetview'
    .pipe livereload()
