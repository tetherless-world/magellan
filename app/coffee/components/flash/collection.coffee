
# FlashCollection class definition
# Defines a basic Backbone.Collection to be used by the
# FlashComponent for storing multiple flash models
class FlashCollection extends Backbone.Collection
  model: require './model'

# # # # #

module.exports = FlashCollection
