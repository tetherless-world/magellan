
# JSON-LD Vis
# https://github.com/scienceai/jsonld-vis

# TODO - problem?
jsonVis = require 'jsonld-vis'
jsonVis.default(d3)

# # # # #

class JsonLDGraphView extends Mn.LayoutView
  template: require './templates/graph'
  className: 'card card-block'

  graphOptions:
    w:                  800
    h:                  300
    maxLabelWidth:      250
    transitionDuration: 250
    transitionEase:     'cubic-in-out'
    minRadius:          5
    scalingFactor:      1

  onRender: ->
    setTimeout(@initJsonChart, 100)

  # TODO - graph elements contaminate each other
  initJsonChart: =>
    # el = @$('[data-display=graph]')
    # d3.jsonldVis(@model.toJSON(), el[0], @graphOptions)

    json = @options.json

    if Array.isArray(json)
      for each in json
        d3.jsonldVis(each, '[data-display=graph]', @graphOptions)

    else
      d3.jsonldVis(@options.json, '[data-display=graph]', @graphOptions)

# # # # #

module.exports = JsonLDGraphView
