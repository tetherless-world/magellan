JsonViewer  = require 'hn_views/lib/json_viewer'
JsonGraph   = require './graph'
TableView   = require './table'

# # # # #

class ResultViewer extends require 'hn_views/lib/nav'

  navItems: [
    { icon: 'fa-table',   text: 'Table',  trigger: 'table', default: true }
    { icon: 'fa-code',    text: 'JSON',   trigger: 'json' }
    { icon: 'fa-sitemap', text: 'Graph',  trigger: 'graph' }
    # { icon: 'fa-sitemap', text: 'Type Ontology',  trigger: 'ontology' }
  ]

  navEvents:
    'table':    'showTable'
    'json':     'showJson'
    'graph':    'showGraph'
    # 'ontology': 'showOntology'

  showTable: ->
    @contentRegion.show new TableView({ model: @model })

  showJson: ->
    @contentRegion.show new JsonViewer({ model: @model })

  showGraph: ->
    @contentRegion.show new JsonGraph({ json: @model.toJSON() })

  # showOntology: ->
  #   ontologyJson = []

  #   # Gets JSON for each @type
  #   for type in @model.get('@type')
  #     id = type.split(':')[0]
  #     attr = type
  #     attribute = Backbone.Radio.channel('ontology').request('attribute', id, attr)
  #     ontologyJson.push(attribute) if attribute

  #   @contentRegion.show new JsonGraph({ json: ontologyJson })

# # # # #

class RecordChild extends Mn.LayoutView
  template: require './templates/record_child'
  tagName:    'li'
  className:  'list-group-item'

  regions:
    viewerRegion: '[data-region=viewer]'

  behaviors: ->
    return obj =
      Tooltips: {}
      ClickableRelations: {}
      CopyToClipboard: { text: @options.model.stringifyJson() }
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

  serializeData: ->
    return {data: super()}

  onRender: ->
    @viewerRegion.show new ResultViewer({ model: @model })

# # # # #

class RecordListView extends Mn.CollectionView
  tagName:    'ul'
  className:  'list-group record-list-group'
  childView:  RecordChild

# # # # #

module.exports = RecordListView
