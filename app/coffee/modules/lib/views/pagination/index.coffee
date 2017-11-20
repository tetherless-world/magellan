
class PaginationView extends Mn.LayoutView
  tagName: 'ul'
  template: require './templates/pagination'

  className: ->
    return 'pager' if @options.pager
    return 'pagination'

  getTemplate: ->
    return require('./templates/pager') if @options.pager
    return require './templates/pagination'

  ui:
    first: '[data-click=first]'
    prev: '[data-click=prev]'
    page: '[data-click=page]'
    next: '[data-click=next]'
    last: '[data-click=last]'

  events:
    'click @ui.first': 'firstPage'
    'click @ui.prev': 'prevPage'
    'click @ui.page': 'goToPage'
    'click @ui.next': 'nextPage'
    'click @ui.last': 'lastPage'

  collectionEvents:
    'reset':  'render'

  # # # # #
  # Paging Callbacks
  firstPage: -> @collection.firstPage()
  prevPage: ->  @collection.prevPage()
  nextPage: ->  @collection.nextPage()
  lastPage: ->  @collection.lastPage()

  goToPage: (e) ->
    @collection.getPage( @$(e.currentTarget).data('page') )
  #
  # # # # #

  onRender: ->
    @state.totalPages <= 1 && @$el.hide() || @$el.show()

  templateHelpers: ->
    return @windowedPageNumber()

  # Returns array that look like [1,2,"...",5,6,7,8,"...", 19,20]
  #                                ^            ^             ^
  #                         outer_window  inner_window  outer_window
  windowedPageNumber: ->
    @state = _.clone @collection.state

    # FEATURE - this can use a tighten-up. We should be able to set max-pages-displayed (name?)
    inner_window = 4
    outer_window = 1

    window_from = @state.currentPage - inner_window
    window_to   = @state.currentPage + inner_window

    if window_to > @state.totalPages
      window_from -= window_to - @state.totalPages
      window_to    = @state.totalPages

    if window_from < 1
      window_to  += 1 - window_from
      window_from = 1
      window_to   = @state.totalPages if window_to > @state.totalPages

    middle = [window_from..window_to]

    # Calculate Left
    if outer_window + 3 < middle[0]
      left = [1..(outer_window + 1)]
      left.push "..."
    else
      left = [1...middle[0]]

    # Calculate Right
    if (@state.totalPages - outer_window - 2) > middle[middle.length - 1]
      right = [(@state.totalPages - outer_window)..@state.totalPages]
      right.unshift "..."
    else
      right_start = Math.min(middle[middle.length - 1] + 1, @state.totalPages)
      right = [right_start..@state.totalPages]
      right = [] if right_start is @state.totalPages

    # Shown pages?
    @state.shown = left.concat(middle.concat(right))
    @state.empty = _.isEmpty( @state.shown )

    # Counter
    # FEATURE - include counter conditionally
    start = if @state.currentPage > 1 then (( @state.currentPage - 1 ) * @state.pageSize) else 1

    end = ((@state.currentPage - 1) * @state.pageSize) + @state.pageSize
    end = if end > @state.totalRecords then @state.totalRecords else end

    @state.displayText = "#{start} - #{end} of #{@state.totalRecords} #{@options.plural || 'items'}"


    return @state

# # # # #

module.exports = PaginationView
