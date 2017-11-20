
# DexieService class definition
# Responsible for managing DexieDB
# - ensures presence of schemas
# - ensures presence of documents in tables that require seed data
# - requests background app to populate the DB (TODO)
class DexieService extends Marionette.Service

  radioRequests:
    'db add':     'addDocument'
    'db delete':  'deleteDocument'
    'db db':      'getDb'

  initialize: (options={})->

    # Initializes new Dexie DB
    # and attaches relevant options
    @db       = new Dexie(options.db)
    @schema   = options.schema
    @version  = options.version || 1

    # TODO - remove
    window.db = @db

    # Ensures schema (must be done before @db is opened)
    @ensureSchema()

    # Listener for Dexie.on('ready')
    # Fired after @db.open()
    @db.on('ready', @onDexieReady)

    # Opens DB, @onDexieReady is next callback
    @db.open()

  # Callback for Dexie.on('ready')
  onDexieReady: =>

    # Ensures presence of documents
    # in tables that require data
    @ensureDocuments()
    .then (results) =>

      # Validates result of @ensureDocuments()
      isValid = @validateDocumentCount(results)

      # Starts the application if isValid
      return @startApp() if isValid

      # Populates tables if not
      return @populateTables()

  # Validates the result of @ensureDocuments()
  validateDocumentCount: (results) ->

    # VALID - there are tables that require results
    return true if _.isEmpty(results)

    # Ensures that _.min() on an empty array does not return Infinity
    results.push(-1)

    # VALID - tables that require results have records
    return true if _.min(results) > 0

    # INALID - there are tables that require data, but no records exist.
    return false

  # Starts the application
  startApp: ->
    Backbone.Radio.channel('db').trigger('ready')

  # Ensures presence of schema defined
  # in the constructor's options
  ensureSchema: ->
    # Iterates over each table in @schema
    for table in @schema
      continue if @db[table.name]
      return @addSchema()

  # Adds a table and associated schema to @db
  addSchema: ->

    # Defines schema
    # Passed into @db.version(...).stores method
    schemaDefinition = {}

    # Iterates over each table in @schema...
    for table in @schema

      # And adds its name and attrs to schemaDefinition
      schemaDefinition[table.name] = table.attrs

    # Sets @db version and schema
    @db.version(@version).stores(schemaDefinition)
    return true

  # Ensures presence of documents
  # Checks @schema[index].ensureDocuments
  # TODO - this should be renamed to more accuratly
  # describe what's happening in this function.
  ensureDocuments: ->

    # Stores the promises used to count elements
    countPromises = []

    # Iterates over each table in @schema
    for table in @schema

      # Skips unless table.ensureDocuments
      continue unless table.ensureDocuments

      # Pushes the promise returned by @db.table.count()
      countPromises.push( @db[table.name].count() )

    # Returns Promise.all() - resolved when all
    return Promise.all(countPromises)

  # Triggers the background app to populate DB
  # TODO - this method is incomplete
  # TODo - do we NEED to do this in the background app?
  populateTables: ->
    # console.log 'POPULATE TABLES IN BACKGROUND APP'

    # Populates database in background app
    if window.global && window.global.ServerRadio
      window.global.ServerRadio.trigger('populate')

    # No Background app detected - fallback gracefully?
    else
      # console.log 'NO BACKGROUND APP DETECTED'

    @startApp() # TODO - this must happen AFTER the DB is populated

  # Adds a document to the named table
  # Returns a promise
  addDocument: (table, doc) ->
    @db[table].add(doc)

  # Deletes a document to the named table
  # Returns a promise
  deleteDocument: (table, document_id) ->
    @db[table].delete(document_id)

  getDb: ->
    return @db

# # # # #

module.exports = DexieService
