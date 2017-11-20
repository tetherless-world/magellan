
class BreadcrumbChild extends Mn.LayoutView
  tagName: 'li'
  template: require './templates/breadcrumb_child'

  className: ->
    css = 'breadcrumb-item'
    return css + ' active' unless @model.get('href')
    return css

# # # # #

class BreadcrumbList extends Mn.CollectionView
  className: 'breadcrumb mb-0 bg-light'
  tagName: 'ol'
  childView: BreadcrumbChild

  attributes:
    role: 'navigation'

# # # # #

module.exports = BreadcrumbList
