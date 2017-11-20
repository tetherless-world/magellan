ConstraintForm = require './constraintForm'
ActionForm = require './actionForm'

# # # # #

class DefinitionForm extends Mn.LayoutView
  className: 'row'
  template: require './templates/definition_form'

  behaviors:
    CancelButton: {}
    SubmitButton: {}

  regions:
    constraintRegion: '[data-region=constraint]'
    actionRegion:     '[data-region=action]'

  templateHelpers: ->
    return { isNew: @options.isNew }

  onRender: ->
    @constraintRegion.show new ConstraintForm({ model: @model, sourceOptions: @options.sourceOptions })
    @actionRegion.show new ActionForm({ model: @model, isNew: @options.isNew, sourceOptions: @options.sourceOptions })

  onCancel: (e) ->
    e.stopPropagation()
    @trigger 'cancel', @

  onSubmit: (e) ->
    e.stopPropagation()

    # Serializes data from form
    data = Backbone.Syphon.serialize(@)

    # console.log data

    # Sets the data on the model
    @model.set(data)

    # Triggers the submit event
    @trigger 'submit', @

# # # # #

module.exports = DefinitionForm
