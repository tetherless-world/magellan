UploadWidget = require '../../../base/views/upload/upload'

# # # # #

# ArchiveForm class definition
class ArchiveForm extends Mn.LayoutView
  template: require './templates/archive_form'
  className: 'row'

  behaviors:
    ModelEvents: {}
    SubmitButton: {}
    Flashes:
      success:
        message:  'Successfully opened archive'
      error:
        message:  'Error - no files selected'

  regions:
    uploadRegion: '[data-region=upload]'

  onRender: ->
    uploadWidget = new UploadWidget({ directory: true })
    uploadWidget.on 'directory:loaded', @onDirectoryUpload
    @uploadRegion.show(uploadWidget)
    @disableSubmit()

  # onDirectoryUpload
  # Invoked as a callback when a JSON file has
  onDirectoryUpload: (files) =>

    # Caches uploaded files
    @uploadedFiles = files

    # Ensures that files have _actually_ been selected
    if files.length == 0

      # Disables submit
      @disableSubmit()

      # Shows error message
      @flashError()

    else
      # Flashes success message
      @flashSuccess()

      # Enables submitButton
      @enableSubmit()

  # onSubmit (from SubmitButton behavior)
  onSubmit: ->

    # Serializes form data
    data = Backbone.Syphon.serialize(@)

    # Gets Knowldege Graph from ArchiveImporter
    # Passes in optional directory prefix for full-filepath generation
    json = @options.importer.parse(@uploadedFiles, data.prefix)

    # Sets context and graph attributes on dataset model
    @model.set('context', json['@context'])

    # We'll need some additional logic to manage the state of the uploaded dataset
    @uploadedGraph = json['@graph']

    # Deletes directory prefix from data
    delete data.prefix

    # Saves Dataset model to Dexie
    @model.set(data)
    @options.creator.deploy(@model, @uploadedGraph)

  # onSync (from ModelEvents behavior)
  # Redirects the app to #datasets
  onSync: ->
    Radio.channel('app').trigger('redirect', '#datasets')

  # TODO - handle error event callbacks
  # TODO - generic error handler behavior
  onError: (err) ->
    console.log 'ERROR'
    console.log err

# # # # #

module.exports = ArchiveForm
