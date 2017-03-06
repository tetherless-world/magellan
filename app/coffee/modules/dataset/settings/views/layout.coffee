FacetList = require './facetList'

# # # # #

class SettingsLayoutView extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  regions:
    listRegion: '[data-region=list]'

  onShow: ->
    @listRegion.show new FacetList({ collection: @collection })

# # # # #

module.exports = SettingsLayoutView
