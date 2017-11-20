RecordViewer = require './recordViewer'

# # # # #

class RecordListChild extends Mn.LayoutView
  tagName:    'a'
  className:  'list-group-item'
  template: require './templates/record_list_child'

  behaviors:
    SelectableChild: {}

# # # # #

class RecordListView extends Mn.CollectionView
  tagName:    'ul'
  className:  'list-group record-list-group'
  childView:  RecordListChild

# # # # #

class RecordListLayout extends Mn.LayoutView
  template: require './templates/record_list_layout'
  className: 'row'

  regions:
    listRegion:   '[data-region=list]'
    detailRegion: '[data-region=detail]'

  # # # # #

  # TODO - keyboard controls are buggy
  # behaviors:
  #   KeyboardControls:
  #     keyEvents:
  #       37: 'key:left'
  #       38: 'key:left'
  #       39: 'key:right'
  #       40: 'key:right'

  # onRender: ->
  #   console.log 'RENDER LIST VIEW'

  # counter: 0
  # onKeyLeft: =>
  #   @counter = @counter - 1
  #   @counter = 0 if @counter < 0
  #   console.log @collection
  #   console.log @counter
  #   @collection.at(@counter)?.trigger('selected')
  #   console.log 'onKeyLeft'

  # onKeyRight: ->
  #   console.log 'onKeyRight'
  #   @counter = @counter + 1
  #   @counter = @collection.length if @counter > @collection.length
  #   @collection.at(@counter)?.trigger('selected')

  # # # # #

  onRender: -> # TODO - abstract into SelectableList helper?
    listView = new RecordListView({ collection: @collection })
    listView.on 'childview:selected', (view) => @showDataset(view.model)
    @listRegion.show(listView)
    @collection.at(0)?.trigger('selected')

  showDataset: (dataset) ->
    detailView = new RecordViewer({ model: dataset })
    @detailRegion.show detailView
    detailView.on 'show:underlay', => $('.drift-underlay').addClass('active')
    detailView.on 'hide:underlay', => $('.drift-underlay').removeClass('active')

# # # # #

module.exports = RecordListLayout
