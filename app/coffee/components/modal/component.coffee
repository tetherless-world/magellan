
class ModalComponent extends require './abstract'

  radioEvents:
    'modal show': 'showViewProxy'

  showViewProxy: (view, modalViewOptions={}) ->
    view.on 'hide', => @hideModal()
    @showModal(view, modalViewOptions)

# # # # #

module.exports = ModalComponent
