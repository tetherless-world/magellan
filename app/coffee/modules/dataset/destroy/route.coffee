LayoutView = require './views/layout'
DatasetDestructor = require '../destructor'

# # # # #

class DestroyDatasetRoute extends require 'hn_routing/lib/route'

  title: ->
    return "Magellan - #{@model.get('label')} - Destroy"

  breadcrumbs: ->
    return [
      { text: 'Home', href: '#' }
      { text: 'Archives', href: '#datasets' }
      { href: "#datasets/#{@model.id}", text: @model.get('label') }
      { text: 'Destroy' }
    ]

  fetch: (id) ->
    Backbone.Radio.channel('dataset').request('model', id)
    .then (model) => @model = model

  render: ->
    @container.show new LayoutView({ model: @model, destructor: DatasetDestructor })

# # # # #

module.exports = DestroyDatasetRoute
