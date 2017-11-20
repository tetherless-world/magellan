LayoutView = require './views/layout'

# # # # #

class EditDatasetRoute extends require 'hn_routing/lib/route'

  title: ->
    return "Magellan - #{@model.get('label')} - Edit"

  breadcrumbs: ->
    return [
      { text: 'Home', href: '#' }
      { text: 'Archives', href: '#datasets' }
      { href: "#datasets/#{@model.id}", text: @model.get('label') }
      { text: 'Edit' }
    ]

  fetch: (id) ->
    Backbone.Radio.channel('dataset').request('model', id)
    .then (model) => @model = model

  render: ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = EditDatasetRoute
