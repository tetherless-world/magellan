Entities = require './entities'

# # # # #

class SearchResultFactory extends Marionette.Service

  radioRequests:
    'search:result collection': 'getCollection'

  initialize: ->
    @cachedCollection = new Entities.Collection()

  getCollection: ->
    return new Promise (resolve, reject) =>
      return resolve(@cachedCollection)

# # # # #

module.exports = new SearchResultFactory()
