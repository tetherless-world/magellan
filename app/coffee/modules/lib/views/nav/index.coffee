
class NavChild extends Mn.LayoutView
  tagName: 'li'
  className: 'nav-item'
  template: require './templates/nav_child'

  behaviors:
    SelectableChild: {}

  className: ->
    css = 'nav-item'
    css += ' active' if @model.get('active')
    css += ' dropdown' if @model.get('dropdown')
    return css

  onRender: ->
    @triggerMethod('selected') if @model.get('active')

  onClick: (e) ->
    return if @model.get('href')
    return if @model.get('dropdown')
    return if @$el.hasClass('active')
    e?.preventDefault()
    @triggerMethod('selected')
    @$el.addClass('active').siblings().removeClass('active')

# # # # #

class NavList extends Mn.CollectionView
  tagName: 'ul'
  childView: NavChild

  className: ->
    css = 'nav'
    return css += ' nav-pills nav-stacked'  if @options.stacked
    return css += ' nav-pills'              if @options.pills
    return css += ' nav-tabs'

  childEvents:
    'selected': 'onChildSelected'

  onChildSelected: (view) ->
    @trigger 'nav:change', view
    return @trigger(view.model.get('trigger'))

# # # # #

class NavView extends Mn.LayoutView
  template: require './templates/nav'

  regions:
    navRegion:      '[data-region=nav]'
    contentRegion:  '[data-region=content]'

  # Includes ViewState behavior if the stateful option has been set
  behaviors: ->
    return { ViewState: { key: @navOptions.stateful } } if @navOptions.stateful
    return {}

  # Items for NavList
  navItems: [{ icon: 'fa-times', text: 'Default Nav', trigger: 'default' }]

  # Options for NavList - tabs (default) / pills / stacked / default / stateful
  # navOptions: { pills: true, stacked: true, stateful: 'someKeyForLocalStorage' }
  navOptions: {}

  # Events registry for navItems
  navEvents: {}

  initialize: ->
    @navOptions = _.result(@, 'navOptions') || {}
    @navItems   = _.result(@, 'navItems')

    # Sets active nav
    trigger = @_getActiveNav()
    return unless trigger
    _.map(@navItems, (item) ->
        return item.active = true if item.trigger == trigger
        return item.active = false
    )

  templateHelpers: ->
    return { stacked: @navOptions.stacked || null }

  # Gets activeTab from state || defaults || first
  _getActiveNav: =>
    if @navOptions.stateful
      state = @getState()
      return state if state

    return _.findWhere(@navItems, { default: true })?.trigger || null

  # Sets activeTab on change
  _setActiveNav: (navChildView) ->
    @activeNav = navChildView
    return unless @navOptions.stateful
    return @setState(navChildView.model.get('trigger'))

  triggerActiveNav: ->
    @activeNav?.trigger('selected')

  showNavView: ->
    # Instantiates @navCollection
    @navCollection = new Backbone.Collection(@navItems)

    # Instantiates NavList view and binds events to this view
    @navList = new NavList( _.extend(@navOptions, { collection: @navCollection }) )
    @navList.on 'nav:change', (navChildView) => @_setActiveNav(navChildView)
    Mn.bindEntityEvents( @, @navList, _.result(@, 'navEvents') )
    @navRegion.show(@navList)

  onRender: ->
    @showNavView()

# # # # #

module.exports = NavView
