
class SettingsLayoutView extends Marionette.LayoutView
  template: require './templates/layout'
  className: 'container d-flex align-items-center h-100 flex-column',

  behaviors:
    Confirmations:
      message:      'Are you sure you want to flush the database?'
      confirmIcon:  'fa-trash'
      confirmText:  'FLUSH DATABASE'
      confirmCss:   'btn-danger'

  ui:
    confirmationTrigger: '[data-click=confirm]'

  # TODO - remove references to window.db
  # These calls should hit the DB service with a close and delete request.
  onConfirmed: ->
    Backbone.Radio.channel('flash').trigger('success', { message: 'Database flushed.' })

    # TODO - this should be functional
    # window.db.close().then () =>
    #   window.db.delete().then () =>
    #     Backbone.Radio.channel('flash').trigger('success', { message: 'Database flushed.' })

# # # # #

module.exports = SettingsLayoutView
