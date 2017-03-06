
# HeaderView class definition
# Defines a simbple view for displaying the
# header of the application. The header displays
# the authenticated user and
# manages toggling the SidebarComponent's view
class HeaderView extends Marionette.LayoutView
  template: require './templates/header'
  className: 'nav navbar navbar-static-top navbar-light'

  events:
    'click .navbar-brand': 'toggleSidebar'

  toggleSidebar: ->
    Backbone.Radio.channel('sidebar').trigger('toggle')

# # # # #

module.exports = HeaderView
