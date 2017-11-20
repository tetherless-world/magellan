
class SettingsModel extends Backbone.Model
  url: 'settings'
  defaults: {} # TODO - set defaults

# # # # #

class SettingsFactory extends Marionette.Service

  radioRequests:
    'settings model':  'getModel'

  initialize: ->
    @settingsModel = new SettingsModel()

  getModel: ->
    return @settingsModel

# # # # #

module.exports = new SettingsFactory()
