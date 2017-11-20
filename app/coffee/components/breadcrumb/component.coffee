BreadcrumbList = require './views/breadcrumbList'

# # # # #

class BreadcrumbComponent extends Mn.Service

  initialize: (options = {}) ->
    @container  = options.container
    @collection = new Backbone.Collection()

  radioEvents:
    'breadcrumb ready': 'onReady'
    'breadcrumb set':   'set'

  onReady: ->
    @set([{text: 'Loading...'}])
    @showView()

  set: (models) ->
    @collection.set(models)

  showView: ->
    unless @shown
      @container.show new BreadcrumbList({ collection: @collection })
      @shown = true

# # # # #

module.exports = BreadcrumbComponent
