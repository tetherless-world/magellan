
class EditDatasetLayout extends Mn.LayoutView
  template: require './templates/layout'
  className: 'container'

  behaviors:
    ModelEvents: {}
    SubmitButton: {}

  onRender: ->
    Backbone.Syphon.deserialize( @, @model.attributes )

  # onSubmit (from SubmitButton behavior)
  onSubmit: ->
    data = Backbone.Syphon.serialize(@)

    # Updates Dataset model
    @model.set(data)
    @model.save()

  # TODO - disable submit and cancel buttons
  onRequest: ->
    console.log 'ON REQUEST'

  onSync: ->
    Radio.channel('app').trigger('redirect', '#datasets')

  # TODO - handle error event callbacks
  onError: (err) ->
    console.log 'ERROR'
    console.log err

# # # # #

module.exports = EditDatasetLayout
