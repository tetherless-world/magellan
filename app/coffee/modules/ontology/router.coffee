require './factory'
require './importer'

ListRoute = require './list/route'
NewRoute = require './new/route'

# # # # #

class OntologyRouter extends require 'hn_routing/lib/router'

  routes:
    'ontologies(/)':            'list'
    'ontologies/:id/search(/)': 'search'
    'ontologies/new(/)':        'new'

  list: ->
    new ListRoute({ container: @container })

  # TODO - search Ontology
  search: (id) ->
    console.log 'SEARCH'

  new: ->
    new NewRoute({ container: @container })

# # # # #

module.exports = OntologyRouter
