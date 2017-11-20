
class FacetSearchHeader extends Mn.LayoutView
  template: require './templates/header'
  className: 'card card-body'

  ui:
    clear:  '[data-click=clear]'
    list:   '[data-click=list]'
    viewer: '[data-click=viewer]'

  triggers:
    'click @ui.clear':  'clear'
    'click @ui.list':   'list'
    'click @ui.viewer': 'viewer'

# # # # #

module.exports = FacetSearchHeader
