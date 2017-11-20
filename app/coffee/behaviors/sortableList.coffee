
# SortableList Behavior definition
# Works with SortableChild Behavior
class SortableList extends Mn.Behavior

  # Defines the reorderCollection method on the view
  # to which the behavior is assigned
  initialize: ->
    @view.reorderCollection = => @reorderCollection()

  onRender: ->

    # Initializes Sortable container
    Sortable.create @view.el,
      handle:       @options.handle || '.sortable'
      animation:    @options.animation || 250
      onEnd: (e) => @reorderCollection()

  # reorderCollection
  # Invoked after sorting has completed
  reorderCollection: =>

    # Triggers order events on CollectionView childView $els
    order = 1
    for el in @view.$el[0].children
      $(el).trigger('sorted',order)
      order++

# # # # #

module.exports = SortableList
