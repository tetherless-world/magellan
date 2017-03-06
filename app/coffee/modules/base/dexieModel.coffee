

# DexieModel class definition
# Defines a Backbone.Model class that can interface
# with Dexie.js rather than a REST API
class DexieModel extends Backbone.Model

  defaults:
    foo: 'bar'

  initialize: (options={}) ->
    console.log 'NEW DEXIE MODEL'
    console.log @
    console.log options
    console.log @urlRoot

# # # # #

# Extends DexieModel
class FacetModel extends DexieModel

  # URL ROOT == TABLE
  urlRoot: 'facets'

  defaults:
    id:     'dmo:resultOf'
    label:  'Result Of'

# # # # #

# Makes accessible
window.FacetModel = FacetModel

# New Instance
window.facet = new FacetModel()
