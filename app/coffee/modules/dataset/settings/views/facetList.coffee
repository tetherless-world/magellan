
# Swaps models at supplied indicies & resets collection
# TODO - rather than swapping indicies we should just PUSH the list accordingly.
swapIndicies = (collection, oldIndex, newIndex) ->

  # Swaps model indicies
  collection.at(oldIndex).set('order', newIndex)
  collection.at(newIndex).set('order', oldIndex)

  # TODO - better way to handle this?
  # models = collection.models
  # collection.reset(models)

# # # # #

class FacetChild extends Mn.LayoutView
  template: require './templates/facet_child'
  className: 'list-group-item'

  ui:
    checkbox: 'input[type=checkbox]'

  events:
    'sortable:end': 'onSortableEnd'
    'switchChange.bootstrapSwitch @ui.checkbox':  'onEnabledChange'

  onEnabledChange: ->
    @model.set(Backbone.Syphon.serialize(@))

  onRender: ->
    Backbone.Syphon.deserialize( @, @model.attributes )
    @ui.checkbox.bootstrapSwitch({ size: 'small', onText: 'Enabled', offText: 'Disabled' })

  onSortableEnd: (e, ev) ->
    # TODO - return if ev.oldIndex / newIndex == undefined
    swapIndicies(@model.collection, ev.oldIndex, ev.newIndex)

# # # # #

class FacetList extends Mn.CollectionView
  className: 'list-group'
  childView: FacetChild

  onRender: ->

    # Initializes Sortable container
    Sortable.create @el,
      handle: '.handle'
      animation: 250
      onEnd: (e) => $(e.item).trigger('sortable:end', e)

# # # # #

module.exports = FacetList
