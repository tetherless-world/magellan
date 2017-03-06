
class ClickableRelations extends Marionette.Behavior

  ui:
    showRelation: '[data-relation]'

  events:
    'click @ui.showRelation': 'showRelation'

  showRelation: (e) ->
    e.preventDefault()
    relatedId = $(e.currentTarget).data('relation')
    @view.trigger('show:relation', relatedId)

# # # # #

module.exports = ClickableRelations
