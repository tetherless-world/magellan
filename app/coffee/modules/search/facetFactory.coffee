# TODO - phase out this file
# Facets are now generated from the dataset
# facetData = require './facetData'

# # # # #

class FacetFactory extends Marionette.Service
  collectionPrototype:  require './facetEntities'

  radioRequests:
    'facet collection':  'getCollection'

  # initialize: ->
  #   @cached = new @collectionPrototype()

  getCollection: (facetData) ->
    return new @collectionPrototype(facetData)
    # return @cached if @cached._synced
    # @cached.reset(facetData)
    # @cached._synced = true
    # return @cached

# # # # #

module.exports = new FacetFactory()
