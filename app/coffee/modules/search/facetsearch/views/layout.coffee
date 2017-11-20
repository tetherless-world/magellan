require './engine'
RecordList = require './recordList'
RecordListLayout = require './recordListLayout'
DetailView = require './itemDetail'
HeaderView = require './header'

# # # # #

class FacetedViewLayout extends Mn.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  events:
    'click h3.facettitle': 'toggleCollapseFacet'

  toggleCollapseFacet: (e) ->
    $(e.currentTarget).parents('.facetsearch').toggleClass('active')

  regions:
    listRegion:   '[data-region=record-list]'
    headerRegion: '[data-region=header]'
    detailRegion: '[data-region=detail]'

  onRender: ->

    # Shows HeaderView
    # TODO - rename to ControlsView / @controlsRegion
    headerView = new HeaderView({ model: @model })

    # Clear Filters
    headerView.on 'clear', => jQuery.clearFacets()

    # View Records as List or Viewer
    headerView.on 'list', @showRecordList
    headerView.on 'viewer', @showRecordListLayout

    # Shows the HeaderView in the headerRegion
    @headerRegion.show headerView

    # Initializes FacetView
    setTimeout(@initFacetView, 100)

    # Bypass List selector
    # @showRecordListLayout()
    @showRecordList()

  showRecordList: =>
    listView = new RecordList({ collection: @collection })
    listView.on 'childview:show:relation', (view, id) => @showItem(id)
    # listView.on 'show:underlay', => @$('.drift-underlay').addClass('active')
    # listView.on 'hide:underlay', => @$('.drift-underlay').removeClass('active')
    @listRegion.show listView

  showRecordListLayout: =>
    listView = new RecordListLayout({ collection: @collection })
    listView.on 'childview:show:relation', (view, id) => @showItem(id)
    @listRegion.show listView

  showItem: (id) =>

    # Empty variable to store found item
    item = null

    # Finds item
    for el in @options.items.models
      if el.get('data')['@id'] == id
        item = el
        break

    # Short circuits if item isn't defined
    return unless item

    # Closes, if @detailView is showing the same model
    return @detailView.trigger('hide') if @detailView && @detailView.model.id == item.id

    # Init detail view & NodeModel
    @detailView = new DetailView({ model: item })

    # Show background for image zoom
    @detailView.on 'show:underlay', => @$('.drift-underlay').addClass('active')
    @detailView.on 'hide:underlay', => @$('.drift-underlay').removeClass('active')

    # Listener for clicking nested file
    # TODO - re-integrate this
    # Invokes this method with the child_id
    # @detailView.on 'show:child', (old_id, child_id) => @showDetail(child_id)

    # Removes .active CSS from node on hide
    # Destroys the view
    @detailView.on 'hide', =>
      @detailRegion.$el.removeClass('active')
      setTimeout( =>
        @detailRegion.empty()
        delete @detailView
      100)

    # Shows detail view and adds .activeCss
    @detailRegion.show(@detailView)
    @detailRegion.$el.addClass('active')

  initFacetView: =>

    # Isolates facet data
    facets = @options.facetCollection.getEnabled()

    # Generates orderByOptions
    orderByOptions = {}
    orderByOptions[f.attribute] = f.label for f in facets

    settings =
      items: @options.items.toJSON()
      facets: facets
      resultElement: '#results'
      facetElement:  '#facets'
      resultTemplate: 'placeholder'
      resultTemplateBypass: (item) => @collection.add(item) # TODO - PERFORMANCE
      beforeResultRender: => @collection.reset([])          # TODO - PERFORMANCE

      # TODO - implement pagination
      paginationCount: 50

      # TODO - adjust ordering of elements
      # TODO - this is broken and it must be re-worked.
      orderByOptions: orderByOptions

      # TODO - this should be implemented..
      # TODO - what does this do????
      # TODO - abstract into SortModel?
      # facetSortOption: 'continent': [
      #   'North America'
      #   'South America'
      # ]

    # use them!
    # window.settings = settings
    state = $.facetelize(settings)

    return

# # # # #

module.exports = FacetedViewLayout
