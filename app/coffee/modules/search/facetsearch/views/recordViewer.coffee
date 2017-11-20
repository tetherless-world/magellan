JsonViewer  = require 'lib/views/json_viewer'
JsonGraph   = require 'lib/views/json_graph'
TableView   = require './table'
CsvViewer   = require './csvViewer'

# # # # #

class RecordViewerSelector extends require 'lib/views/nav'

  navItems: ->
    items = [
      { icon: 'fa-table',   text: 'Table',  trigger: 'table', default: true }
      { icon: 'fa-code',    text: 'JSON',   trigger: 'json' }
      { icon: 'fa-sitemap', text: 'Graph',  trigger: 'graph' }
    ]

    # CSV Viewer
    csvViewer = { icon: 'fa-file-excel-o', text: 'CSV',  trigger: 'csv' }
    items.push(csvViewer) if @model.get('views').csv

    return items

  navEvents:
    'table':    'showTable'
    'json':     'showJson'
    'graph':    'showGraph'
    'csv':      'showCsv'

  showTable: ->
    @contentRegion.show new TableView({ model: @model })

  showJson: ->
    @contentRegion.show new JsonViewer({ model: @model })

  showGraph: ->
    @contentRegion.show new JsonGraph({ json: @model.toJSON()['data'] })

  showCsv: ->
    @contentRegion.show new CsvViewer({ model: @model })

# # # # #

class RecordViewer extends Mn.LayoutView
  template: require './templates/record_viewer'
  className:  'card card-body'

  regions:
    viewerRegion: '[data-region=viewer]'

  behaviors: ->
    return obj =
      Tooltips: {}
      ClickableRelations: {}
      # CopyToClipboard: { text: @options.model.stringifyJson() }
      Flashes:
        success:
          message:  'Copied JSON to clipboard.'
          timeout:  1000
        error:
          message:  'Error copying JSON to clipboard.'
          timeout:  1000

  # CopyToClipboard behavior callbacks
  onClipboardSuccess: -> @flashSuccess()
  onClipboardError: -> @flashError()

  onRender: ->
    @viewerRegion.show new RecordViewerSelector({ model: @model })

  events:
    'mouseover img': 'onImageIn'
    'mouseout img': 'onImageOut'

  onImageIn: (e) =>
    @trigger 'show:underlay'
    return @drift.enable() if @drift
    @drift = new Drift(document.querySelector('img'), {
      containInline: true
      inlinePane: 200
      paneContainer: $('.drift-content')[0] # TODO - overlay should be a region, perhaps?
      zoomFactor: 5
      hoverBoundingBox: true
    })

  onImageOut: (e) =>
    @trigger 'hide:underlay'
    @drift.disable()

# # # # #

module.exports = RecordViewer
