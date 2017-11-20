gulp = require 'gulp'

# Paths config
nodeModules = './node_modules/'

paths =
  src:          './app/'
  dest:         './build/'
  node_modules: './node_modules/'
  jadeSrc:      './app/index.jade'

  bundle:
    src: 'coffee/manifest.coffee'
    dest: 'app.js'

  server_bundle:
    src: './app_server/**/*.coffee'
    dest: './build/server_js/'

  nwk_package:
    src:  './app/nwk_package.coffee'
    dest: './build/package.json'

  nwk_release:
    src:        './build/**/**'
    version:    '0.14.6'
    # platforms:  ['win32','win64','osx32','osx64','linux32','linux64'] # All options
    # platforms:  ['win64','osx64']
    # platforms:  ['win64']
    platforms:  ['osx64']

  sass:
    src:  './app/sass/app.sass'
    dest: './build/css/'

  sass_dark:
    src:  './app/sass/app_dark.sass'
    dest: './build/css/'

  copy:
    font_awesome:
      src:  nodeModules + 'font-awesome/fonts/*'
      dest: './build/fonts'

    img:
      src:  './app/img/**/*'
      dest: './build/img'

    python:
      src:  './app/python/*'
      dest: './build/python'

  concat:
    dest: 'vendor.js'
    src: [
      nodeModules + 'jquery/dist/jquery.js'
      nodeModules + 'underscore/underscore.js'
      nodeModules + 'backbone/backbone.js'
      nodeModules + 'backbone-relational/backbone-relational.js'
      nodeModules + 'backbone.babysitter/lib/backbone.babysitter.js'
      nodeModules + 'backbone.wreqr/lib/backbone.wreqr.js'
      nodeModules + 'backbone.marionette/lib/core/backbone.marionette.js'
      nodeModules + 'backbone-metal/dist/backbone-metal.js'
      nodeModules + 'backbone-routing/dist/backbone-routing.js'
      nodeModules + 'backbone.radio/build/backbone.radio.js'
      nodeModules + 'backbone.syphon/lib/backbone.syphon.js'
      nodeModules + 'marionette-service/dist/marionette-service.js'
      # nodeModules + 'tether/dist/js/tether.min.js'
      nodeModules + 'popper.js/dist/umd/popper.min.js'
      nodeModules + 'bootstrap/dist/js/bootstrap.min.js'
      nodeModules + 'bluebird/js/browser/bluebird.min.js'
      nodeModules + 'd3/build/d3.js' # TODO - RDF viewer is preventing update.
      # nodeModules + 'jsonld/js/jsonld.js'
      # nodeModules + 'dagre/dist/dagre.js'
      nodeModules + 'three/build/three.js'
      # nodeModules + 'three/examples/js/controls/TrackballControls.js'
      nodeModules + 'three/examples/js/controls/OrbitControls.js'
      # nodeModules + 'three/build/three.modules.js'
      # nodeModules + 'facetview2/es.js'
      # nodeModules + 'facetview2/bootstrap4.facetview.theme.js'
      # nodeModules + 'facetview2/jquery.facetview2.js'
      nodeModules + 'facetedsearch/facetedsearch.js'
      nodeModules + 'dexie/dist/dexie.js'
      nodeModules + 'drift-zoom/dist/Drift.js'
      nodeModules + 'clipboard/dist/clipboard.js'
      nodeModules + 'chart.js/dist/Chart.js'
      nodeModules + 'sortablejs/Sortable.min.js'
      nodeModules + 'bootstrap-switch/dist/js/bootstrap-switch.min.js'
      nodeModules + 'select2/dist/js/select2.full.js'
      nodeModules + 'cornerstone/dist/cornerstone.min.js'
      nodeModules + 'cytoscape/dist/cytoscape.min.js'

    ]

# Import Plugins
plugins = require 'gulp_tasks/gulp/config/plugins'
plugins.browserify = require 'gulp-browserify'

# Import tasks
require('gulp_tasks/gulp/tasks/env')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/copy')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/sass')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/jade')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/watch')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/webserver')(gulp, paths, plugins)
require('gulp_tasks/gulp/tasks/noop')(gulp, paths, plugins)

# # # # #

# Concat Task
gulp.task 'concat', ->
  stream = gulp.src(paths.concat.src)
    .pipe plugins.plumber()
    .pipe plugins.concat(paths.concat.dest)

  stream.pipe uglify() if process.env.NODE_ENV == 'prod'
  stream.pipe gulp.dest paths.dest + 'js/'

# Bundle task
gulp.task 'bundle', ->
  stream = gulp.src(paths.src + paths.bundle.src, { read: false })
    .pipe plugins.plumber()
    .pipe plugins.browserify
      debug:      if process.env.NODE_ENV == 'prod' then 'production' else 'development'
      debug:      true
      paths: [
          './node_modules',
          './app/coffee/modules'
      ],
      transform:  ['coffeeify', 'jadeify']
      extensions: ['.coffee', '.jade']
    .pipe plugins.concat(paths.bundle.dest)

  stream.pipe uglify() if process.env.NODE_ENV == 'prod'
  stream.pipe gulp.dest paths.dest + 'js/'

# # # # #

# Watch Task
gulp.task 'watch', ->
  gulp.watch paths.src + '**/*.coffee',  ['bundle']
  gulp.watch paths.src + '**/*.jade',    ['bundle', 'jade']
  gulp.watch paths.src + '**/*.sass',    ['sass']

# Watch Task
gulp.task 'nodewebkit_watch', ->
  gulp.watch './app_server/**/*.coffee',  ['server_bundle']

# # # # #

# NodeWebKit Package.json
gulp.task 'nodewebkit_package', ->
  str = require paths.nwk_package.src
  plugins.fs.writeFileSync( paths.nwk_package.dest, str)
  return true

# NodeWebKit Releases
NwBuilder = require 'nw-builder'
gulp.task 'nodewebkit_release', ->
  nw = new NwBuilder
    files:        paths.nwk_release.src
    platforms:    paths.nwk_release.platforms
    version:      paths.nwk_release.version
    downloadUrl:  'https://dl.nwjs.io/'

  # Log NWK Build
  nw.on 'log', console.log

  # Build returns a promise
  nw.build()
  .then ->
    console.log 'NWK Build complete'
    return

  .catch (error) ->
    console.log 'NWK Build Error!'
    console.error error
    return

# Bundle server task
# TODO - is this still used?
gulp.task 'server_bundle', ->
  gulp.src(paths.server_bundle.src)
    .pipe plugins.plumber()
    .pipe plugins.coffee({bare: true})
    .pipe gulp.dest paths.server_bundle.dest

# Copy Python files
# TODO - is this still used?
gulp.task 'copy_python', ->
  gulp.src paths.copy.python.src
    .pipe plugins.plumber()
    .pipe gulp.dest paths.copy.python.dest

# # # # #

# Build tasks
gulp.task 'default', ['dev']

gulp.task 'dev', =>
  plugins.runSequence.use(gulp)('env_dev', 'copy_fontawesome', 'copy_python', 'copy_images', 'sass', 'jade', 'concat', 'bundle', 'server_bundle', 'watch', 'webserver')

gulp.task 'release', =>
  plugins.runSequence.use(gulp)('env_prod', 'copy_fontawesome', 'copy_python', 'copy_images', 'sass', 'jade', 'concat', 'bundle', 'server_bundle', => console.log 'Release completed.' )

gulp.task 'nwk_dev', =>
  plugins.runSequence.use(gulp)('env_dev', 'copy_fontawesome', 'copy_python', 'copy_images', 'sass', 'jade', 'concat', 'bundle', 'server_bundle', 'nodewebkit_package', 'watch', 'nodewebkit_watch')

gulp.task 'nwk_release', =>
  plugins.runSequence.use(gulp)('env_dev', 'copy_fontawesome', 'copy_python', 'copy_images', 'sass', 'jade', 'concat', 'bundle', 'server_bundle', 'nodewebkit_package', 'nodewebkit_release', => console.log 'NWK Release completed.' )
