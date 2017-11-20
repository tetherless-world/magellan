
class DatasetEmpty extends Mn.LayoutView
  template: require './templates/dataset_empty'
  className: 'list-group-item list-group-item-warning'
  tagName: 'li'

# # # # #

class DatasetChild extends Mn.LayoutView
  template: require './templates/dataset_child'
  className: 'list-group-item'
  tagName: 'li'

  behaviors:
    SelectableChild: {}

# # # # #

class DatasetList extends Mn.CompositeView
  className: 'row'
  template: require './templates/dataset_list'
  childView: DatasetChild
  emptyView: DatasetEmpty
  childViewContainer: 'ul'

# # # # #

class DatasetShow extends Mn.LayoutView
  className: 'card card-body'
  template: require './templates/dataset_show'

# # # # #

class DatasetListLayout extends Mn.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    listRegion:   '[data-region=list]'
    detailRegion: '[data-region=detail]'

  onShow: -> # TODO - abstract into SelectableList helper?
    listView = new DatasetList({ collection: @collection })
    listView.on 'childview:selected', (view) => @showDataset(view.model)
    @listRegion.show(listView)
    @collection.at(0)?.trigger('selected')

  showDataset: (dataset) ->
    @detailRegion.show new DatasetShow({ model: dataset })

# # # # #

module.exports = DatasetListLayout
