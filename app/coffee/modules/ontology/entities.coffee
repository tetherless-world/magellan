
class OntologyModel extends Backbone.Model
  url: 'ontologies'

  # Overwritten save method
  save: ->
    Backbone.Radio.channel('ontology').request('save', @)

# # # # #

class OntologyCollection extends Backbone.Collection
  urlRool: 'ontologies'
  model: OntologyModel

# # # # #

module.exports =
  Model:      OntologyModel
  Collection: OntologyCollection
