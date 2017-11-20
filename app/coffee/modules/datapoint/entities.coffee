
class DatapointModel extends Backbone.Model
  urlRoot: 'datapoints'

  # TODO - model defaults

  save: ->
    Backbone.Radio.channel('datapoint').request('save', @)

# # # # #

class DatapointCollection extends Backbone.Collection
  model: DatapointModel

  # resetTargetObject
  # Resets the collection of datapoints to their default attributes
  resetTargetObject: (target_object) ->

    # Index and count variables for Loading component updates
    index = 0
    count = _s.numberFormat(@length)

    # Resets data attribute from raw, and saves
    resetDatapoint = (dp) ->

      # Loading component update message
      index = index + 1
      Backbone.Radio.channel('loading').trigger('show', "Processing #{_s.numberFormat(index)} of #{count}")

      # Deep-copy from raw
      # Ensures objects don't represent the same space in memory
      if target_object == 'data'
        raw = JSON.parse(JSON.stringify(dp.get('raw')))
        dp.set('data', raw)

      # Reset views
      if target_object == 'views'
        dp.set('views', {})

      return dp.save()

    # Iterates over each model and invokes resetDatapoint
    return Promise.each(@models, resetDatapoint)

# # # # #

module.exports =
  Model:      DatapointModel
  Collection: DatapointCollection
