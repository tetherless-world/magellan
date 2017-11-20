
class LoadingView extends Mn.LayoutView
  template: require './templates/loading'
  className: 'loading-view'

  ui:
    message: '[data-display=message]'

  updateMessage: (msg) ->
    @ui.message.text(msg)

# # # # #

module.exports = LoadingView
