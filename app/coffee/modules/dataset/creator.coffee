
# TODO - abstract into a separate service?
# Perhaps abstract into Application?
# This will likely need to be used elsewhere
buildUniqueId = (prefix='')->
  return prefix + Math.random().toString(36).substr(2, 10)

# TODO - decomission this
window.buildUniqueId = buildUniqueId

# # # # #

class DatasetCreator extends Backbone.Model

  # They may be re-generated, though stateful
  # properties will be lost in the process
  # TODO - we will need a process to UPDATE or RE-GENERATE facets
  # TODO - this should be abstracted into the Dataset model as a generateFacets method
  ensureFacets: (dataset_id, datapoints) ->

    # Isolates unique keys from the datapoints
    # These unique keys will be used to generate facets
    allKeys = []
    for el in datapoints
      allKeys = _.union(allKeys, _.keys(el) )

    # Adds an index to each facet for correct ordering
    index = 0

    # Save Datapoint function
    # Passed to Bluebird's Promise.each method, returns a Promise
    saveFacet = (facet) ->

      # Assembles a new facet
      attrs =
        id:         buildUniqueId('fc_')
        dataset_id: dataset_id
        attribute:  facet
        label:      facet
        order:      index
        enabled:    if facet in ['@id'] then false else true
        tooltip:    ''

      # Increments index
      index = index + 1

      # Returns 'add' Promise from DB service
      return Backbone.Radio.channel('db').request('add', 'facets', attrs)

    # Iterates over each id in allKeys returns a promise
    return Promise.each(allKeys, saveFacet)

  # ensureDatapoints
  # Populates Dexie with the datapoints from the uploaded JSON
  # Returns a Promise that resolves when all datapoints have been persisted to Dexie
  ensureDatapoints: (dataset_id, datapoints) ->

    # Index and count variables for Loading component updates
    index = 0
    count = _s.numberFormat(datapoints.length)

    # Save Datapoint function
    # Passed to Bluebird's Promise.each method, returns a Promise
    saveDatapoint = (datapoint) ->

      # Loading component update message
      index = index + 1
      Backbone.Radio.channel('loading').trigger('show', "Processing #{_s.numberFormat(index)} of #{count}")

      # Assembles a new datapoint
      attrs =
        id:         buildUniqueId('dp_')
        dataset_id: dataset_id
        raw:        datapoint
        data:       JSON.parse(JSON.stringify(datapoint))
        views:      {}

      # Returns 'add' Promise from DB service
      return Backbone.Radio.channel('db').request('add', 'datapoints', attrs)

    # Iterate over each datapoint, return a promise
    return Promise.each(datapoints, saveDatapoint)

  # ensureDataset
  # Saves the Dataset model to Dexie
  ensureDataset: (dataset) ->
    return Backbone.Radio.channel('db').request('add', 'datasets', dataset.toJSON())

  # deploy
  # Used to persist Dataset, Datapoints, and Facets to the database
  deploy: (dataset, datapoints) ->

    # Sets count attribute defined from length of graph parameter
    # and unique ID for Dataset model
    dataset.set('count', datapoints.length)
    dataset.set('id', buildUniqueId('ds_'))

    # Triggers 'request' event on Dataset model
    # (important for views to function correctly)
    dataset.trigger('request')

    # Shows Loading component
    Radio.channel('loading').trigger('show', 'Saving Dataset...')

    # Adds the Dataset record to Dexie
    @ensureDataset(dataset).then (dataset_id) =>

      # Updates Loading component
      Radio.channel('loading').trigger('show', 'Saving Datapoints...')

      # Iterate over all datapoints
      # Format and add each to database
      @ensureDatapoints(dataset_id, datapoints).then () =>

        # Updates Loading component
        Radio.channel('loading').trigger('show', 'Generating Facets...')

        # Generate the facets from the datapoints
        # Formats and adds each to database
        @ensureFacets(dataset_id, datapoints).then () =>

          # Updates Loading component
          Radio.channel('loading').trigger('show', 'Loading Facets...')

          # Loads the facets for this dataset
          Radio.channel('facet').request('collection', dataset_id).then () =>

            # Updates Loading component
            Radio.channel('loading').trigger('show', 'Linking Facets to Ontologies...')

            # Links facets to Ontologies
            Radio.channel('facet').request('link:all').then () =>

              # Updates Loading component
              Radio.channel('loading').trigger('hide')

              # DONE.
              # Triggers 'sync' event on the Dataset model
              dataset.trigger('sync')

            # Error handling.
            .catch (err) => dataset.trigger('error', err)
          .catch (err) => dataset.trigger('error', err)
        .catch (err) => dataset.trigger('error', err)
      .catch (err) => dataset.trigger('error', err)
    .catch (err) => dataset.trigger('error', err)

# # # # #

module.exports = new DatasetCreator()
