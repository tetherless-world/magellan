Entities = require './entities'
DexieFactory  = require '../base/dexieFactory'

# # # # #

class ViewerRuleFactory extends DexieFactory

  # Defines tableName
  tableName: 'viewer_rules'

  # Defines radioRequests
  radioRequests:
    'viewer:rule collection':  'getCollection'
    'viewer:rule save':        'saveModel'
    'viewer:rule destroy':     'destroyModel'

  initialize: ->
    @cachedCollection = new Entities.Collection()

# # # # #

module.exports = new ViewerRuleFactory()
