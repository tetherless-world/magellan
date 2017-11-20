DefinitionViewer = require './definitionViewer'

# # # # #

class DefinitionEmpty extends Mn.LayoutView
  template: require './templates/definition_empty'
  className: 'list-group-item list-group-item-warning'

# # # # #

class DefinitionChild extends Mn.LayoutView
  template: require './templates/definition_child'
  className: 'list-group-item'

  behaviors:
    SortableChild: {}
    SelectableChild: {}

  modelEvents:
    'change:order': 'onReordered'

  onReordered: ->
    @render()

# # # # #

# TODO - collection add and remove events?
class DefinitionList extends Mn.CollectionView
  className: 'list-group'
  childView: DefinitionChild
  emptyView: DefinitionEmpty

  behaviors:
    SortableList: {}

  collectionEvents:
    'remove': 'onCollectionRemove'
    'add':    'onCollectionRemove'

  # Resets the selected model in the list
  # When a selected rule has been removed
  onCollectionRemove: ->
    setTimeout( @reorderCollection, 250 )
    @collection.at(0)?.trigger('selected')

# # # # #

class DefinitionLayout extends Mn.LayoutView
  className: 'row'
  template: require './templates/definition_list_layout'

  collectionEvents:
    'add':    'render'
    'remove': 'render'

  regions:
    listRegion:   '[data-region=list]'
    detailRegion: '[data-region=detail]'

  onRender: ->
    @showDefinitionList()

  showDefinitionList: ->
    listView = new DefinitionList({ collection: @collection })
    listView.on 'childview:selected', (view) => @showDefinitionViewer(view.model)
    @listRegion.show(listView)
    @collection.at(0)?.trigger('selected')

  showDefinitionViewer: (model) ->
    definitionViewer = new DefinitionViewer({ model: model })
    definitionViewer.on 'edit', (view) => @trigger('edit:definition', view.model)
    @detailRegion.show definitionViewer

# # # # #

module.exports = DefinitionLayout
