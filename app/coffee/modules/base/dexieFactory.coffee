
# DexieFactory
# Provides methods used by factories extended
# from this abstract class definition
class DexieFactory extends Marionette.Service

  # ensureDb
  # Manages dependency injection of DexieDB class instance
  ensureDb: (options) ->
    @db ||= Backbone.Radio.channel('db').request('db')
    return @db

  # getCollection
  # Returns a collection of Datapoints belonging to this dataset
  getCollection: (dataset_id) ->

    # Ensures presence of @db
    @ensureDb()

    # Returns Promise to manage async DB operations
    return new Promise (resolve, reject) =>

      # Queries DB
      @db[@tableName].where('dataset_id').equals(dataset_id).toArray()

      # Resets the collection and resolves the promise
      .then (models) =>

        # Resets the collection of models
        @cachedCollection.reset(models)

        # Resolves the Promise and returns the FacetCollection
        return resolve(@cachedCollection)

      # Error handling
      .catch (err) => return reject(err)

  # getModel
  # Returns a model instance queried from @cachedCollection
  getModel: (id) ->

    # Ensures presence of @db
    @ensureDb()

    # Returns Promise to manage async DB operations
    return new Promise (resolve, reject) =>

      # Resolves if ID is undefined
      return resolve(new @cachedCollection.model()) unless id

      # Returns from @cached if synced
      return resolve(@cachedCollection.get(id)) if @cachedCollection.get(id)

      # Gets @cachedCollection and returns
      return @getCollection().then () => resolve(@cachedCollection.get(id))

  # saveModel
  # Persists an individual model to Dexie
  saveModel: (model) ->

    # Ensures presence of @db
    @ensureDb()

    # Returns Promise to manage async DB operations
    return new Promise (resolve, reject) =>

      # Triggers 'request' event on model
      model.trigger('request')

      # Item JSON to insert into Dexie table
      item = model.toJSON()

      # Updates the record in the table (or saves a new)
      @db[@tableName].put(item)
      .then (model_id) =>
        model.trigger('sync')
        return resolve()

      # Error handling
      .catch (err) =>
        model.trigger('error', err)
        return reject(err)

  # DestroyModel
  # Removes an individual model from Dexie
  destroyModel: (model) ->

    # Ensures presence of @db
    @ensureDb()

    # Returns Promise to manage async DB operations
    return new Promise (resolve, reject) =>

      # Triggers 'request' event on model
      model.trigger('request')

      # Inserts item into Dexie table
      primary_key = model.id

      # Deletes the record from the table via primary key
      @db[@tableName].delete(primary_key)
      .then (model_id) =>
        model.trigger('destroy')
        return resolve()

      # Error handling
      .catch (err) =>
        model.trigger('error', err)
        return reject(err)

# # # # #

module.exports = DexieFactory
