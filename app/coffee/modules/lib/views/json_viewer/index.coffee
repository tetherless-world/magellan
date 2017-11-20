
class JsonViewer extends Marionette.LayoutView
  className: 'json-viewer'
  template: require './templates/json_viewer'

  serializeData: -> # Returns an array of JSON, styled w/ numbered lines
    return { json: JSON.stringify(@model.toJSON(), null, 2).split("\n") }

# # # # #

module.exports = JsonViewer
