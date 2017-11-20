
# SearchResultDecorator class definition
class SearchResultDecorator extends Mn.Decorator

  icon: ->
    nfoType = @get('data')['@type']

    return switch nfoType
      when "nfo:Folder"             then 'fa-folder-open-o'
      when "nfo:Document"           then 'fa-file-o'
      when "nfo:Image"              then 'fa-file-image-o'
      when "nfo:PlainTextDocument"  then 'fa-file-text-o'
      when "nfo:Spreadsheet"        then 'fa-file-excel-o'

# # # # #

class SearchResultModel extends Backbone.Model

  # Assigns decorator property
  decorator: SearchResultDecorator

  # Returns a stringified, indented copy of the record's JSON
  # Used as a helper for copy-and-paste view Behavior
  stringifyJson: -> return JSON.stringify(@toJSON(), null, 2)

# # # # #

class SearchResultCollection extends Backbone.Collection
  model: SearchResultModel

# # # # #

module.exports =
  Model:      SearchResultModel
  Collection: SearchResultCollection
