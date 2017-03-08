require './engine'
RecordListView = require './recordList'
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
    headerView.on 'clear', => jQuery.clearFacets()
    @headerRegion.show headerView

    # Initializes FacetView
    setTimeout(@initFacetView, 100)

    # Bypass List selector
    listView = new RecordListView({ collection: @collection })
    listView.on 'childview:show:relation', (view, uri) => @showItem(uri)
    @listRegion.show listView

  showItem: (uri) =>

    # Gets item from collection
    item = @options.items.get(uri)
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

    settings =
      items: @options.items.toJSON()
      facets: @options.facetCollection.getEnabled()
      resultElement: '#results'
      facetElement:  '#facets'
      resultTemplate: 'placeholder'
      resultTemplateBypass: (item) => @collection.add(item)
      beforeResultRender: => @collection.reset([])

      # TODO - implement pagination
      # paginationCount: 50

      # TODO - adjust ordering of elements
      # TODO - abstract into OrderModel, Settings Model??
      orderByOptions:
        'dmo:type':   'DMO Type'
        'label':      'Label'

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
