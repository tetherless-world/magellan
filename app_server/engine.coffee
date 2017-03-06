
###*
# Please note that when passing in custom templates for
# listItemTemplate and orderByTemplate to keep the classes as
# they are used in the code at other locations as well.
###

defaults =

  # Placeholder
  items: [
    {a: 2,b: 1,c: 2}
    {a: 2,b: 2,c: 1}
    {a: 1,b: 1,c: 1}
    {a: 3,b: 3,c: 1}
  ]

  # Placeholder
  facets:
    'a': 'Title A'
    'b': 'Title B'
    'c': 'Title C'

  resultSelector: '#results' # REMOVE
  facetSelector: '#facets' # REMOVE
  facetContainer: '<div class=facetsearch id=<%= id %> ></div>' # REMOVE
  facetTitleTemplate: '<h3 class=facettitle><%= title %></h3>' # REMOVE
  facetListContainer: '<div class=facetlist></div>' # REMOVE
  listItemTemplate: '<div class=facetitem id="<%= id %>"><%= name %> <span class=facetitemcount>(<%= count %>)</span></div>' # REMOVE
  bottomContainer: '<div class=bottomline></div>' # REMOVE
  orderByTemplate: '<div class=orderby><span class="orderby-title">Sort by: </span><ul><% _.each(options, function(value, key) { %>' + '<li class=orderbyitem id=orderby_<%= key %>>' + '<%= value %> </li> <% }); %></ul></div>' # REMOVE
  countTemplate: '<div class=facettotalcount>Results</div>'
  deselectTemplate: '<div class=deselectstartover>Deselect all filters</div>'
  resultTemplate: '<div class=facetresultbox><%= name %></div>'
  resultTemplateBypass: null
  noResults: '<div class=results>Sorry, but no items match these criteria</div>'

  # Placeholder
  orderByOptions:
    'a': 'by A'
    'b': 'by B'
    'RANDOM': 'by random'

  # State
  state:
    orderBy: false
    filters: {}

  showMoreTemplate: '<a id=showmorebutton>Show more</a>' # REMOVE
  enablePagination: true # REMOVE
  paginationCount: 20 # REMOVE - should be default attribute on state

###*
# This is the first function / variable that gets exported into the
# jQuery namespace. Pass in your own settings (see above) to initialize
# the faceted search
###

settings = {}

###*
# resets the facet count
###
resetFacetCount = ->
  _.each settings.facetStore, (items, facetname) ->
    _.each items, (value, itemname) ->
      settings.facetStore[facetname][itemname].count = 0
      return
    return
  return

###*
# Filters all items from the settings according to the currently
# set filters and stores the results in the settings.currentResults.
# The number of items in each filter from each facet is also updated
###
filter = ->

  # Stores applied filters
  appliedFilters = {}
  # first apply the filters to the items
  settings.currentResults = _.select(settings.items, (item) ->
    # Bool for _.select / _.filter
    filtersApply = true
    # Iterates over each filter
    _.each settings.state.filters, (filter, facet) ->
      console.log filter
      console.log facet
      appliedFilters[facet] = filter
      if $.isArray(item[facet])
        inters = _.intersection(item[facet], filter)
        if inters.length == 0
          filtersApply = false
      else
        if filter.length and _.indexOf(filter, item[facet]) == -1
          filtersApply = false
      return
    filtersApply
  )

  # DEXIE DATABASE CALL
  # TODO - remove
  # if window.global
  #   window.dexiePromise = window.global.queryDexie(appliedFilters)

  # Update the count for each facet and item:
  # intialize the count to be zero
  resetFacetCount()

  # # # # #
  # TODO - this should be moved to the server
  #

  # then reduce the items to get the current count for each facet
  _.each settings.facets, (facettitle, facet) ->
    _.each settings.currentResults, (item) ->
      if $.isArray(item[facet])
        _.each item[facet], (facetitem) ->
          settings.facetStore[facet][facetitem].count += 1
          return
      else
        if item[facet] != undefined
          settings.facetStore[facet][item[facet]].count += 1
      return
    return
  # remove confusing 0 from facets where a filter has been set
  _.each settings.state.filters, (filters, facettitle) ->
    _.each settings.facetStore[facettitle], (facet) ->
      if facet.count == 0 and settings.state.filters[facettitle].length
        facet.count = '+'
      return
    return
  settings.state.shownResults = 0
  return

  #
  #
  # # # # #

###*
# Orders the currentResults according to the settings.state.orderBy variable
###

order = ->
  if settings.state.orderBy
    $('.activeorderby').removeClass 'activeorderby'
    $('#orderby_' + settings.state.orderBy).addClass 'activeorderby'
    settings.currentResults = _.sortBy(settings.currentResults, (item) ->
      if settings.state.orderBy == 'RANDOM'
        Math.random() * 10000
      else
        item[settings.state.orderBy]
    )
  return

###*
# The given facetname and filtername are activated or deactivated
# depending on what they were beforehand. This causes the items to
# be filtered again and the UI is updated accordingly.
###

toggleFilter = (key, value) ->
  settings.state.filters[key] = settings.state.filters[key] or []
  if _.indexOf(settings.state.filters[key], value) == -1
    settings.state.filters[key].push value
  else
    settings.state.filters[key] = _.without(settings.state.filters[key], value)
    if settings.state.filters[key].length == 0
      delete settings.state.filters[key]
  filter()
  return

###*
# The following section contains the presentation of the faceted search
###

###*
# This function is only called once, it creates the facets ui.
###

createFacetUI = ->
  itemtemplate = _.template(settings.listItemTemplate)
  titletemplate = _.template(settings.facetTitleTemplate)
  containertemplate = _.template(settings.facetContainer)
  $(settings.facetSelector).html ''
  _.each settings.facets, (facettitle, facet) ->
    facetHtml = $(containertemplate(id: facet))
    facetItem = title: facettitle
    facetItemHtml = $(titletemplate(facetItem))
    facetHtml.append facetItemHtml
    facetlist = $(settings.facetListContainer)
    _.each settings.facetStore[facet], (filter, filtername) ->
      item =
        id: filter.id
        name: filtername
        count: filter.count
      filteritem = $(itemtemplate(item))
      if _.indexOf(settings.state.filters[facet], filtername) >= 0
        filteritem.addClass 'activefacet'
      facetlist.append filteritem
      return
    facetHtml.append facetlist
    $(settings.facetSelector).append facetHtml
    return
  # add the click event handler to each facet item:
  $('.facetitem').click (event) ->
    `var filter`
    filter = getFilterById(@id)
    toggleFilter filter.facetname, filter.filtername
    $(settings.facetSelector).trigger 'facetedsearchfacetclick', filter
    order()
    updateFacetUI()
    updateResults()
    return
  # Append total result count
  bottom = $(settings.bottomContainer)
  countHtml = _.template(settings.countTemplate, count: settings.currentResults.length or 0)
  $(bottom).append countHtml
  # generate the "order by" options:
  ordertemplate = _.template(settings.orderByTemplate)
  itemHtml = $(ordertemplate('options': settings.orderByOptions))
  $(bottom).append itemHtml
  $(settings.facetSelector).append bottom
  $('.orderbyitem').each ->
    id = @id.substr(8)
    if settings.state.orderBy == id
      $(this).addClass 'activeorderby'
    return
  # add the click event handler to each "order by" item:
  $('.orderbyitem').click (event) ->
    id = @id.substr(8)
    settings.state.orderBy = id
    $(settings.facetSelector).trigger 'facetedsearchorderby', id
    settings.state.shownResults = 0
    order()
    updateResults()
    return
  # Append deselect filters button
  deselect = $(settings.deselectTemplate).click((event) ->
    settings.state.filters = {}
    jQuery.facetUpdate()
    return
  )
  $(bottom).append deselect
  $(settings.facetSelector).trigger 'facetuicreated'
  return

###*
# get a facetname and filtername by the unique id that is created in the beginning
###

getFilterById = (id) ->
  result = false
  _.each settings.facetStore, (facet, facetname) ->
    _.each facet, (filter, filtername) ->
      if filter.id == id
        result =
          'facetname': facetname
          'filtername': filtername
      return
    return
  result

###*
# This function is only called whenever a filter has been added or removed
# It adds a class to the active filters and shows the correct number for each
###
updateFacetUI = ->
  itemtemplate = _.template(settings.listItemTemplate)
  _.each settings.facetStore, (facet, facetname) ->
    _.each facet, (filter, filtername) ->
      item =
        id: filter.id
        name: filtername
        count: filter.count
      filteritem = $(itemtemplate(item)).html()
      $('#' + filter.id).html filteritem
      if settings.state.filters[facetname] and _.indexOf(settings.state.filters[facetname], filtername) >= 0
        $('#' + filter.id).addClass 'activefacet'
      else
        $('#' + filter.id).removeClass 'activefacet'
      return
    return
  countHtml = _.template(settings.countTemplate, count: settings.currentResults.length)
  $(settings.facetSelector + ' .facettotalcount').replaceWith countHtml
  return

###*
# Updates the the list of results according to the filters that have been set
###
updateResults = ->
  $(settings.resultSelector).html if settings.currentResults.length == 0 then settings.noResults else ''
  showMoreResults()
  return

# ?????
showMoreResults = ->
  `var itemHtml`
  # ???
  showNowCount = if settings.enablePagination then Math.min(settings.currentResults.length - (settings.state.shownResults), settings.paginationCount) else settings.currentResults.length
  itemHtml = ''
  # TODO - remove
  if settings.beforeResultRender
    settings.beforeResultRender()
  # Item Template (remove)
  template = _.template(settings.resultTemplate)
  i = settings.state.shownResults
  while i < settings.state.shownResults + showNowCount
    item = $.extend(settings.currentResults[i],
      totalItemNr: i
      batchItemNr: i - (settings.state.shownResults)
      batchItemCount: showNowCount)
    if settings.resultTemplateBypass
      settings.resultTemplateBypass item
    else
      itemHtml = itemHtml + template(item)
    i++
  # Appends itemHTML
  $(settings.resultSelector).append itemHtml
  # Append MoreButton
  if !moreButton
    moreButton = $(settings.showMoreTemplate).click(showMoreResults)
    $(settings.resultSelector).after moreButton
  # ???/
  if settings.state.shownResults == 0
    moreButton.show()
  # ???
  settings.state.shownResults += showNowCount
  if settings.state.shownResults == settings.currentResults.length
    $(moreButton).hide()
  # Remove
  $(settings.resultSelector).trigger 'facetedsearchresultupdate'
  return

# # # # # # # # # # #

$.facetelize = (usersettings) ->

  # Settings
  $.extend settings, defaults, usersettings

  # Settings defaults
  settings.currentResults = []
  settings.facetStore = {}

  # TODO
  filter()

  # TODO
  order()

  # TODO
  updateResults()

  # TODO
  createFacetUI()

###*
# This is the second function / variable that gets exported into the
# jQuery namespace. Use it to update everything if you messed with
# the settings object
###
jQuery.facetUpdate = ->
  filter()
  order()
  updateFacetUI()
  updateResults()
  return

# Shows more results
moreButton = undefined
return
