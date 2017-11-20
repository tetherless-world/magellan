AbstractRuleEntities = require '../abstract_rule/entities'

# # # # #

# ViewerRuleDecorator class definition
class ViewerRuleDecorator extends Mn.Decorator

  icon: ->
    return 'fa-globe'

# # # # #

# ViewerRuleModel definition
class ViewerRuleModel extends AbstractRuleEntities.Model

  # Decorator assignment
  decorator: ViewerRuleDecorator

  # radioChannel Definition
  radioChannel: 'viewer:rule'

# # # # #

ViewerRuleModel.setup()

# # # # #

# ViewerRuleCollection definition
class ViewerRuleCollection extends AbstractRuleEntities.Collection
  model: ViewerRuleModel

  # Object attribute to which the rules are applied
  target_object: 'views'

# # # # #

module.exports =
  Model:      ViewerRuleModel
  Collection: ViewerRuleCollection
