
class ExportView extends Mn.LayoutView
  template: require './templates/export'
  className: 'container d-flex align-items-center h-100 flex-column',

  behaviors:
    DownloadFile: {}
    Flashes:
      success:
        message:  'Successfully exported dataset for analysis.'

  ui:
    exportJSON:     '[data-export=json]'
    exportEnhanced: '[data-export=enhanced]'
    exportCSV:      '[data-export=csv]'

  events:
    'click @ui.exportJSON':     'exportJSON'
    'click @ui.exportCSV':      'exportCSV'
    'click @ui.exportEnhanced': 'exportEnhanced'

  # Generates unique filename for the KnowledgeRule export
  generateFilename: (extension) ->
    label = @model.get('label')
    label = label.toLowerCase().replace(/\s/g, '_')
    # date  = new Date().toJSON().slice(0,10).replace(/-/g, '_')
    # filename = [label, '_magellan_dataset_', date, '.', extension ]
    filename = [label, '_magellan_dataset', '.', extension ]
    return filename.join('')

  preExport: ->

    # Shows 'Exporting' message
    Backbone.Radio.channel('loading').trigger('show', "Exporting #{@model.get('label')}...")

  postExport: ->

    # Hides loading element
    Backbone.Radio.channel('loading').trigger('hide')

    # Shows success message
    @flashSuccess()

  # exportJson
  # Exports the JSON graph without knowledge enhanacement
  exportJSON: ->
    @exportJsonGraph()

  # exportEnhanced
  # Exports Knowledge-Enhanced JSON-LD
  exportEnhanced: ->
    @exportJsonGraph({ enhanced: true })

  exportJsonGraph: (opts={}) ->

    # Shows 'Exporting...' messsage
    @preExport()

    # Fetches datapoints
    # TODO - datapoints should be sorted by some arbitrary attribute, @id?
    @model.export(opts).then (exported_graph) =>

      # Filename and filetype
      filename  = @generateFilename('json')
      filetype  = 'application/json'

      # Downloads File
      @downloadFile({ content: JSON.stringify(exported_graph, null, 2), type: filetype, filename: filename })
      @postExport()

  # TODO - this should be mostly be contained inside a model method
  exportCSV: ->

    # Shows 'Exporting' message
    Backbone.Radio.channel('loading').trigger('show', "Exporting #{@model.get('label')}...")

    # Fetches datapoints
    # TODO - datapoints should be sorted by some arbitrary attribute, @id?
    @model.fetchDatapoints().then (datapoints) =>

      # Knowledge-Enhanced Export
      jsonExport = datapoints.pluck('data')

      # Gathers keys for CSV
      allKeys = []
      allKeys = _.union(allKeys, _.keys(el) ) for el in jsonExport
      allKeys = _.uniq(allKeys)

      # CSV Out
      csvOut = []

      # CSV Header
      csvOut.push(allKeys.join(', '))

      # CSV Rows
      for el in jsonExport
        row = []

        for header in allKeys
          value = el[header]
          value = value['@id'] if typeof value == 'object' && value['@id']
          value = 'NULL' if value == undefined
          row.push(value)

        csvOut.push(row.join(', '))

      # Filename and filetype
      filename  = @generateFilename('csv')
      filetype  = 'text/csv'

      # Downloads File
      @downloadFile({ content: csvOut.join('\n'), type: filetype, filename: filename })
      @postExport()

# # # # #

module.exports = ExportView
