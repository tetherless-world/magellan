
class SettingsLayoutView extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container-fluid'

  onRender: ->
    console.log 'SETTINGS LAYOUT'

# # # # #

module.exports = SettingsLayoutView
