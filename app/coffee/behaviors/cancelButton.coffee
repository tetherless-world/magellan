
# TODO - abstract into Henson.js
class CancelButtonBehavior extends Mn.Behavior

  ui:
    cancel: '[data-click=cancel]'

  events:
    'click @ui.cancel:not(.disabled)': 'onCancelClick'

  initialize: (options={}) ->
    @view.disableCancel = => @disableCancel()
    @view.enableCancel  = => @enableCancel()

  onCancelClick: (e) -> @view.onCancel?(e)
  disableCancel: -> @ui.cancel.addClass('disabled')
  enableCancel: ->  @ui.cancel.removeClass('disabled')

# # # # #

module.exports = CancelButtonBehavior
