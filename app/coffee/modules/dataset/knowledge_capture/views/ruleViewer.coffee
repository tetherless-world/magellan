
class RuleViewer extends Mn.LayoutView
  className: 'card card-body'
  template: require './templates/rule_viewer'

  behaviors:
    Confirmations:
      message:      'Are you sure you want to destroy this Knowledge Rule?'
      confirmIcon:  'fa-trash'
      confirmText:  'DESTROY'
      confirmCss:   'btn-danger'

  ui:
    edit:                 '[data-click=edit]'
    confirmationTrigger:  '[data-click=destroy]'

  triggers:
    'click @ui.edit': 'edit'

  modelEvents:
    'destroy':  'onModelDestroy'
    'error':    'onError'

  onConfirmed: ->
    @model.destroy()

  onModelDestroy: ->
    @model.collection.remove(@model)

  onError: ->
    console.log 'onError'

# # # # #

module.exports = RuleViewer
