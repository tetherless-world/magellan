LayoutView  = require './views/layout'
ItemCollection = require '../collection'

# # # # #

class FacetViewRoute extends require 'hn_routing/lib/route'

  title: 'Magellan - Search'

  breadcrumbs: [{ text: 'Faceted Search' }]

  fetch: ->

    # Gets all items for Faceted Search
    # TODO - abstract into a factory
    @items = new ItemCollection(window.data["@graph"])

    # Gets FacetCollection
    @facetCollection = Backbone.Radio.channel('facet').request('collection')

    # Gets SearchResultCollection
    Backbone.Radio.channel('search:result').request('collection')
    .then (collection) =>
      @collection = collection

  render: ->
    @container.show new LayoutView({ collection: @collection, items: @items, facetCollection: @facetCollection })

# # # # #

module.exports = FacetViewRoute
