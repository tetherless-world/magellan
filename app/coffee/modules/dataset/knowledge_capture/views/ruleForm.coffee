
DefinitionForm = require './definitionForm'
DefinitionList = require './definitionList'

# # # # #

# OntologySelector class definition
# TODO - this should be abstracted into a component that can be used elsewhere
class OntologySelector extends Mn.LayoutView
  className: 'row'
  template: require './templates/ontology_attribute_selector'

  ui:
    attributeSelector: '[name=target_property]'

  templateHelpers: ->
    return { dropdown: @options.dropdown }

  onRender: ->
    Backbone.Syphon.deserialize(@, @model.attributes)
    setTimeout(@initAttributeSelector, 200)

  initAttributeSelector: =>
    @ui.attributeSelector.select2({ placeholder: 'Target Attribute' })

# # # # #

# TODO - this form should be renamed to RuleForm
# And RuleFormSelector should be decomissioned
class RuleForm extends Mn.LayoutView
  className: 'row'
  template: require './templates/rule_form'

  behaviors:
    CancelButton: {}
    SubmitButton: {}
    ModelEvents: {}

  ui:
    addDefinition: '[data-click=add]'

  events:
    'click @ui.addDefinition': 'addDefinition'

  regions:
    ontologySelector:   '[data-region=ontology-selector]'
    definitionsRegion:  '[data-region=definitions]'

  addToCollection: (definitionModel) ->
    @collection.add(definitionModel)
    @showDefinitionList()

  showOntologyAttributeSelector: ->
    Backbone.Radio.channel('ontology').request('attribute:dropdown').then (dropdown) =>
      @ontologySelector.show new OntologySelector({ model: @model, dropdown: dropdown })

  addDefinition: ->

    # Instantiates new DefinitionModel from the collection
    newDefinition = new @collection.model({ id: buildUniqueId('cn_'), order: @collection.length + 1 })

    # Instantiates new DefinitionForm instance
    definitionForm = new DefinitionForm({ model: newDefinition, isNew: true, sourceOptions: @options.sourceOptions })

    # Cancel event callback
    definitionForm.on 'cancel', => @showDefinitionList()

    # Submit event callback
    definitionForm.on 'submit', (view) => @addToCollection(view.model)

    # Shows the form in region
    @definitionsRegion.show definitionForm

  editDefinition: (definitionModel) ->

    # Instantiates new DefinitionForm instance
    definitionForm = new DefinitionForm({ model: definitionModel, sourceOptions: @options.sourceOptions })

    # Cancel event callback
    definitionForm.on 'cancel', => @showDefinitionList()

    # Submit event callback
    definitionForm.on 'submit', (view) => @showDefinitionList()

    # Shows the form in region
    @definitionsRegion.show definitionForm

  showDefinitionList: ->
    definitionList = new DefinitionList({ collection: @collection, header: true })
    definitionList.on 'edit:definition', (definitionModel) => return @editDefinition(definitionModel)

    # Shows the list view in region
    @definitionsRegion.show definitionList

  onRender: ->
    Backbone.Syphon.deserialize( @, @model.attributes )
    @showDefinitionList()
    @showOntologyAttributeSelector()

  onCancel: ->
    @trigger 'cancel'

  onSubmit: ->
    data = Backbone.Syphon.serialize(@)
    @collection.sort()
    @model.set(data)
    @model.save()

  onRequest: ->
    console.log 'onRequest'

  onSync: ->
    @trigger 'sync', @model

  onError: ->
    console.log 'onError'

# # # # #

module.exports = RuleForm
