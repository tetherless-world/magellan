Entities      = require './entities'
DexieFactory  = require '../base/dexieFactory'

# # # # #

class DatapointFactory extends DexieFactory

  # Defines tableName
  tableName: 'datapoints'

  # Defines radioRequests
  radioRequests:
    'datapoint collection': 'getCollection'
    'datapoint save':       'saveModel'
    'datapoint destroy':    'destroyModel'

  initialize: ->
    @cachedCollection = new Entities.Collection()

# # # # #

module.exports = new DatapointFactory()
