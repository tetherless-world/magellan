
# UnsupportedComponent class definition
# Defines an interface to display a 'not supported'
# message in unsupported browser environments
class UnsupportedComponent extends Mn.Service

  radioEvents:
    'unsupported show': 'showUnsupported'

  showUnsupported: ->

    unsupportedConfirm =
      message:      'Magellan only works in Google Chrome.<br>More browsers coming soon.'
      messageCss:   'text-center'

      denyIcon:     'fa-sign-out'
      denyText:     'Leave'
      denyCss:      'btn-outline-secondary'

      confirmIcon:  'fa-download'
      confirmText:  'Download Chrome'
      confirmCss:   'btn-outline-success'

    Radio.channel('confirm').request('show', unsupportedConfirm).then (confirmView) =>
      confirmView.on 'destroy', => Radio.channel('app').trigger('redirect', 'https://tw.rpi.edu/')
      confirmView.on 'denied', => Radio.channel('app').trigger('redirect', 'https://tw.rpi.edu/')
      confirmView.on 'confirmed', => Radio.channel('app').trigger('redirect', 'http://www.google.com/chrome/browser')

# # # # #

module.exports = UnsupportedComponent
