
RuleViewer = require './ruleViewer'

# # # # #

class RuleEmpty extends Mn.LayoutView
  template: require './templates/rule_empty'
  className: 'list-group-item list-group-item-warning'

# # # # #

class RuleChild extends Mn.LayoutView
  template: require './templates/rule_child'
  className: 'list-group-item'

  behaviors:
    SelectableChild: {}
    SortableChild: {}
    Tooltips: {}

  modelEvents:
    'change:order': 'onReordered'
    'sync':         'onSync'

  onReordered: ->
    @model.save()

  onSync: ->
    @render()

# # # # #

class RuleList extends Mn.CollectionView
  className: 'list-group'
  childView: RuleChild
  emptyView: RuleEmpty

  behaviors:
    SortableList: {}

  collectionEvents:
    'remove': 'onCollectionRemove'

  # Resets the selected model in the list
  # When a selected rule has been removed
  onCollectionRemove: ->
    setTimeout( @reorderCollection, 250 )
    @collection.at(0)?.trigger('selected')

# # # # #

class RuleLayout extends Mn.LayoutView
  className: 'row'
  template: require './templates/rule_list_layout'

  regions:
    listRegion:   '[data-region=list]'
    detailRegion: '[data-region=detail]'

  onRender: ->
    listView = new RuleList({ collection: @collection })
    window.listView = listView
    listView.on 'childview:selected', (view) => @showDetail(view.model)
    @listRegion.show(listView)
    @collection.at(0)?.trigger('selected')

  showDetail: (model) ->
    ruleViewer = new RuleViewer({ model: model })
    ruleViewer.on 'edit', (view) => @trigger('edit', view.model)
    @detailRegion.show ruleViewer

# # # # #

module.exports = RuleLayout
