LayoutView = require './views/layout'

# # # # #

class ShowDatasetRoute extends require 'hn_routing/lib/route'

  title: ->
    return "Magellan - #{@model.get('label')}"

  breadcrumbs: ->
    return [
      { text: 'Home', href: '#' }
      { text: 'Archives', href: '#datasets' }
      { text: @model.get('label') }
    ]

  fetch: (id) ->
    Backbone.Radio.channel('dataset').request('model', id)
    .then (model) => @model = model

  render: ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = ShowDatasetRoute
