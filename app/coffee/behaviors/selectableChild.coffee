
class SelectableChild extends Marionette.Behavior

  css:
    active: 'active'

  events:
    'click':  'onClick'

  modelEvents:
    'selected': 'onClick'

  # Selects activeModel on render
  onRender: ->
    return unless @options.setActive
    @$el.trigger('click') if @view.model.collection._activeModel == @view.model.id

  # Sets activeModel on click
  onSelected: ->
    return unless @options.setActive
    @view.model.collection._setActiveModel(@view.model.id)
    @view.model.collection.trigger('selected:model', @view.model)

  # Invoked when clicked
  onClick: (e) ->
    # Bypass behavior with custom onClick callback
    return @view.onClick(e) if @view.onClick

    # Prevent double-click unless specificed
    e?.preventDefault() unless @options.doubleClick

    # Return if element is currently selected
    return if @$el.hasClass(@css.active)

    # Prevent deafult and trigger selected
    e?.preventDefault()
    @view.triggerMethod 'selected'
    @$el.addClass(@css.active).siblings().removeClass(@css.active)

# # # # #

module.exports = SelectableChild
