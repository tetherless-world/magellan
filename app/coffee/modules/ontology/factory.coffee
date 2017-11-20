Entities = require './entities'
DexieFactory  = require '../base/dexieFactory'

# # # # #

class OntologyFactory extends DexieFactory

  tableName: 'ontologies'

  radioRequests:
    'ontology model':               'getModel'
    'ontology save':                'saveModel'
    'ontology collection':          'getCollection'
    'ontology attribute':           'attribute'
    'ontology attribute:dropdown':  'getAttributeDropdown'

  initialize: ->
    @cachedCollection = new Entities.Collection()

  # getCollection
  # Returns a collection of Ontologies
  getCollection: (dataset_id) ->

    # Ensures presence of @db
    @ensureDb()

    # Returns Promise to manage async DB operations
    return new Promise (resolve, reject) =>

      # Queries DB
      @db[@tableName].toArray()

      # Resets the collection and resolves the promise
      .then (models) =>

        # Resets the collection of models
        @cachedCollection.reset(models)

        # Resolves the Promise and returns the FacetCollection
        return resolve(@cachedCollection)

      # Error handling
      .catch (err) => return reject(err)

  attribute: (prefix, attribute) ->
    return new Promise (resolve, reject) =>

      # Fetchs the full collection of ontologies
      @getCollection().then (ontologyCollection) =>

        # Finds the ontology by prefix
        ontology = ontologyCollection.findWhere({ prefix: prefix })

        # Resolves false unless the ontology exists
        return resolve(false) unless ontology

        # Isolates the graph attribute from the ontology model
        graph = ontology.get('graph')

        # Re-assigns correct attribute @id
        attribute = prefix + ':' + attribute

        # Finds and returns the attribute
        return resolve(_.find(graph, (attr) -> attr['@id'] == attribute))

  # getAttributeDropdown
  # Used to create a grouped dropdown menu to select an ontology attribute
  getAttributeDropdown: ->

    # Returns Promise to manage async operation
    return new Promise (resolve, reject) =>

      # Variable to store the dropdown data
      dropdown = []

      # Fetches ontology collection
      @getCollection().then (ontologyCollection) =>

        # Iterates over each ontology in the collection
        for ontology in ontologyCollection.models

          # Constructs an object to maintain the <optgroup> label
          # and the associated <option> elements
          item = {}
          item.label = ontology.get('label')
          item.items = _.pluck(ontology.get('graph'), '@id')

          # Appends the item to the dropdown return variable
          dropdown.push item

        # Resolves and returns the constructed dropdown data
        return resolve(dropdown)

# # # # #

module.exports = new OntologyFactory()

