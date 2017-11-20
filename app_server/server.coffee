fs = require 'fs'
Promise = require 'bluebird'

# # # # #

# String to ArrayBuffer
str2ab = (str) ->
  buf = new ArrayBuffer(str.length * 2)
  # 2 bytes for each char
  bufView = new Uint16Array(buf)
  i = 0
  strLen = str.length
  while i < strLen
    bufView[i] = str.charCodeAt(i)
    i++
  buf

# Initializes file request
initServerRadio = () ->

  # # # # #

  class ServerService extends Backbone.Marionette.Service

    radioRequests:
      'background file': 'requestFile'

    requestFile: (filepath) ->
      filepath = filepath.split('file://')[1] if filepath.indexOf('file://') > -1
      return new Promise (resolve,reject) =>
        fs.readFile filepath, (error, data) ->
          console.log 'FETCHED FILE?????'
          return reject(error) if error
          return resolve(data) # Return as ArrayBuffer

  # # # # #

  new ServerService()

# # # # #

# Initializes communication link between client and backgroun app
setTimeout( =>
  return unless window.global.Backbone
  initServerRadio()
, 1000)

# Defines ServerRadio
# ServerRadio = _.extend({}, Backbone.Events)

# Attaches ServerRadio to window.global
# (shared object between client/background)
# window.global.ServerRadio = ServerRadio

# Populates database from Client application
# TODO - pass in options
# ServerRadio.on 'request:file', (filepath) =>
#   console.log 'REQUESTING FILE'
#   console.log filepath
#   # console.log 'START POPULATING DATABASE'

# # # # #

# ServerRadio Events (triggers changes on client)

# ServerRadio - FileOpen routine
# ServerRadio.trigger('file:open:start')
# ServerRadio.trigger('file:open:progress')
# ServerRadio.trigger('file:open:success')
# ServerRadio.trigger('file:open:error')

# ServerRadio - Populate DB
# ServerRadio.trigger('populate:start')
# ServerRadio.trigger('populate:success')
# ServerRadio.trigger('populate:error')

# TODO - Parse Facets should be handled in a different file
# Database population should not be tied tightly to FacetParsing
# ServerRadio - Parse Facets
# ServerRadio.trigger('parse:facets:start')
# ServerRadio.trigger('parse:facets:success')
# ServerRadio.trigger('parse:facets:error')

# # # # # #
