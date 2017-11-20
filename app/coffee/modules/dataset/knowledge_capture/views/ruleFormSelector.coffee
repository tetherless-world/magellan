
# RuleFormSelector class definition
# Provides an interface to select between different
# types of new KnowledgeRules
class RuleFormSelector extends Mn.LayoutView
  className: 'row'
  template: require './templates/rule_form_selector'

  behaviors:
    CancelButton: {}

  ui:
    typeSelector: '[data-click=type-selector]'

  events:
    'click @ui.typeSelector': 'onTypeSelected'

  onTypeSelected: (e) ->
    el = $(e.currentTarget)
    type = el.data('type')

    # Decides the form to be rendered
    return @trigger('new:definer') if type == 'definer'
    return @trigger('new:decorator')

  onCancel: ->
    @trigger 'cancel'

# # # # #

module.exports = RuleFormSelector
