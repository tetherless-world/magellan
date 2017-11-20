# FlashChild class definition
# Defines a Marionette.LayoutView to display a FlashModel instance
# This view auto-dismisses after the timeout defined in the FlashModel instance
class FlashChild extends Marionette.LayoutView
  className: 'row'
  template: require './templates/flash_child'

  attributes:
    style: 'display:none;'

  ui:
    close: '[data-click=dismiss]'

  events:
    'click @ui.close': 'dismiss'

  onShow: ->
    timeout = @model.get('timeout')
    setTimeout( @dismiss, timeout )

  onAttach: ->
    @$el.fadeIn()

  remove: ->
    @$el.slideToggle( =>
      Marionette.LayoutView.prototype.remove.call(@)
    )

  dismiss: =>
    @model.collection?.remove( @model )

# FlashList class definition
# Defines a Marionette.CollectionView to the list of Flashes
class FlashList extends Marionette.CollectionView
  className: 'container-fluid'
  childView: FlashChild

# # # # #

module.exports = FlashList
