Entities = require './entities'
DexieFactory  = require '../base/dexieFactory'

# # # # #

class KnowledgeRuleFactory extends DexieFactory

  # Defines tableName
  tableName: 'knowledge_rules'

  # Defines radioRequests
  radioRequests:
    'knowledge:rule collection':  'getCollection'
    'knowledge:rule save':        'saveModel'
    'knowledge:rule destroy':     'destroyModel'

  initialize: ->
    @cachedCollection = new Entities.Collection()

# # # # #

module.exports = new KnowledgeRuleFactory()
