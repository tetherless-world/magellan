require './factory'
require './creator'

ListRoute     = require './list/route'
ShowRoute     = require './show/route'
GraphRoute     = require './graph/route'
SearchRoute   = require './search/route'
ConfigRoute   = require './config/route'
NewRoute      = require './new/route'
EditRoute     = require './edit/route'
DestroyRoute  = require './destroy/route'
ExportRoute   = require './export/route'
CaptureRoute  = require './knowledge_capture/route'

# # # # #

class DatasetRouter extends require 'hn_routing/lib/router'

  routes:
    'datasets(/)':              'list'
    'datasets/new(/)':          'new'
    'datasets/:id(/)':          'show'
    'datasets/:id/graph(/)':    'graph'
    'datasets/:id/search(/)':   'search'
    'datasets/:id/capture(/)':  'knowledgeCapture'
    'datasets/:id/config(/)':   'config'
    'datasets/:id/export(/)':   'export'
    'datasets/:id/edit(/)':     'edit'
    'datasets/:id/destroy(/)':  'destroy'

  list: ->
    new ListRoute({ container: @container })

  show: (id) ->
    new ShowRoute({ container: @container, id: id })

  graph: (id) ->
    new GraphRoute({ container: @container, id: id })

  search: (id) ->
    new SearchRoute({ container: @container, id: id })

  knowledgeCapture: (id) ->
    new CaptureRoute({ container: @container, id: id })

  config: (id) ->
    new ConfigRoute({ container: @container, id: id })

  export: (id) ->
    new ExportRoute({ container: @container, id: id })

  edit: (id) ->
    new EditRoute({ container: @container, id: id })

  destroy: (id) ->
    new DestroyRoute({ container: @container, id: id })

  new: ->
    new NewRoute({ container: @container })

# # # # #

module.exports = DatasetRouter
