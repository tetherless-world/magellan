KnowledgeRuleLayout = require '../../knowledge_capture/views/layout'
KnowledgeRuleForm = require '../../knowledge_capture/views/ruleForm'
ExportForm = require '../../knowledge_capture/views/exportForm'
ImportForm = require '../../knowledge_capture/views/importForm'

# # # # #

class RuleForm extends KnowledgeRuleForm
  template: require './templates/rule_form'

  onRender: ->
    Backbone.Syphon.deserialize( @, @model.attributes )
    @showDefinitionList()

# # # # #

class RuleLayout extends KnowledgeRuleLayout
  template: require './templates/layout'
  className: 'row'

  # showRuleForm
  # Shows the form to create or edit a Definer rule instance
  showRuleForm: (model) ->

    # HACK - assigns null if showRuleForm was invoked via jQuery event
    model = null if model.currentTarget

    # Gets model to pass into RuleForm
    formModel = model || @buildNewRule()

    # Fetches SourceOptions
    @fetchSourceOptions().then (sourceOptions) =>

      # Instantiates new RuleForm instance
      formView = new RuleForm({ model: formModel, collection: formModel.get('definitions'), sourceOptions: sourceOptions })

      # Form 'cancel' event handler
      formView.on 'cancel', => @showRuleList()

      # Form 'sync' event handler
      formView.on 'sync', (model) =>

        # Adds new model to the collection
        @collection.add(model)

        # Renders the rule list
        @showRuleList()

      # Shows the form inside the content region
      @contentRegion.show(formView)

  # showExportForm
  # Shows the view to export SmartRendering rules (rather than KnowledgeRule default)
  showExportForm: ->
    exportForm = new ExportForm({ model: @model, exportType: 'smart_rendering' })
    exportForm.on 'cancel', => @showRuleList()
    exportForm.on 'success', => @showRuleList()
    @contentRegion.show(exportForm)

  # showImportForm
  # Shows the view to import KnowledgeRules
  showImportForm: ->
    importForm = new ImportForm({ model: @model, importType: 'smart_rendering' })
    importForm.on 'cancel', => @showRuleList()
    importForm.on 'success', => @showRuleList()
    @contentRegion.show(importForm)

# # # # #

module.exports = RuleLayout
