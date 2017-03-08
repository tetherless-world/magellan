
class FacetSearchHeader extends Mn.LayoutView
  template: require './templates/header'
  className: 'card card-block'

  ui:
    clear: '[data-click=clear]'

  triggers:
    'click @ui.clear': 'clear'

# # # # #

module.exports = FacetSearchHeader
