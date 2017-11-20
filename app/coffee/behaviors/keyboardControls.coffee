# NOTE - this behavior has not been tested with multiple views simultaneously
# Enables view callbacks to be triggered by keyboard input
class KeyboardControls extends Mn.Behavior

  initialize: ->
    @keyEvents = @options.keyEvents

  onRender: ->
    @removeEventListener()
    @addEventListener()

  onBeforeRender: ->
    @removeEventListener()

  keyAction: (e) =>

    console.log 'keyAction'

    # Isolates the keystroke
    keyCode = e.keyCode

    # Do nothing if there isn't an
    # event associated with the keystroke
    return unless @keyEvents[keyCode]

    # Prevents any default action associated with the keycode
    e.preventDefault()
    e.stopPropagation()

    # Triggers the event associated with
    # the keystroke on the view instance
    return @view.triggerMethod(@keyEvents[keyCode], e)

  addEventListener: ->
    $(document).on 'keydown', @keyAction
    Backbone.Radio.channel('flash').trigger('add', { context: 'info', timeout: 1500, message: 'Keyboard controls enabled'})

  removeEventListener: ->
    $(document).off 'keydown', @keyAction
    Backbone.Radio.channel('flash').trigger('add', { context: 'info', timeout: 1500, message: 'Keyboard controls disabled'})

# # # # #

module.exports = KeyboardControls
