Entities = require './entities'
DexieFactory  = require '../base/dexieFactory'

# # # # #

class DatasetFactory extends DexieFactory

  tableName: 'datasets'

  radioRequests:
    'dataset model':      'getModel'
    'dataset save':       'saveModel'
    'dataset destroy':    'destroyModel'
    'dataset collection': 'getCollection'

  initialize: ->
    @cachedCollection = new Entities.Collection()

  getCollection: ->

    # Ensures presence of @db variable
    @ensureDb()

    # Returns a Promise to manage async DB operations
    return new Promise (resolve, reject) =>

      # Fetches all records from Dexie
      @db[@tableName].toArray()

      # Fetches successfully
      .then (models) =>
        @cachedCollection.reset(models)
        return resolve(@cachedCollection)

      # Error handling
      .catch (err) =>
        return reject(err)

# # # # #

module.exports = new DatasetFactory()
