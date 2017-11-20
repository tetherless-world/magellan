LayoutView  = require './views/layout'

# # # # #

class DatasetExportRoute extends require 'hn_routing/lib/route'

  title: ->
    return "Datasets - #{@model.get('label')} - Export"

  breadcrumbs: ->
    return [
      { text: 'Home', href: '#' }
      { href: "#datasets", text: 'Archives' }
      { href: "#datasets/#{@model.id}", text: @model.get('label') }
      { text: 'Export' }
    ]

  fetch: (id) ->
    Backbone.Radio.channel('dataset').request('model', id)
    .then (model) => @model = model # Assigns dataset to @model

  render: ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = DatasetExportRoute
