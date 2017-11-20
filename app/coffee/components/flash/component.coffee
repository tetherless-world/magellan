require './service'
FlashList = require './views/flashList'

# # # # #

# FlashService class definition
# Defines a component to create and display flashes
# in the app. Provides multiple interfaces in radioEvents
# to handle common types of flashes (error, warning, success)
class FlashComponent extends Backbone.Marionette.Service

  initialize: (options = {}) ->
    @container = options.container
    Backbone.Radio.channel('flash').request('collection').then (collection) =>
      @collection = collection
      @collection.on 'update', @showListView, @

  radioEvents:
    'flash add':      'add'
    'flash reset':    'reset'
    'flash error':    'error'
    'flash warning':  'warning'
    'flash success':  'success'

  add: (options = {}) ->
    @collection.add(options)

  reset: ->
    @collection.reset()

  error: (options={}) ->
    @collection.add _.extend( options, { context:  'danger' })

  warning: (options={}) ->
    @collection.add _.extend( options, { context:  'warning' })

  success: (options={}) ->
    @collection.add _.extend( options, { context:  'success' })

  showListView: =>
    unless @rendered
      @container.show new FlashList({ collection: @collection })
      @rendered = true

# # # # #

module.exports = FlashComponent
