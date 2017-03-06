
class SearchResultFactory extends require 'hn_entities/lib/factory'
  radioChannel:         'search:result'
  modelPrototype:       require './model'
  collectionPrototype:  require './collection'

  collection: ->
    return new Promise (resolve, reject) => resolve(@cached)

# # # # #

module.exports = new SearchResultFactory()
