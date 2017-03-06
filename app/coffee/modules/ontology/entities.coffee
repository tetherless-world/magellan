
# TODO - add associated ontology models

class OntologyModel extends Backbone.Model
  url: 'ontologies'

# # # # #

class OntologyCollection extends Backbone.Collection
  urlRool: 'ontologies'
  model: OntologyModel

# # # # #

module.exports =
  Model:      OntologyModel
  Collection: OntologyCollection
