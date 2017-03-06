
class FacetSearchHeader extends Mn.LayoutView
  template: require './templates/header'
  className: 'card card-block'

  # ui:
  #   settings: '[data-click=settings]'

  # events:
  #   'click @ui.settings': 'showSettingsView'

  # showSettingsView: -> # TODO - should be a trigger.
  #   console.log 'SHOW SETTINGS!'

# # # # #

module.exports = FacetSearchHeader
