LayoutView  = require './views/layout'

# Testing JSON
# modelJson = require './views/berners_lee'
modelJson = require './views/rdf_1'
# modelJson = require './views/rdf_3'
# modelJson = require './views/rdf_4'
# modelJson = require './views/rdf_5'
# modelJson = require './views/rdf_6'
# modelJson = require './views/rdf_7'

# RDF Links
# TODO - RDF conversion
# defaultUrl: 'http://www.w3.org/People/Berners-Lee/card.rdf'
# defaultUrl: 'http://orion.tw.rpi.edu/~olyerickson/darpa.ttl'
# defaultUrl: 'https://a.uguu.se/LyIBBLx3bynA_instanceLevelDomain.ttl'

# defaultUrl: 'https://a.uguu.se/d7WSzEdod07D_rawArchive.ttl'
# defaultUrl: 'http://orion.tw.rpi.edu/~olyerickson/rawArchive.ttl'
# defaultUrl: 'http://orion.tw.rpi.edu/~olyerickson/instanceLevelDomain.ttl'

# # # # #

class RdfRoute extends require 'hn_routing/lib/route'

  title: 'Magellan - Knowledge Graph'

  breadcrumbs: [{ text: 'Knowledge Graph'}]

  fetch: ->
    @model = new Backbone.Model(modelJson)

  render: ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = RdfRoute
