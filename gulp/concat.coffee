# Import dependencies
gulp        = require 'gulp'
concat      = require 'gulp-concat'
plumber     = require 'gulp-plumber'
livereload  = require 'gulp-livereload'

# Import Paths
paths = require './paths.coffee'

# Concat
gulp.task 'concat', ->
  stream = gulp.src([
      paths.node_modules + 'jquery/dist/jquery.js'
      paths.node_modules + 'underscore/underscore.js'
      paths.node_modules + 'backbone/backbone.js'
      paths.node_modules + 'backbone-relational/backbone-relational.js'
      paths.node_modules + 'backbone.babysitter/lib/backbone.babysitter.js'
      paths.node_modules + 'backbone.wreqr/lib/backbone.wreqr.js'
      paths.node_modules + 'backbone.marionette/lib/core/backbone.marionette.js'
      paths.node_modules + 'backbone-metal/dist/backbone-metal.js'
      paths.node_modules + 'backbone-routing/dist/backbone-routing.js'
      paths.node_modules + 'backbone.radio/build/backbone.radio.js'
      paths.node_modules + 'backbone.syphon/lib/backbone.syphon.js'
      paths.node_modules + 'marionette-service/dist/marionette-service.js'
      paths.node_modules + 'tether/dist/js/tether.min.js'
      paths.node_modules + 'bootstrap/dist/js/bootstrap.min.js'
      paths.node_modules + 'bluebird/js/browser/bluebird.min.js'
      paths.node_modules + 'd3/build/d3.js' # TODO - RDF viewer is preventing update.
      # paths.node_modules + 'jsonld/js/jsonld.js'
      # paths.node_modules + 'dagre/dist/dagre.js'
      paths.node_modules + 'three/build/three.js'
      # paths.node_modules + 'three/examples/js/controls/TrackballControls.js'
      paths.node_modules + 'three/examples/js/controls/OrbitControls.js'
      # paths.node_modules + 'three/build/three.modules.js'
      # paths.node_modules + 'facetview2/es.js'
      # paths.node_modules + 'facetview2/bootstrap4.facetview.theme.js'
      # paths.node_modules + 'facetview2/jquery.facetview2.js'
      # paths.node_modules + 'facetedsearch/facetedsearch.js'

    ])
    # .pipe plumber()
    .pipe concat('vendor.js')
    .pipe livereload()

  stream.pipe gulp.dest paths.dest + 'js/'
