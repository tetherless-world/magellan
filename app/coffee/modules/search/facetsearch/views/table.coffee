
class RecordTable extends Mn.LayoutView
  template: require './templates/table'
  tagName:    'table'
  className:  'table table-responsive attr-table'

  ui:
    toggleAggregates: '[data-click=toggle-aggegates]'

  events:
    'click @ui.toggleAggregates': 'toggleAggregates'

  # TOGGLE AGGREGATES
  aggregatesShown: false
  toggleAggregates: ->
    if @aggregatesShown
      @ui.toggleAggregates.text('Show Aggregates')
      @$('[data-toggle=aggregates]').hide()
      @aggregatesShown = false

    else
      @ui.toggleAggregates.text('Hide Aggregates')
      @$('[data-toggle=aggregates]').show()
      @aggregatesShown = true

  serializeData: ->
    d = super
    return { data: d }

# # # # #

module.exports = RecordTable
