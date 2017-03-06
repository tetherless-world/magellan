# TODO - abstract into separate library
LdViewer = require '../../../search/facetsearch/views/graph.coffee'

# # # # #

class OntologyEmpty extends Mn.LayoutView
  template: require './templates/ontology_empty'
  className: 'list-group-item list-group-item-warning'
  tagName: 'li'

# # # # #

class OntologyChild extends Mn.LayoutView
  template: require './templates/ontology_child'
  className: 'list-group-item'
  tagName: 'li'

  behaviors:
    SelectableChild: {}

# # # # #

class OntologyList extends Mn.CompositeView
  className: 'row'
  template: require './templates/ontology_list'
  childView: OntologyChild
  emptyView: OntologyEmpty
  childViewContainer: 'ul'

# # # # #

class OntologyListLayout extends Mn.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    listRegion: '[data-region=list]'
    graphRegion: '[data-region=graph]'

  onShow: -> # TODO - abstract into SelectableList helper?
    listView = new OntologyList({ collection: @collection })
    listView.on 'childview:selected', (view) => @showGraph(view.model)
    @listRegion.show listView
    @collection.at(0)?.trigger('selected')

  showGraph: (ontology) ->
    @graphRegion.show new LdViewer({ json: ontology.toJSON()['graph'] })

# # # # #

module.exports = OntologyListLayout
