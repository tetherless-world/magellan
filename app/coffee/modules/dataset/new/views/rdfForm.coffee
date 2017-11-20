UploadWidget = require '../../../base/views/upload/upload'

# # # # #

# RdfForm class definition
class RdfForm extends Mn.LayoutView
  template: require './templates/rdf_form'
  className: 'row'

  behaviors:
    ModelEvents: {}
    SubmitButton: {}

  regions:
    uploadRegion: '[data-region=upload]'

  ui:
    dirInput: '[name=dir]'

  events:
    'change @ui.dirInput': 'onDirChange'

  onRender: ->
    uploadWidget = new UploadWidget()
    uploadWidget.on 'file:loaded', @onJsonUpload # TODO
    @uploadRegion.show uploadWidget
    @disableSubmit()

  # # # # #

  # onJsonUpload
  # Invoked as a callback when an RDF/XML file has been loaded
  onJsonUpload: (uploadedText) =>

    # Parses JSON from upload
    # parsedJson = JSON.parse(uploadedText)

    # Sets context and graph attributes on dataset model
    # @model.set('context', parsedJson['@context'])

    # TODO - is there a better way to manage this?
    # We'll need some additional logic to manage the state of the uploaded dataset
    # @uploadedGraph = parsedJson['@graph']

    # Enables submitButton
    # TODO - there should be a validate method that manages submitButton state
    # @enableSubmit()

  # onSubmit (from SubmitButton behavior)
  onSubmit: ->

    # TODO - this should be abstracted into a behavior...or has it been at some point?
    data = Backbone.Syphon.serialize(@)

    # Saves Dataset model to Dexie
    @model.set(data)
    @options.creator.deploy(@model, @uploadedGraph)

  onSync: ->
    Radio.channel('app').trigger('redirect', '#datasets')

  # TODO - handle error event callbacks
  onError: (err) ->
    console.log 'ERROR'
    console.log err

# # # # #

module.exports = RdfForm
