require './factory'
ListRoute = require './list/route'
NewRoute = require './new/route'
# # # # #

class OntologyRouter extends require 'hn_routing/lib/router'

  routes:
    'ontologies(/)':      'list'
    'ontologies/new(/)':  'new'

  list: ->
    new ListRoute({ container: @container })

  new: ->
    new NewRoute({ container: @container })

# # # # #

module.exports = OntologyRouter
