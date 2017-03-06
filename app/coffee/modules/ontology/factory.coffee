
Entities = require './entities'

# # # # #

# TODO - abstract patterns here into DexieFactory?
class OntologyFactory extends Marionette.Service

  # Defines radioRequests
  radioRequests:
    'ontology model':       'getModel'
    'ontology collection':  'getCollection'
    'ontology attribute':   'attribute'

  initialize: ->
    @cached = new Entities.Collection()

  # getCollection: ->
  #   return @cached if @cached._synced
  #   @cached.reset(window.ontologies)
  #   @cached._synced = true
  #   return @cached

  # TODO - this should accept a query
  getCollection: ->
    return new Promise (resolve, reject) =>

      # TODO - catch statement
      table = 'ontologies' # MODEL.urlRoot
      window.db[table].toArray().then (models) =>
        @cached.reset(models)
        return resolve(@cached)

  getModel: (id) ->
    return new Promise (resolve, reject) =>

      # Resolves if ID is undefined
      return resolve(new Entities.Model()) unless id

      # Returns from @cached if synced
      return resolve(@cached.get(id)) if @cached._synced

      # Gets @cached and returns
      return @getCollection().then () => resolve(@cached.get(id))

  attribute: (id, attribute) ->
    return new Promise (resolve, reject) =>
      @getModel(id).then (ontology) =>
        return resolve(false) unless ontology

        graph = ontology.get('graph')
        return resolve(_.find(graph, (attr) -> attr['@id'] == attribute))

# # # # #

module.exports = new OntologyFactory()
