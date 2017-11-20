
class ExportForm extends Mn.LayoutView
  template: require './templates/export_form'
  className: 'card card-body'

  behaviors:
    CancelButton: {}
    SubmitButton: {}
    DownloadFile: {}
    Flashes:
      success:
        message:  'Successfully exported Knowledge Capture.'

  # Sets default exportType flag
  # Used when subclassing this view to apply to both Knowledge Rules and Smart Rendering rules
  initialize: (options) ->
    options.exportType ||= 'knowledge'
    return

  onCancel: ->
    @trigger 'cancel'

  # Generates unique filename for the KnowledgeRule export
  generateFilename: ->

    # Dataset label
    label = @model.get('label')
    label = label.toLowerCase().replace(/\s/g, '_')

    # Export type label
    exportType = '_magellan_knowledge_rules'
    exportType = '_magellan_smart_rendering_rules' if @options.exportType == 'smart_rendering'

    # Assembles filename
    filename = [label, exportType, '.json']
    return filename.join('')

  fetchRules: ->
    return @model.fetchViewerRules() if @options.exportType == 'smart_rendering'
    return @model.fetchKnowledgeRules()

  onSubmit: ->
    @fetchRules().then (ruleCollection) =>

      # Content and filename
      content   = JSON.stringify(ruleCollection.toJSON(), null, 2)
      filename  = @generateFilename()
      filetype  = 'applicaton/json'

      # Downloads file (DownloadFile behavior)
      @downloadFile({ content: content, type: filetype, filename: filename })

      # Shows success message
      @flashSuccess()

      # Triggers 'success' event
      @trigger('success')

# # # # #

module.exports = ExportForm
