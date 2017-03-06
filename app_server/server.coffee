# TODO - clean this up
Dexie = require './dexie_source'
$ = jquery = require './jquery'
_ = require './underscore'
Backbone = require './backbone'

# # # # #

# Defines ServerRadio
ServerRadio = _.extend({}, Backbone.Events)

# Attaches ServerRadio to window.global
# (shared object between client/background)
window.global.ServerRadio = ServerRadio

# Populates database from Client application
# TODO - pass in options
ServerRadio.on 'populate', =>
  console.log 'START POPULATING DATABASE'

# # # # #

# ServerRadio Events (triggers changes on client)

# ServerRadio - FileOpen routine
# ServerRadio.trigger('file:open:start')
# ServerRadio.trigger('file:open:progress')
# ServerRadio.trigger('file:open:success')
# ServerRadio.trigger('file:open:error')

# ServerRadio - Populate DB
# ServerRadio.trigger('populate:start')
# ServerRadio.trigger('populate:success')
# ServerRadio.trigger('populate:error')

# TODO - Parse Facets should be handled in a different file
# Database population should not be tied tightly to FacetParsing
# ServerRadio - Parse Facets
# ServerRadio.trigger('parse:facets:start')
# ServerRadio.trigger('parse:facets:success')
# ServerRadio.trigger('parse:facets:error')

# # # # # #

# # New DB
# db = new Dexie('dexie_database')
# console.log 'NEW DB!'
# console.log db

# # # # # #

# # Loads data into db
# data = require './data'
# console.log data.items.length

# # # # # #

# # Put some data into it
# db.results.bulkPut(data.items)
# .then () ->
#   console.log 'BULK PUT SUCCESS'
#   # window.global.db = db
#   # initBrowser()
#   # initFacetCount()
#   return

# .catch (error) ->
#   console.log 'BULK PUT ERROR', error

# # # # # #







# window.db = db

# # Defines storage schema
# db.version(1).stores
#   results: 'id,label'

# # # # # #

# query = {
#   "dmoType": [
#     "Result"
#   ],
#   "FileType": [
#     "Image"
#   ]
# }

# # # # # #

# # window.global.db.results.filter(window.global.filterFunction).toArray().then(function(resp){console.log(resp)})

# # # # # #

# filterFunction = (item) =>
#   # query = window.global.appliedFilters
#   query = window.query

#   # Bool for _.select / _.filter
#   filtersApply = true

#   # Iterates over each filter
#   _.each query, (filter, facet) ->

#     if $.isArray(item[facet])
#       inters = _.intersection(item[facet], filter)
#       if inters.length == 0
#         filtersApply = false

#     else
#       if filter.length and _.indexOf(filter, item[facet]) == -1
#         filtersApply = false

#   # Returns
#   return filtersApply

# # # # # #

# # TODO - remove reference from global?
# # TODO - order
# # TODO - page number & size
# window.global.queryDexie = (query) =>
#   window.query = query
#   console.log 'Querying...'
#   return db.results.filter(filterFunction).limit(20).toArray()

# # # # # #

# # FacetStore
# facetStore = {}

# # Placeholder facets
# facets =
#   'dmoType':    'DMO Type'
#   'oreType':    'Curation Level'
#   'arkType':    'Archive Level'
#   'isResultOf': 'Coupon'
#   'resultType':  'Results Type'
#   'hasResult':  'Results Collection'
#   'aggregates': 'Aggregates'
#   'belongsTo': 'Belongs To'
#   'FileType':   'File Type'

# initFacetCount = (items) ->

#   # Iterate over each facet
#   # Instantiates empty facet object in facetStore registry
#   _.each facets, (facettitle, facet) ->
#     facetStore[facet] = {}
#     return

#   # TODO - this should be the query - which should initially return
#   # the unfiltered list paginated to 20-30 items

#   # Iterate over each item
#   _.each items, (item) ->

#     # intialize the count to be zero
#     _.each facets, (facettitle, facet) ->
#       # ???
#       if $.isArray(item[facet])
#         #
#         _.each item[facet], (facetitem) ->
#           facetStore[facet][facetitem] = facetStore[facet][facetitem] or
#             count: 0
#             id: _.uniqueId('facet_')
#           return
#       #
#       else
#         #
#         if item[facet] != undefined
#           facetStore[facet][item[facet]] = facetStore[facet][item[facet]] or
#             count: 0
#             id: _.uniqueId('facet_')
#       return
#     return

#   console.log 'DONE HERE???'
#   window.global.facets = facets
#   window.global.facetStore = facetStore

#   return

# resetFacetCount = ->
#   console.log 'RESETTING FACET COUNT'
#   _.each facetStore, (items, facetname) ->
#     _.each items, (value, itemname) ->
#       facetStore[facetname][itemname].count = 0

# initBrowser = ->
#   db.results.toArray()
#   .then (items) =>
#     resetFacetCount()
#     initFacetCount(items)

# # # # # # # # # #

