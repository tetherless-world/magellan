ArchiveForm = require './archiveForm'
JsonForm    = require './jsonForm'
RdfForm     = require './rdfForm'

# # # # #

class ImportSelectorView extends require 'lib/views/nav'
  className: 'container'
  template: require './templates/layout'

  navItems: [
    { icon: 'fa-folder-open-o', text: 'Archive',    trigger: 'archive', default: true }
    { icon: 'fa-code',    text: 'JSON-LD',   trigger: 'json' }
    { icon: 'fa-file', text: 'RDF/XML',    trigger: 'rdf' }
  ]

  navEvents:
    'archive':  'archive'
    'json':     'json'
    'rdf':      'rdf'

  navOptions:
    pills: true

  archive: ->
    @contentRegion.show new ArchiveForm({ model: @model, creator: @options.creator, importer: @options.importer })

  json: ->
    @contentRegion.show new JsonForm({ model: @model, creator: @options.creator })

  rdf: -> # TODO - pass RDFImporter to this view
    @contentRegion.show new RdfForm({ model: @model, creator: @options.creator })

# # # # #

module.exports = ImportSelectorView
