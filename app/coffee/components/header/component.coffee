LayoutView = require './views/layout'

# HeaderService class definition
# Defines a basic service for managing application
# header state. Displays the authenticated user,
# or the 'unauthenticated' message if none is defined
class HeaderService extends Marionette.Service

  initialize: ->
    @container = @options.container

  radioEvents:
    'header reset': 'reset'

  reset: ->
    @container.show new LayoutView()

# # # # #

module.exports = HeaderService
