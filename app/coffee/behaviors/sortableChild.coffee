
# SortableChild Behavior definition
# Works with SortableList Behavior
class SortableChild extends Mn.Behavior

  events:
    'sorted': 'onSorted'

  onSorted: (e, order) ->
    @view.model.set('order', order)

# # # # #

module.exports = SortableChild
