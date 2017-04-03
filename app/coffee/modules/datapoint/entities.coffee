
class DatapointModel extends Backbone.Model
  urlRoot: 'datapoints'

  save: ->
    Backbone.Radio.channel('datapoint').request('save', @)

# # # # #

class DatapointCollection extends Backbone.Collection
  model: DatapointModel

  # resetDataFromRaw
  # Resets the collection of datapoints to their default attributes
  resetDataFromRaw: ->
    console.log "RESET DATA"

    # Resets data attribute from raw, and saves
    resetDatapoint = (dp) ->
      raw = dp.get('raw')
      dp.set('data', raw)
      return dp.save()

    # Iterates over each model and invokes resetDatapoint
    return Promise.each(@models, resetDatapoint)

# # # # #

module.exports =
  Model:      DatapointModel
  Collection: DatapointCollection