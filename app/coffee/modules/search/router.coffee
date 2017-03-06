require './factory'
require './facetFactory'

FacetSearchRoute  = require './facetsearch/route'

# # # # #

class SearchRouter extends require 'hn_routing/lib/router'

  # routes:
  #   '(/)':          'facetsearch'

  # facetsearch: ->
  #   new FacetSearchRoute({ container: @container })

# # # # #

module.exports = SearchRouter
