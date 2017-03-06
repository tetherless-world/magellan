JSONLDViewer = require 'json_ld_viewer/lib/viewer'

# # # # #

# Canvas + Zoom
# http://stackoverflow.com/questions/23971717/magnifying-glass-that-follows-cursor-for-canvas
# http://jsfiddle.net/powerc9000/G39W9/
class RdfViewer extends Mn.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  onRender: ->
    setTimeout(@loadRDF, 100)

  loadRDF: =>
    # TODO - pass in Resource Model / Decorator
    # TODO - pass in Predicate Model / Decorator
    # TODO - ALL should be passed in as options, rather than parameters
    nodeWidth = 450
    JSONLDViewer("#chart", 1000, 1000, @model.toJSON(), nodeWidth)

# # # # #

module.exports = RdfViewer


