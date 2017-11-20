
# UploadWidget class definition
class UploadWidget extends Mn.LayoutView
  template: require './templates/upload'
  className: 'form-group'

  events:
    'change input[type=file]': 'onInputChange'

  titles:
    file:       'Open a file.'
    directory:  'Open a directory.'

  getTitle: ->
    return @options.title if @options.title
    return @titles.directory if @options.directory
    return @titles.file

  templateHelpers: ->
    return opts =
      title:      @getTitle()
      directory:  @options.directory

  onInputChange: (e) ->
    return @onDirectoryUpload(e) if @options.directory
    return @onFileUpload(e)

  onDirectoryUpload: (e) ->
    return @trigger('directory:loaded', e.target.files)

  onFileUpload: (e) ->

    # Cache e.target
    file = e.target.files[0]

    # Return without a file
    return unless file

    # Parse text from input file
    fileReader = new FileReader()
    fileReader.onload = => @trigger('file:loaded', fileReader.result)
    fileReader.readAsText(file)

  # TODO - optionally parse JSON from upload?
  # On Uploaded callback
  # Parses JSON from text and sends to parent view
  # onFileLoaded: (text) ->
  #   parsed = JSON.parse(text)
  #   @trigger 'parse', parsed

# # # # #

module.exports = UploadWidget
