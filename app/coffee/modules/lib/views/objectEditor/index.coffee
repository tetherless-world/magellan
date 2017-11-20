
class FormAttribute extends Backbone.Model
  defaults:
    attr: null
    type: null
    val:  null

class AttrubteCollection extends Backbone.Collection
  model: FormAttribute

  comparator: 'attr'

  getData: ->
    data = {}
    for model in @models
      data[model.get('attr')] = model.get('val')

    return data

# # # # # # # # # # # # # # # # # # # #

class AttrChild extends Marionette.LayoutView
  tagName: 'li'
  className: 'list-group-item'
  template: require './templates/attr_child'

  behaviors:
    BindCheckboxes: {}
    BindInputs: {}
    Confirmations:
      message:      'Are you sure you want to remove this attribute?'
      confirmIcon:  'fa-times'
      confirmText:  'Remove'
      confirmCss:   'btn-danger'

  ui:
    confirmationTrigger: '[data-click=remove]'

  regions:
    editorRegion: '[data-region=object-editor]'

  modelEvents:
    'change': 'onModelChange'

  onModelChange: =>
    @trigger 'change'

  onConfirmed: ->
    @model.collection.remove(@model)

  onRender: ->
    Backbone.Syphon.deserialize(@, @model.attributes)

  onShow: ->
    if @model.get('type') == 'array'
      # TODO - select2 looks like shit. Alternative for multiple selects?
      return

    # Nested object editing
    if @model.get('type') == 'object'
      form = new ObjectForm({ model: @model.get('val'), disableSubmit: true })
      form.on 'changed', (e) => @model.set('val', form.getData())
      @editorRegion.show form

# # # # #

class AttrEmpty extends Marionette.LayoutView
  tagName: 'li'
  className: 'list-group-item list-group-item-warning'
  template: require './templates/attr_empty'

# # # # #

class AttrForm extends Marionette.LayoutView
  className: 'modal-content'
  template: require './templates/attr_form'

  behaviors:
    SubmitButton: {}

  serializeData: ->
    return { modalTitle: 'New Attribute' }

  buildAttrModel: ->
    data = Backbone.Syphon.serialize(@)
    data.val = @getAttrVal(data)
    return data

  getAttrVal: (data) ->
    if data.type == 'string'
      return ''

    if data.type == 'number'
      return 0

    if data.type == 'boolean'
      return true

    if data.type == 'array'
      return []

    if data.type == 'object'
      return []

  onSubmit: ->
    @trigger 'submitted', @buildAttrModel()
    @trigger 'hide'

# # # # #

class ObjectForm extends Marionette.CompositeView
  className: 'row'
  template: require './templates/attr_list'
  childViewContainer: '[data-container=editors]'
  childView: AttrChild
  emptyView: AttrEmpty

  behaviors:
    SubmitButton: {}
    CancelButton: {}

  ui:
    addAttr: '[data-click=add]'

  events:
    'click @ui.addAttr': 'addAttr'

  childEvents:
    'change': 'onChildChange'

  onBeforeRemoveChild: (view) => @trigger 'changed'
  onChildChange: (e) => @trigger 'changed'

  initialize: (options) ->
    @collection = new AttrubteCollection()

    json = _.clone(@model.toJSON?()) || @options.model

    for attr, val of json
      type = typeof(val)
      type = 'array' if Array.isArray(val) # Array != Object
      @collection.add({ attr: attr, val: val, type: type })

  templateHelpers: ->
    return { disableSubmit: @options.disableSubmit || false }

  addAttr: (e) ->
    e.stopPropagation()
    attrForm = new AttrForm()
    attrForm.on 'submitted', (newAttr) => @collection.add(newAttr)
    Backbone.Radio.channel('modal').trigger('show', attrForm)

  getData: ->
    @collection.getData()

# # # # #

module.exports = ObjectForm
