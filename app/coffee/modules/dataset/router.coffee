require './factory'

ListRoute = require './list/route'
SearchRoute = require './search/route'
NewRoute = require './new/route'
SettingsRoute = require './settings/route'

# # # # #

class DatasetRouter extends require 'hn_routing/lib/router'

  routes:
    'datasets(/)':              'list'
    'datasets/:id/search(/)':   'search'
    'datasets/:id/settings(/)': 'settings'
    'datasets/new(/)':          'new'
    # TODO - edit route
    # TODO - knowledge graph for each dataset?

  list: ->
    new ListRoute({ container: @container })

  search: (id) ->
    new SearchRoute({ container: @container, id: id })

  settings: (id) ->
    new SettingsRoute({ container: @container, id: id })

  new: ->
    new NewRoute({ container: @container })

# # # # #

module.exports = DatasetRouter
