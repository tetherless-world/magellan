
# DefinitionModel class definition
class DefinitionModel extends Backbone.RelationalModel

  # Default attributes
  # TODO - should 'source', 'operation', and 'value' be renamed?
  defaults:
    order:      null

    # Condition
    source:     '@id'
    operation:  'ends_with'
    value:      ''

    # Action
    # TODO - Action should be an object, rather than string attributes
    # The action = {} attribute can better store a variable number and type of attributes
    action:     ''

    applied: false # TODO - definitions should track wether or not they have been applied

  # isBlocking
  # Helper function used while evaluating rules

  # BIG TODO - 'block' esentially means 'filter' - it continues ONLY if the constraint is met.
  # We need an opposite? Continues ONLY if the constraint is false?
  isBlocking: ->
    # return @get('action') == 'block'
    return @get('action') in ['filter', 'block'] # TODO - DEPRECATED

  # evaluateAction
  # Evaluates the DefinitionModel's action and assigns the result to the target model
  evaluateAction: (target, target_object, target_property, data, ruleModel) =>

    # Isolates target_object_data
    target_object_data = target.get(target_object)

    # Block
    # TODO - deprecated!!
    if @get('action') == 'block'
      return

    # Filter
    if @get('action') == 'filter'
      return

    # Literal
    if @get('action') == 'literal'
      if ruleModel.get('references_node')
        target_object_data[target_property] = { '@id': @get('literal_text') }
      else
        target_object_data[target_property] = @get('literal_text')

      target.set(target_object, target_object_data)
      return

    # Replace
    if @get('action') == 'replace'

      # Replace operation
      replace_source  = data[@get('replace_source')]
      replace_text    = @get('replace_text')
      replace_with    = @get('replace_with')
      result          = replace_source.replace(replace_text, replace_with)

      # Sets value
      if ruleModel.get('references_node')
        target_object_data[target_property] = { '@id': result }
      else
        target_object_data[target_property] = result

      target.set(target_object, target_object_data)
      return

    # Index From Split
    if @get('action') == 'index_from_split'
      index_from_split_source = data[@get('index_from_split_source')]
      split = index_from_split_source.split(@get('index_from_split_delimiter'))
      result = split[@get('index_from_split_index')]

      # Sets value
      if result
        if ruleModel.get('references_node')
          target_object_data[target_property] = { '@id': result }
        else
          target_object_data[target_property] = result

        target.set(target_object, target_object_data)

      return

    # Index From Regex Match
    if @get('action') == 'index_from_regex_match'

      # Caches variables
      match_source  = data[@get('index_from_regex_match_source')]
      match_regex   = @get('index_from_regex_match_regex')
      index         = @get('index_from_regex_match_index')

      # Evaluates
      result = new RegExp(match_regex).exec(match_source)

      # Assigns
      if result && result[index]
        if ruleModel.get('references_node')
          target_object_data[target_property] = { '@id': result[index] }
        else
          target_object_data[target_property] = result[index]

        target.set(target_object, target_object_data)
        return

    # # # # #
    # FORMAT UPPERCASE
    # TODO - this is an ACTION
    # if operation == 'format_uppercase'
    #   continue unless source
    #   formatted = source.toUpperCase()
    #   if formatted
    #     conditionMatched = true
    #     data[target_property] = formatted
    #     target.set(target_object, data)

    # FORMAT LOWERCASE
    # TODO - this is an ACTION
    # if operation == 'format_lowercase'
    #   continue unless source
    #   formatted = source.toLowerCase()
    #   if formatted
    #     conditionMatched = true
    #     data[target_property] = formatted
    #     target.set(target_object, data)

# # # # #

class DefinitionCollection extends Backbone.Collection
  model: DefinitionModel
  comparator: 'order'

  evaluate: (target, target_object, target_property, ruleModel) =>

    # Condition matched flag
    # Target model is saved IF true
    conditionMatched = false

    # Iterates over each condition
    # TODO - abstract into DefinitionCollection prototype?
    for definition in @models

      # Isolates target data
      data = target.get('data')

      # Constraint
      source    = data[definition.get('source')] # TODO - we must find a way to handle non-string datatypes here (Array, Object, Collection, etc.)
      operation = definition.get('operation')
      value     = definition.get('value')

      # # # # # # # # # # # # # # # # # # # #
      # TODO - this operation must manage values that are arrays, objects, etc.

      # Skip undefined
      # continue unless source

      # # # # #

      # Exists
      if operation == 'exists'
        if source
          conditionMatched = true
          definition.evaluateAction(target, target_object, target_property, data, ruleModel)
        else
          break if definition.isBlocking()

      # EXACT MATCH
      if operation == 'exact_match'
        if source == value
          conditionMatched = true
          definition.evaluateAction(target, target_object, target_property, data, ruleModel)
        else
          break if definition.isBlocking()

      # STARTS WITH
      # TODO - STARTS_WITH_CASE_SENSITIVE
      if operation == 'starts_with'
        if _s.startsWith(source, value)
          conditionMatched = true
          definition.evaluateAction(target, target_object, target_property, data, ruleModel)
        else
          break if definition.isBlocking()

      # CONTAINS
      if operation == 'contains'
        if _s.include(source.toLowerCase(), value.toLowerCase())
          conditionMatched = true
          definition.evaluateAction(target, target_object, target_property, data, ruleModel)
        else
          break if definition.isBlocking()

      # CONTAINS (Case-sensitive)
      if operation == 'contains_case_sensitive'
        if _s.include(source, value)
          conditionMatched = true
          definition.evaluateAction(target, target_object, target_property, data, ruleModel)
        else
          break if definition.isBlocking()

      # DOES NOT CONTAIN
      if operation == 'does_not_contain'
        if not _s.include(source.toLowerCase(), value.toLowerCase())
          conditionMatched = true
          definition.evaluateAction(target, target_object, target_property, data, ruleModel)
        else
          break if definition.isBlocking()

      # ENDS WITH
      # TODO - ENDS_WITH_CASE_SENSITIVE
      if operation == 'ends_with'
        if _s.endsWith(source, value)
          conditionMatched = true
          definition.evaluateAction(target, target_object, target_property, data, ruleModel)
        else
          break if definition.isBlocking()

    # Returns conditionMatched
    return conditionMatched

# # # # #

# TODO - this class probably needs some apply/evaluate-against method?
# TODO - should the applyRule method belong here?
# The AbstractRuleCollection should just ITERATE over each rule, invoking the method defined here.
class AbstractRuleModel extends Backbone.RelationalModel

  # RadioChannel
  # Determines the channel used by save and destroy methods
  # This should be overwritten when subclassed
  radioChannel: null

  # Model defaults
  defaults:
    order:            0
    enabled:          true
    target_property:  ''
    definitions:      []

  # Backbone.Relational - @relations definition
  relations: [
      type:           Backbone.HasMany
      key:            'definitions' # TODO - rename to 'definitions'
      relatedModel:   DefinitionModel
      collectionType: DefinitionCollection
  ]

  # Overwritten save method
  save: ->
    Backbone.Radio.channel(@radioChannel).request('save', @)

  # Overwritten destroy method
  destroy: ->
    Backbone.Radio.channel(@radioChannel).request('destroy', @)

# # # # #

# Substring helper function
# TODO - phase this out w/ Underscore.String
isSubstringOf = (str, sub) ->
  return str.indexOf(sub) > -1

# # # # #

# AbstractRuleCollection definition
class AbstractRuleCollection extends Backbone.Collection

  # @model definition
  # This should be overwritten when subclassed
  model: AbstractRuleModel

  # Object attribute to which the rules are applied
  # This should be overwritten when subclassed
  target_object: null

  # Sort by order attribute
  comparator: 'order'

  # applyRules
  # Applies the defined KnowledgeRules to the TargetCollection
  applyRules: (targetCollection) ->

    # Index and count variables for Loading component updates
    index = 0
    count = _s.numberFormat(targetCollection.length)

    # Iterates over each model in targetCollection and applies rule to each model
    # TODO - should this be a function belonging to the KnowledgeRule model?
    # ^^^ Yes, definitely.
    applyRuleToTarget = (target) =>

      # Loading component update message
      index = index + 1
      Backbone.Radio.channel('loading').trigger('show', "Processing #{_s.numberFormat(index)} of #{count}")

      # # # # #
      # Condition-checking starts

      # Save flag variable
      saveFlag = false

      # Iterates over each rule...
      for rule in @models

        # Isolates target_property and definitions from Rule
        target_property = rule.get('target_property')
        definitionCollection = rule.get('definitions')

        # Evaluates the definitions againt the target, returns boolean
        conditionMatched = definitionCollection.evaluate(target, @target_object, target_property, rule)

        # Save if ANY condition has been matched
        saveFlag = true if conditionMatched

      # Condition-checking finished
      # # # # #

      # Saves the target model ONLY if a condition has been matched
      # and the saveFlag has been set to 'true'
      return target.save() if saveFlag

      # Returns an empty Promise :(
      return new Promise (resolve, reject) => resolve(true)

    # Returns as a Promise
    return Promise.each(targetCollection.models, applyRuleToTarget)

# # # # #

module.exports =
  Model:      AbstractRuleModel
  Collection: AbstractRuleCollection
