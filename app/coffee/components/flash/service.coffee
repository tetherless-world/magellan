FlashCollection = require './collection'

# # # # #

# FlashService class definition
# Defined a basic service to return the FlashesCollection
# when requested. This is used by the FlashComponent to retrieve
# the FlashCollection it is responsible for rendering
class FlashService extends Backbone.Marionette.Service

  radioRequests:
    'flash collection': 'getCollection'

  alerts: null

  getCollection: ->
    return new Promise (resolve,reject) =>
      @alerts ||= new FlashCollection()
      resolve(@alerts)
      return

# # # # #

module.exports = new FlashService()
