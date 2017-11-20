SearchView = require '../../search/facetsearch/views/layout'

# # # # #

class DatasetSearchRoute extends require 'hn_routing/lib/route'

  title: ->
    return "Magellan - #{@model.get('label')} - Search"

  breadcrumbs: ->
    return [
      { text: 'Home', href: '#' }
      { text: 'Archives', href: '#datasets' }
      { text: "#{@model.get('label')}", href: "#datasets/#{@model.id}" }
      { text: 'Search' }
    ]

  # TODO - this should be re-evaluated
  # Datapoints, Facets, and Results can be loaded in a non-blocking way
  fetch: (id) ->

    # Gets the Dataset
    return new Promise (resolve, reject) =>
      Backbone.Radio.channel('dataset').request('model', id)
      .then (model) =>

        # Assigns dataset to @model
        @model = model

        # Fetches datapoints contained within the dataset
        @model.fetchDatapoints().then (datapoints) =>

          # Assigns @datapoints
          @datapoints = datapoints

          # Gets FacetCollection from Dataset
          @model.fetchFacets().then (facetCollection) =>

            # Assigns @facetCollection
            @facetCollection = facetCollection

            # Gets SearchResultCollection
            Backbone.Radio.channel('search:result').request('collection').then (collection) =>

              # Assigns @collection
              @collection = collection

              # Resolves outter promise
              return resolve()

  render: ->
    @container.show new SearchView({ model: @model, collection: @collection, items: @datapoints, facetCollection: @facetCollection })

# # # # #

module.exports = DatasetSearchRoute
