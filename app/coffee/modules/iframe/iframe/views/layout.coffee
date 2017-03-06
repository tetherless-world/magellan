
class IFrameView extends Mn.LayoutView
  template: require './templates/iframe'
  className: 'container-fluid'

  templateHelpers: ->
    return { iframeURL: @options.iframeURL }

# # # # #

module.exports = IFrameView
