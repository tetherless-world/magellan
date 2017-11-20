RecordViewer = require './recordViewer'

# # # # #

class RecordList extends Mn.CollectionView
  tagName:    'ul'
  className:  'list-group record-list-group'
  childView:  RecordViewer

  childViewOptions: ->
    return { tagName: 'li', className: 'list-group-item' }

# # # # #

module.exports = RecordList
