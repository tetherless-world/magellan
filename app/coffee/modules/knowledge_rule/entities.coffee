AbstractRuleEntities = require '../abstract_rule/entities'

# # # # #

# KnowledgeRuleModel definition
class KnowledgeRuleModel extends AbstractRuleEntities.Model

  # radioChannel Definition
  radioChannel: 'knowledge:rule'

# # # # #

# Backbone.RelationalModel.setup()
KnowledgeRuleModel.setup()

# # # # #

# KnowledgeRuleCollection definition
class KnowledgeRuleCollection extends AbstractRuleEntities.Collection
  model: KnowledgeRuleModel

  # Object attribute to which the rules are applied
  target_object: 'data'

# # # # #

module.exports =
  Model:      KnowledgeRuleModel
  Collection: KnowledgeRuleCollection
