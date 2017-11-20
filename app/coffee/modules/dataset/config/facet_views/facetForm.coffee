
class FacetForm extends Mn.LayoutView
  className: 'card card-body'
  template: require './templates/facet_form'

  behaviors:
    CancelButton: {}
    ModelEvents: {}
    SubmitButton: {}
    Flashes:
      success:
        message:  'Successfully updated Facet.'
      error:
        message:  'Error updating Facet.'

  ui:
    checkbox: 'input[type=checkbox]'
    edit:     '[data-click=edit]'

  onRender: ->
    Backbone.Syphon.deserialize( @, @model.attributes )
    @ui.checkbox.bootstrapSwitch({ wrapperClass: 'enable-facet', onText: 'Enabled', offText: 'Disabled' })

  onCancel: ->
    @trigger('cancel', @)

  onSubmit: ->
    data = Backbone.Syphon.serialize(@)
    @model.set(data)
    @model.save()

  onRequest: ->
    @disableSubmit()
    @disableCancel()

  onSync: ->
    @flashSuccess()
    @trigger('sync', @)

  onError: ->
    @flashError()
    @trigger('sync', @)

# # # # #

module.exports = FacetForm
