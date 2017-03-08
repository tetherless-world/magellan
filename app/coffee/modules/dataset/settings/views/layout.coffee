FacetList = require './facetList'

# # # # #

class SettingsLayoutView extends require 'hn_views/lib/nav'
  className: 'container-fluid'
  template: require './templates/layout'

  navItems: [
    { icon: 'fa-table',   text: 'Facets',  trigger: 'facets', default: true }
    { icon: 'fa-code',    text: 'Attributes',   trigger: 'attrs' }
  ]

  navEvents:
    'facets':    'showFacets'
    'attrs':     'showAttrs'

  navOptions:
    stacked: true

  showFacets: ->
    @contentRegion.show new FacetList({ collection: @collection })
    # @contentRegion.show new TableView({ model: @model })

  showAttrs: ->
    console.log 'SHOW ATTRS'
    # @contentRegion.show new JsonViewer({ model: @model })

# # # # #

module.exports = SettingsLayoutView
