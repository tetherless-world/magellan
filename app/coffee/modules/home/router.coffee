require './factory'

RDFRoute = require './rdf_new/route'
SettingsRoute = require './settings/route'

# # # # #

# HomeRouter class definition
class HomeRouter extends require 'hn_routing/lib/router'

  routes:
    'rdf(/)':     'rdfViewer'
    'settings(/)':  'settings'

  rdfViewer: ->
    new RDFRoute({ container: @container })

  settings: ->
    new SettingsRoute({ container: @container })

# # # # #

module.exports = HomeRouter
