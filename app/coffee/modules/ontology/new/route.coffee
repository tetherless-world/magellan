LayoutView = require './views/layout'

# # # # #

class NewDatasetRoute extends require 'hn_routing/lib/route'

  title: 'Magellan - New Ontology'

  breadcrumbs: [
    { text: 'Ontologies', href: '#ontologies' }
    { text: 'New' }
  ]

  fetch: ->
    Backbone.Radio.channel('ontology').request('model')
    .then (model) => @model = model

  render: ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = NewDatasetRoute
