LayoutView  = require './views/layout'

# # # # #

class OntologyListRoute extends require 'hn_routing/lib/route'

  title: 'Magellan - Ontologies'

  breadcrumbs: [
    { text: 'Ontologies'}
  ]

  fetch: ->
    Backbone.Radio.channel('ontology').request('collection')
    .then (collection) => @collection = collection

  render: ->
    @container.show new LayoutView({ collection: @collection })

# # # # #

module.exports = OntologyListRoute
