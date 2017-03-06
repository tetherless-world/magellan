
class FacetModel extends Backbone.Model
  url: 'facet'

# # # # #

class FacetCollection extends Backbone.Collection
  model: FacetModel
  comparator: 'order' # TODO - sort by 'ORDER' attribute

  getEnabled: ->
    @sort()
    facets = []
    facets.push(facet.toJSON()) for facet in @where({ enabled: true })
    return facets

# # # # #

module.exports = FacetCollection
