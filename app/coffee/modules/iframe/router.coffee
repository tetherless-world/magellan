IFrameRoute = require './iframe/route'

# # # # #

class IFrameRouter extends require 'hn_routing/lib/router'

  routes:
    'home(/)':  'home'
    'data(/)':  'data'

  home: ->
    @_showIframe({ url: 'https://manufacturing.xdataproxy.com', title: 'Home', breadcrumb: 'Home' })

  data: ->
    @_showIframe({ url: 'https://manufacturing.xdataproxy.com/data', title: 'Data', breadcrumb: 'Data' })

  _showIframe: (opts={}) ->
    new IFrameRoute({ container: @container, iFrameURL: opts.url, title: opts.title, breadcrumb: opts.breadcrumb })

# # # # #

module.exports = IFrameRouter
