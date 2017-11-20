require './factory'

WelcomeRoute = require './welcome/route'
SettingsRoute = require './settings/route'

# # # # #

# MainRouter class definition
class MainRouter extends require 'hn_routing/lib/router'

  routes:
    '(/)':          'welcome'
    'settings(/)':  'settings'

  welcome: ->
    new WelcomeRoute({ container: @container })

  settings: ->
    new SettingsRoute({ container: @container })

# # # # #

module.exports = MainRouter
