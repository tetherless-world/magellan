Entities = require './entities'
DexieFactory  = require '../base/dexieFactory'

# # # # #

class FacetFactory extends DexieFactory

  # Defines tableName
  tableName: 'facets'

  # Defines radioRequests
  radioRequests:
    'facet collection': 'getCollection'
    'facet save':       'saveModel'
    'facet destroy':    'destroyModel'
    'facet link:all':   'linkAllFacets'

  initialize: ->
    @cachedCollection = new Entities.Collection()

  linkAllFacets: ->
    return @cachedCollection.linkAllFacets()

# # # # #

module.exports = new FacetFactory()
