LayoutView  = require './views/layout'

# # # # #

class SearchSettingsRoute extends require 'hn_routing/lib/route'

  title: 'Settings'

  breadcrumbs: [
    { href: '#', text: 'Home' }
    { text: 'Settings' }
  ]

  fetch: ->
    @model = Backbone.Radio.channel('settings').request('model')

  render: ->
    @container.show new LayoutView({ model: @model })

# # # # #

module.exports = SearchSettingsRoute
