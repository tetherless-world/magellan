
# TODO - this should be generalized to flush both data and views attributes from datapoint models
class ResetRulesView extends Mn.LayoutView
  template: require './templates/reset_rules'
  className: 'card card-body'

  behaviors:
    CancelButton: {}

    Confirmations:
      message:      'Are you sure you want to reset this dataset?'
      confirmIcon:  'fa-refresh'
      confirmText:  'RESET'
      confirmCss:   'btn-danger'

    Flashes:
      success:
        message:  'Successfully reset dataset.'

  ui:
    confirmationTrigger:  '[data-click=submit]'

  onCancel: ->
    @trigger 'cancel'

  onConfirmed: ->
    @model.fetchDatapoints().then (datapoints) =>

      datapoints.resetTargetObject(@options.target_object).then () =>

        @model.regenerateFacets().then () =>

          # Hides Loading component
          Backbone.Radio.channel('loading').trigger('hide')

          # Shows success message
          @flashSuccess()

          # Triggers 'success' event
          @trigger('success')

# # # # #

module.exports = ResetRulesView
