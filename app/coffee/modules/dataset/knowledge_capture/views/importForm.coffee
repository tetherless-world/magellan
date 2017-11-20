UploadWidget = require '../../../base/views/upload/upload'

# # # # #

class ImportForm extends Mn.LayoutView
  template: require './templates/import_form'
  className: 'card card-body'

  behaviors:
    CancelButton: {}
    SubmitButton: {}
    DownloadFile: {}
    Flashes:
      success:
        message:  'Successfully imported Knowledge Rules.'

  regions:
    uploadRegion: '[data-region=upload]'

  # Sets default importType flag
  # Used when subclassing this view to apply to both Knowledge Rules and Smart Rendering rules
  initialize: (options) ->
    options.importType ||= 'knowledge'
    return

  onCancel: ->
    @trigger 'cancel'

  onRender: ->
    uploadWidget = new UploadWidget()
    uploadWidget.on 'file:loaded', @onFileUpload # TODO
    @uploadRegion.show uploadWidget
    @disableSubmit()

  # onFileUpload
  # Invoked as a callback when a JSON file has
  onFileUpload: (uploadedText) =>

    # Parses JSON from upload
    @importedRules = JSON.parse(uploadedText)

    # Enables submitButton
    @enableSubmit()

  fetchRules: ->
    return @model.fetchViewerRules() if @options.importType == 'smart_rendering'
    return @model.fetchKnowledgeRules()

  # TODO - most of this logic should be managed by a KnowledgeRule importer class
  onSubmit: ->

    # Fetches existing Rules
    @fetchRules().then (ruleCollection) =>

      # # # # #
      # Updates @importedRules to be compatible with this dataset

      # Order
      order = ruleCollection.length + 1

      # Updates importedRules to be associated with the present Dataset model
      for rule in @importedRules

        # Assigns dataset_id
        rule.dataset_id = @model.id

        # Assigns order (and increments)
        rule.order = order
        order = order + 1

        # Assigns unique ID to KnowledgeRule model
        rule.id = buildUniqueId('kn_')

        # Iterates over each definition and assigns unique ID
        for definition in rule.definitions
          definition.id = buildUniqueId('cn_')

      #
      # # # # #

      # Async helper method to instantiate and save a new KnowledgeRule
      buildNewRule = (rule) ->

        # Instantiates new KnowledgeRule model
        importedRule = new ruleCollection.model(rule)

        # Persists new KnowledgeRule to DB (returns a Promise)
        return importedRule.save()

      # Persists each imported KnowledgeRule to the database
      Promise.each(@importedRules, buildNewRule)
      .then () =>

        # Adds the imported rules to the existing collection
        ruleCollection.add(@importedRules)

        # Shows success message
        @flashSuccess()

        # Triggers 'success' event
        @trigger('success')

# # # # #

module.exports = ImportForm
