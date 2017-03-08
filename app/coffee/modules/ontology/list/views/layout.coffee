
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

# TODO - abstract into separate library
LdViewer = require '../../../search/facetsearch/views/graph.coffee'
JsonViewer = require 'hn_views/lib/json_viewer'
class AttributeDetail extends require 'hn_views/lib/nav'

  navItems: [
    { icon: 'fa-code',    text: 'JSON',   trigger: 'json', default: true }
    { icon: 'fa-sitemap', text: 'Graph',  trigger: 'graph' }
  ]

  navEvents:
    'json':     'showJson'
    'graph':    'showGraph'

  showJson: ->
    @contentRegion.show new JsonViewer({ model: @model })

  showGraph: ->
    @contentRegion.show new LdViewer({ json: @model.toJSON() })

# # # # #
# TODO - abstract Attribute viewing into a separate file

class AttributeChild extends Mn.LayoutView
  className: 'list-group-item'
  template: require './templates/attribute_child'
  tagName: 'li'

  behaviors:
    SelectableChild: {}

  serializeData: ->
    return { data: super }

class AttributeList extends Mn.CollectionView
  className: 'list-group'
  childView: AttributeChild

class AttributeListLayout extends Mn.LayoutView
  className: 'row'
  template: require './templates/attribute_layout'

  regions:
    listRegion:   '[data-region=list]'
    detailRegion: '[data-region=detail]'

  onRender: ->
    attributeCollection = new Backbone.Collection(@model.get('graph'))

    listView = new AttributeList({ collection: attributeCollection })
    listView.on 'childview:selected', (view) => @showAttribute(view.model)
    @listRegion.show listView
    attributeCollection.at(0)?.trigger('selected')

  showAttribute: (attributeModel) ->
    @detailRegion.show new AttributeDetail({ model: attributeModel })

# # # # #

class OntologyListLayout extends Mn.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    listRegion: '[data-region=list]'
    # detailRegion: '[data-region=detail]'
    detailRegion:
      selector:     '[data-region=detail]'
      regionClass:  require 'Marionette.AnimatedRegion/lib/animatedRegion'
      inAnimation:  'fadeInUp'
      outAnimation: 'fadeOutDown'

  onShow: -> # TODO - abstract into SelectableList helper?
    listView = new OntologyList({ collection: @collection })
    listView.on 'childview:selected', (view) => @showGraph(view.model)
    @listRegion.show listView
    @collection.at(0)?.trigger('selected')

  showGraph: (ontology) ->
    @detailRegion.show new AttributeListLayout({ model: ontology })

# # # # #

module.exports = OntologyListLayout
