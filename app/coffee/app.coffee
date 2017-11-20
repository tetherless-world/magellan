
# Application class definition
# Manages lifecycle and bootstraps application
class Application extends Marionette.Service

  radioEvents:
    'db ready':     'onReady'
    'app redirect': 'redirectTo'

  # Invoked after constructor
  initialize: ->

    # Starts Header Component
    Backbone.Radio.channel('header').trigger('reset')

    # Starts Loading Component
    Backbone.Radio.channel('loading').trigger('ready')

    # Starts Henson.js Components
    Backbone.Radio.channel('breadcrumb').trigger('ready')
    Backbone.Radio.channel('overlay').trigger('ready')
    return true

  # Starts the application
  # Populates the database with the bundled ontologies,
  # starts Backbone.history (enables routing), and initializes sidebar module
  onReady: ->

    # Populates DexieDB with default ontologies
    Backbone.Radio.channel('ontology').request('ensure:bundled').then () =>

      # TODO - Populate DexieDB with default datasets

      # Hides loading message
      Backbone.Radio.channel('loading').trigger('hide')

      # Starts Backbone.History
      Backbone.history.start()

      # Prevents non-chrome browsers from using the tool
      if !window.chrome
        Backbone.Radio.channel('unsupported').trigger('show')

    .catch (err) =>

      # TODO - this needs a graceful fallback
      console.log 'ERROR FETCHING ONTOLOGIES'
      console.log err

  # Redirection interface
  # Used accross the application to redirect
  # to specific views after specific actions
  redirectTo: (route) ->
    window.location = route
    return true

# # # # #

module.exports = Application
