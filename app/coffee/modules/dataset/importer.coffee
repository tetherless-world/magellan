
# ArchiveImporter class definition
# Imports a directory of files uploaded via HTML input[type=file]
class ArchiveImporter

  context:
    "dmoa": "http://dmo.org/archive/"
    "dmoi": "http://dmo.org/instance/"
    "foaf": "http://xmlns.com/foaf/0.1/"
    "nfo":  "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#"
    "ore":  "http://www.openarchives.org/ore/terms/"
    "rdf":  "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    "rdfs": "http://www.w3.org/2000/01/rdf-schema#"
    "xsd":  "http://www.w3.org/2001/XMLSchema#"

  sanitizeString: (str) =>
    return str.replace('{', '\{').replace('{', '\{')

  getType: (label) ->

    return 'FALSE' unless label

    # Helper function for fn.indexOf('.ext') > -1
    ofType = (fn, ext) -> return fn.indexOf(ext) != -1

    # Sets @type for directories
    return 'nfo:Folder' unless label.split('.')[1]

    # Caches filename
    fn = @sanitizeString(label)

    # console.log fn

    # nfo:Spreadsheet
    return 'nfo:Spreadsheet' if ofType(fn,'.csv') || ofType(fn,'.xlx') || ofType(fn,'.xlsx')

    # nfo:Image
    return 'nfo:Image' if ofType(fn,'.png') || ofType(fn,'.jpg')

    # nfo:PlainTextDocument
    return 'nfo:PlainTextDocument' if ofType(fn,'.txt')

    # TODO - other types?
    return 'nfo:Document'

  # TODO - files must be split to find their parent directories

  # Stores the IDs of the directories found
  # TODO - this should be blanked before each import
  directoryIDs: []

  # collectDirectory
  # Collects the unique parent directory paths from the filenames
  collectDirectory: (dir) ->
    @directoryIDs.push(dir)
    @directoryIDs = _.uniq(@directoryIDs)

  # addDirectories
  # Adds each directory to the knowledge graph
  addDirectories: ->
    for dir in @directoryIDs

      # Isolates directory's parent directory
      belongsTo = dir.split('/')
      belongsTo.pop()
      belongsTo.pop()
      belongsTo = belongsTo.join('/') + '/'
      belongsTo = 'root' if belongsTo == '/'

      # Assembles individual directory data structure
      dirElement =
        '@id':                    dir
        '@type':                  'nfo:Folder'
        'rdfs:label':             dir
        'nfo:belongsToContainer': { '@id': belongsTo }

      # Adds directory to knowledge graph
      @output['@graph'].push(dirElement)

  # parseFile
  # Parses an individual file and its parent directory
  parseFile: (file, prefix) ->

    # Isolates filepath with prefix
    if prefix

      # Formats prefix
      prefix = prefix + '/' unless _s.endsWith(prefix, '/')
      prefix = '/' + prefix unless _s.startsWith(prefix, '/')

      # Formats filepath
      filepath = prefix + file.webkitRelativePath

    # Isolate filepaht without prefix
    else
      filepath = '/' + file.webkitRelativePath

    # Gets label & belongsTo
    pieces    = filepath.split('/')
    label     = pieces.pop()
    belongsTo = pieces.join('/') + '/'

    # Adds parent directory
    @collectDirectory(belongsTo)

    # Assembles individual file data structure
    # TODO - should include file extension
    el =
      '@id':                    filepath
      '@type':                  @getType(label)
      'rdfs:label':             label
      'nfo:belongsToContainer': { '@id': belongsTo }
      # 'nfo:size':               file.size
      # 'nfo:lastModified':       file.lastModified

    return el

  # parse
  # Parses a directory import from
  # a list of files from a file upload form
  parse: (files, prefix=null) ->

    # Flushes Directory IDs
    @directoryIDs = []

    # Defines output structure
    @output = { "@context": @context, "@graph": [] }

    # Parses graph
    @output['@graph'].push(@parseFile(f, prefix)) for f in files

    # Adds directories to graph
    @addDirectories()

    # Returns parsed archive
    return @output

# # # # #

module.exports = new ArchiveImporter()
