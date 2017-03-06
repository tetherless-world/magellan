LayoutView  = require './views/layout'

# # # # #

class IFrameRoute extends require 'hn_routing/lib/route'

  title: ->
    return 'Magellan - ' + @options.title

  breadcrumbs: ->
    return [{ text: @options.breadcrumb }]

  render: ->
    @container.show new LayoutView({ iframeURL: @options.iFrameURL })

# # # # #

module.exports = IFrameRoute
