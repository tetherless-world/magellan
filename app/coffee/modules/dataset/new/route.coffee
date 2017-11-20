LayoutView = require './views/layout'
DatasetCreator = require '../creator'
ArchiveImporter = require '../importer'

# # # # #

class NewDatasetRoute extends require 'hn_routing/lib/route'

  title: 'Magellan - New Dataset'

  breadcrumbs: [
    { text: 'Home', href: '#' }
    { text: 'Archives', href: '#datasets' }
    { text: 'New' }
  ]

  fetch: ->
    Backbone.Radio.channel('dataset').request('model')
    .then (model) => @model = model

  render: ->
    @container.show new LayoutView({ model: @model, creator: DatasetCreator, importer: ArchiveImporter })

# # # # #

module.exports = NewDatasetRoute
