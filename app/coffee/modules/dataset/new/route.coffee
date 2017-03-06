LayoutView = require './views/layout'

# # # # #

class NewDatasetRoute extends require 'hn_routing/lib/route'

  title: 'Magellan - New Dataset'

  breadcrumbs: [
    { text: 'Datasets', href: '#datasets' }
    { text: 'New' }
  ]

  fetch: ->
    Backbone.Radio.channel('dataset').request('model')
    .then (model) => @model = model

  render: ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = NewDatasetRoute
