LdViewer = require 'lib/views/json_graph'
JsonViewer = require 'lib/views/json_viewer'

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

class AttributeDetail extends require 'lib/views/nav'

  className: 'col-lg-12'

  navItems: [
    { icon: 'fa-sitemap', text: 'Graph',  trigger: 'graph', default: true }
    { icon: 'fa-code',    text: 'JSON',   trigger: 'json' }
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

class OntologyDagre extends require 'lib/views/dagre'

  onRender: ->
    elements = {
      nodes: []
      edges: []
    }

    # Nodes to be added to the graph
    datapoints = @model.get('graph')

    # Finds root node in Ontology
    # TODO - not sure if this will be needed
    # rootNode = null
    # for n in datapoints
    #   if n['@type'] == 'owl:Ontology'
    #     rootNode = n
    #     break

    # Gets the nodes and edges
    _.each(datapoints, (n) =>

      # Debug
      # console.log n

      # Pushes each node into the list
      elements.nodes.push({ data: { id: n['@id'], label: n['rdfs:label'] || n['dc:title'] || n['@id'] } })

      # Iterates over each node's attributes
      for k, v of n

        # Adds `prop: { '@id': 'xyz' }` elements
        if _.isObject(v) && v['@id']
          elements.edges.push({ data: { label: k, source: n['@id'], target: v['@id'] } })

        # Handles Arrays of `prop: [{ '@id': 'xyz' }, ...]` elements
        if Array.isArray(v)
          for each in v
            if each['@id']
              elements.edges.push({ data: { label: k, source: n['@id'], target: each['@id'] } })

        # Handles Lists ('@list')
        if _.isObject(v) && v['@list']
          for each in v['@list']
            if each['@id']
              elements.edges.push({ data: { label: k, source: n['@id'], target: each['@id'] } })

    )

    # Renders the graph
    setTimeout( =>
      @renderGraph(elements)
    , 500 )

# # # # #

class OntologyViewSelector extends require 'lib/views/nav'
  template: require './templates/ontology_view_selector'
  className: 'col-lg-12'

  navItems: [
    { icon: 'fa-list-alt', text: 'Attributes', trigger: 'attrs', default: true }
    { icon: 'fa-sitemap', text: 'Graph',  trigger: 'graph' }
  ]

  navEvents:
    'attrs':    'showAttrs'
    'graph':    'showGraph'

  showAttrs: ->
    @contentRegion.show new AttributeListLayout({ model: @model })

  showGraph: ->
    @contentRegion.show new OntologyDagre({ model: @model })


# # # # #

class OntologyListLayout extends Mn.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    listRegion: '[data-region=list]'
    detailRegion: '[data-region=detail]'

  onShow: -> # TODO - abstract into SelectableList helper?
    listView = new OntologyList({ collection: @collection })
    listView.on 'childview:selected', (view) => @showGraph(view.model)
    @listRegion.show listView
    @collection.at(0)?.trigger('selected')

  showGraph: (ontology) ->
    @detailRegion.show new OntologyViewSelector({ model: ontology })

# # # # #

module.exports = OntologyListLayout
