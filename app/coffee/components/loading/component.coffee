LoadingView = require './views/layout'

# # # # #

class LoadingComponent extends Mn.Service

  initialize: (options = {}) ->
    @container  = options.container

  radioEvents:
    'loading ready':  'onReady'
    'loading show':   'showLoading'
    'loading hide':   'hideLoading'

  showLoading: (message='LOADING') ->
    $('.loading-region').addClass('active')
    @view.updateMessage(message)

  hideLoading: ->
    $('.loading-region').removeClass('active')

  onReady: ->
    unless @view
      @view = new LoadingView()
      @container.show(@view)

# # # # #

module.exports = LoadingComponent
