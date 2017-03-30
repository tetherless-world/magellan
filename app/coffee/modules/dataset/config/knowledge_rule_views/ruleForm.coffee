
# AbstractRuleForm class definition
# Defines an abstract class used for
# both the DefinerForm and DecoratorForm classes
class AbstractRuleForm extends Mn.LayoutView
  className: 'row'

# # # # #

ConditionList = require './conditionList'

# # # # #

class DefinerForm extends AbstractRuleForm
  template: require './templates/definer_form'

  regions:
    conditionsRegion: '[data-region=conditions]'

  onRender: ->
    console.log 'RENDERD'

    # TODO - get this from the model?
    conditionsCollection = new Backbone.Collection()

    @conditionsRegion.show new ConditionList({ collection: conditionsCollection })

# # # # #

class DecoratorForm extends AbstractRuleForm
  template: require './templates/decorator_form'

# # # # #

class RuleForm extends Mn.LayoutView
  className: 'row'
  template: require './templates/rule_form'

  behaviors:
    CancelButton: {}
    SubmitButton: {}

  regions:
    typeFormRegion: '[data-region=type-form]'

  ui:
    typeSelector: '[data-click=type-selector]'

  events:
    'click @ui.typeSelector': 'onTypeSelected'

  onTypeSelected: (e) ->
    el = $(e.currentTarget)
    type = el.data('type')

    # Sets the type attribute on the new rule
    @model.set('type', type)

    # Decides the form to be rendered
    if type == 'definer'
      formView = new DefinerForm({ model: @model })

    else
      formView = new DecoratorForm({ model: @model })

    # Shows the formView instance in the region
    @typeFormRegion.show(formView)

  onSubmit: ->
    console.log 'ON SUBMIT'
    data = Backbone.Syphon.serialize(@)
    console.log data
    # @model.set(data)
    # @trigger 'submitted'
    # @trigger 'hide'

  # onRender: ->
  #   Backbone.Syphon.deserialize(@, @model.toJSON())

# # # # #

module.exports = RuleForm
