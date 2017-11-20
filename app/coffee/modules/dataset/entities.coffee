
# TODO - abstract this into a different class?
class DatasetModel extends Backbone.Model
  urlRoot: 'datasets'

  # Default attributes
  # TODO - validations
  # TODO - uploaded_at timestamp
  defaults:
    id:       ''
    label:    ''
    context:  {}

  # export
  # Exports the dataset with or without knowledge enhancement
  export: (opts={}) ->

    # Fetches datapoints
    # TODO - datapoints should be sorted by some arbitrary attribute, @id?
    @fetchDatapoints().then (datapoints) =>

      # Returns graph + knowledge enhancement
      if opts.enhanced
        return { '@context': @get('context'), '@graph': datapoints.pluck('data') }

      # Returns graph without knowledge enhancement
      else
        return { '@context': @get('context'), '@graph': datapoints.pluck('raw') }

      return ""

  # Overwritten save method
  save: ->
    Backbone.Radio.channel('dataset').request('save', @)

  # fetchFacets
  # Fetches a FacetCollection instance populated with the facets associated
  # with this dataset. Returns a Promise.
  fetchFacets: ->
    return Backbone.Radio.channel('facet').request('collection', @id)

  fetchDatapoints: ->
    return Backbone.Radio.channel('datapoint').request('collection', @id)

  fetchKnowledgeRules: ->
    return Backbone.Radio.channel('knowledge:rule').request('collection', @id)

  fetchViewerRules: ->
    return Backbone.Radio.channel('viewer:rule').request('collection', @id)

  generateNewFacets: (facetKeys, indexStart) ->

    # Adds an index to each facet for correct ordering
    index = indexStart

    # Save Datapoint function
    # Passed to Bluebird's Promise.each method, returns a Promise
    saveFacet = (facet) =>

      # Assembles a new facet
      attrs =
        id:         buildUniqueId('fc_')
        dataset_id: @id
        attribute:  facet
        label:      facet
        order:      index
        enabled:    true
        tooltip:    ''

      # Increments index
      index = index + 1

      # Returns 'add' Promise from DB service
      return Backbone.Radio.channel('db').request('add', 'facets', attrs)

    # # # # #

    # Iterates over each id in facetKeys returns a promise
    return Promise.each(facetKeys, saveFacet)

  # TODO - perhaps this should be exported into a separate class to manage facets related to datasets
  # rather than maintaining this directly on the dataset itself.
  # Destroys superfluous facets
  destroySuperfluousFacets: (toDestroy, facetCollection) =>

    # Anonymous helper function
    # Returns Promise from facet.destroy
    destroyFacet = (facet) =>
      facetCollection.remove(facet)
      return facet.destroy()

    # Iterates over each facet - removes from collection and destroys
    return Promise.each(toDestroy, destroyFacet)

  # Regenerates facets after KnowledgeRule-related updates
  regenerateFacets: ->

    # Returns Promise to handle async operations
    return new Promise (resolve, reject) =>

      # Fetches datapoints
      @fetchDatapoints().then (datapointCollection) =>

        # Fetches Facets
        @fetchFacets().then (facetCollection) =>

          # Stores facet models that are pending destruction
          pendingDestroy = []

          # Isolates keys for facet generation
          allKeys = []
          for dp in datapointCollection.models
            allKeys = _.union(allKeys, _.keys(dp.get('data')) )

          # Iterates over each existing facet
          for facet in facetCollection.models

            # Isolates the 'attribute' attribute (ha...)
            attr = facet.get('attribute')

            # Remove attr from allKeys if an associated facet is defined
            if attr in allKeys
              allKeys = _.without(allKeys, attr)

            # Destroys a facet with no associated attribute
            else

              # Marks the facet as pending destruction
              pendingDestroy.push(facet)

          # Destroys superfluous facets
          @destroySuperfluousFacets(pendingDestroy, facetCollection)
          .then () =>

            # Builds new Facets from attributes with no existing associated facet
            @generateNewFacets(allKeys, facetCollection.length + 1)
            .then () => return resolve()
            .catch () => return reject(err)

          .catch (err) => return reject(err)

# # # # #

class DatasetCollection extends Backbone.Collection
  urlRoot: 'datasets'
  model: DatasetModel

# # # # #

module.exports =
  Model:      DatasetModel
  Collection: DatasetCollection
