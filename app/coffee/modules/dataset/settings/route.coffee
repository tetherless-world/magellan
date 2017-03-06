LayoutView  = require './views/layout'

# # # # #

class SearchSettingsRoute extends require 'hn_routing/lib/route'

  # TODO
  title: ->
    return "Datasets - #{@model.get('label')} - Settings"

  breadcrumbs: ->
    return [
      { href: "#datasets", text: 'Datasets' }
      { href: "#datasets/#{@model.id}/search", text: @model.get('label') }
      { text: 'Settings' }
    ]

  # TODO - this needs to be cleaned up dramatically.
  # DatasetModel.ensureFacets() should be done inside the view
  # to gracefully load the collection in a non-blocking way
  fetch: (id) ->

    # Gets the Dataset
    return new Promise (resolve, reject) =>
      Backbone.Radio.channel('dataset').request('model', id)
      .then (model) =>

        # Assigns dataset to @model
        @model = model

        # Gets FacetCollection from Dataset
        @model.ensureFacets().then (facetCollection) =>
          @collection = facetCollection

          # Resolves outter promise
          resolve()

  render: ->
    @container.show new LayoutView({ model: @model, collection: @collection })

# # # # #

module.exports = SearchSettingsRoute
