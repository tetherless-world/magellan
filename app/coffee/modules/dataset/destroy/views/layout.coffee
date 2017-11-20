UploadWidget = require '../../../base/views/upload/upload'

# # # # #

class DestroyDatasetLayout extends Mn.LayoutView
  template: require './templates/layout'
  className: 'container'

  behaviors:
    ModelEvents: {}

    Confirmations:
      message:      'Are you sure you want to destroy this dataset?'
      confirmIcon:  'fa-trash'
      confirmText:  'DESTROY'
      confirmCss:   'btn-danger'

    Flashes:
      success:
        message:  'Successfully reset dataset.'

  ui:
    confirmationTrigger:  '[data-click=confirm]'


  # onConfirmed (Confirmations behavior)
  # Destroy datapoints, facets, knowledge_rules, viewer_rules, and dataset.
  onConfirmed: ->
    @options.destructor.deploy(@model)

  # onRequest (ModelEvents behavior)
  onRequest: ->
    @ui.confirmationTrigger.addClass('disabled')

  # onSync (ModelEvents behavior)
  onSync: ->
    Radio.channel('app').trigger('redirect', '#datasets')

  # onError (ModelEvents behavior)
  # TODO - handle error event callbacks
  onError: (err) ->
    console.log 'ERROR'
    console.log err

# # # # #

module.exports = DestroyDatasetLayout
