LayoutView  = require './views/layout'

# # # # #

class KnowledgeCaptureRoute extends require 'hn_routing/lib/route'

  title: ->
    return "Datasets - #{@model.get('label')} - Knowledge Capture"

  breadcrumbs: ->
    return [
      { text: 'Home', href: '#' }
      { href: "#datasets", text: 'Archives' }
      { href: "#datasets/#{@model.id}", text: @model.get('label') }
      { href: "#datasets/#{@model.id}/search", text: 'Search' }
      { text: 'Knowledge Capture' }
    ]

  fetch: (id) ->
    # Handle async operations
    return new Promise (resolve, reject) =>

      # Fetch dataset
      Backbone.Radio.channel('dataset').request('model', id)
      .then (model) =>

        # Assigns dataset to @model
        @model = model

        # Fetches Knowledge Rules
        @model.fetchKnowledgeRules()
        .then (knowledgeRuleCollection) =>

          # Assigns knowledgeRules to @collection
          @collection = knowledgeRuleCollection

          # Resolves promise
          return resolve()

        # Error Handling
        .catch (err) => return reject(err)
      .catch (err) => return reject(err)

  render: ->
    @container.show new LayoutView({ model: @model, collection: @collection })

# # # # #

module.exports = KnowledgeCaptureRoute
