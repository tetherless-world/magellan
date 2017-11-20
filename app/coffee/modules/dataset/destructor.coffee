
# DatasetDestructor class definition
# Defines an interface that can destroy a dataset completely,
# including its associated datapoints, facets, knowledge rules, and viewer rules
class DatasetDestructor extends Backbone.Model

  # destroyFacets
  # Destroys all facets associated with the dataset
  destroyFacets: (facets) -> return @destroyCollection(facets, 'facet')

  # destroyDatapoints
  # Destroys all datapoints associated with the dataset
  destroyDatapoints: (datapoints) -> return @destroyCollection(datapoints, 'datapoint')

  # destroyKnowledgeRules
  # Destroys all Knowledge Rules associated with the dataset
  destroyKnowledgeRules: (knowledgeRules) -> return @destroyCollection(knowledgeRules, 'knowledge:rule')

  # destroyViewerRules
  # Destroys all Viewer Rules associated with the dataset
  destroyViewerRules: (viewerRules) -> return @destroyCollection(viewerRules, 'viewer:rule')

  # destroyCollection
  # Destroys collections of ViewerRules, KnowledgeRules, Facets, and Datapoints
  destroyCollection: (collection, radioChannel) ->

    # destoyModel - removes an indiviudal model from the database
    # Passed to Bluebird's Promise.each method, returns a Promise
    destroyModel = (model) -> return Backbone.Radio.channel(radioChannel).request('destroy', model)

    # Iterate over each viewer rule, return a promise
    return Promise.each(collection.models, destroyModel)

  # destroyDataset
  # Removes the Dataset model from Dexie
  destroyDataset: (dataset) ->
    return Backbone.Radio.channel('dataset').request('destroy', dataset)

  # deploy
  # Used to destroy Dataset, Datapoints, Facets, Knowledge Rules, and Viewer Rules
  deploy: (dataset) ->

    console.log 'DESTROY DATASET'

    # Triggers 'request' event on Dataset model
    # (important for views to function correctly)
    dataset.trigger('request')

    # Shows Loading component
    Radio.channel('loading').trigger('show', 'Destroying Dataset...')

    # Fetches Viewer Rules
    dataset.fetchViewerRules()
    .then (viewerRules) =>

      # Updates Loading Component
      Radio.channel('loading').trigger('show', 'Destoying Smart Rendering...')

      # Destroys Viewer Rules
      @destroyViewerRules(viewerRules)
      .then () =>

        # Fetches Knowledge Rules
        dataset.fetchKnowledgeRules()
        .then (knowledgeRules) =>

          # Updates Loading Component
          Radio.channel('loading').trigger('show', 'Destoying Knowledge Capture...')

          # Destroys Knowledge Rules
          @destroyKnowledgeRules(knowledgeRules)
          .then () =>

            # Fetches Facets
            dataset.fetchFacets()
            .then (facets) =>

              # Updates Loading Component
              Radio.channel('loading').trigger('show', 'Destoying Facets...')

              # Destroys Facets
              @destroyFacets(facets)
              .then () =>

                # Fetch Datapoints
                dataset.fetchDatapoints()
                .then (datapoints) =>

                  # Updates Loading Component
                  Radio.channel('loading').trigger('show', 'Destoying Knowledge Graph...')

                  # Destroy Datapoints
                  @destroyDatapoints(datapoints)
                  .then () =>

                    # Updates Loading Component
                    Radio.channel('loading').trigger('show', 'Destoying Archive...')

                    # Destroy Dataset
                    @destroyDataset(dataset)
                    .then () =>

                      # Hides Loading Component
                      Radio.channel('loading').trigger('hide')

                      # Fires sync event on dataset model
                      dataset.trigger('sync')

                    # Error Handling (WOW.)
                    .catch (err) => dataset.trigger('error', err)
                  .catch (err) => dataset.trigger('error', err)
                .catch (err) => dataset.trigger('error', err)
              .catch (err) => dataset.trigger('error', err)
            .catch (err) => dataset.trigger('error', err)
          .catch (err) => dataset.trigger('error', err)
        .catch (err) => dataset.trigger('error', err)
      .catch (err) => dataset.trigger('error', err)
    .catch (err) => dataset.trigger('error', err)

# # # # #

module.exports = new DatasetDestructor()
